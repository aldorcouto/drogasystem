-- Active: 1692452936450@@127.0.0.1@5432@drogasystem@public

-- Laboratórios: 
insert into laboratorio (nome, razao, cnpj) 
  values ('Medley', 'SANOFI MEDLEY FARMACÊUTICA LTDA', '10.588.595/0012-54');
insert into laboratorio (nome, razao, cnpj) 
  values ('Atenolol', 'BIOMAXFARMA JOTA LTDA', '19.987.783/0001-77');
insert into laboratorio (nome, razao, cnpj) 
  values ('Eurofarma', 'Eurofarma Laboratórios S/A', '61.190.096/0001-92');
insert into laboratorio (nome, razao, cnpj) 
  values ('EMS', 'EMS S/A', '57.507.378/0003-65');
insert into laboratorio (nome, razao, cnpj) 
  values ('NEO QUIMICA', 'BRAINFARMA INDUSTRIA QUIMICA E FARMACEUTICA S.A.', '05.161.069/0001-10');

insert into medicamento (laboratorio_id, nome, dosagem, apresentacao, tipo, controle, quantidade, preco) 
  values (1, 'Glimepirida', '1 comprimido por dia', 'sólido', 'genérico', 'não controlado', '60 comprimidos', 45.00);
insert into medicamento (laboratorio_id, nome, dosagem, apresentacao, tipo, controle, quantidade, preco) 
  values (2, 'Angipress', '1 comprimido por dia', 'sólido', 'genérico', 'não controlado', '30 comprimidos', 23.00);
  
insert into estoque (medicamento_id, lote, validade, preco, quant_inicial, quant_atual) 
  values (1, 'lote 1', '2023-12-31', 20.00, 10, 10);
insert into estoque (medicamento_id, lote, validade, preco, quant_inicial, quant_atual) 
  values (1, 'lote 2', '2024-04-30', 20.00, 10, 10);
insert into estoque (medicamento_id, lote, validade, preco, quant_inicial, quant_atual) 
  values (2, 'lote 3', '2023-12-31', 9.50, 15, 15);
insert into estoque (medicamento_id, lote, validade, preco, quant_inicial, quant_atual) 
  values (2, 'lote 4', '2024-01-31', 9.50, 10, 10);

insert into estoque_total (medicamento_id, total) 
  select id, 0 from medicamento;
update estoque_total set total = total + 10 where medicamento_id = 1;
update estoque_total set total = total + 10 where medicamento_id = 1;
update estoque_total set total = total + 15 where medicamento_id = 2;
update estoque_total set total = total + 10 where medicamento_id = 2;

insert into pessoa (nome) 
  values ('eu');
insert into cliente (id, cpf, data_nasc, sexo) 
  values (1, '1234567890', '1965-12-31', 'M');

insert into pessoa (nome) 
  values ('joão');
insert into profissional (id, registro, tipo) 
  values (2, '123456', 'médico');

insert into venda (cliente_id, total) 
  values (1, 129.2);
insert into itens_venda (venda_id, medicamento_id, estoque_id, quantidade, desconto, total) 
  values (1, 1, 1, 2, 4.5, 85.5);
insert into itens_venda (venda_id, medicamento_id, estoque_id, quantidade, desconto, total) 
  values (1, 2, 3, 2, 2.3, 43.7);

update estoque set quant_venda = quant_venda + 2, quant_atual = quant_atual - 2 where id = 1;
update estoque set quant_venda = quant_venda + 2, quant_atual = quant_atual - 2 where id = 3;
update estoque_total set total = total - 2 where medicamento_id = 1;
update estoque_total set total = total - 2 where medicamento_id = 2;

insert into venda (profissional_id, total) 
  values (2, 69);
insert into itens_venda (venda_id, medicamento_id, estoque_id, quantidade, total) 
  values (2, 1, 1, 1, 46);
insert into itens_venda (venda_id, medicamento_id, estoque_id, quantidade, total) 
  values (2, 2, 3, 1, 23);

update estoque set quant_venda = quant_venda + 1, quant_atual = quant_atual - 1 where id = 1;
update estoque set quant_venda = quant_venda + 1, quant_atual = quant_atual - 1 where id = 3;
update estoque_total set total = total - 1 where medicamento_id = 1;
update estoque_total set total = total - 1 where medicamento_id = 2;
