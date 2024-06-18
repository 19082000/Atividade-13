
1.4 Escreva os seguintes stored procedures (incluindo um bloco anônimo de teste para cada
um):
1.4.3 Recebe um sexo como parâmetro em modo IN e utiliza oito parâmetros em modo OUT
para dizer qual o percentual de cada nota (variável grade) obtida por estudantes daquele
sexo.
CREATE OR REPLACE PROCEDURE sp_nota_genero(
    IN Genero INT,
    OUT Fail NUMERIC (10, 2),
    OUT DD NUMERIC (10, 2),
    OUT DC NUMERIC (10, 2),
    OUT CC NUMERIC (10, 2),
    OUT CB NUMERIC (10, 2),
    OUT BB NUMERIC (10, 2),
    OUT BA NUMERIC (10, 2),
    OUT AA NUMERIC (10, 2)
    )
LANGUAGE plpgsql
AS $$
 
BEGIN
    SELECT COUNT (*)
    INTO Fail
    FROM tb_alunos
    WHERE notes = 0 AND gender = Genero;
 
    SELECT COUNT (*)
    INTO DD
    FROM tb_alunos
    WHERE notes = 1 AND gender = Genero;
 
        SELECT COUNT (*)
    INTO DC
    FROM tb_alunos
    WHERE notes = 2 AND gender = Genero;
 
    SELECT COUNT (*)
    INTO CC
    FROM tb_alunos
    WHERE notes = 3 AND gender = Genero;
 
        SELECT COUNT (*)
    INTO CB
    FROM tb_alunos
    WHERE notes = 4 AND gender = Genero;
 
    SELECT COUNT (*)
    INTO BB
    FROM tb_alunos
    WHERE notes = 5 AND gender = Genero;
 
        SELECT COUNT (*)
    INTO BA
    FROM tb_alunos
    WHERE notes = 6 AND gender = Genero;
 
    SELECT COUNT (*)
    INTO AA
    FROM tb_alunos
    WHERE notes = 7 AND gender = Genero;
 
    Fail := (Fail /(Fail + DD + DC + CC + CB + BB + BA + AA))* 100;
    DD := (DD /(Fail + DD + DC + CC + CB + BB + BA + AA))* 100;
    DC := (DC /(Fail + DD + DC + CC + CB + BB + BA + AA))* 100;
    CC := (CC /(Fail + DD + DC + CC + CB + BB + BA + AA))* 100;
    CB := (CB /(Fail + DD + DC + CC + CB + BB + BA + AA))* 100;
    BB := (BB /(Fail + DD + DC + CC + CB + BB + BA + AA))* 100;
    BA := (BA /(Fail + DD + DC + CC + CB + BB + BA + AA))* 100;
    AA := (AA /(Fail + DD + DC + CC + CB + BB + BA + AA))* 100;
END;
$$
 
DO $$
DECLARE
    Fail NUMERIC (10, 2);
    DD NUMERIC (10, 2);
    DC NUMERIC (10, 2);
    CC NUMERIC (10, 2);
    CB NUMERIC (10, 2);
    BB NUMERIC (10, 2);
    BA NUMERIC (10, 2);
    AA NUMERIC (10, 2);
BEGIN
    CALL sp_nota_genero(2, Fail, DD, DC, CC, CB, BB, BA, AA);
    RAISE NOTICE 'O percentual de Fail para o genero escolhido é de %', Fail;
    RAISE NOTICE 'O percentual de DD para o genero escolhido é de %', DD;
    RAISE NOTICE 'O percentual de DC para o genero escolhido é de %', DC;
    RAISE NOTICE 'O percentual de CC para o genero escolhido é de %', CC;
    RAISE NOTICE 'O percentual de CB para o genero escolhido é de %', CB;
    RAISE NOTICE 'O percentual de BB para o genero escolhido é de %', BB;
    RAISE NOTICE 'O percentual de BA para o genero escolhido é de %', BA;
    RAISE NOTICE 'O percentual de AA para o genero escolhido é de %', AA;
END;
$$
 
 
1.4.2 Exibe o percentual de estudantes de cada sexo.
 CREATE OR REPLACE PROCEDURE sp_perc_por_genero(
     OUT Masculino NUMERIC ( 10, 2 ),
     OUT Feminino NUMERIC( 10, 2)
     )
 LANGUAGE plpgsql
 AS $$
 
 BEGIN
     SELECT COUNT (*)
     INTO Masculino
     FROM tb_alunos
     WHERE gender = 2;
 
     SELECT COUNT (*)
     INTO Feminino
     FROM tb_alunos
     WHERE gender = 1;
     Feminino := (Feminino /(Feminino + Masculino))* 100;
     Masculino :=(Masculino /(Feminino + Masculino))* 100;
 END;
 $$
 
 DO $$
 DECLARE
     Masculino NUMERIC( 10, 2);
     Feminino NUMERIC( 10, 2);
 BEGIN
     CALL sp_perc_por_genero(Feminino, Masculino);
     RAISE NOTICE 'O percentual de Masculino é % e Feminino é %', Masculino, Feminino ;
 END;
 $$
 
 
1.4.1 Exibe o número de estudantes maiores de idade.
 
 CREATE OR REPLACE PROCEDURE sp_qt_maior_idade(
     OUT Age INT
     )
 LANGUAGE plpgsql
 AS $$
 BEGIN
     SELECT COUNT (cod_id)
     INTO age
     FROM tb_alunos;
 
 END;
 $$
 
 DO $$
 DECLARE
     Age INT;
 BEGIN
     CALL sp_qt_maior_idade(Age);
     RAISE NOTICE 'A quantidade de maior de idade é de %', Age;
 END;
 $$
 
 CREATE TABLE tb_alunos(
  cod_id SERIAL PRIMARY KEY,
  Age INT,
  Gender INT,
  Salary INT,
  Prep_exam INT,
  Notes INT,
  Grade INT
 );
 
 SELECT * FROM tb_alunos;
