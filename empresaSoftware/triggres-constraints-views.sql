/* Nome do Projeto: Banco de Dados da EmpresaSoftware  
Componentes: 
	Deysiele da Silva Sousa 		RA: 2049280
	Elisangela Barbosa Vieira		RA: 2329028
	Helen Santos Cedro 				RA: 2353635
	Janaína Moreira do Nascimento 	RA: 2632213  
	Thiago da Penha Feitosa 		RA: 2415595

 */

CREATE VIEW vw_status_projetos AS
SELECT 
    p.id_proj,
    p.nome_proj,
    p.descricao_proj,
    p.status_proj
FROM 
    projeto p;
   
   
   CREATE VIEW vw_recursos_em_uso AS
SELECT 
    p.id_proj,
    p.nome_proj,
    r.id_recurso,
    r.nome_recurso
FROM 
    projeto p
JOIN 
    projeto_recurso pr ON p.id_proj = pr.id_proj
JOIN 
    recurso r ON pr.id_recurso = r.id_recurso;
   
   CREATE VIEW vw_funcionarios_projetos_atrasados AS
SELECT 
    f.id_funcionario,
    f.nome_funcionario,
    f.tipo_funcao,
    p.id_proj,
    p.nome_proj,
    p.status_proj
FROM 
    funcionario f
JOIN 
    projeto_funcionario pf ON f.id_funcionario = pf.id_funcionario
JOIN 
    projeto p ON pf.id_proj = p.id_proj
WHERE 
    p.status_proj = 'Atrasado';
   
   CREATE VIEW vw_projeto_recursos_funcionarios AS
SELECT 
    p.id_proj,
    p.nome_proj,
    p.descricao_proj,
    p.status_proj,
    r.id_recurso,
    r.nome_recurso,
    f.id_funcionario,
    f.nome_funcionario,
    f.tipo_funcao
FROM 
    projeto p
JOIN 
    projeto_recurso pr ON p.id_proj = pr.id_proj
JOIN 
    recurso r ON pr.id_recurso = r.id_recurso
JOIN 
    projeto_funcionario pf ON p.id_proj = pf.id_proj
JOIN 
    funcionario f ON pf.id_funcionario = f.id_funcionario;
   
   
   -- Constraints 
   
 CREATE TABLE projeto_funcionario (
    id_proj INT,
    id_funcionario INT,
    PRIMARY KEY (id_proj, id_funcionario),  -- Chave primária composta
    FOREIGN KEY (id_proj) REFERENCES projeto(id_proj) ON DELETE CASCADE,  -- Chave estrangeira para projeto
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario) ON DELETE CASCADE  -- Chave estrangeira para funcionario
);


CREATE TABLE projeto_recurso (
    id_proj INT,
    id_recurso INT,
    PRIMARY KEY (id_proj, id_recurso),  -- Chave primária composta
    FOREIGN KEY (id_proj) REFERENCES projeto(id_proj) ON DELETE CASCADE,  -- Chave estrangeira para projeto
    FOREIGN KEY (id_recurso) REFERENCES recurso(id_recurso) ON DELETE CASCADE  -- Chave estrangeira para recurso
);


CREATE TABLE IF NOT EXISTS tarefa (
    id_tarefa INTEGER PRIMARY KEY,
    nome_tarefa VARCHAR(255) NOT NULL,
    descricao_tarefa TEXT,
    cod_projeto INTEGER,
    FOREIGN KEY (cod_projeto) REFERENCES projeto(cod_projeto) ON DELETE CASCADE
);


CREATE TRIGGER TGR_TAREFA_INSERT
AFTER INSERT ON tarefa
FOR EACH ROW
BEGIN
    UPDATE projeto
    SET orcamento = orcamento + NEW.valor_tarefa
    WHERE cod_projeto = NEW.cod_projeto;
END;


CREATE TRIGGER TGR_ATUALIZA_HORAS_USADAS
AFTER INSERT ON tarefa
BEGIN
    -- Atualiza o número de horas usadas no projeto, adicionando 10 horas ao total de horas usadas
    UPDATE projeto
    SET num_hora_usada_proj = num_hora_usada_proj + 10  -- Exemplo: adiciona 10 horas para cada tarefa
    WHERE cod_projeto = (SELECT cod_projeto FROM INSERTED LIMIT 1);
END;


