/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Login;

import Usuario.Usuario;
import Usuario.UsuarioDAO;
import atendimentos.AtendimentoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Felipe Bomfim
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
        String email = request.getParameter("email");
        Usuario usuario = new Usuario();

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
            exception.printStackTrace();
        }
        usuario.setEmail(email);
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        AtendimentoDAO atendimentoDAO = new AtendimentoDAO();
        //faz a requisição verificando se o login e senha inseridos são validos
        usuarioDAO.Logar(usuario);
        String page = "index.php";
        if (usuario.getId() > 0) {
            String nome = usuario.getNome();
            int id = usuario.getId();
            HttpSession session = request.getSession(true);
            session.setAttribute("id", usuario.getId());
            session.setAttribute("nome", usuario.getNome());
            session.setAttribute("perfil", usuario.getPerfil());
            
            if (usuario.getPerfil() == 1)  {
               request.setAttribute("atendimentos", atendimentoDAO.getAllAtendimentos(usuario.getId())); 
               page = "AtendimentoServlet?action=listar_atendimentos"; 
            }else if(usuario.getPerfil() == 2){
               page = "AtendimentoServlet?action=listar_atendimentos_funcionario"; 
            }else if(usuario.getPerfil() == 3){
                page = "AtendimentoServlet?action=listar_atendimentos_gerente";
            } 
            request.setAttribute("msg", "Successo! Aguarde..." );
            request.setAttribute("class", "success" );
        }else{
            request.setAttribute("msg", "Autenticação incorreta. Usuário ou senha inválidos." );
            request.setAttribute("class", "warning" );
            page = "/index.jsp";
        }
        RequestDispatcher rd = request.getRequestDispatcher(page);
        rd.forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
