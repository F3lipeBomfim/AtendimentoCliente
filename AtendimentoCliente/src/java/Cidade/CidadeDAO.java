/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Cidade;

import ConnectionFactory.ConnectionFactory;
import Estados.Estados;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Felipe Bomfim    
 */
public class CidadeDAO {
     private Connection connection;

    public CidadeDAO() {
        connection = ConnectionFactory.getConnection();
    }
    public List<Cidade> getAllCidades(int id_estado) {
    List<Cidade> ListaDeCidades = new ArrayList<Cidade>();
    try {
        Connection con = connection;
        String sql = "SELECT * FROM cidades WHERE id_estado = ? ORDER BY nome ASC";
        PreparedStatement ps;
        ps = con.prepareStatement(sql);
        ps.setInt(1, id_estado);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Cidade cidade = new Cidade();
            cidade.setId_cidade(rs.getInt("id"));
            cidade.setNome(rs.getString("nome"));
            cidade.setId_estado(rs.getInt("id"));
            ListaDeCidades.add(cidade);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return ListaDeCidades;
    }   
    
}
