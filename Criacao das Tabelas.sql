use facilit;


create table tipo_bolsa(
	id int IDENTITY(1,1) primary key,
	tipo_bolsa varchar(256) not null
);

create table tipo_raca(
	id int IDENTITY(1,1)primary key,
	raca_beneficiario_bolsa varchar(20)
);

create table tipo_sexo(
	id int IDENTITY(1,1) primary key,
	sexo_beneficiario_bolsa char(1)
);

create table modalidade_bolsa(
	id int IDENTITY(1,1) primary key,
	modalidade_bolsa varchar(256) not null
);
create table turno(
	id int IDENTITY(1,1) primary key,
	nome_turno_curso_bolsa varchar(256) not null 
);

create table curso(
	id int IDENTITY(1,1) primary key,
	nome_curso_bolsa varchar(256) not null 
);


create table estado(
    id int IDENTITY(1,1) primary key,
	uf varchar(2),
	regiao varchar(50)
);

create table municipio(
	id int IDENTITY(1,1) primary key,
	municipio_beneficiario_bolsa varchar(256),
	idestado int,
	
	foreign key (idestado) references estado(id)
	
);

create table beneficiario(
	id int IDENTITY(1,1) primary key,
	cpf_beneficiario_bolsa varchar(16) not null,
	dt_beneficiario_bolsa date,
	beneficiario_deficiente_fisico char(1),
	idsexo int,
	idraca int,
	idmunicipio int,
	
	
	foreign key (idmunicipio) references municipio(id),
	foreign key (idsexo) references tipo_sexo(id),
	foreign key (idraca) references tipo_raca(id)
	
);


create table bolsa(
	id int IDENTITY(1,1) primary key,
	nome_ies_bolsa varchar(256) not null,
	idbeneficiario int,
	idcurso int,
	idturno int,
	idmodalidade int,
	idtipobolsa int,
	code_ies int,
	ano int,
	
	foreign key (idbeneficiario) references beneficiario(id),
	foreign key (idcurso) references curso(id),
	foreign key (idturno) references turno(id),
	foreign key (idmodalidade) references modalidade_bolsa(id),
	foreign key (idtipobolsa) references tipo_bolsa(id)
);