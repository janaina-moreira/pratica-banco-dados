/* Nome do Projeto: Banco de Dados da EmpresaSoftware  
Componentes: 
	Deysiele da Silva Sousa 		RA: 2049280
	Elisangela Barbosa Vieira		RA: 2329028
	Helen Santos Cedro 				RA: 2353635
	Janaína Moreira do Nascimento 	RA: 2632213  
	Thiago da Penha Feitosa 		RA: 2415595

 */

/* Criando o Banco de dados */
CREATE DATABASE bd_empresa_software;
USE bd_empresa_software;

/* Criação da Tabela tarefa */
CREATE TABLE tarefa (
    cod_tarefa int PRIMARY KEY UNIQUE, /* PK */
    descricao_tarefa varchar(350) NOT NULL
);

/* Criação da Tabela atividade */
CREATE TABLE atividade (
    cod_atividade int PRIMARY KEY UNIQUE, /* PK */
    nome_atividade CHAR(100) NOT NULL,
    cod_tarefa int,
    FOREIGN KEY (cod_tarefa) REFERENCES tarefa (cod_tarefa) /* FK */
);

/* Criação da Tabela ferramenta */
CREATE TABLE ferramenta (
    cod_ferramenta int PRIMARY KEY UNIQUE, /* PK */
    tipo_ferramenta varchar(30) NOT NULL,
    versao_ferramenta varchar(30) NOT NULL
);

/* Criação da Tabela endereco */
CREATE TABLE endereco (
    cod_endereco int PRIMARY KEY UNIQUE, /* PK */
    rua varchar(100) NOT NULL,
    bairro varchar(100) NOT NULL,
    cidade varchar(90) NOT NULL,
    pais varchar(60) NOT NULL,
    estado varchar(100) NOT NULL,
    numero int NOT NULL,
    complemento varchar(100),
    cep int NOT NULL
);

/* Criação da Tabela funcao */
CREATE TABLE funcao (
    cod_funcao int PRIMARY KEY UNIQUE, /* PK */
    tipo_funcao char(50) NOT NULL
);

/* Criação da Tabela equipe */
CREATE TABLE equipe (
    cod_equipe int PRIMARY KEY UNIQUE, /* PK */
    nome_equipe varchar(30) NOT NULL,
    quantidade_recurso int NOT NULL
);

/* Criação da Tabela recurso */
CREATE TABLE recurso (
    cod_recurso int PRIMARY KEY UNIQUE, /* PK */
    nome_recurso char(100) NOT NULL,
    cod_endereco int,
    cod_funcao int,
    cod_ferramenta int,
    cod_equipe int,
    FOREIGN KEY (cod_endereco) REFERENCES endereco (cod_endereco), /* FK */
    FOREIGN KEY (cod_funcao) REFERENCES funcao (cod_funcao), /* FK */
    FOREIGN KEY (cod_ferramenta) REFERENCES ferramenta (cod_ferramenta), /* FK */
    FOREIGN KEY (cod_equipe) REFERENCES equipe (cod_equipe) /* FK */
);

/* Criação da Tabela projeto */
CREATE TABLE projeto (
    cod_projeto int PRIMARY KEY UNIQUE, /* PK */
    nome_projeto varchar(50) NOT NULL,
    data_inicio_proj date NOT NULL,
    data_fim_proj date,
    data_term_prev_proj date NOT NULL,
    status_proj char(25) NOT NULL,
    num_hora_prev_proj int NOT NULL,
    num_hora_usada_proj int,
    cod_atividade int,
    cod_equipe int,
    FOREIGN KEY (cod_atividade) REFERENCES atividade (cod_atividade), /* FK */
    FOREIGN KEY (cod_equipe) REFERENCES equipe (cod_equipe) /* FK */
    CHECK (status_proj IN ('Em andamento', 'Finalizado', 'Cancelado', 'Aguardando Prioridade'))
);

