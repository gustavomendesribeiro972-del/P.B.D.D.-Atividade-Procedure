--Tabelas:
CREATE TABLE hospedes(
	id_hospede SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(150) UNIQUE NOT NULL,
	telefone VARCHAR(20)
);

CREATE TABLE reservas(
	id_reserva SERIAL PRIMARY KEY,
	id_hospede INTEGER NOT NULL,
	data_checkin DATE NOT NULL,
	data_checkout DATE NOT NULL,
	valor_diaria NUMERIC (10, 2) NOT NULL,		--	HÓSPEDE <-1:1-------------1:N-> RESERVA
	status VARCHAR(20) DEFAULT 'ATIVA',

	FOREIGN KEY (id_hospede)
		REFERENCES hospedes(id_hospede)
);

--Inserções:
INSERT INTO hospedes (nome, email, telefone)
VALUES
    ('Ana Oliveira', 'ana@email.com', '86999990001'),
    ('Bruno Santos', 'bruno@email.com', '86999990002'),
    ('Carla Mendes', 'carla@email.com', '86999990003'),
    ('Daniel Costa', 'daniel@email.com', '86999990004');

INSERT INTO reservas (id_hospede, data_checkin, data_checkout, valor_diaria, status)
VALUES
    (1, '2026-10-10', '2026-10-13', 250.00, 'ATIVA'),
    (2, '2026-10-15', '2026-10-18', 300.00, 'ATIVA'),
    (3, '2026-11-05', '2026-11-07', 200.00, 'ATIVA');

--Selects para consultar os dados:
SELECT * FROM hospedes;
SELECT * FROM reservas;
