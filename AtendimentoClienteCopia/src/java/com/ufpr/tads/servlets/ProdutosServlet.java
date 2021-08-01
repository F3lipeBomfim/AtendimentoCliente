/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ufpr.tads.servlets;

import com.ufpr.tads.beans.Produtos;
import com.ufpr.tads.dao.ProdutosDAO;
import com.ufpr.tads.beans.Usuario;
import com.ufpr.tads.dao.AtendimentoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
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
 * @author lipe1
 */
@WebServlet(name = "ProdutosServlet", urlPatterns = {"/ProdutosServlet"})
public class ProdutosServlet extends HttpServlet {

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
        String forward = "";
        Produtos produto = new Produtos();
        ProdutosDAO produtoDAO = new ProdutosDAO();

        HttpSession session = request.getSession(true);
        if (isEmpty(session.getAttribute("id"))) {
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            request.setAttribute("msg", "Usuário deve se autenticar para acessar o sistema.");
            request.setAttribute("class", "error");
            rd.forward(request, response);
            return;
        } else {
            switch (action) {
                case "adicionar_categoria":
                    forward = "/operador-atendimentos.jsp";
                    String idCategoria = request.getParameter("id");
                    produto.setNome_categoria(request.getParameter("nome_categoria"));

                    if (idCategoria == null || idCategoria.isEmpty()) {
                        produtoDAO.AddCategoria(produto);
                        forward = "/operador-categorias.jsp";
                    } else {
                        produto.setId_categoria(Integer.parseInt(idCategoria));
                        produtoDAO.AlterarProduto(produto);
                        forward = "/operador-categorias.jsp";
                    }
                    break;
                case "remover_categoria":
                    int id = Integer.parseInt(request.getParameter("id"));
                    produtoDAO.removerCategoria(id);
                    forward = "";
                    break;
                case "remover_produto":
                    id = Integer.parseInt(request.getParameter("id"));
                    produtoDAO.removerProduto(id);
                    forward = "";
                    break;
                case "alterar_produto":
                    id = Integer.parseInt(request.getParameter("id"));
                    produto.setId(id);
                    produto.setNome(request.getParameter("nome_prod"));
                    produto.setDescricao(request.getParameter("desc_prod"));
                    produtoDAO.AlterarProd(produto);
                    forward = "";
                    break;
                case "adicionar_produto":
                    forward = "";
                    produto.setNome(request.getParameter("nome_produto"));
                    produto.setDescricao(request.getParameter("descricao"));
                    produto.setId_categoria(Integer.parseInt(request.getParameter("categoria")));
                    produto.setPeso(Integer.parseInt(request.getParameter("peso")));
                    produtoDAO.adicionarProduto(produto);
                    if (produto.getId() > 0) {
                        request.setAttribute("msg", "Sucesso ao adicionar produto!");
                        request.setAttribute("class", "success");
                    }
                    forward = "/operador-produtos.jsp";
                    break;
                default:
                    request.setAttribute("msg", "Página não encontrada!");
                    request.setAttribute("class", "info");
                    forward = "AtendimentoServlet?action=listar_atendimentos_funcionario";
                    break;
            }
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
