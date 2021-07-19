/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package atendimentos;

import com.google.gson.Gson;
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
 * @author Felipe Bomfim
 */
@WebServlet(name = "AtendimentoServlet", urlPatterns = {"/AtendimentoServlet"})
public class AtendimentoServlet extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        String forward="";
        int cod = 0;
        HttpSession session = request.getSession(true);
        Atendimento atendimento = new Atendimento();
        AtendimentoDAO atendimentoDAO = new AtendimentoDAO();
        //se não existir id na sessão, redireciona para a tela de login
        if (isEmpty(session.getAttribute("id"))) {
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            request.setAttribute("msg", "Usuário deve se autenticar para acessar o sistema." );
            request.setAttribute("class", "error" );
            rd.forward(request, response);
            return;
        }else{
            int idUsuarioSessao = (int) request.getSession().getAttribute("id");
            int perfil = (int) request.getSession().getAttribute("perfil");
            //se for perfil = 1, permite entrar nas ações abaixo
            if(perfil == 1){
                switch (action) {
                    case "listar_atendimentos":
                        forward = "/cliente-meus-atend.jsp";
                        request.setAttribute("atendimentos", atendimentoDAO.getAllAtendimentos(idUsuarioSessao)); 
                    break;
                    case "detalhes_atendimento":
                        int idAtendimento = Integer.parseInt(request.getParameter("id_atendimento"));
                        atendimento = atendimentoDAO.getAtendimentoById(idAtendimento);
                        if(idUsuarioSessao == atendimento.getId_usuario()){
                           forward = "/cliente-meus-atend-detalhes.jsp";
                           request.setAttribute("atendimentos", atendimento);
                        }else{
                            request.setAttribute("msg", "Você não possuí permissão para visualizar este atendimento." );
                            request.setAttribute("class", "error" );
                            forward = "AtendimentoServlet?action=listar_atendimentos";
                        }
                    break;
                    case "remover":
                        atendimentoDAO = new AtendimentoDAO();
                        int id = Integer.parseInt(request.getParameter("id_atendimento"));
                        atendimentoDAO.remover(id);
                        forward = "";  
                    break;
                    case "novo_atendimento":
                        int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));
                        atendimento.setId_usuario(idUsuario);
                        atendimento.setTitulo(request.getParameter("titulo-novo-atend"));
                        atendimento.setDescricao(request.getParameter("desc-novo-atend"));
                        atendimento.setId_produto(Integer.parseInt(request.getParameter("atend-prod-select")));
                        atendimento.setId_tipo_atendimento(Integer.parseInt(request.getParameter("tipo-atend-select")));

                        java.util.Date date = new java.util.Date();
                        String dateStr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
                        atendimento.setData(dateStr);
                        atendimentoDAO.addAtendimento(atendimento);
                        if(atendimento.getId() > 0){
                            cod = 0;
                        }else{
                            cod = 1;
                        }
                    break;
                    default:
                       request.setAttribute("msg", "Página não encontrada!" );
                       request.setAttribute("class", "info" );
                       forward = "AtendimentoServlet?action=listar_atendimentos";
                    break;
                }
            }else if (perfil == 2){
                switch (action) {
                    case "listar_atendimentos_funcionario":
                        forward = "/operador-atendimentos.jsp";
                    break;
                    case "listagem_filtros":
                        int filro = 0;
                        filro = Integer.parseInt(request.getParameter("filtro"));
                        request.setAttribute("atendimentos", atendimentoDAO.getAllAtendimentosEquipe(filro)); 
                        forward = "/listagem-operador.jsp";
                    break;
                    case "atendimento_detalhes_operador":
                        int idAtendimento = Integer.parseInt(request.getParameter("id"));
                        atendimento = atendimentoDAO.getAtendimentoById(idAtendimento);
                        forward = "/operador-atendimentos-detalhes.jsp";
                        request.setAttribute("atendimentos", atendimento);
                    break;
                    case "adicionar_resposta":
                        idAtendimento = Integer.parseInt(request.getParameter("id"));
                        atendimento.setResposta(request.getParameter("resp"));
                        atendimento.setId(idAtendimento);
                        atendimentoDAO.AdicionarResposta(atendimento);
                        
                        request.setAttribute("msg", "Resposta adicionada com sucesso!" );
                        request.setAttribute("class", "success" ); 
                        forward = "AtendimentoServlet?action=listar_atendimentos_funcionario";
                    break;
                    default:
                        request.setAttribute("msg", "Página não encontrada!" );
                        request.setAttribute("class", "info" );
                        forward = "AtendimentoServlet?action=listar_atendimentos_funcionario";
                    break;
                }
            }else if(perfil == 3){
                switch (action) {
                  case "listar_atendimentos_gerente":
                        forward = "/gerente-atendimentos.jsp";
                    break;
                    case "listagem_filtros":
                        int filro = 0;
                        filro = Integer.parseInt(request.getParameter("filtro"));
                        request.setAttribute("atendimentos", atendimentoDAO.getAllAtendimentosEquipe(filro)); 
                        forward = "/listagem-gerente.jsp";
                    break;
                    case "atendimento_detalhes_gerente":
                        int idAtendimento = Integer.parseInt(request.getParameter("id"));
                        atendimento = atendimentoDAO.getAtendimentoById(idAtendimento);
                        forward = "/gerente-atendimentos-detalhes.jsp";
                        request.setAttribute("atendimentos", atendimento);
                    break;
                    default:
                        request.setAttribute("msg", "Página não encontrada!" );
                        request.setAttribute("class", "info" );
                        forward = "AtendimentoServlet?action=listar_atendimentos_gerente";
                    break;
                }
            }
        }
        if(forward != ""){
            RequestDispatcher rd = request.getRequestDispatcher(forward);
            rd.forward(request, response); 
        }else{
            String json = new Gson().toJson(cod);   
            response.getWriter().write(json); 
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
