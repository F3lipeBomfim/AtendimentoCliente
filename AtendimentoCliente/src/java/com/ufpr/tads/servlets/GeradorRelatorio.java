/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ufpr.tads.servlets;

import com.ufpr.tads.dao.ConnectionFactory;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URL;
import java.text.ParseException;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import static javax.faces.component.UIInput.isEmpty;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 *
 * @author Fernando
 */
@WebServlet(name = "GeradorRelatorio", urlPatterns = {"/GeradorRelatorio"})
public class GeradorRelatorio extends HttpServlet {

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
        try {
            HttpSession session = request.getSession(true);
        if (isEmpty(session.getAttribute("id"))) {
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            request.setAttribute("msg", "Usuário deve se autenticar para acessar o sistema.");      
            rd.forward(request, response);
            return;
        }
            String host = "http://" + request.getServerName() + ":" + request.getServerPort();
            String action = request.getParameter("action");
            URL jasperURL = null;
            HashMap params = new HashMap();
            int x = 0;
            switch (action) {
                case "funcionarios":
                    String jasper = request.getContextPath() + "/relatorios" + "/RelatorioFuncionarios.jasper";
                    jasperURL = new URL(host + jasper);
                    break;
                case "reclamacoes":
                    String str = (String) request.getParameter("tipo");
                    if (str.equals("Todos")) {
                        jasper = request.getContextPath() + "/relatorios" + "/RelatorioReclamacoesTodos.jasper";
                        jasperURL = new URL(host + jasper);
                    } else if (str.equals("Em aberto")) {
                        jasper = request.getContextPath() + "/relatorios" + "/RelatorioReclamacoes.jasper";
                        jasperURL = new URL(host + jasper);
                        x = 1;
                    } else if (str.equals("Finalizados")) {
                        jasper = request.getContextPath() + "/relatorios" + "/RelatorioReclamacoes.jasper";
                        jasperURL = new URL(host + jasper);
                        x = 2;
                    }
                    params.put("situacao", x);
                    break;
                case "aberto":
                    String dtini = request.getParameter("datainicio");
                    String dtfim = request.getParameter("datafim");
                    Date date1 = new SimpleDateFormat("yyyy-MM-dd").parse(dtini);
                    Date date2 = new SimpleDateFormat("yyyy-MM-dd").parse(dtfim);
                    jasper = request.getContextPath() + "/relatorios" + "/RelatorioAtendimentoData.jasper";
                    jasperURL = new URL(host + jasper);
                    params.put("DataInicio", date1);
                    params.put("DataFim", date2);
                    break;
                case "produtos":
                    jasper = request.getContextPath() + "/relatorios" + "/ProdutosMaisReclamados.jasper";
                    jasperURL = new URL(host + jasper);
                    break;
            }

            byte[] bytes = JasperRunManager.runReportToPdf(
                    jasperURL.openStream(),
                    params,
                    ConnectionFactory.getConnection());
            if (bytes != null) {
                response.setContentType("application/pdf");
                OutputStream ops = response.getOutputStream();
                ops.write(bytes);
            }
        } catch (JRException ex) {
            Logger.getLogger(GeradorRelatorio.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(GeradorRelatorio.class.getName()).log(Level.SEVERE, null, ex);
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
