/*1) CLIENTE = {CODCLIENTE, NOMECLIENTE, FOTO, DATANASC, CODSEXO_FK, CODRUA_FK,
CODBAIRRO_FK, CODCEP_FK, CODCIDADE_FK, SALARIO, CODTRABALHO_FK, NUMEROCASA_FK}*/
CREATE TABLE CLIENTE(
CODCLIENTE SERIAL PRIMARY KEY,
NOMECLIENTE VARCHAR(80) NOT NULL,
FOTO VARBINARY(MAX) NOT NULL UNIQUE,
DATANASC VARCHAR(80) NOT NULL,
CODSEXO_FK INTEGER REFERENCES SEXO(CODSEXO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODRUA_FK INTEGER REFERENCES RUA(CODRUA) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODBAIRRO_FK INTEGER REFERENCES BAIRRO(CODBAIRRO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODCEP_FK INTEGER REFERENCES CEP(CODCEP) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODCIDADE_FK INTEGER REFERENCES CIDADE(CODCIDADE) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
SALARIO NUMERIC (10,2) NOT NULL,
CODTRABALHO_FK INTEGER REFERENCES TRABALHO(CODTRABALHO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
NUMEROCASA_FK INTEGER REFERENCES FUNCIONARIOS(NUMEROCASA) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);

--2) SEXO = {CODSEXO, NOMESEXO}
CREATE TABLE SEXO(
CODSEXO SERIAL PRIMARY KEY,
NOMESEXO VARCHAR (9) NOT NULL UNIQUE
);
--3) RUA = {CODRUA, NOMERUA}
CREATE TABLE RUA (
CODRUA SERIAL PRIMARY KEY,
NOMERUA VARCHAR (80) NOT NULL UNIQUE
);
--4) BAIRRO = {CODBAIRRO, NOMEBAIRRO}
CREATE TABLE BAIRRO(
CODBAIRRO SERIAL PRIMARY KEY,
NOMEBAIRRO VARCHAR (80) NOT NULL UNIQUE
);
--5) CEP = {CODCEP, NUMEROCEP}
CREATE TABLE CEP (
CODCEP SERIAL PRIMARY KEY,
NUMEROCEP CHAR(9) NOT NULL UNIQUE
);
--6) CIDADE = {CODCIDADE, NOMECIDADE, CODUF}
CREATE TABLE CIDADE (
CODCIDADE SERIAL PRIMARY KEY,
NOMECIDADE VARCHAR(80) NOT NULL UNIQUE,
CODUF INTEGER(2) NOT NULL UNIQUE
);
--7) UF = {CODUF, NOMEUF, SIGLA}
CREATE TABLE UF(
CODUF_FK INTEGER REFERENCES CIDADE(CODUF) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
NOMEUF VARCHAR (80) NOT NULL UNIQUE,
SIGLA CHAR (2) NOT NULL UNIQUE
);
--8) TRABALHO = {CODTRABALHO, NOMETRABALHO}
CREATE TABLE TRABALHO
CODTRABALHO SERIAL PRIMARY KEY,
NOMETRABALHO VARCHAR(80) NOT NULL

