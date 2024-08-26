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


-- View de Totais de Procedimentos por Paciente.
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


-- Histórico de Preços de Procedimentos.
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

-- View que mostra um resumo completo dos agendamentos,
-- incluindo detalhes do paciente, do procedimento e do histórico de status.
CREATE VIEW resumo_agendamentos AS
SELECT 
    a.agendamento_id,
    p.nome AS paciente_nome,
    p.telefone AS paciente_telefone,
    p.email AS paciente_email,
    a.data_hora AS agendamento_data_hora,
    pr.nome AS procedimento_nome,
    pr.preco AS procedimento_preco,
    ha.status AS agendamento_status
FROM 
    agendamentos a
JOIN 
    pacientes p ON a.paciente_id = p.paciente_id
JOIN 
    procedimentos pr ON a.procedimento_id = pr.procedimento_id
JOIN 
    historico_agendamentos ha ON a.agendamento_id = ha.agendamento_id
WHERE 
    ha.data_hora = (SELECT MAX(data_hora) FROM historico_agendamentos ha2 WHERE ha2.agendamento_id = a.agendamento_id);

