-- Active: 1692452936450@@127.0.0.1@5432@drogasystem@public

-- drop database if exists drogasystem;
-- create database drogasystem;

drop table if exists laboratorio cascade;
drop table if exists medicamento cascade;
drop table if exists estoque cascade;
drop table if exists estoque_total cascade;
drop table if exists pessoa cascade;
drop table if exists cliente cascade;
drop table if exists profissional cascade;
drop table if exists venda cascade;
drop table if exists itens_venda cascade;

create table laboratorio (
  id              serial primary key, 
  nome            varchar(255) not null, 
  razao           varchar(255) not null, 
  cnpj            varchar(255) not null
);

create table classe (
  id              serial primary key, 
  descricao       varchar(255) not null
)

create table substancia (
  id              serial primary key, 
  descricao       varchar(255) not null,
  classe_id       int not null references classe(id)
)

create table medicamento (
  id              serial primary key, 
  laboratorio_id  int not null references laboratorio(id), 
  nome            varchar(255) not null, 
  substancia_id   int not null references substancia(id),
  dosagem         varchar(255), 
  apresentacao    varchar(255) not null check (apresentacao in ('Sólido', 'Líquido', 'Semissólido')), 
  tipo            varchar(255) not null check (tipo in ('Biológico', 'Específico', 'Fitoterápico', 'Genérico', 'Novo', 'Outros', 'Produto de Terapia Avançada', 'Radiofármaco', 'Similar')), 
  controle        varchar(255) not null check (controle in ('Não controlado', 'A2', 'A3', 'B1', 'B2', 'C1', 'C2', 'AM')), 
  classe          varchar(255) not null,
  quantidade      varchar(255), 
  preco           numeric(10, 2) not null
);


create table estoque (
  id              serial primary key, 
  medicamento_id  int not null references medicamento(id), 
  lote            varchar(255) not null, 
  data            date not null default current_date, 
  validade        date not null, 
  preco           numeric(10, 2) not null, 
  quant_inicial   int not null, 
  quant_venda     int not null default 0, 
  quant_atual     int not null default 0
);

create table estoque_total (
  id              serial primary key, 
  medicamento_id  int not null unique references medicamento(id), 
  total           int not null, 
  minimo          int not null default 0, 
  maximo          int not null default 9999
);

create table pessoa (
  id              serial primary key, 
  nome            varchar(255) not null, 
  logradouro      varchar(255), 
  numero          varchar(255), 
  complemento     varchar(255), 
  bairro          varchar(255), 
  cep             numeric(8), 
  cidade          varchar(255), 
  estado          char(2), 
  telefone        numeric(11)
);

create table cliente (
  id              int primary key references pessoa(id), 
  cpf             numeric(11) not null unique, 
  data_nasc       date not null, 
  sexo            char(1) not null check (sexo in ('F', 'M'))
);

create table profissional (
  id              int primary key references pessoa(id), 
  registro        varchar(255) not null unique, 
  tipo            varchar(255) not null check (tipo in ('Médico', 'Dentista', 'Veterinário'))
);

create table venda (
  id              serial primary key, 
  time_stamp      timestamp not null default now(), 
  total           numeric(10, 2) not null, 
  cliente_id      int references cliente(id), 
  profissional_id int references profissional(id)
);

create table itens_venda (
  id              serial primary key, 
  venda_id        int not null references venda(id), 
  medicamento_id  int not null references medicamento(id), 
  estoque_id      int not null references estoque(id), 
  quantidade      int not null, 
  desconto        numeric(10, 2) not null default 0, 
  total           numeric(10, 2) not null
);
