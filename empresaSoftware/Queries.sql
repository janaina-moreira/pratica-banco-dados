/* Nome do Projeto: Banco de Dados da EmpresaSoftware  
Componentes: 
	Deysiele da Silva Sousa 		RA: 2049280
	Elisangela Barbosa Vieira		RA: 2329028
	Helen Santos Cedro 				RA: 2353635
	Janaína Moreira do Nascimento 	RA: 2632213  
	Thiago da Penha Feitosa 		RA: 2415595

 */

/******Queries******/

-- nome de todos os recursos
SELECT nome_recurso 
FROM recurso;


-- conta quantos funcionários há na empresa
SELECT COUNT(cod_recurso) as  'Número de Funcionários'
FROM recurso;

-- Todos os projetos e status deles
SELECT nome_projeto, status_proj 
FROM projeto; 

-- Todos os projetos com status em andamento
SELECT nome_projeto, status_proj 
FROM projeto WHERE status_proj = 'Em andamento'; 


-- Funcionários que tiveram aumento há mais de um ano
SELECT nome_recurso, valor_aumento, valor_salario 
FROM salario 
JOIN recurso ON salario.cod_recurso = recurso.cod_recurso
WHERE salario.data_aumento >= DATE('now', '-13 months'); 


--calculo da média salarial por função
SELECT tipo_funcao, AVG(valor_salario) as salario
FROM recurso 
join funcao on funcao.cod_funcao = recurso.cod_funcao 
join salario on salario.cod_recurso = recurso.cod_recurso 
GROUP BY tipo_funcao;


-- lista todos os projetos e a equipe responsável
SELECT nome_projeto, nome_equipe 
FROM projeto 
join equipe on projeto.cod_equipe = equipe.cod_equipe;


--numero de projeto que cada equipe tem
SELECT nome_equipe, COUNT(cod_projeto) as 'projetos por equipe' 
FROM equipe
join projeto on equipe.cod_equipe = projeto.cod_equipe 
GROUP BY nome_equipe;

--projetos que passaram da data prevista
SELECT nome_projeto, data_inicio_proj, data_term_prev_proj, data_fim_proj 
FROM projeto 
WHERE data_fim_proj > data_term_prev_proj ;


--exibe histórico salarial de um funcionário específico
SELECT nome_recurso, valor_salario, data_aumento, status_salario, valor_aumento, data_aumento 
FROM recurso 
JOIN salario on salario.cod_recurso = recurso.cod_recurso 
WHERE recurso.nome_recurso LIKE'%Maria%'
ORDER BY salario.data_aumento desc;

SELECT * FROM recurso

--lista todos os funcionários de uma equipe especifica
SELECT nome_equipe, nome_recurso 
FROM equipe 
join recurso on recurso.cod_equipe = equipe.cod_equipe 
WHERE nome_equipe LIKE '%al%'