/* Criação da Tabela salario */
CREATE TABLE salario (
    cod_salario int PRIMARY KEY UNIQUE, /* PK */
    data_aumento date NOT NULL,
    valor_aumento decimal(10,2) NOT NULL,
    valor_salario decimal(10,2) NOT NULL,
    status_salario char(15) NOT NULL, /* "Vigente" ou "Reajustado" */
    cod_recurso int,
    FOREIGN KEY (cod_recurso) REFERENCES recurso (cod_recurso) /* FK */
    CHECK (status_salario IN ('vigente', 'reajustado')
);

/* Criação da Tabela telefone */
CREATE TABLE telefone (
    cod_fone int PRIMARY KEY UNIQUE, /* PK */
    tipo_fone varchar(30) NOT NULL,
    numero_fone varchar(25) NOT NULL,
    cod_recurso int,
    FOREIGN KEY (cod_recurso) REFERENCES recurso (cod_recurso) /* FK */
);

/* Inserções nas tabelas */
INSERT INTO tarefa (cod_tarefa, descricao_tarefa)  
VALUES  
(1, 'Instalação do Pacote Office'),  
(2, 'Substituição de disco rígido'),  
(3, 'Atualização para Windows 11'),  
(4, 'Configuração de VPN'),  
(5, 'Suporte ao Microsoft Teams');

INSERT INTO atividade (cod_atividade, nome_atividade, cod_tarefa)  
VALUES  
(1, 'Instalação de software', 1),  
(2, 'Manutenção de Hardware', 2),  
(3, 'Atualização do sistema operacional', 3),  
(4, 'Configuração de rede', 4),  
(5, 'Suporte ao usuário', 5);

INSERT INTO ferramenta (cod_ferramenta, tipo_ferramenta, versao_ferramenta)  
VALUES  
(1, 'Python', '3.9'),  
(2, 'Java', '16'),  
(3, 'JavaScript', 'ES6'),  
(4, 'C#', '9.0'),  
(5, 'Ruby', '3.0');

INSERT INTO endereco (cod_endereco, rua, bairro, cidade, pais, estado, numero, complemento, cep)  
VALUES  
(1, 'Rua das Flores', 'Jardim das Rosas', 'São Paulo', 'Brasil', 'São Paulo', 123, 'Apto 45', 12345678),  
(2, 'Avenida Paulista', 'Bela Vista', 'São Paulo', 'Brasil', 'São Paulo', 456, 'Bloco B', 87654321),  
(3, 'Rua Augusta', 'Consolação', 'São Paulo', 'Brasil', 'São Paulo', 789, 'Casa 10', 23456789),  
(4, 'Alameda Santos', 'Jardim Paulista', 'São Paulo', 'Brasil', 'São Paulo', 101, 'Loja 5', 34567890),  
(5, 'Rua Oscar Freire', 'Jardim Paulista', 'São Paulo', 'Brasil', 'São Paulo', 112, 'Sala 300', 45678901),  
(6, 'Rua Maria Clotilde', 'Ubirajara', 'São Paulo', 'Brasil', 'São Paulo', 1182, null, 45678701);

INSERT INTO funcao (cod_funcao, tipo_funcao)  
VALUES  
(1, 'Gerente'),  
(2, 'Programador'),  
(3, 'Analista'),  
(4, 'Desenvolvedor'),  
(5, 'Arquiteto de Software');

INSERT INTO equipe (cod_equipe, nome_equipe, quantidade_recurso)  
VALUES  
(1, 'Equipe Alpha', 5),  
(2, 'Equipe Beta', 3),  
(3, 'Equipe Gamma', 2);

INSERT INTO recurso (cod_recurso, nome_recurso, cod_endereco, cod_funcao, cod_ferramenta, cod_equipe)  
VALUES  
(1, 'Maria Santos', 1, 1, 1, 1),  
(2, 'João Silva', 2, 2, 2, 1),  
(3, 'Pedro Oliveira', 3, 3, 3, 1),  
(4, 'Ana Pereira', 4, 4, 4, 2),  
(5, 'Carlos Souza', 5, 5, 5, 2),  
(6, 'Janaína Moreira do Nascimento', 6, 1, 1, 3);

INSERT INTO projeto (cod_projeto, nome_projeto, data_inicio_proj, data_fim_proj, data_term_prev_proj, status_proj, num_hora_prev_proj, num_hora_usada_proj, cod_atividade, cod_equipe)  
VALUES  
(1, 'Projeto Alpha', '2023-01-01', NULL, '2023-12-31', 'Em andamento', 2000, 500, 1, 1),  
(2, 'Projeto Beta', '2023-02-01', NULL, '2023-12-31', 'Em andamento', 1800, 450, 2, 2),  
(3, 'Projeto Gamma', '2023-03-01', NULL, '2023-12-31', 'Em andamento', 2200, 1100, 3, 3),  
(4, 'Projeto Delta', '2023-04-01', NULL, '2023-12-31', 'Em andamento', 2400, 1200, 4, 1),  
(5, 'Projeto Epsilon', '2023-05-01', NULL, '2023-12-31', 'Em andamento', 2600, 1300, 5, 2),  
(6, 'Projeto Zeta', '2023-06-01', '2023-12-31', '2023-12-31', 'Finalizado', 2800, 1400, 1, 1),  
(7, 'Projeto Eta', '2023-07-01', '2023-12-31', '2023-12-31', 'Aguardando Prioridade', 3000, 1500, 2, 2),  
(8, 'Projeto Theta', '2023-08-01', '2023-12-31', '2023-12-31', 'Cancelado', 3200, 1600, 3, 3);

INSERT INTO salario (cod_salario, data_aumento, valor_aumento, valor_salario, status_salario, cod_recurso)  
VALUES  
(1, '2023-07-01', 500.00, 3500.00, 'Vigente', 1),  
(2, '2023-08-01', 600.00, 3600.00, 'Vigente', 2),  
(3, '2023-09-01', 700.00, 3700.00, 'Vigente', 3),  
(4, '2023-10-01', 800.00, 3800.00, 'Vigente', 4),  
(5, '2023-11-01', 900.00, 3900.00, 'Vigente', 5);

INSERT INTO telefone (cod_fone, tipo_fone, numero_fone, cod_recurso)  
VALUES  
(1, 'Celular', '11987654321', 1),  
(2, 'Fixo', '11387654321', 2),  
(3, 'Celular', '11947654321', 3),  
(4, 'Celular', '11927654321', 4),  
(5, 'Fixo', '11317654321', 5);

 

