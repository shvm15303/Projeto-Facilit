use facilit

-- Variáveis
DECLARE @ano int,@codigo_ies int,@bolsa varchar(256),@tipobolsa varchar(256),@modalidade varchar(256),
@cusro varchar(256),@turno varchar(256),@cpf varchar(16),@sexo char(1),@raca varchar(256),
@data date,@deficiente char(3),@regiao varchar(256),@uf char(2),@municipio varchar(256),@idestado int,
@idmunicipio int,@idcurso int,@idturno int,@idtipobolsa int,@idtiporaca int,@idtiposexo int,
@idbeneficiario int,@idbolsa int,@idmodalidadebolsa int


-- Cursor para percorrer os registros
DECLARE cursor1 CURSOR FOR 
SELECT [ANO_CONCESSAO_BOLSA]
      ,[CODIGO_EMEC_IES_BOLSA]
      ,[NOME_IES_BOLSA]
      ,[TIPO_BOLSA]
      ,[MODALIDADE_ENSINO_BOLSA]
      ,[NOME_CURSO_BOLSA]
      ,[NOME_TURNO_CURSO_BOLSA]
      ,[CPF_BENEFICIARIO_BOLSA]
      ,[SEXO_BENEFICIARIO_BOLSA]
      ,[RACA_BENEFICIARIO_BOLSA]
      ,[DT_NASCIMENTO_BENEFICIARIO]
      ,[BENEFICIARIO_DEFICIENTE_FISICO]
      ,[REGIAO_BENEFICIARIO_BOLSA]
      ,[SIGLA_UF_BENEFICIARIO_BOLSA]
      ,[MUNICIPIO_BENEFICIARIO_BOLSA]
  FROM [dbo].[importacao]


--Abrindo Cursor
OPEN cursor1


-- Lendo a próxima linha
FETCH NEXT FROM cursor1 INTO @ano,@codigo_ies,@bolsa,@tipobolsa,@modalidade,@cusro,@turno,@cpf,@sexo,@raca,
@data,@deficiente,@regiao,@uf,@municipio

-- Percorrendo linhas do cursor (enquanto houverem)
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Verificar e inserir modalidade bolsa
	select @idmodalidadebolsa = (select id from modalidade_bolsa where upper(trim(modalidade_bolsa)) = upper(trim(@modalidade)));
	if @idmodalidadebolsa is null and @modalidade is not null
	begin
	   insert into modalidade_bolsa(modalidade_bolsa)  values (@modalidade);
	   SELECT @idmodalidadebolsa = @@IDENTITY;
	end

    -- Verificar e inserir tipo sexo
	select @idtiposexo = (select id from tipo_sexo where SUBSTRING(upper(trim(sexo_beneficiario_bolsa)),1,1) = SUBSTRING(upper(trim(@sexo)),1,1));
	if @idtiposexo is null and @sexo is not null
	begin
	   insert into tipo_sexo(sexo_beneficiario_bolsa,descricao)  values (SUBSTRING(@sexo,1,1),@sexo);
	   SELECT @idtiposexo = @@IDENTITY;
	end

    -- Verificar e inserir tipo raça
	select @idtiporaca = (select id from tipo_raca where upper(trim(raca_beneficiario_bolsa)) = upper(trim(@raca)));
	if @idtiporaca is null and @raca is not null
	begin
	   insert into tipo_raca(raca_beneficiario_bolsa)  values (@raca);
	   SELECT @idtiporaca = @@IDENTITY;
	end
    
	-- Verificar e inserir tipo bolsa
	select @idtipobolsa = (select id from tipo_bolsa where upper(trim(tipo_bolsa)) = upper(trim(@tipobolsa)));
	if @idtipobolsa is null and @tipobolsa is not null
	begin
	   insert into tipo_bolsa(tipo_bolsa)  values (@tipobolsa);
	   SELECT @idtipobolsa = @@IDENTITY;
	end
    
	-- Verificar e inserir turno
	select @idturno = (select id from turno where upper(trim(nome_turno_curso_bolsa)) = upper(trim(@turno)));
	if @idturno is null and @turno is not null
	begin
	   insert into turno(nome_turno_curso_bolsa)  values (@turno);
	   SELECT @idturno = @@IDENTITY;
	end

	-- Verificar e inserir curso
	select @idcurso = (select id from curso where upper(trim(nome_curso_bolsa)) = upper(trim(@cusro)));
	if @idcurso is null and @cusro is not null 
	begin
	   insert into curso(nome_curso_bolsa)  values (@cusro);
	   SELECT @idcurso = @@IDENTITY;
	end
	
	-- Verificar e inserir estado
    select @idestado = (select id from estado where trim(uf) = trim(@uf));
	if @idestado is null
	begin
	   insert into estado(uf,regiao)  values (@uf,@regiao);
	   SELECT @idestado = @@IDENTITY;
	end

	-- Verificar e inserir municipio
	select @idmunicipio = (select id from municipio where trim(municipio_beneficiario_bolsa) = trim(@municipio));
	if @idmunicipio is null
	begin
	    insert into municipio (municipio_beneficiario_bolsa,idestado) values (trim(@municipio),@idestado);
		SELECT @idmunicipio = @@IDENTITY;
    end

	-- Verificar e inserir beneficiario
	--select @idbeneficiario = (select id from beneficiario where trim(cpf_beneficiario_bolsa) = trim(@cpf));
	--if @idbeneficiario is null and @cpf is not null
	--begin
    insert into beneficiario (cpf_beneficiario_bolsa,dt_nascimento,beneficiario_deficiente_fisico,
	idsexo,idraca,idmunicipio) values (@cpf,@data,@deficiente,@idtiposexo,@idtiporaca,@idmunicipio);
	SELECT @idbeneficiario = @@IDENTITY;
	--end

	-- inserir bolsa
    insert into bolsa(ano,code_ies,nome_ies_bolsa,idbeneficiario,idcurso,idturno,idmodalidade,idtipobolsa) 
	values (@ano,@codigo_ies,@bolsa,@idbeneficiario,@idcurso,@idturno,@idmodalidadebolsa,@idtipobolsa);

-- Lendo a próxima linha
    FETCH NEXT FROM cursor1 INTO @ano,@codigo_ies,@bolsa,@tipobolsa,@modalidade,@cusro,@turno,@cpf,@sexo,@raca,
    @data,@deficiente,@regiao,@uf,@municipio
END

-- Fechando Cursor para leitura
CLOSE cursor1
 
-- Finalizado o cursor
DEALLOCATE cursor1