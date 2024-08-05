CREATE TABLE `usuario` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`nome` VARCHAR(100),
	`email` VARCHAR(100),
	`senha` VARCHAR(100),
	PRIMARY KEY(`id`)
);


CREATE TABLE `agendamento` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`nome` VARCHAR(70),
	`dataHora` TIMESTAMP NOT NULL,
	`idUsuario` INTEGER NOT NULL,
	`idAdministrador` INTEGER,
	PRIMARY KEY(`id`)
);


CREATE TABLE `administrador` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`email` VARCHAR(255) NOT NULL,
	`senha` VARCHAR(255) NOT NULL,
	PRIMARY KEY(`id`)
);


ALTER TABLE `usuario`
ADD FOREIGN KEY(`id`) REFERENCES `agendamento`(`idUsuario`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `administrador`
ADD FOREIGN KEY(`id`) REFERENCES `agendamento`(`idAdministrador`)
ON UPDATE NO ACTION ON DELETE NO ACTION;