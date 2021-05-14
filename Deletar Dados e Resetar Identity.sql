/****** Script do comando SelectTopNRows de SSMS  ******/
use facilit


-- Deletar os dados
delete from importacao
delete from beneficiario;
delete from bolsa;
delete from municipio;
delete from curso;
delete from turno;
delete from modalidade_bolsa;
delete from estado;
delete from tipo_sexo;
delete from tipo_raca  ;
delete from tipo_bolsa;

-- Resetar os identity
DBCC CHECKIDENT('[turno]', RESEED, 0);
DBCC CHECKIDENT('[tipo_sexo]', RESEED, 0);
DBCC CHECKIDENT('[tipo_raca]', RESEED, 0);
DBCC CHECKIDENT('[tipo_bolsa]', RESEED, 0);
DBCC CHECKIDENT('[municipio]', RESEED, 0);
DBCC CHECKIDENT('[estado]', RESEED, 0);
DBCC CHECKIDENT('[curso]', RESEED, 0);
DBCC CHECKIDENT('[bolsa]', RESEED, 0);
DBCC CHECKIDENT('[beneficiario]', RESEED, 0);


-- Povoar a tabela importacao
--insert into importacao select * from importacao2016;
--insert into importacao select * from importacao2018;
--select count(*) from importacao;
