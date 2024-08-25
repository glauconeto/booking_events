-- Views para o banco da clínica.
-- Esta view exibe todos os agendamentos que ainda não foram concluídos ou cancelados.
-- É útil para visualizar rapidamente todos os agendamentos futuros.
CREATE VIEW agendamentos_ativos AS
SELECT
    a.agendamento_id,
    p.nome AS paciente_nome,
    pr.nome AS procedimento_nome,
    a.data_hora,
    a.observacoes
FROM
    agendamentos a
JOIN
    pacientes p ON a.paciente_id = p.paciente_id
JOIN
    procedimentos pr ON a.procedimento_id = pr.procedimento_id
WHERE
    a.data_hora >= NOW()
    AND NOT EXISTS (
        SELECT 1
        FROM historico_agendamentos ha
        WHERE ha.agendamento_id = a.agendamento_id
        AND ha.status IN ('realizado', 'cancelado')
    );


-- View de Totais de Procedimentos por Paciente
CREATE VIEW total_gasto_paciente AS
SELECT
    p.paciente_id,
    p.nome AS paciente_nome,
    SUM(pr.preco) AS total_gasto
FROM
    agendamentos a
JOIN
    pacientes p ON a.paciente_id = p.paciente_id
JOIN
    procedimentos pr ON a.procedimento_id = pr.procedimento_id
GROUP BY
    p.paciente_id, p.nome;


-- Histórico de Preços de Procedimentos
CREATE VIEW historico_precos_procedimentos AS
SELECT
    hp.procedimento_id,
    pr.nome AS procedimento_nome,
    hp.preco_antigo,
    hp.preco_novo,
    hp.data_alteracao
FROM
    historico_precos hp
JOIN
    procedimentos pr ON hp.procedimento_id = pr.procedimento_id;
