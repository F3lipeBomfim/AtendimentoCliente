/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ufpr.tads.dao;

import com.ufpr.tads.beans.Produtos;
import com.ufpr.tads.beans.Atendimento;
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
public class ProdutosDAO {
    private Connection connection;
    public ProdutosDAO() {
        connection = ConnectionFactory.getConnection();
    }
    public List<Produtos> getAllProdutosCat(int idCategoria) {
    List<Produtos> ListaDeProdutos = new ArrayList<Produtos>();
    try {
        Connection con = connection;
        String sql = "SELECT * FROM produto WHERE id_categoria = ?";
        PreparedStatement ps;
        ps = con.prepareStatement(sql);
        ps.setInt(1, idCategoria);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Produtos produto = new Produtos();
            produto.setId(rs.getInt("id"));
            produto.setNome(rs.getString("nome"));
            ListaDeProdutos.add(produto);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return ListaDeProdutos;
    } 
    
    public List<Produtos> getAllProdutos() {
    List<Produtos> ListaDeProdutos = new ArrayList<Produtos>();
    try {
        Connection con = connection;
        String sql = "SELECT * FROM produto";
        PreparedStatement ps;
        ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Produtos produto = new Produtos();
            produto.setId(rs.getInt("id"));
            produto.setNome(rs.getString("nome"));
            ListaDeProdutos.add(produto);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return ListaDeProdutos;
    } 
    
    public List<Produtos> getAllCategorias() {
    List<Produtos> ListaDeProdutos = new ArrayList<Produtos>();
    try {
        Connection con = connection;
        String sql = "SELECT * FROM categoria_produto";
        PreparedStatement ps;
        ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Produtos produto = new Produtos();
            produto.setId_categoria(rs.getInt("id"));
            produto.setNome_categoria(rs.getString("nome"));
            ListaDeProdutos.add(produto);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return ListaDeProdutos;
    } 
    
    public List<Produtos> getAllTipos() {
    List<Produtos> ListaDeProdutos = new ArrayList<Produtos>();
    try {
        Connection con = connection;
        String sql = "SELECT * FROM tipo_atendimento";
        PreparedStatement ps;
        ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Produtos produto = new Produtos();
            produto.setId_tipo(rs.getInt("id"));
            produto.setNome_tipo(rs.getString("nome"));
            ListaDeProdutos.add(produto);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return ListaDeProdutos;
    } 
    
    public void AlterarProduto(Produtos produtos) {
        try {
            String sql = "UPDATE categoria_produto SET nome = ? WHERE id = ?";
            PreparedStatement preparedStatement = connection
                    .prepareStatement(sql);
            int x = 0;
            preparedStatement.setString(++x, produtos.getNome_categoria());
            preparedStatement.setInt(++x, produtos.getId_categoria());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void AlterarProd(Produtos produtos) {
        try {
            String sql = "UPDATE produto SET nome = ? ,descricao = ? WHERE id = ?";
            PreparedStatement preparedStatement = connection
                    .prepareStatement(sql);
            preparedStatement.setString(1, produtos.getNome());
            preparedStatement.setString(2, produtos.getDescricao());
            preparedStatement.setInt(3, produtos.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void AddCategoria(Produtos produtos) {
        try {
            String sql = "INSERT categoria_produto SET nome = ?";
            PreparedStatement preparedStatement = connection
                    .prepareStatement(sql);
            int x = 0;
            preparedStatement.setString(++x, produtos.getNome_categoria());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void removerCategoria(int idCategoria) {
        try {
            PreparedStatement preparedStatement = connection
                    .prepareStatement("DELETE FROM categoria_produto WHERE id = ?");
            preparedStatement.setInt(1, idCategoria);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }   
    }
    public void removerProduto(int idProduto) {
        try {
            PreparedStatement preparedStatement = connection
                    .prepareStatement("DELETE FROM produto WHERE id = ?");
            preparedStatement.setInt(1, idProduto);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }   
    }
    
    public void adicionarProduto(Produtos produtos) {
      try {
        Connection con = connection;
        
        String sql = "INSERT INTO produto(nome, descricao, id_categoria, peso)"
                + "VALUES (?, ?, ?, ?)";
          // Parameters start with 1
          PreparedStatement ps;
          ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

          ps.setString(1, produtos.getNome());
          ps.setString(2, produtos.getDescricao());
          ps.setInt(3, produtos.getId_categoria());
          ps.setInt(4, produtos.getPeso());
          ps.executeUpdate();
          java.sql.ResultSet generatedKeys = ps.getGeneratedKeys();
          if ( generatedKeys.next() ) {
            produtos.setId(generatedKeys.getInt(1));
          }
      } catch (SQLException e) {
          e.printStackTrace();
      }
    }
    
}
