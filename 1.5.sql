##### 1.5.1 Responde (devolve boolean) se é verdade que todos os estudantes de renda acima de 410 são aprovados (grade > 0).

CREATE OR REPLACE PROCEDURE sp_todos_renda_alta_aprovados(

    OUT resultado BOOLEAN

)

LANGUAGE plpgsql

AS $$

DECLARE

    contagem_renda_alta INT;

    contagem_renda_alta_aprovados INT;

BEGIN

    

    SELECT COUNT(*) INTO contagem_renda_alta

    FROM tb_alunos

    WHERE Salario > 410;

    SELECT COUNT(*) INTO contagem_renda_alta_aprovados

    FROM tb_alunos

    WHERE Salario > 410 AND Nota > 0;


    IF contagem_renda_alta = contagem_renda_alta_aprovados THEN

        resultado := TRUE;

    ELSE

        resultado := FALSE;

    END IF;

END;

$$;
 


DO $$

DECLARE

    resultado BOOLEAN;

BEGIN

    CALL sp_todos_renda_alta_aprovados(resultado);

    RAISE NOTICE 'Todos os estudantes com renda acima de 410 são aprovados: %', resultado;

END;

$$;






 
 ############## 1.5.2 Responde (devolve boolean) se é verdade que, entre os estudantes que fazem anotações pelo menos algumas vezes durante as aulas, pelo menos 70% são aprovados (grade > 0).

CREATE OR REPLACE PROCEDURE sp_anotacoes_aprovados(

    OUT resultado BOOLEAN

)

LANGUAGE plpgsql

AS $$

DECLARE

    contagem_anotacoes INT;

    contagem_anotacoes_aprovados INT;

    percentual NUMERIC(5, 2);

BEGIN

   

    SELECT COUNT(*) INTO contagem_anotacoes

    FROM tb_alunos

    WHERE Anotacoes > 0;


    SELECT COUNT(*) INTO contagem_anotacoes_aprovados

    FROM tb_alunos

    WHERE Anotacoes > 0 AND Nota > 0;

     Calcula o percentual de aprovados

    IF contagem_anotacoes > 0 THEN

        percentual := (contagem_anotacoes_aprovados::NUMERIC / contagem_anotacoes::NUMERIC) * 100;

    ELSE

        percentual := 0;

    END IF;

     Verifica se pelo menos 70% dos estudantes foram aprovados

    IF percentual >= 70 THEN

        resultado := TRUE;

    ELSE

        resultado := FALSE;

    END IF;

END;

$$;
 
 Teste a procedure 1.5.2

DO $$

DECLARE

    resultado BOOLEAN;

BEGIN

    CALL sp_anotacoes_aprovados(resultado);

    RAISE NOTICE 'Pelo menos 70%% dos estudantes que fazem anotações são aprovados: %', resultado;

END;

$$;
 

#################Apostila 13 ###############################33
 ######### 1.5.3 Devolve o percentual de alunos que se preparam pelo menos um pouco para os “midterm exams” e que são aprovados (grade > 0).

CREATE OR REPLACE PROCEDURE sp_preparacao_exame_aprovados(

    OUT percentual NUMERIC(5, 2)

)

LANGUAGE plpgsql

AS $$

DECLARE

    contagem_preparados INT;

    contagem_preparados_aprovados INT;

BEGIN

     Conta todos os estudantes que se preparam pelo menos um pouco para os midterm exams

    SELECT COUNT(*) INTO contagem_preparados

    FROM tb_alunos

    WHERE Preparacao_exame > 0;

     Conta todos os estudantes que se preparam pelo menos um pouco para os midterm exams e foram aprovados

    SELECT COUNT(*) INTO contagem_preparados_aprovados

    FROM tb_alunos

    WHERE Preparacao_exame > 0 AND Nota > 0;

     Calcula o percentual de aprovados

    IF contagem_preparados > 0 THEN

        percentual := (contagem_preparados_aprovados::NUMERIC / contagem_preparados::NUMERIC) * 100;

    ELSE

        percentual := 0;

    END IF;

END;

$$;
 
 Teste a procedure 1.5.3

DO $$

DECLARE

    percentual NUMERIC(5, 2);

BEGIN

    CALL sp_preparacao_exame_aprovados(percentual);

    RAISE NOTICE 'Percentual de alunos que se preparam e são aprovados: %', percentual;

END;

$$;
