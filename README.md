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
#### DDL (Tabelas):
- Q.01: Criação da Tabela 'hospedes' com a inserção dos seus valores;
- Q.02: Criação da Tabela 'reservas' com a inserção dos seus valores.

#### DML & DQL (Questões de Procedure) :
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


## A checklist de conceitos utilizados:

| Conceito | Status | Onde foi utilizado no código SQL |
| :--- | :---: | :--- |
| **CREATE PROCEDURE** | [✔] | Utilizei na criação ou substituição de todas as procedures no arquivo DML & DQL: (ex.: `CREATE OR REPLACE PROCEDURE cadastrar_hospede(...)`). |
| **CALL** | [✔] | Presente nas instruções de teste e execução das procedures (ex.: `CALL cadastrar_hospede(...)`). |
| **Parâmetros** | [✔] | Utilizados nas assinaturas de quase todas as procedures com o prefixo `p_` (ex.: `p_id_hospede INT`, `p_novo_valor NUMERIC`). |
| **DECLARE** | [✔] | Utilizado do Nível 2 em diante para abrir o bloco de declaração de variáveis internas (ex.: **Q3 a Q15**). |
| **Variáveis** | [✔] | Declaradas no bloco `DECLARE` com o prefixo `v_` para armazenar dados temporários e resultados (ex.: `v_status`, `v_valor_total`, `v_dias`). |
| **SELECT INTO** | [✔] | Utilizado a partir da **Q3** para buscar registros das tabelas e atribui-los às variáveis (ex.: `SELECT nome INTO v_nome_hospede FROM hospedes WHERE ...`). |
| **INSERT** | [✔] | Aplicado no cadastro de novos hóspedes e criação de reservas nas questões **Q1, Q5, Q6 e Q7**. |
| **UPDATE** | [✔] | Utilizado na alteração de telefone (**Q2**), cancelamento (**Q8, Q9**), finalização (**Q12**), alteração de diária (**Q13**) e reabertura (**Q14**). |
| **IF** | [✔] | Aplicado na verificação de condições e validações (**Q4 a Q15**), como `IF NOT FOUND` ou validação de status (`IF v_status <> 'ATIVA'`). |
| **RAISE INFO** | [✔] | Utilizado para exibir mensagens informativas de sucesso/consulta no console (**Q3, Q10, Q11, Q12, Q13, Q14 e Q15**). |
| **RAISE EXCEPTION** | [✔] | Utilizado para lançar erros e interromper a execução quando uma regra é violada (**Q4, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14 e Q15**). |
| **Cálculos** | [✔] | Aplicados nos Níveis 5, 6 e no Desafio Final para determinar a quantidade de dias (`v_checkout - v_checkin`), valor total e descontos. |
| **Relacionamento entre tabelas** | [✔] | Utilizado na **Q15 (Desafio Final)** para relacionar e validar a chave estrangeira do hóspede na tabela de reservas com a tabela de hóspedes. |
| **Validação de regras de negócio** | [✔] | Implementada do Nível 4 ao Nível 7 para checar checkout > checkin (**Q7**), evitar duplo cancelamento (**Q9**), validar status e diárias > 0 (**Q13, Q15**). |
