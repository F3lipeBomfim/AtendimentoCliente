/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ufpr.tads.dao;

//import LoginBean.LoginBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.ufpr.tads.beans.Produtos;
import com.ufpr.tads.beans.Usuario;
import java.sql.Statement;

/**
 *
 * @author Felipe Bomfim    
 */

public class UsuarioDAO {
    private Connection connection;

    public UsuarioDAO() {
        connection = ConnectionFactory.getConnection();
    }
    public void Logar(Usuario Usuario){

       try{
        Connection con = connection;
        String sql = "SELECT id, nome, perfil FROM usuarios WHERE email = ? AND senha = ? AND excluido IS NULl LIMIT 1";
       
        PreparedStatement ps;
        ps = con.prepareStatement(sql);
        ps.setString(1, Usuario.getEmail());
        ps.setString(2, Usuario.getSenha());

        ResultSet resultSet = ps.executeQuery();
          while(resultSet.next()){ 
            Usuario.setId(resultSet.getInt("id"));
            Usuario.setNome(resultSet.getString("nome"));
            Usuario.setPerfil(resultSet.getInt("perfil"));
          }
          ps.close();
       }
       catch(Exception e){
          System.out.println(e);
       }
    }
     
    public Usuario getUsuarioById(int idUsuario) {
        Usuario usuario = new Usuario();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT usuarios.* FROM usuarios WHERE id = ?");
            preparedStatement.setInt(1, idUsuario);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setCpf(rs.getString("cpf"));
                usuario.setEmail(rs.getString("email"));
                usuario.setTelefone(rs.getString("telefone"));
                usuario.setCep(rs.getString("cep"));
                usuario.setLogradouro(rs.getString("cep"));
                usuario.setNumero(rs.getInt("numero"));
                usuario.setComplemento(rs.getString("complemento"));
                usuario.setId_estado(rs.getInt("id_estado"));
                usuario.setId_cidade(rs.getInt("id_cidade"));
                usuario.setBairro(rs.getString("bairro"));
                usuario.setPerfil(rs.getInt("perfil"));
                usuario.setTipo_tel(rs.getInt("tipo_tel"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuario;
    }
    
    public void addUser(Usuario Usuario) {
      try {
        Connection con = connection;
        
        String sql = "INSERT INTO usuarios(nome, email, senha, cpf, telefone, cep, logradouro, numero, complemento,"
                + " perfil, id_estado, id_cidade, tipo_tel, bairro) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
          // Parameters start with 1
          PreparedStatement ps;
          ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

          ps.setString(1, Usuario.getNome());
          ps.setString(2, Usuario.getEmail());
          ps.setString(3, Usuario.getSenha());
          ps.setString(4, Usuario.getCpf());
          ps.setString(5, Usuario.getTelefone());
          ps.setString(6, Usuario.getCep());
          ps.setString(7, Usuario.getLogradouro());
          ps.setInt(8, Usuario.getNumero());
          ps.setString(9, Usuario.getComplemento());
          ps.setInt(10, Usuario.getPerfil());
          ps.setInt(11, Usuario.getId_estado());
          ps.setInt(12, Usuario.getId_cidade());
          ps.setInt(13, Usuario.getTipo_tel());
          ps.setString(14, Usuario.getBairro());
          ps.executeUpdate();
          java.sql.ResultSet generatedKeys = ps.getGeneratedKeys();
          if ( generatedKeys.next() ) {
            Usuario.setId(generatedKeys.getInt(1));
          }

      } catch (SQLException e) {
          e.printStackTrace();
      }
    }
    public List<Usuario> getAllEquipe(int userId) {
        List<Usuario> ListaDeUsuarios = new ArrayList<Usuario>();
        try {
            Connection con = connection;
            String sql = "SELECT * FROM usuarios WHERE perfil IN (2,3) AND usuarios.id != ? AND excluido IS NULL";
            PreparedStatement ps;
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setEmail(rs.getString("email"));
                ListaDeUsuarios.add(usuario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ListaDeUsuarios;
    } 
    
    public void alterar(Usuario usuario) {
        try {
            
            String sql = "UPDATE usuarios SET nome = ?, telefone = ?, "
                    + " cep = ?, logradouro = ?, complemento = ?, numero = ?, perfil = ?, tipo_tel = ?, id_estado = ?, id_cidade = ?, bairro = ?";
            if (usuario.getSenha()!= null) {
                sql = sql + " , senha = ?";
            }
            sql = sql + " WHERE id = ?";
            PreparedStatement preparedStatement = connection
                    .prepareStatement(sql);
            // Parameters start with 1
            int x = 0;
            preparedStatement.setString(++x, usuario.getNome());
            preparedStatement.setString(++x, usuario.getTelefone());
            preparedStatement.setString(++x, usuario.getCep());
            preparedStatement.setString(++x, usuario.getLogradouro());
            preparedStatement.setString(++x, usuario.getComplemento());
            preparedStatement.setInt(++x, usuario.getNumero());
            preparedStatement.setInt(++x, usuario.getPerfil());
            preparedStatement.setInt(++x, usuario.getTipo_tel());
            preparedStatement.setInt(++x, usuario.getId_estado());
            preparedStatement.setInt(++x, usuario.getId_cidade());
            preparedStatement.setString(++x, usuario.getBairro());
            if (usuario.getSenha() != null) {
                preparedStatement.setString(++x, usuario.getSenha());
            }
            preparedStatement.setInt(++x, usuario.getId());
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();

        }
    }
    
    public void remover(int idUsuario) {
        try {
            PreparedStatement preparedStatement = connection
                    .prepareStatement("UPDATE usuarios SET excluido = NOW() WHERE id = ?");
            preparedStatement.setInt(1, idUsuario);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }   
    }
    
}
