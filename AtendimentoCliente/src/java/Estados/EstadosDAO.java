/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Estados;

import ConnectionFactory.ConnectionFactory;
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
public class EstadosDAO {
    private Connection connection;

    public EstadosDAO() {
        connection = ConnectionFactory.getConnection();
    }
        
    public List<Estados> getAllEstados() {
    List<Estados> ListaDeEstados = new ArrayList<Estados>();
    try {
        Connection con = connection;
        String sql = "SELECT * FROM estados";
        PreparedStatement ps;
        ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Estados estado = new Estados();
            estado.setId(rs.getInt("id"));
            estado.setNome(rs.getString("nome"));
            estado.setUf(rs.getString("sigla"));
            ListaDeEstados.add(estado);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return ListaDeEstados;
    }   
}
