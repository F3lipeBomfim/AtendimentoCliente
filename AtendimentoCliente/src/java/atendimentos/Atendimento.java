/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package atendimentos;

import java.util.Date;

/**
 *
 * @author Felipe Bomfim    
 */
public class Atendimento {
    private int id;
    private int id_usuario;
    private int situacao;
    private int id_tipo_atendimento;
    private int id_produto;
    private String descricao;
    private String nome_usuario;
    private String email_usuario;
    private String nome_situacao;
    private String tipoAtendimento;
    private String produto;
    private String titulo;
    private String data;
    private String date_diff;
    private String resposta;
    private String data_resposta;

    public String getData_resposta() {
        return data_resposta;
    }

    public void setData_resposta(String data_resposta) {
        this.data_resposta = data_resposta;
    }

    public String getResposta() {
        return resposta;
    }

    public void setResposta(String resposta) {
        this.resposta = resposta;
    }

    public String getEmail_usuario() {
        return email_usuario;
    }

    public void setEmail_usuario(String email_usuario) {
        this.email_usuario = email_usuario;
    }

    public String getNome_usuario() {
        return nome_usuario;
    }

    public void setNome_usuario(String nome_usuario) {
        this.nome_usuario = nome_usuario;
    }

    public String getDate_diff() {
        return date_diff;
    }

    public void setDate_diff(String date_diff) {
        this.date_diff = date_diff;
    }

    public int getId_produto() {
        return id_produto;
    }

    public void setId_produto(int id_produto) {
        this.id_produto = id_produto;
    }

    public int getId_tipo_atendimento() {
        return id_tipo_atendimento;
    }

    public void setId_tipo_atendimento(int id_tipo_atendimento) {
        this.id_tipo_atendimento = id_tipo_atendimento;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }
    
    public String getNome_situacao() {
        return nome_situacao;
    }

    public void setNome_situacao(String nome_situacao) {
        this.nome_situacao = nome_situacao;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public String getTitulo() {
        return titulo;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public int getSituacao() {
        return situacao;
    }

    public void setSituacao(int situacao) {
        this.situacao = situacao;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getTipoAtendimento() {
        return tipoAtendimento;
    }

    public void setTipoAtendimento(String tipoAtendimento) {
        this.tipoAtendimento = tipoAtendimento;
    }

    public String getProduto() {
        return produto;
    }

    public void setProduto(String produto) {
        this.produto = produto;
    }
}
