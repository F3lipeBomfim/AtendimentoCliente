/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ufpr.tads.servlets;

import com.ufpr.tads.beans.Usuario;
import com.ufpr.tads.dao.UsuarioDAO;
import com.ufpr.tads.dao.AtendimentoDAO;
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
@WebServlet(name = "UsuarioServlet", urlPatterns = ("/UsuarioServlet"))
public class UsuarioServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String forward="";
        UsuarioDAO usuariodao = new UsuarioDAO();
        switch (action) {
            case "adicionar":
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
                
                String permissao = request.getParameter("permissao");
                String tipoTel = request.getParameter("tipoTel");

                if(permissao.equals("")){
                    usuario.setPerfil(1);
                }else{
                    usuario.setPerfil(Integer.parseInt(request.getParameter("permissao")));
                }
                
                if(tipoTel.equals("1")){
                    usuario.setTipo_tel(1);
                }else{
                    usuario.setTipo_tel(2);
                }

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
                String idUser = request.getParameter("id");
                if(idUser == null || idUser.isEmpty()){
                    usuariodao.addUser(usuario);
                    if(usuario.getId() > 0){
                        request.setAttribute("msg", "Cadastro feito com sucesso!" );
                        request.setAttribute("class", "success" );
                    }else{
                        request.setAttribute("msg", "Erro ao realizar cadastro!" );
                        request.setAttribute("class", "danger" ); 
                    }
                    forward = "/index.jsp";
                }else{
                    usuario.setId(Integer.parseInt(idUser));
                    usuariodao.alterar(usuario);
                    request.setAttribute("msg", "Usuário modificado com sucesso!" );
                    request.setAttribute("class", "success" ); 
                    
                    int perfil = (int) request.getSession().getAttribute("perfil");
                    if(perfil == 1){
                        forward = "AtendimentoServlet?action=listar_atendimentos";
                    }else if(perfil == 3){
                        forward = "/gerente-equipe.jsp";
                    }
                }
            break;
            case "editar":
                int userId = Integer.parseInt(request.getParameter("id"));
                forward = "/cadastro.jsp";
                request.setAttribute("usuario", usuariodao.getUsuarioById(userId));  
            break;
            case "remover":
                usuariodao = new UsuarioDAO();
                int id = Integer.parseInt(request.getParameter("id_usuario"));
                usuariodao.remover(id);
                forward = "";  
            break;
                
        }
        RequestDispatcher rd = request.getRequestDispatcher(forward);
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