--9) TELEFONE = {CODTELEFONE, NUMERO, CODOPERADORA}
CREATE TABLE TELEFONE (
CODTELEFONE SERIAL PRIMARY KEY,
NUMERO CHAR (9) NOT NULL UNIQUE,
CODOPERADORA_FK INTEGER REFERENCES OPERADORA(CODOPERADORA) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);
--10) OPERADORA = {CODPERADORA, NOMEOPERADORA}
CREATE TABLE OPERADORA (
CODOPERADORA SERIAL PRIMARY KEY,
NOMEOPERADORA VARCHAR(80) NOT NULL UNIQUE
);
--11) ITENSTELCLIENTE = {CODTELEFONE, CODCLIENTE}
CREATE TABLE ITENSTELCLIENTE (
CODTELEFONE_FK INTEGER REFERENCES TELEFONE(CODTELEFONE) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODCLIENTE_FK INTEGER REFERENCES CLIENTE(CODCLIENTE) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
);
--12) ITENSTELEFONETRABALHO = {CODTRABALHO, CODTELEFONE}
CREATE TABLE ITENSTELEFONETRABALHO(
CODTRABALHO_FK INTEGER REFERENCES TRABALHO(CODTRABALHO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODTELEFONE_FK INTEGER REFERENCES TELEFONE(CODTELEFONE) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);
/*13) FUNCIONARIOS = {CODFUNCIONARIO, NOMEFUNCIONARIO, NUMEROCASA,
CODRUA, CODBAIRRO, CODCEP, CODCIDADE, CODFUNCAO, SALARIO, CODLOJA}*/
CREATE TABLE FUNCIONARIOS(
CODFUNCIONARIOS SERIAL PRIMARY KEY,
NOMEFUNCIONARIO VARCHAR(80) NOT NULL,
NUMEROCASA CHAR(10) NOT NULL,
CODRUA_FK INTEGER REFERENCES RUA(CODRUA) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODBAIRRO_FK INTEGER REFERENCES BAIRRO(CODBAIRRO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODCEP_FK INTEGER REFERENCES CEP(CODCEP) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODCIDADE_FK INTEGER REFERENCES CIDADE(CODCIDADE) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODFUNCAO_FK INTEGER REFERENCES FUNCAOP(CODCIDADE) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
SALARIO_FK INTEGER REFERENCES CLIENTE(SALARIO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODLOJA_FK INTEGER REFERENCES LOJA(CODLOJA) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);
--15) FUNCAO = {CODFUNCAO, NOMEFUNCAO}
CREATE TABLE FUNCAO(
CODFUNCAO SERIAL PRIMARY KEY,
NOMEFUNCAO (80) NOT NULL UNIQUE
);
--16) ITENSTELEFONEFUNCIONARIO = {CODFUNCIONARIO, CODTELEFONE}
CREATE TABLE ITENSTELEFONEFUNCIONARIO(
CODFUNCIONARIO_FK INTEGER REFERENCES FUNCIONARIO(CODFUNCIONARIO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODTELEFONE_FK INTEGER REFERENCES TELEFONE(CODTELEFONE) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);
--17) LOGIN = {CODLOGIN, USUARIO, SENHA, CODFUNCIONARIO}
CREATE TABLE LOGIN(
CODLOGIN SERIAL PRIMARY KEY,
USUARIO VARCHAR(80) NOT NULL,
SENHA CHAR(40) NOT NULL,
CODFUNCIONARIO_FK INTEGER REFERENCES FUNCIONARIO(CODFUNCIONARIO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);
--18) CONTROLELOGSISTEMA = {CODCONTROLE, CODLOGIN, DATA, HORA}
CREATE TABLE CONTROLELOGSISTEMA(
CODCONTROLE SERIAL PRIMARY KEY,
CODLOGIN_FK INTEGER REFERENCES LOGIN(CODLOGIN) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
DATAS DATE NOT NULL
);
--19) ACESSO = {CODACESSO, NOMEACESSO}
CREATE TABLE ACESSO(
CODACESSO SERIAL PRIMARY KEY,
NOMEACESSO VARCHAR(80) NOT NULL UNIQUE
);
--20) ITENSACESSOLOGIN = {CODACESSO, CODLOGIN}
CREATE TABLE ITENSACESSOLOGIN(
CODACESSO_FK INTEGER REFERENCES ACESSO(CODACESSO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODLOGIN_FK INTEGER REFERENCES ACESSO(CODLOGIN) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);
--21) LOJA = {CODLOJA, NOMELOJA, CNPJ, NOMEFANTASIA, RAZAOSOCIAL}
CREATE TABLE LOJA(
CODLOJA SERIAL PRIMARY KEY,
NOMELOJA VARCHAR (80) NOT NULL,
CNPJ CHAR (14) NOT NULL UNIQUE,
NOMEFANTASIA VARCHAR(80) NOT NULL UNIQUE,
RAZAOSOCIAL VARCHAR(80) NOT NULL UNIQUE
);
--22) ITENSTELEFONELOJA={CODLOJA, CODTELEFONE}
CREATE TABLE ITENSTELEFONELOJA(
CODLOJA_FK INTEGER REFERENCES LOJA(CODLOJA) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODTELEFONE_FK INTEGER REFERENCES TELEFONE(CODTELEFONE) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);
/*23) PRODUTO = {CODPRODUTO, NOMEPRODUTO, QUANTIDADE, VALOR, CODMARCA,
CODTIPO }*/
CREATE TABLE PRODUTO(
CODPRODUTO SERIAL PRIMARY KEY,
NOMEPRODUTO VARCHAR(80) UNIQUE,
QUANTIDADE NUMERIC(10,2) NOT NULL,
VALOR NUMERIC(10,2) NOT NULL,
CODMARCA_FK INTEGER REFERENCES MARCA(CODMARCA) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODTIPO_FK INTEGER REFERENCES TIPO(CODTIPO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);
--24) MARCA={CODMARCA, NOMEMARCA}
CREATE TABLE MARCA(
CODMARCA SERIAL PRIMARY KEY,
NOMEMARCA VARCHAR(80) NOT NULL UNIQUE
);
--25) TIPO={CODTIPO, NOMETIPO}
CREATE TABLE TIPO(
CODTIPO SERIAL PRIMARY KEY,
NOMETIPO VARCHAR(80) NOT NULL UNIQUE
);
/*26) FORNECEDOR={CODFORNECEDOR, NOMEFORNECEDOR, NUMEROCASA, CORUA,
CODBAIRRO, CODCEP, CODCIDADE}*/
CREATE TABLE FORNECEDOR(
CODFORNECEDOR SERIAL PRIMARY KEY,
NOMEFORNECEDOR VARCHAR(80) NOT NULL UNIQUE,
NUMEROCASA_FK INTEGER REFERENCES FUNCIONARIOS(NUMEROCASA) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODCIDADE_FK INTEGER REFERENCES CIDADE(CODCIDADE) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODRUA_FK INTEGER REFERENCES RUA(CODRUA) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODBAIRRO_FK INTEGER REFERENCES BAIRRO(CODBAIRRO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODCEP_FK INTEGER REFERENCES CEP(CODCEP) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODCIDADE_FK INTEGER REFERENCES CIDADE(CODCIDADE) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE

);
--27) ITENSTELEFONEFORNECEDOR={CODTELEFONE, CODFORNECEDOR}
CREATE TABLE ITENSTELEFONEFORNECEDOR(
CODTELEFONE_FK INTEGER REFERENCES TELEFONE(CODTELEFONE) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODFORNECEDOR_FK INTEGER REFERENCES FORNECEDOR(CODFORNECEDOR) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);
/*28) COMPRAPRODUTO = {CODCOMPRA, DATACOMPRA, CODFORNECEDOR,
CODFUNCIONARIO}*/
CREATE TABLE COMPRAPRODUTO(
CODCOMPRA SERIAL PRIMARY KEY,
DATACOMPRA DATE NOT NULL,
CODTELEFONE_FK INTEGER REFERENCES TELEFONE(CODTELEFONE) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODFORNECEDOR_FK INTEGER REFERENCES FORNECEDOR(CODFORNECEDOR) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODFUNCIONARIO_FK INTEGER REFERENCES FUNCIONARIO(CODFUNCIONARIO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);
--29) ITENSCOMPRAPRODUTO = {CODCOMPRA, CODPRODUTO, QUANTIDADE, VALORC}
CREATE TABLE ITENSCOMPRAPRODUTO(
CODCOMPRA_FK INTEGER REFERENCES COMPRAPRODUTO(CODCOMPRA) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODPRODUTO_FK INTEGER REFERENCES PRODUTO(CODPRODUTO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
QUANTIDADES NUMERIC (10,2) NOT NULL,
VALORC NUMERIC(10,2) NOT NULL
);
/*30) PARCELACOMPRA = {CODPARCELACOMPRA, DATAVENCIMENTO, VALOR,
CODSITUACAO, CODCOMPRA}*/
CREATE TABLE PARCELACOMPRA(
CODPARCELACOMPRA SERIAL PRIMARY KEY,
DATAVENCIMENTO DATE NOT NULL,
VALORP NUMERIC (10,2) NOT NULL,
CODSITUACAO_FK INTEGER REFERENCES SITUACAO(CODSITUACAO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODCOMPRA_FK INTEGER REFERENCES COMPRAPRODUTO(CODCOMPRA) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);
--31) SITUACAO = {CODSITUACAO, NOMESITUACAO}
CREATE TABLE SITUACAO(
CODSITUACAO SERIAL PRIMARY KEY,
NOMESITUACAO (80) NOT NULL UNIQUE
);
--32) VENDAPRODUTO = {CODVENDA, DATAVENDA, CODCLIENTE, CODFUNCIONARIO}
CREATE TABLE VENDAPRODUTO(
CODVENDA SERIAL PRIMARY KEY,
DATAVENDA DATE NOT NULL,
CODCLIENTE_FK INTEGER REFERENCES CLIENTE(CODCLIENTE) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODFUNCIONARIO_FK INTEGER REFERENCES FUNCIONARIO(CODFUNCIONARIO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE

);
--33) ITENSVENDAPRODUTO = {CODVENDA,CODPRODUTO, QUANTIDADE, VALOR}
CREATE TABLE ITENSVENDAPRODUTO(
CODVENDA_FK INTEGER REFERENCES VENDAPRODUTO(CODVENDA) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
QUANTIDADEITENVENDA NUMERIC (10,2) NOT NULL,
VALORITENSVENDA NUMERIC (10,2) NOT NULL
);
/*34) PARCELAVENDA={CODPARCELA, DATAVENCIMENTO, VALOR, CODSITUACAO,
CODVENDA}*/
CREATE TABLE PARCELAVENDA(
CODPARCELA SERIAL PRIMARY KEY,
DATAVENCIMENTO_FK INTEGER REFERENCES PARCELA(DATAVENCIMENTO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
VALORPARCELA NUMERIC (10,2) NOT NULL,
CODFUNCIONARIO_FK INTEGER REFERENCES FUNCIONARIO(CODFUNCIONARIO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODSITUACAO_FK INTEGER REFERENCES SITUACAO(CODSITUACAO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
CODVENDA_FK INTEGER REFERENCES VENDAPRODUTO(CODVENDA) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);
--35) IMAGENS={CODIMAGENS, IMAGEM, DESCRICAO, CODPRODUTO}
CREATE TABLE IMAGENS(
CODIMAGENS SERIAL PRIMARY KEY,
IMAGEN BYTEA NOT NULL UNIQUE,
DESCRICAO VARCHAR(120) NOT NULL,
CODPRODUTO_FK INTEGER REFERENCES PRODUTO(CODPRODUTO) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
);