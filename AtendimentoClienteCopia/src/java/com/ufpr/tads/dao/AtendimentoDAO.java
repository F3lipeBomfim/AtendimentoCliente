/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ufpr.tads.dao;

import com.ufpr.tads.beans.Atendimento;
import com.ufpr.tads.dao.ConnectionFactory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Felipe Bomfim    
 */
public class AtendimentoDAO {
    
    private Connection connection;

    public AtendimentoDAO() {
        connection = ConnectionFactory.getConnection();
    }
    
    public List<Atendimento> getAllAtendimentos(int id) {
    List<Atendimento> listaDeAtendimento = new ArrayList<Atendimento>();
    try {
        Connection con = connection;
        String sql = "SELECT atendimento.*, tipo_atendimento.nome AS nome_tipo FROM atendimento "
                   + "LEFT JOIN tipo_atendimento ON (tipo_atendimento.id = atendimento.tipo_atendimento) WHERE excluido IS NULL AND id_usuario = ? ORDER BY id DESC";
        PreparedStatement ps;
        ps = con.prepareStatement(sql);
        ps.setInt(1, id);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Atendimento atendimento = new Atendimento();
            atendimento.setId(rs.getInt("id"));
            atendimento.setDescricao(rs.getString("descricao"));
            atendimento.setSituacao(rs.getInt("situacao"));
            atendimento.setTitulo(rs.getString("titulo"));
            atendimento.setData(rs.getString("data_hora_cadastro"));
            atendimento.setTipoAtendimento(rs.getString("nome_tipo"));
            atendimento.setId_usuario(rs.getInt("id_usuario"));
            listaDeAtendimento.add(atendimento);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return listaDeAtendimento;
    }
    
    public List<Atendimento> getAllAtendimentosEquipe(int filtro) {
    List<Atendimento> listaDeAtendimento = new ArrayList<Atendimento>();
    try {
        Connection con = connection;
        String sql = "SELECT atendimento.*, usuarios.nome AS nome_usuario, usuarios.email, (SELECT DATEDIFF(NOW(),atendimento.data_hora_cadastro)) AS date_diff, tipo_atendimento.nome AS nome_tipo FROM atendimento "
                   + "LEFT JOIN tipo_atendimento ON (tipo_atendimento.id = atendimento.tipo_atendimento) "
                   + "LEFT JOIN usuarios ON (usuarios.id = atendimento.id_usuario) WHERE atendimento.excluido IS NULL";
        
        if (filtro == 1) {
            sql = sql + " AND data_hora_resposta IS NULL ";
        }else if(filtro == 2){
            sql = sql + " AND data_hora_resposta IS NULL HAVING date_diff >= 7";
        }else if (filtro == 3){
            sql = sql + " AND data_hora_resposta IS NOT NULL";
        }
        
        sql = sql + " ORDER BY data_hora_resposta ASC, id DESC";
        
        PreparedStatement ps;
        ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Atendimento atendimento = new Atendimento();
            atendimento.setId(rs.getInt("id"));
            atendimento.setDescricao(rs.getString("descricao"));
            atendimento.setNome_usuario(rs.getString("nome_usuario"));
            atendimento.setEmail_usuario(rs.getString("email"));
            atendimento.setSituacao(rs.getInt("situacao"));
            atendimento.setDate_diff(rs.getString("date_diff"));
            atendimento.setTitulo(rs.getString("titulo"));
            atendimento.setData(rs.getString("data_hora_cadastro"));
            atendimento.setData_resposta(rs.getString("data_hora_resposta"));
            atendimento.setTipoAtendimento(rs.getString("nome_tipo"));
            atendimento.setId_usuario(rs.getInt("id_usuario"));
            listaDeAtendimento.add(atendimento);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return listaDeAtendimento;
    }
    
    public void AdicionarResposta(Atendimento atendimento) {
        try {
            String sql = "UPDATE atendimento SET resposta = ?, data_hora_resposta = NOW(), situacao = 2 WHERE id = ?";
            PreparedStatement preparedStatement = connection
                    .prepareStatement(sql);
            int x = 0;
            preparedStatement.setString(++x, atendimento.getResposta());
            preparedStatement.setInt(++x, atendimento.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();

        }
    }
         
    public Atendimento getAtendimentoById(int idAtendimento) {
        Atendimento atendimento = new Atendimento();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT atendimento.*, tipo_atendimento.nome AS nome_tipo, produto.nome AS nome_produto,"
                    + "IF(atendimento.situacao = 1, 'Em aberto', 'Finalizado') AS nome_situacao"
                    + " FROM atendimento "
                        + "INNER JOIN produto ON (produto.id = atendimento.id_produto)"
                        + "INNER JOIN tipo_atendimento ON (tipo_atendimento.id = atendimento.tipo_atendimento) WHERE atendimento.id = ?");
            preparedStatement.setInt(1, idAtendimento);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                atendimento.setId(rs.getInt("id"));
                atendimento.setProduto(rs.getString("nome_produto"));
                atendimento.setDescricao(rs.getString("descricao"));
                atendimento.setNome_situacao(rs.getString("nome_situacao"));
                atendimento.setSituacao(rs.getInt("situacao"));
                atendimento.setTitulo(rs.getString("titulo"));
                atendimento.setTipoAtendimento(rs.getString("nome_tipo"));
                atendimento.setData_resposta(rs.getString("data_hora_resposta"));
                atendimento.setResposta(rs.getString("resposta"));
                atendimento.setData(rs.getString("data_hora_cadastro"));
                atendimento.setId_usuario(rs.getInt("id_usuario"));
                atendimento.setTipoAtendimento(rs.getString("nome_tipo"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return atendimento;
    }
    
    public void addAtendimento(Atendimento Atendimento) {
      try {
        Connection con = connection;
        
        String sql = "INSERT INTO atendimento(titulo, data_hora_cadastro, id_usuario, situacao, id_produto, tipo_atendimento, descricao)"
                + "VALUES (?, ?, ?, 1, ?, ?, ?)";
          // Parameters start with 1
          PreparedStatement ps;
          ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

          ps.setString(1, Atendimento.getTitulo());
          ps.setString(2, Atendimento.getData());
          ps.setInt(3, Atendimento.getId_usuario());
          ps.setInt(4, Atendimento.getId_produto());
          ps.setInt(5, Atendimento.getId_tipo_atendimento());
          ps.setString(6, Atendimento.getDescricao());
          ps.executeUpdate();
          java.sql.ResultSet generatedKeys = ps.getGeneratedKeys();
          if ( generatedKeys.next() ) {
            Atendimento.setId(generatedKeys.getInt(1));
          }
      } catch (SQLException e) {
          e.printStackTrace();
      }
    }
    public void remover(int idAtendimento) {
        try {
            PreparedStatement preparedStatement = connection
                    .prepareStatement("UPDATE atendimento SET excluido = NOW() WHERE id = ?");
            preparedStatement.setInt(1, idAtendimento);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }   
    }
}
