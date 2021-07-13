/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Usuario;

//import LoginBean.LoginBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import ConnectionFactory.ConnectionFactory;

/**
 *
 * @author Felipe Bomfim    
 */

public class UsuarioDAO {
    private Connection connection;

    public UsuarioDAO() {
        connection = ConnectionFactory.getConnection();
    }
     public void consulta(Usuario Usuario){

       try{
        Connection con = connection;
        String sql = "SELECT id_usuario, nome_usuario FROM tb_usuario WHERE login_usuario = ? AND senha_usuario = ? LIMIT 1";
        PreparedStatement ps;
        
        ps = con.prepareStatement(sql);
        ps.setString(1, Usuario.getNome());
        ps.setString(2, Usuario.getSenha());

        ResultSet resultSet = ps.executeQuery();
          while(resultSet.next()){ 
             Usuario.setId(resultSet.getInt("id_usuario"));
             Usuario.setNome(resultSet.getString("nome_usuario"));
          }
          ps.close();
       }
       catch(Exception e){
          System.out.println(e);
       }
    }
     
    public List<Usuario> getAllUsers() {
    List<Usuario> listaDeUsuario = new ArrayList<Usuario>();
    try {
        Connection con = connection;
        String sql = "select * from tb_usuario";
        PreparedStatement ps;
        ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Usuario usuario = new Usuario();
            usuario.setId(rs.getInt("id_usuario"));
            usuario.setNome(rs.getString("nome_usuario"));
            usuario.setEmail(rs.getString("login_usuario"));
            usuario.setSenha(rs.getString("senha_usuario"));

            listaDeUsuario.add(usuario);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return listaDeUsuario;
    }
    
    public void addUser(Usuario Usuario) {
      try {
        Connection con = connection;
        String sql = "INSERT INTO usuarios(nome, email, senha, cpf, telefone, cep, logradouro, numero, complemento,"
                + " perfil, id_estado, id_cidade, bairro) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
          // Parameters start with 1
          PreparedStatement ps;
          ps = con.prepareStatement(sql);

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
          ps.setString(13, Usuario.getBairro());

          ps.executeUpdate();

      } catch (SQLException e) {
          e.printStackTrace();
      }
    }
    
}
