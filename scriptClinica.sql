-- Criação de tabelas e suas relações.

CREATE TABLE `usuario` (
	`id` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`nome` VARCHAR(100),
	`email` VARCHAR(100),
	`senha` VARCHAR(100),
);

CREATE TABLE `agendamento` (
	`id` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`nome` VARCHAR(70) NOT NULL,
	`telefone` VARCHAR(20) NOT NULL,
	`dataHora` TIMESTAMP NOT NULL,
	`procedimento` VARCHAR(50) NOT NULL,
	`idAdministrador` INTEGER,
);

CREATE TABLE `administrador` (
	`id` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`email` VARCHAR(255) NOT NULL,
	`senha` VARCHAR(255) NOT NULL,
);

CREATE TABLE `informações usuario` (
	`id` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`nome` VARCHAR(100),
	`dataNascimento` DATE,
	`usId` INTEGER,
	`descricao` VARCHAR(255),
);

CREATE TABLE `preco` (
	`id` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`nomeProcedimento` VARCHAR(100),
	`preco` DECIMAL(6, 2),
	`descricao` TEXT(100),
);

ALTER TABLE `administrador`
ADD FOREIGN KEY(`id`) REFERENCES `agendamento`(`idAdministrador`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `usuario`
ADD FOREIGN KEY(`id`) REFERENCES `informações usuario`(`usId`)
ON UPDATE NO ACTION ON DELETE CASCADE;