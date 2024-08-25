-- Criação de tabelas e suas relações.
CREATE TABLE pacientes (
    paciente_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    data_nascimento DATE,
    endereco TEXT
);


CREATE TABLE administradores (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    usuario VARCHAR(50) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,  -- Certifique-se de usar hashing para armazenar senhas
    email VARCHAR(100) UNIQUE
);


CREATE TABLE agendamentos (
    agendamento_id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT,
    procedimento_id INT,
    data_hora DATETIME NOT NULL,
    observacoes TEXT,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(paciente_id),
    FOREIGN KEY (procedimento_id) REFERENCES procedimentos(procedimento_id)
);


CREATE TABLE procedimentos (
    procedimento_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL
);


CREATE TABLE historico_agendamentos (
    historico_id INT AUTO_INCREMENT PRIMARY KEY,
    agendamento_id INT,
    data_hora DATETIME NOT NULL,
    status ENUM('agendado', 'realizado', 'cancelado') NOT NULL,
    FOREIGN KEY (agendamento_id) REFERENCES agendamentos(agendamento_id)
);

-- Inserindo informações nas tabelas.
INSERT INTO pacientes (nome, telefone, email, data_nascimento, endereco) VALUES
('Ana Silva', '11987654321', 'ana.silva@example.com', '1985-06-15', 'Rua A, 123, São Paulo, SP'),
('João Souza', '11912345678', 'joao.souza@example.com', '1990-03-22', 'Rua B, 456, São Paulo, SP'),
('Maria Oliveira', '11923456789', 'maria.oliveira@example.com', '1982-11-30', 'Rua C, 789, São Paulo, SP'),
('Carlos Pereira', '11934567890', 'carlos.pereira@example.com', '1975-05-10', 'Rua D, 101, São Paulo, SP'),
('Fernanda Costa', '11945678901', 'fernanda.costa@example.com', '1988-08-20', 'Rua E, 202, São Paulo, SP'),
('Pedro Santos', '11956789012', 'pedro.santos@example.com', '1992-12-25', 'Rua F, 303, São Paulo, SP'),
('Laura Martins', '11967890123', 'laura.martins@example.com', '1980-07-05', 'Rua G, 404, São Paulo, SP'),
('Lucas Almeida', '11978901234', 'lucas.almeida@example.com', '1995-09-15', 'Rua H, 505, São Paulo, SP'),
('Patrícia Lima', '11989012345', 'patricia.lima@example.com', '1987-04-10', 'Rua I, 606, São Paulo, SP'),
('Roberto Oliveira', '11990123456', 'roberto.oliveira@example.com', '1991-01-30', 'Rua J, 707, São Paulo, SP');

INSERT INTO administradores (nome, usuario, senha, email) VALUES
('Maria Santos', 'admin1', 'senha_segura_123', 'maria.santos@example.com'),
('Paulo Ferreira', 'admin2', 'senha_segura_456', 'paulo.ferreira@example.com'),
('Juliana Almeida', 'admin3', 'senha_segura_789', 'juliana.almeida@example.com');

INSERT INTO procedimentos (nome, descricao, preco) VALUES
('Limpeza de Pele', 'Procedimento para remoção de impurezas e células mortas da pele.', 150.00),
('Massagem Relaxante', 'Massagem para alívio de tensão e estresse.', 120.00),
('Hidratação Facial', 'Tratamento para hidratação profunda da pele do rosto.', 180.00),
('Peeling Químico', 'Exfoliação química para melhorar a textura da pele.', 250.00),
('Massagem Modeladora', 'Massagem que ajuda na redução de medidas.', 200.00),
('Tratamento de Acne', 'Procedimento para controle e tratamento de acne.', 160.00),
('Drenagem Linfática', 'Massagem para estimular o sistema linfático e reduzir retenção de líquidos.', 130.00),
('Revitalização Facial', 'Tratamento para rejuvenescer a pele do rosto.', 220.00),
('Esfoliação Corporal', 'Procedimento para remoção de células mortas do corpo.', 140.00),
('Massagem Terapêutica', 'Massagem focada no tratamento de dores e lesões.', 170.00);

INSERT INTO agendamentos (paciente_id, procedimento_id, data_hora, observacoes) VALUES
(1, 1, '2024-09-01 10:00:00', 'Primeira sessão de limpeza de pele.'),
(2, 2, '2024-09-02 14:00:00', 'Massagem relaxante para alívio de estresse.'),
(3, 3, '2024-09-03 09:00:00', 'Hidratação facial agendada.'),
(4, 4, '2024-09-04 11:00:00', 'Peeling químico para rejuvenescimento.'),
(5, 5, '2024-09-05 15:00:00', 'Massagem modeladora para redução de medidas.'),
(6, 6, '2024-09-06 16:00:00', 'Tratamento para acne.'),
(7, 7, '2024-09-07 13:00:00', 'Drenagem linfática programada.'),
(8, 8, '2024-09-08 10:30:00', 'Revitalização facial marcada.'),
(9, 9, '2024-09-09 12:00:00', 'Esfoliação corporal agendada.'),
(10, 10, '2024-09-10 14:30:00', 'Massagem terapêutica para dores musculares.');

INSERT INTO historico_agendamentos (agendamento_id, data_hora, status) VALUES
(1, '2024-09-01 10:00:00', 'realizado'),
(2, '2024-09-02 14:00:00', 'realizado'),
(3, '2024-09-03 09:00:00', 'realizado'),
(4, '2024-09-04 11:00:00', 'realizado'),
(5, '2024-09-05 15:00:00', 'cancelado'),
(6, '2024-09-06 16:00:00', 'realizado'),
(7, '2024-09-07 13:00:00', 'realizado'),
(8, '2024-09-08 10:30:00', 'realizado'),
(9, '2024-09-09 12:00:00', 'realizado'),
(10, '2024-09-10 14:30:00', 'realizado');

