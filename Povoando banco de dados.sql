INSERT INTO USUARIO (Email, Password, Nome, Sobrenome)
VALUES ('vinicius@mail.com', '123456', 'Vinicius', 'Teodoro');

INSERT INTO LOJA (Email, Password, Telefone, Nome, 
				  Nome_Proprietario, Sobrenome_Proprietario, Email_Proprietario, Telefone_Proprietario)
VALUES ('lojabd@mail.com', '654321', '31977777777', 'BD Store', 'Bruno', 'Monteiro', 'bruno@mail.com', '31988888888');

INSERT INTO ENTREGADOR (Email, Password, Nome, Sobrenome, Telefone)
VALUES ('fulano@mail.com', '0123456789', 'Fulano', 'Ciclano', '31966666666');

INSERT INTO ENDERECO (CEP, Pais, Estado, Cidade, Bairro, Rua, Numero)
VALUES ('75755205', 'Brasil', 'Minas Gerais', 'Joao Monlevade', 'Novo Horizonte', 'Realeza', 100);

INSERT INTO TIPO_ENDERECO
VALUES ('CS', 'Casa');

INSERT INTO TRANSPORTE_STATUS_CODE
VALUES ('NLJ', 'Na Loja');

INSERT INTO PEDIDO_STATUS_CODE
VALUES ('Conf', 'Confirmado');

INSERT INTO PEDIDO_ITENS_STATUS_CODE
VALUES ('ON', 'Em estoque');

INSERT INTO METODO_DE_ENTREGA
VALUES ('DELI', 'Delivery');

INSERT INTO TIPO_PRODUTO
VALUES ('CJ', 'Calca Jeans');

INSERT INTO METODOS_DE_PAGAMENTO
VALUES ('CC', 'Credito');

INSERT INTO FATURA_STATUS_CODE
VALUES ('PG', 'Pago');

INSERT INTO BUSCA (ID_Usuario, Descricao)
VALUES ((SELECT ID_Usuario FROM USUARIO), 'Camisa');

INSERT INTO USUARIOS_ENDERECO (ID_Tipo_endereco, ID_Usuario, ID_Endereco)
VALUES ((SELECT ID_Tipo_Endereco FROM TIPO_ENDERECO), 
	   (SELECT ID_Usuario FROM USUARIO),
	   (SELECT ID_Endereco FROM ENDERECO));

INSERT INTO LOJAS_ENDERECO  (ID_Tipo_endereco, ID_Loja, ID_Endereco)
VALUES ((SELECT ID_Tipo_Endereco FROM TIPO_ENDERECO), 
		(SELECT ID_Loja FROM LOJA), 
		(SELECT ID_Endereco FROM ENDERECO));

INSERT INTO ENTREGADORES_ENDERECO  (ID_Tipo_endereco, ID_Entregador, ID_Endereco)
VALUES ((SELECT ID_Tipo_Endereco FROM TIPO_ENDERECO WHERE Descricao = 'Casa'), 
		(SELECT ID_Entregador FROM ENTREGADOR),
	    (SELECT ID_Endereco FROM ENDERECO));
		
INSERT INTO CARTAO (ID_Usuario, ID_Metodo, Nome, Numero, Validade, CVC)
VALUES ((SELECT ID_Usuario FROM USUARIO),
		(SELECT ID_Metodo FROM METODOS_DE_PAGAMENTO WHERE Descricao = 'Credito'), 
	   'Vinicius T', '012345678910', '20170401', '123');

INSERT INTO PEDIDO (ID_Usuario,ID_Pedido_Status_code, ID_Metodo_Entrega)
VALUES ((SELECT ID_Usuario FROM USUARIO),
		(SELECT ID_Pedido_Status_code FROM PEDIDO_STATUS_CODE WHERE Descricao = 'Confirmado'), 
	   (SELECT ID_Metodo_Entrega FROM METODO_DE_ENTREGA WHERE Descricao = 'Delivery'));

INSERT INTO FATURA (ID_Pedido, ID_Fatura_Status_code)
VALUES ((SELECT ID_Pedido FROM PEDIDO), 
	   (SELECT ID_Fatura_Status_code FROM FATURA_STATUS_CODE WHERE Descricao = 'Pago'));
	   
INSERT INTO PAGAMENTO (ID_Fatura, ID_Cartao, Valor)
VALUES ((SELECT ID_Fatura FROM FATURA), 
	   (SELECT C.ID_Cartao FROM CARTAO C, PEDIDO P
			WHERE C.ID_Usuario = P.ID_Usuario), 12);

INSERT INTO PRODUTO (ID_Loja, ID_Tipo_Produto, Valor, Nome)
VALUES ((SELECT ID_Loja FROM LOJA),
		(SELECT ID_Tipo_Produto FROM TIPO_PRODUTO WHERE Descricao = 'Calca Jeans'), 
		10, 'Jeans Preto');

INSERT INTO PEDIDO_ITENS (ID_Pedido, ID_Produto, ID_PI_Status_code)
VALUES ((SELECT ID_Pedido FROM PEDIDO), 
		(SELECT ID_Produto FROM PRODUTO), 
		(SELECT ID_PI_Status_code FROM PEDIDO_ITENS_STATUS_CODE WHERE Descricao = 'Em estoque'));
		
INSERT INTO TRANSPORTE (ID_Pedido, ID_Transporte_Status_code)
VALUES ((SELECT ID_Pedido FROM PEDIDO), 
	(SELECT ID_Transporte_Status_code FROM TRANSPORTE_STATUS_CODE WHERE Descricao = 'Na Loja'));

INSERT INTO TRANSPORTE_DELIVERY (ID_Transporte, ID_US_Endereco, ID_Entregador)
VALUES ((SELECT ID_Transporte FROM TRANSPORTE), 
		(SELECT C.ID_US_Endereco FROM USUARIOS_ENDERECO C, PEDIDO P, TRANSPORTE T 
		 WHERE C.ID_Usuario = P.ID_Usuario AND P.ID_Pedido = T.ID_Pedido), 
	   (SELECT ID_Entregador FROM ENTREGADOR));