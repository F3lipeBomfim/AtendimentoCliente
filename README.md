# AtendimentoCliente


CREATE TABLE `atendimento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) DEFAULT NULL,
  `data_hora_cadastro` datetime DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `situacao` int(11) DEFAULT NULL COMMENT '1= Em Aberto, 2= Finalizadas.',
  `id_produto` int(11) DEFAULT NULL,
  `tipo_atendimento` int(11) DEFAULT NULL,
  `descricao` longtext,
  `resposta` varchar(500) DEFAULT NULL,
  `data_hora_resposta` datetime DEFAULT NULL,
  `excluido` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8


CREATE TABLE `categoria_produto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8


CREATE TABLE `cidades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_estado` int(11) NOT NULL,
  `nome` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5300109 DEFAULT CHARSET=utf8


CREATE TABLE `estados` (
  `id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) CHARACTER SET latin1 NOT NULL,
  `sigla` varchar(100) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8

CREATE TABLE `produto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) DEFAULT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `descricao` varchar(300) DEFAULT NULL,
  `peso` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8

CREATE TABLE `tipo_atendimento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8

CREATE TABLE `usuarios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `cpf` varchar(50) DEFAULT NULL,
  `senha` varchar(200) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `tipo_tel` int(20) DEFAULT NULL COMMENT '1- telefone, 2- celular',
  `cep` char(10) DEFAULT NULL,
  `logradouro` varchar(255) DEFAULT NULL,
  `numero` varchar(10) DEFAULT NULL,
  `complemento` varchar(30) DEFAULT NULL,
  `id_estado` int(10) DEFAULT NULL,
  `id_cidade` int(10) DEFAULT NULL,
  `bairro` varchar(10) DEFAULT NULL,
  `perfil` int(11) DEFAULT NULL COMMENT '1 - Cliente, 2 - Funcionário 3 - Gerente',
  `excluido` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8
