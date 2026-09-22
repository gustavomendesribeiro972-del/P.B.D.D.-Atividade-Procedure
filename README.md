# **ATIVIDADE PROCEDURES P.B.D.D.___________(UNIFSA / 28M4A)**

#### Identificação do Aluno:
* Nome: Guilherme M. Ribeiro
* Disciplina: Projeto de Banco de Dados (P.B.D.D.)
* Turma: 28M4A
* Professor: Anderson Soares Costa
* Curso: Engenharia de Software

#### Este repositório contém a **modelagem de um banco de dados** e a implementação de suas **Procedures** para um sistema de gerenciamento de hotel desenvolvido em **PostgreSQL**

#### As Tecnologias e Conceitos que apliquei nesta atividade:
* **SGBD:** PostgreSQL (v9.12)
* **Linguagem Procedural:** PL/pgSQL (`CREATE PROCEDURE`, `DECLARE`, `IF/ELSE`, `RAISE INFO/EXCEPTION`)
* **Persistência & Consultas:** DDL, DML e DQL (`INSERT`, `UPDATE`), `SELECT INTO`


## Mapeamento das questões:

#### Organizei as questões dentro dos arquivos 'DDL' e 'DML & DQL':
#### DDL :
- Q.01: Criação da Tabela 'hospedes' com a inserção dos seus valores;
- Q.02: Criação da Tabela 'reservas' com a inserção dos seus valores.

#### DML & DQL :
- N.01: 'CREATE OR REPLACE PROCEDURE cadastrar_hospede (...'
- N.02: 'CREATE OR REPLACE PROCEDURE atualizar_telefone_hospede(...'
- N.03: 'CREATE OR REPLACE PROCEDURE consultar_hospede(...'
- N.04: Modificação da procedure anterior: 'CREATE OR REPLACE PROCEDURE consultar_hospede(...'
- N.05: 'CREATE OR REPLACE PROCEDURE criar_reserva(...'
- N.06: Modificaçã da procedure anterior, para validar o hospede: 'CREATE OR REPLACE PROCEDURE criar_reserva(...'
- N.07: 'CREATE OR REPLACE PROCEDURE criar_reserva(...'
- N.08: 'CREATE OR REPLACE PROCEDURE cancelar_reserva(...'
- N.09: Modificação da procedure anterior, para impedir o cancelamento de uma reserva já cancelada: 'CREATE OR REPLACE PROCEDURE cancelar_reserva(...'
- N.10: 'CREATE OR REPLACE PROCEDURE calcular_valor_reserva(...'
- N.11: 'CREATE OR REPLACE PROCEDURE calcular_valor_com_desconto(...'
- N.12: 'CREATE OR REPLACE PROCEDURE finalizar_reserva(...'
- N.13: 'CREATE OR REPLACE PROCEDURE alterar_valor_diaria(...'
- N.14: 'CREATE OR REPLACE PROCEDURE reabrir_reserva(...'
- N.15: 'CREATE OR REPLACE PROCEDURE confirmar_reserva(...'
