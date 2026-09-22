-- =============================================================================
-- BANCO DE DADOS: SISTEMA DE RESERVAS HOTELARIAS (PostgreSQL / PL/pgSQL)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- NÍVEL 1 — PROCEDURE BÁSICA
-- -----------------------------------------------------------------------------

-- Questão 1 — Cadastrar hóspede
CREATE OR REPLACE PROCEDURE cadastrar_hospede(
    p_nome VARCHAR,
    p_email VARCHAR,
    p_telefone VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO hospedes (nome, email, telefone)
    VALUES (p_nome, p_email, p_telefone);
END;
$$;

-- Teste Q1:
CALL cadastrar_hospede('Eduardo Silva', 'eduardo@email.com', '86999990005');


-- Questão 2 — Atualizar telefone
CREATE OR REPLACE PROCEDURE atualizar_telefone_hospede(
    p_id_hospede INT,
    p_novo_telefone VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE hospedes
    SET telefone = p_novo_telefone
    WHERE id_hospede = p_id_hospede;
END;
$$;

-- Teste Q2:
CALL atualizar_telefone_hospede(1, '86988880001');


-- -----------------------------------------------------------------------------
-- NÍVEL 2 — PARÂMETROS E VARIÁVEIS
-- -----------------------------------------------------------------------------

-- Questão 3 — Consultar hóspede
CREATE OR REPLACE PROCEDURE consultar_hospede(
    p_id_hospede INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_nome VARCHAR;
    v_email VARCHAR;
    v_telefone VARCHAR;
BEGIN
    SELECT nome, email, telefone 
    INTO v_nome, v_email, v_telefone
    FROM hospedes
    WHERE id_hospede = p_id_hospede;

    RAISE INFO 'Hóspede: %, E-mail: %, Telefone: %', v_nome, v_email, v_telefone;
END;
$$;

-- Teste Q3:
CALL consultar_hospede(1);


-- Questão 4 — Verificar existência do hóspede
CREATE OR REPLACE PROCEDURE consultar_hospede(
    p_id_hospede INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_nome VARCHAR;
    v_email VARCHAR;
    v_telefone VARCHAR;
BEGIN
    SELECT nome, email, telefone 
    INTO v_nome, v_email, v_telefone
    FROM hospedes
    WHERE id_hospede = p_id_hospede;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Hóspede com código % não foi encontrado.', p_id_hospede;
    ELSE
        RAISE INFO 'Hóspede: %, E-mail: %, Telefone: %', v_nome, v_email, v_telefone;
    END IF;
END;
$$;

-- Teste Q4:
CALL consultar_hospede(99);


-- -----------------------------------------------------------------------------
-- NÍVEL 3 — TRABALHANDO COM RESERVAS
-- -----------------------------------------------------------------------------

-- Questão 5 — Criar reserva
CREATE OR REPLACE PROCEDURE criar_reserva(
    p_id_hospede INT,
    p_checkin DATE,
    p_checkout DATE,
    p_valor_diaria NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO reservas (id_hospede, data_checkin, data_checkout, valor_diaria, status)
    VALUES (p_id_hospede, p_checkin, p_checkout, p_valor_diaria, 'ATIVA');
END;
$$;

-- Teste Q5:
CALL criar_reserva(1, '2026-12-01', '2026-12-05', 280.00);


-- Questão 6 — Validar hóspede
CREATE OR REPLACE PROCEDURE criar_reserva(
    p_id_hospede INT,
    p_checkin DATE,
    p_checkout DATE,
    p_valor_diaria NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_dummy INT;
BEGIN
    SELECT id_hospede 
    INTO v_dummy 
    FROM hospedes 
    WHERE id_hospede = p_id_hospede;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Não é possível criar reserva. Hóspede com código % não existe.', p_id_hospede;
    END IF;

    INSERT INTO reservas (id_hospede, data_checkin, data_checkout, valor_diaria, status)
    VALUES (p_id_hospede, p_checkin, p_checkout, p_valor_diaria, 'ATIVA');
END;
$$;

-- Teste Q6:
CALL criar_reserva(99, '2026-12-01', '2026-12-05', 280.00);


-- -----------------------------------------------------------------------------
-- NÍVEL 4 — REGRAS DE NEGÓCIO
-- -----------------------------------------------------------------------------

-- Questão 7 — Validar datas
CREATE OR REPLACE PROCEDURE criar_reserva(
    p_id_hospede INT,
    p_checkin DATE,
    p_checkout DATE,
    p_valor_diaria NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_dummy INT;
BEGIN
    SELECT id_hospede 
    INTO v_dummy 
    FROM hospedes 
    WHERE id_hospede = p_id_hospede;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Hóspede com código % não existe.', p_id_hospede;
    END IF;

    IF p_checkout <= p_checkin THEN
        RAISE EXCEPTION 'Data de check-out (%) deve ser posterior à data de check-in (%).', p_checkout, p_checkin;
    END IF;

    INSERT INTO reservas (id_hospede, data_checkin, data_checkout, valor_diaria, status)
    VALUES (p_id_hospede, p_checkin, p_checkout, p_valor_diaria, 'ATIVA');
END;
$$;

-- Teste Q7:
CALL criar_reserva(1, '2026-10-10', '2026-10-08', 250.00);


-- Questão 8 — Cancelar reserva
CREATE OR REPLACE PROCEDURE cancelar_reserva(
    p_id_reserva INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_dummy INT;
BEGIN
    SELECT id_reserva 
    INTO v_dummy 
    FROM reservas 
    WHERE id_reserva = p_id_reserva;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Reserva com código % não existe.', p_id_reserva;
    END IF;

    UPDATE reservas
    SET status = 'CANCELADA'
    WHERE id_reserva = p_id_reserva;
END;
$$;

-- Teste Q8:
CALL cancelar_reserva(1);


-- Questão 9 — Impedir cancelamento de reserva já cancelada
CREATE OR REPLACE PROCEDURE cancelar_reserva(
    p_id_reserva INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_status VARCHAR;
BEGIN
    SELECT status 
    INTO v_status 
    FROM reservas 
    WHERE id_reserva = p_id_reserva;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Reserva com código % não existe.', p_id_reserva;
    END IF;

    IF v_status = 'CANCELADA' THEN
        RAISE EXCEPTION 'A reserva % já se encontra CANCELADA.', p_id_reserva;
    END IF;

    UPDATE reservas
    SET status = 'CANCELADA'
    WHERE id_reserva = p_id_reserva;
END;
$$;

-- Teste Q9:
CALL cancelar_reserva(1);


-- -----------------------------------------------------------------------------
-- NÍVEL 5 — CÁLCULOS
-- -----------------------------------------------------------------------------

-- Questão 10 — Calcular valor da reserva
CREATE OR REPLACE PROCEDURE calcular_valor_reserva(
    p_id_reserva INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_checkin DATE;
    v_checkout DATE;
    v_diaria NUMERIC(10, 2);
    v_dias INT;
    v_valor_total NUMERIC(10, 2);
BEGIN
    SELECT data_checkin, data_checkout, valor_diaria
    INTO v_checkin, v_checkout, v_diaria
    FROM reservas
    WHERE id_reserva = p_id_reserva;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Reserva com código % não foi encontrada.', p_id_reserva;
    END IF;

    v_dias := v_checkout - v_checkin;
    v_valor_total := v_dias * v_diaria;

    RAISE INFO 'Reserva % | Dias: % | Valor diária: R$ % | Total: R$ %', 
        p_id_reserva, v_dias, v_diaria, v_valor_total;
END;
$$;

-- Teste Q10:
CALL calcular_valor_reserva(2);


-- Questão 11 — Aplicar desconto
CREATE OR REPLACE PROCEDURE calcular_valor_com_desconto(
    p_id_reserva INT,
    p_percentual_desconto NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_checkin DATE;
    v_checkout DATE;
    v_diaria NUMERIC(10, 2);
    v_dias INT;
    v_valor_total NUMERIC(10, 2);
    v_valor_final NUMERIC(10, 2);
BEGIN
    SELECT data_checkin, data_checkout, valor_diaria
    INTO v_checkin, v_checkout, v_diaria
    FROM reservas
    WHERE id_reserva = p_id_reserva;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Reserva com código % não foi encontrada.', p_id_reserva;
    END IF;

    v_dias := v_checkout - v_checkin;
    v_valor_total := v_dias * v_diaria;
    v_valor_final := v_valor_total * (1 - (p_percentual_desconto / 100.0));

    RAISE INFO 'Reserva % | Valor Original: R$ % | Desconto: %%% | Valor Final: R$ %', 
        p_id_reserva, v_valor_total, p_percentual_desconto, v_valor_final;
END;
$$;

-- Teste Q11:
CALL calcular_valor_com_desconto(2, 10);


-- -----------------------------------------------------------------------------
-- NÍVEL 6 — OPERAÇÃO COMPLETA
-- -----------------------------------------------------------------------------

-- Questão 12 — Finalizar reserva
CREATE OR REPLACE PROCEDURE finalizar_reserva(
    p_id_reserva INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_checkin DATE;
    v_checkout DATE;
    v_diaria NUMERIC(10, 2);
    v_status VARCHAR;
    v_dias INT;
    v_valor_total NUMERIC(10, 2);
BEGIN
    SELECT data_checkin, data_checkout, valor_diaria, status
    INTO v_checkin, v_checkout, v_diaria, v_status
    FROM reservas
    WHERE id_reserva = p_id_reserva;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Reserva com código % não foi encontrada.', p_id_reserva;
    END IF;

    IF v_status <> 'ATIVA' THEN
        RAISE EXCEPTION 'Apenas reservas ATIVAS podem ser finalizadas. Status atual: %', v_status;
    END IF;

    v_dias := v_checkout - v_checkin;
    v_valor_total := v_dias * v_diaria;

    UPDATE reservas
    SET status = 'FINALIZADA'
    WHERE id_reserva = p_id_reserva;

    RAISE INFO 'Reserva % finalizada com sucesso! Valor total da hospedagem: R$ %', 
        p_id_reserva, v_valor_total;
END;
$$;

-- Teste Q12:
CALL finalizar_reserva(2);


-- -----------------------------------------------------------------------------
-- NÍVEL 7 — DESAFIO
-- -----------------------------------------------------------------------------

-- Questão 13 — Alterar valor da diária
CREATE OR REPLACE PROCEDURE alterar_valor_diaria(
    p_id_reserva INT,
    p_novo_valor NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_status VARCHAR;
BEGIN
    SELECT status 
    INTO v_status 
    FROM reservas 
    WHERE id_reserva = p_id_reserva;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Reserva com código % não foi encontrada.', p_id_reserva;
    END IF;

    IF v_status <> 'ATIVA' THEN
        RAISE EXCEPTION 'O valor só pode ser alterado para reservas ATIVAS. Status atual: %', v_status;
    END IF;

    IF p_novo_valor <= 0 THEN
        RAISE EXCEPTION 'O novo valor da diária deve ser maior que zero. Valor informado: %', p_novo_valor;
    END IF;

    UPDATE reservas
    SET valor_diaria = p_novo_valor
    WHERE id_reserva = p_id_reserva;

    RAISE INFO 'Valor da diária da reserva % alterado para R$ %.', p_id_reserva, p_novo_valor;
END;
$$;

-- Teste Q13:
CALL alterar_valor_diaria(3, 220.00);


-- Questão 14 — Reabrir reserva
CREATE OR REPLACE PROCEDURE reabrir_reserva(
    p_id_reserva INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_status VARCHAR;
BEGIN
    SELECT status 
    INTO v_status 
    FROM reservas 
    WHERE id_reserva = p_id_reserva;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Reserva com código % não foi encontrada.', p_id_reserva;
    END IF;

    IF v_status <> 'CANCELADA' THEN
        RAISE EXCEPTION 'Apenas reservas CANCELADAS podem ser reabertas. Status atual: %', v_status;
    END IF;

    UPDATE reservas
    SET status = 'ATIVA'
    WHERE id_reserva = p_id_reserva;

    RAISE INFO 'Reserva % reaberta com sucesso e redefinida para ATIVA.', p_id_reserva;
END;
$$;

-- Teste Q14:
CALL reabrir_reserva(1);


-- -----------------------------------------------------------------------------
-- DESAFIO FINAL
-- -----------------------------------------------------------------------------

-- Questão 15 — Confirmar reserva
CREATE OR REPLACE PROCEDURE confirmar_reserva(
    p_id_reserva INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_hospede INT;
    v_nome_hospede VARCHAR;
    v_checkin DATE;
    v_checkout DATE;
    v_diaria NUMERIC(10, 2);
    v_status VARCHAR;
    v_dias INT;
    v_valor_total NUMERIC(10, 2);
BEGIN
    -- 1. Verificar se a reserva existe
    SELECT id_hospede, data_checkin, data_checkout, valor_diaria, status
    INTO v_id_hospede, v_checkin, v_checkout, v_diaria, v_status
    FROM reservas
    WHERE id_reserva = p_id_reserva;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Reserva com código % não existe.', p_id_reserva;
    END IF;

    -- 2. Verificar se o hóspede associado existe
    SELECT nome INTO v_nome_hospede
    FROM hospedes
    WHERE id_hospede = v_id_hospede;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Hóspede associado (ID: %) não existe.', v_id_hospede;
    END IF;

    -- 3. Verificar se a reserva está ATIVA
    IF v_status <> 'ATIVA' THEN
        RAISE EXCEPTION 'A reserva % não está ATIVA (Status atual: %).', p_id_reserva, v_status;
    END IF;

    -- 4. Verificar se a data de checkout é posterior ao check-in
    IF v_checkout <= v_checkin THEN
        RAISE EXCEPTION 'Data de check-out (%) deve ser posterior ao check-in (%).', v_checkout, v_checkin;
    END IF;

    -- 5. Verificar se o valor da diária é maior que zero
    IF v_diaria <= 0 THEN
        RAISE EXCEPTION 'Valor da diária inválido (R$ %). Deve ser maior que zero.', v_diaria;
    END IF;

    -- 6. Calcular valor total da reserva
    v_dias := v_checkout - v_checkin;
    v_valor_total := v_dias * v_diaria;

    -- 7 e 8. Apresentar dados da reserva e valor calculado
    RAISE INFO '=========================================';
    RAISE INFO '       CONFIRMAÇÃO DE RESERVA #%         ', p_id_reserva;
    RAISE INFO '=========================================';
    RAISE INFO 'Hóspede: % (ID: %)', v_nome_hospede, v_id_hospede;
    RAISE INFO 'Check-in: % | Check-out: % (% dias)', v_checkin, v_checkout, v_dias;
    RAISE INFO 'Valor Diária: R$ %', v_diaria;
    RAISE INFO 'Status: %', v_status;
    RAISE INFO '-----------------------------------------';
    RAISE INFO 'VALOR TOTAL CALCULADO: R$ %', v_valor_total;
    RAISE INFO '=========================================';
END;
$$;

-- Teste Q15:
CALL confirmar_reserva(3);