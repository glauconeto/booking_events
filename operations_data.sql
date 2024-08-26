-- Stored procedures que serão realizadas no banco.


-- Calcular Total de Procedimentos Agendados por Mês.
-- Calcula o total de valores de procedimentos agendados em um mês específico.
DELIMITER //

CREATE PROCEDURE calcular_total_mensal(IN mes INT, IN ano INT, OUT total DECIMAL(10, 2))
BEGIN
    SELECT SUM(p.preco) INTO total
    FROM agendamentos a
    JOIN procedimentos p ON a.procedimento_id = p.procedimento_id
    WHERE MONTH(a.data_hora) = mes AND YEAR(a.data_hora) = ano;
END //

DELIMITER ;


-- Adicionar Novo Procedimento
-- Adiciona um novo procedimento com um nome, descrição e preço especificado.
DELIMITER //

CREATE PROCEDURE adicionar_procedimento(
    IN nome_procedimento VARCHAR(100),
    IN descricao_procedimento TEXT,
    IN preco_procedimento DECIMAL(10, 2)
)
BEGIN
    INSERT INTO procedimentos (nome, descricao, preco)
    VALUES (nome_procedimento, descricao_procedimento, preco_procedimento);
END //

DELIMITER ;


-- Atualizar Preço de Procedimento
-- Atualiza o preço de um procedimento específico.
DELIMITER //

CREATE PROCEDURE atualizar_preco_procedimento(
    IN procedimento_id INT,
    IN novo_preco DECIMAL(10, 2)
)
BEGIN
    UPDATE procedimentos
    SET preco = novo_preco
    WHERE procedimento_id = procedimento_id;
END //

DELIMITER ;

-- Remove agendamento
-- Exclui um agendamento e também remove o histórico associado a ele.
DELIMITER //

CREATE PROCEDURE remover_agendamento(IN p_agendamento_id INT)
BEGIN
    START TRANSACTION;

    -- Remove o histórico de agendamento relacionado
    DELETE FROM historico_agendamentos
    WHERE agendamento_id = p_agendamento_id;

    -- Remove o agendamento
    DELETE FROM agendamentos
    WHERE agendamento_id = p_agendamento_id;

    -- Confirma a transação
    COMMIT;
END //

DELIMITER ;


-- Triggers a serem disparados no banco.
-- Trigger para Atualizar Histórico Quando um Agendamento é Inserido
-- Este trigger insere uma entrada na tabela historico_agendamentos quando um novo agendamento é feito.
DELIMITER //

CREATE TRIGGER after_agendamento_insert
AFTER INSERT ON agendamentos
FOR EACH ROW
BEGIN
    INSERT INTO historico_agendamentos (agendamento_id, data_hora, status)
    VALUES (NEW.agendamento_id, NOW(), 'agendado');
END //

DELIMITER ;


-- Atualizaçãp de Preço Quando um Procedimento é Atualizado
-- Este trigger atualiza o preço do procedimento na tabela procedimentos e
-- adiciona uma entrada na tabela historico_preco quando o preço é alterado.
-- Definição da tabela de histórico de preços.
CREATE TABLE historico_precos (
    historico_id INT AUTO_INCREMENT PRIMARY KEY,
    procedimento_id INT,
    preco_antigo DECIMAL(10, 2),
    preco_novo DECIMAL(10, 2),
    data_alteracao DATETIME,
    FOREIGN KEY (procedimento_id) REFERENCES procedimentos(procedimento_id)
);

-- Definição do trigger.
DELIMITER //

CREATE TRIGGER after_procedimento_update
AFTER UPDATE ON procedimentos
FOR EACH ROW
BEGIN
    INSERT INTO historico_precos (procedimento_id, preco_antigo, preco_novo, data_alteracao)
    VALUES (OLD.procedimento_id, OLD.preco, NEW.preco, NOW());
END //

DELIMITER ;


-- Atualiza o status na Tabela historico_agendamentos quando um agendamento é cancelado.
-- Este trigger atualiza o status para 'cancelado' quando um agendamento é deletado da tabela agendamentos.
DELIMITER //

CREATE TRIGGER after_agendamento_delete
AFTER DELETE ON agendamentos
FOR EACH ROW
BEGIN
    INSERT INTO historico_agendamentos (agendamento_id, data_hora, status)
    VALUES (OLD.agendamento_id, NOW(), 'cancelado');
END //

DELIMITER ;


-- Cursor.
-- Gera relatório de agendamentos
-- Vamos usar um cursor para gerar um relatório com o total de preços dos procedimentos agendados para
-- cada paciente em um determinado mês.
DELIMITER //

CREATE PROCEDURE relatorio_agendamentos(IN mes INT, IN ano INT)
BEGIN
    -- Declaração de variáveis
    DECLARE done INT DEFAULT FALSE;
    DECLARE p_id INT;
    DECLARE total DECIMAL(10, 2);
    DECLARE cur CURSOR FOR 
        SELECT paciente_id, SUM(p.preco) 
        FROM agendamentos a
        JOIN procedimentos p ON a.procedimento_id = p.procedimento_id
        WHERE MONTH(a.data_hora) = mes AND YEAR(a.data_hora) = ano
        GROUP BY paciente_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Abre o cursor
    OPEN cur;
    
    -- Iterar sobre o cursor
    read_loop: LOOP
        FETCH cur INTO p_id, total;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Exibir resultados (aqui você pode usar uma tabela de relatório ou outro método de saída)
        SELECT p_id AS paciente_id, total AS total_gasto;
    END LOOP;
    
    -- Fechar o cursor
    CLOSE cur;
END //

DELIMITER ;

-- Uso:
CALL relatorio_agendamentos(8, 2024);
