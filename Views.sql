use facilit	
GO

CREATE VIEW vagas_regiao   as

select count(*) as quantidade,d.regiao
from bolsa a
inner join beneficiario b on a.idbeneficiario = b.id
inner join municipio c on b.idmunicipio = c.id
inner join estado d on c.idestado = d.id
group by d.regiao

GO

--drop view vagas_raca;
CREATE VIEW vagas_raca as
select count(*) as quantidade,c.raca_beneficiario_bolsa as raca
from bolsa a
inner join beneficiario b on a.idbeneficiario = b.id
inner join tipo_raca c on b.idraca = c.id
group by c.raca_beneficiario_bolsa

GO

CREATE VIEW vagas_genero as
select count(*) as quantidade,
case c.descricao 
	when 'F' then
	   'Feminino'
	when 'M' then
	   'Masculino' 
    else 
	   'Não informado'
end as genero
from bolsa a
inner join beneficiario b on a.idbeneficiario = b.id
inner join tipo_sexo c on b.idsexo = c.id
group by c.descricao

GO
CREATE VIEW vagas_ano as
select COUNT(*) as quantidade, ano
from bolsa
group by ano