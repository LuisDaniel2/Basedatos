
CREATE DATABASE ULTIMATE_DB_PROYECT;
USE ULTIMATE_DB_PROYECT;

-- Tabla: Usuarios
CREATE TABLE Usuarios (
  id_usuario INT PRIMARY KEY,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  correo_electronico VARCHAR(100),
  contrasena VARCHAR(50)
);

-- Tabla: Tecnicos
CREATE TABLE Tecnicos (
	id_tecnico INT PRIMARY KEY,
	nombre VARCHAR(50),
	apellido VARCHAR(50),
	correo_electronico VARCHAR(100),
	especialidad VARCHAR(50)
);

-- Tabla: Solicitudes

CREATE TABLE Solicitudes (
	id_solicitud INT IDENTITY(1,1) PRIMARY KEY,
	id_usuario INT,
	fecha_solicitud DATETIME DEFAULT GETDATE(),
	descripcion_problema TEXT,
	estado VARCHAR(50),
	FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- Tabla: Asignaciones

CREATE TABLE Asignaciones (
	id_asignacion INT IDENTITY(1,1) PRIMARY KEY,
	id_solicitud INT,
	id_tecnico INT,
	fecha_asignacion DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (id_solicitud) REFERENCES Solicitudes(id_solicitud),
	FOREIGN KEY (id_tecnico) REFERENCES Tecnicos(id_tecnico)
);

-- Tabla: Informes
CREATE TABLE Informes (
	id_informe INT IDENTITY(1,1) PRIMARY KEY,
	id_solicitud INT,
	id_usuario INT,
	id_tecnico INT,
	id_asignacion INT,
	informe TEXT,

	FOREIGN KEY (id_solicitud) REFERENCES Solicitudes(id_solicitud),
	FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
	FOREIGN KEY (id_tecnico) REFERENCES Tecnicos(id_tecnico),
	FOREIGN KEY (id_asignacion) REFERENCES Asignaciones(id_asignacion)
);



-- Procedimientos almacenados para la tabla Usuarios
CREATE PROCEDURE SP_Usuarios_Agregar
  @p_id_usuario INT,
  @p_nombre VARCHAR(50),
  @p_apellido VARCHAR(50),
  @p_correo_electronico VARCHAR(100),
  @p_contrasena VARCHAR(50)
AS
BEGIN
  INSERT INTO Usuarios (id_usuario, nombre, apellido, correo_electronico, contrasena)
  VALUES (@p_id_usuario, @p_nombre, @p_apellido, @p_correo_electronico, @p_contrasena);
END;

execute SP_Usuarios_Agregar 1, 'luis', 'este', 'correo@core', '12345';
SELECT * FROM Usuarios;


CREATE PROCEDURE SP_Usuarios_Eliminar
  @p_id_usuario INT
AS
BEGIN
  DELETE FROM Usuarios WHERE id_usuario = @p_id_usuario;
END;

CREATE PROCEDURE SP_Usuarios_Actualizar
  @p_id_usuario INT,
  @p_nombre VARCHAR(50),
  @p_apellido VARCHAR(50),
  @p_correo_electronico VARCHAR(100),
  @p_contrasena VARCHAR(50)
AS
BEGIN
  UPDATE Usuarios
  SET nombre = @p_nombre, apellido = @p_apellido, correo_electronico = @p_correo_electronico, contrasena = @p_contrasena
  WHERE id_usuario = @p_id_usuario;
END;

CREATE PROCEDURE SP_Usuarios_ListarTodos
AS
BEGIN
  SELECT * FROM Usuarios;
END;

CREATE PROCEDURE SP_Usuarios_ObtenerPorId
  @p_id_usuario INT
AS
BEGIN
  SELECT * FROM Usuarios WHERE id_usuario = @p_id_usuario;
END;


-- Procedimientos almacenados para la tabla Solicitudes
CREATE PROCEDURE SP_Solicitudes_Agregar
  @p_id_usuario INT,  
  @p_descripcion_problema TEXT,
  @p_estado VARCHAR(50)
AS
BEGIN
  INSERT INTO Solicitudes ( id_usuario, descripcion_problema, estado)
  VALUES ( @p_id_usuario, @p_descripcion_problema, @p_estado);
END;

execute SP_Solicitudes_Agregar 1, 'el pc no sirve', 'sin respuesta';
SELECT * FROM Solicitudes;



CREATE PROCEDURE SP_Solicitudes_Eliminar
  @p_id_solicitud INT
AS
BEGIN
  DELETE FROM Solicitudes WHERE id_solicitud = @p_id_solicitud;
END;

CREATE PROCEDURE SP_Solicitudes_Actualizar
  @p_id_solicitud INT,
  @p_id_usuario INT,
  @p_fecha_solicitud DATE,
  @p_descripcion_problema TEXT,
  @p_estado VARCHAR(50)
AS
BEGIN
  UPDATE Solicitudes
  SET id_usuario = @p_id_usuario, fecha_solicitud = @p_fecha_solicitud, descripcion_problema = @p_descripcion_problema, estado = @p_estado
  WHERE id_solicitud = @p_id_solicitud;
END;

CREATE PROCEDURE SP_Solicitudes_ListarTodos
AS
BEGIN
  SELECT * FROM Solicitudes;
END;

CREATE PROCEDURE SP_Solicitudes_ObtenerPorId
@p_id_solicitud INT
AS
BEGIN
SELECT * FROM Solicitudes WHERE id_solicitud = @p_id_solicitud;
END;



-- Procedimientos almacenados para la tabla Tecnicos
CREATE PROCEDURE SP_Tecnicos_Agregar
@p_id_tecnico INT,
@p_nombre VARCHAR(50),
@p_apellido VARCHAR(50),
@p_correo_electronico VARCHAR(100),
@p_especialidad VARCHAR(50)
AS
BEGIN
INSERT INTO Tecnicos (id_tecnico, nombre, apellido, correo_electronico, especialidad)
VALUES (@p_id_tecnico, @p_nombre, @p_apellido, @p_correo_electronico, @p_especialidad);
END;

execute SP_Tecnicos_Agregar 1, 'juan', 'trab', 'bie@gma', 'impresoras';
SELECT * FROM Tecnicos;


CREATE PROCEDURE SP_Tecnicos_Eliminar
@p_id_tecnico INT
AS
BEGIN
DELETE FROM Tecnicos WHERE id_tecnico = @p_id_tecnico;
END;

CREATE PROCEDURE SP_Tecnicos_Actualizar
@p_id_tecnico INT,
@p_nombre VARCHAR(50),
@p_apellido VARCHAR(50),
@p_correo_electronico VARCHAR(100),
@p_especialidad VARCHAR(50)
AS
BEGIN
UPDATE Tecnicos
SET nombre = @p_nombre, apellido = @p_apellido, correo_electronico = @p_correo_electronico, especialidad = @p_especialidad
WHERE id_tecnico = @p_id_tecnico;
END;

CREATE PROCEDURE SP_Tecnicos_ListarTodos
AS
BEGIN
SELECT * FROM Tecnicos;
END;

CREATE PROCEDURE SP_Tecnicos_ObtenerPorId
@p_id_tecnico INT
AS
BEGIN
SELECT * FROM Tecnicos WHERE id_tecnico = @p_id_tecnico;
END;


-- Procedimientos almacenados para la tabla Asignaciones
CREATE PROCEDURE SP_Asignaciones_Agregar
@p_id_solicitud INT,
@p_id_tecnico INT
AS
BEGIN
INSERT INTO Asignaciones ( id_solicitud, id_tecnico)
VALUES ( @p_id_solicitud, @p_id_tecnico);
END;

execute SP_Asignaciones_Agregar 1, 1; 
SELECT * FROM Asignaciones;


CREATE PROCEDURE SP_Asignaciones_Eliminar
@p_id_asignacion INT
AS
BEGIN
DELETE FROM Asignaciones WHERE id_asignacion = @p_id_asignacion;
END;

CREATE PROCEDURE SP_Asignaciones_Actualizar
@p_id_asignacion INT,
@p_id_solicitud INT,
@p_id_tecnico INT,
@p_fecha_asignacion DATE
AS
BEGIN
UPDATE Asignaciones
SET id_solicitud = @p_id_solicitud, id_tecnico = @p_id_tecnico, fecha_asignacion = @p_fecha_asignacion
WHERE id_asignacion = @p_id_asignacion;
END;

CREATE PROCEDURE SP_Asignaciones_ListarTodos
AS
BEGIN
SELECT * FROM Asignaciones;
END;

CREATE PROCEDURE SP_Asignaciones_ObtenerPorId
@p_id_asignacion INT
AS
BEGIN
SELECT * FROM Asignaciones WHERE id_asignacion = @p_id_asignacion;
END;



-- Procedimientos almacenados para la tabla Informes
CREATE PROCEDURE SP_Informes_Agregar
@p_id_solicitud INT,
@p_id_usuario INT,
@p_id_tecnico INT,
@p_id_asignacion INT,
@p_informe TEXT
AS
BEGIN
INSERT INTO Informes ( id_solicitud, id_usuario, id_tecnico, id_asignacion, informe)
VALUES ( @p_id_solicitud, @p_id_usuario, @p_id_tecnico, @p_id_asignacion, @p_informe);
END;

execute SP_Informes_Agregar 1, 1, 1, 2,'sirve el informe';
SELECT * FROM Informes;

CREATE PROCEDURE SP_Informes_Eliminar
@p_id_informe INT
AS
BEGIN
DELETE FROM Informes WHERE id_informe = @p_id_informe;
END;

CREATE PROCEDURE SP_Informes_Actualizar
@p_id_informe INT,
@p_id_solicitud INT,
@p_id_usuario INT,
@p_id_tecnico INT,
@p_id_asignacion INT,
@p_informe TEXT
AS
BEGIN
UPDATE Informes
SET id_solicitud = @p_id_solicitud, id_usuario = @p_id_usuario, id_tecnico = @p_id_tecnico , id_asignacion = @p_id_asignacion, informe = @p_informe
WHERE id_informe = @p_id_informe;
END;

CREATE PROCEDURE SP_Informes_ListarTodos
AS
BEGIN
SELECT * FROM Informes;
END;

CREATE PROCEDURE SP_Informes_ObtenerPorId
@p_id_informe INT
AS
BEGIN
SELECT * FROM Informes WHERE id_informe = @p_id_informe;
END;


execute SP_Usuarios_ListarTodos;
execute SP_Tecnicos_ListarTodos;
execute SP_Solicitudes_ListarTodos;
execute SP_Asignaciones_ListarTodos;
execute SP_Informes_ListarTodos;
