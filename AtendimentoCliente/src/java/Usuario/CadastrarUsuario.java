/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Usuario;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Felipe Bomfim    
 */
@WebServlet(name = "CadastrarUsuario", urlPatterns = ("/CadastrarUsuario"))
public class CadastrarUsuario extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Usuario usuario = new Usuario();
        usuario.setNome(request.getParameter("nome"));
        usuario.setEmail(request.getParameter("email"));
        usuario.setCpf(request.getParameter("cpf"));
        usuario.setTelefone(request.getParameter("tel"));
        usuario.setCep(request.getParameter("cep"));
        usuario.setBairro(request.getParameter("bairro"));
        usuario.setLogradouro(request.getParameter("rua"));
        usuario.setComplemento(request.getParameter("complemento"));
        usuario.setNumero(Integer.parseInt(request.getParameter("num")));
        usuario.setId_estado(Integer.parseInt(request.getParameter("id_estado")));
        usuario.setId_cidade(Integer.parseInt(request.getParameter("id_cidade")));
        usuario.setPerfil(1);

        UsuarioDAO usuariodao = new UsuarioDAO();

        String data = request.getParameter("senha");
        MessageDigest messageDigest;
        try {
            messageDigest = MessageDigest.getInstance("SHA-256");
            messageDigest.update(data.getBytes());
            byte[] messageDigestMD5 = messageDigest.digest();
            StringBuffer stringBuffer = new StringBuffer();
            for (byte bytes : messageDigestMD5) {
                stringBuffer.append(String.format("%02x", bytes & 0xff));
            }
            usuario.setSenha(stringBuffer.toString());
        } catch (NoSuchAlgorithmException exception) {
            // TODO Auto-generated catch block
            exception.printStackTrace();
        }
        usuariodao.addUser(usuario);
        RequestDispatcher view = request.getRequestDispatcher("/index.html");
        request.setAttribute("users", usuariodao.getAllUsers());
        view.forward(request, response);
    }
}