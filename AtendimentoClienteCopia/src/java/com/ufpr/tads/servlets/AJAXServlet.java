/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ufpr.tads.servlets;

import com.ufpr.tads.dao.CidadeDAO;
import com.ufpr.tads.dao.EstadosDAO;
import com.ufpr.tads.dao.ProdutosDAO;
import com.ufpr.tads.dao.UsuarioDAO;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import static javax.faces.component.UIInput.isEmpty;
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
@WebServlet(name = "AJAXServlet", urlPatterns = {"/AJAXServlet"})
public class AJAXServlet extends HttpServlet {

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
        String action = request.getParameter("action");
        switch (action) {
            case "getEstados":
                EstadosDAO EstadosDAO = new EstadosDAO();
                String json = new Gson().toJson(EstadosDAO.getAllEstados());
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
                break;
            case "getCidades":
                CidadeDAO CidadeDAO = new CidadeDAO();
                int id_estado = Integer.parseInt(request.getParameter("estadoId"));
                json = new Gson().toJson(CidadeDAO.getAllCidades(id_estado));
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
                break;
            case "getProdutosCat":
                ProdutosDAO ProdutoDAO = new ProdutosDAO();
                int idCategoria = Integer.parseInt(request.getParameter("id_categoria"));
                json = new Gson().toJson(ProdutoDAO.getAllProdutosCat(idCategoria));
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
                break;
            case "getProdutos":
                ProdutoDAO = new ProdutosDAO();
                json = new Gson().toJson(ProdutoDAO.getAllProdutos());
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
                break;
            case "getCategorias":
                ProdutoDAO = new ProdutosDAO();
                json = new Gson().toJson(ProdutoDAO.getAllCategorias());
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
                break;
            case "getTipoAtendimento":
                ProdutoDAO = new ProdutosDAO();
                json = new Gson().toJson(ProdutoDAO.getAllTipos());
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
                break;
            case "getEquipe":
                UsuarioDAO UsuarioDAO = new UsuarioDAO();
                int idUsuarioSessao = (int) request.getSession().getAttribute("id");
                json = new Gson().toJson(UsuarioDAO.getAllEquipe(idUsuarioSessao));
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
                break;
        }
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
