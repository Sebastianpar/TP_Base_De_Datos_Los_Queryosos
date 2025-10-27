USE GD2C2025
GO

--CREATE SCHEMA LOS_QUERYOSOS;
--GO

-- Creacion de tablas

CREATE TABLE LOS_QUERYOSOS.Institucion(
	institucion_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	institucion_Nombre NVARCHAR(255),
	institucion_RazonSocial NVARCHAR(255),
	institucion_Cuit NVARCHAR(255)
);
GO

CREATE TABLE LOS_QUERYOSOS.Sede(
	sede_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	sede_Nombre NVARCHAR(255),
	sede_Direccion BIGINT,  --fk a institucion
	sede_Contacto BIGINT,
	sede_Institucion BIGINT -- FK a Institucion
);
GO

CREATE TABLE LOS_QUERYOSOS.Curso(
	curso_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	curso_Nombre VARCHAR(255),
	curso_Descripcion VARCHAR(255),
	curso_FechaInicio DATETIME2(6),
	curso_FechaFin DATETIME2(6),
	curso_DuracionMeses BIGINT,
	curso_PrecioMensual DECIMAL(38,2),
	curso_Categoria VARCHAR(255), --FK a Categoria
	curso_Turno VARCHAR(255), -- FK a Turno
	curso_Profesor BIGINT,--FK a Profesor
	curso_Sede BIGINT,--FK a Sede
	--falta curso_Dia en la tabla curso? 
	--pero esta la tabla diaCurso que ya lo relaciona
);
GO

CREATE TABLE LOS_QUERYOSOS.Profesor(
	profesor_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	profesor_Dni NVARCHAR(255),
	profesor_Nombre NVARCHAR(255),
	profesor_Apellido NVARCHAR(255),
	profesor_FechaNacimiento DATETIME2(6),
	profesor_Direccion BIGINT, --FK a Direccion
	profesor_Contacto BIGINT --FK a Contacto
);

GO

CREATE TABLE LOS_QUERYOSOS.Alumno(
	alumno_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	alumno_Legajo BIGINT,
	alumno_Dni BIGINT,
	alumno_Nombre VARCHAR(255),
	alumno_Apellido VARCHAR(255),
	alumno_FechaNacimiento DATETIME2(6),
	alumno_Contacto BIGINT, --FK a Contacto
	alumno_Direccion BIGINT --FK a Direccion
);
GO

CREATE TABLE LOS_QUERYOSOS.Inscripcion(
	inscripcion_Numero BIGINT IDENTITY(1,1) PRIMARY KEY,
	inscripcion_Fecha DATETIME2(6),
	inscripcion_Estado VARCHAR(255),
	inscripcion_FechaRespuesta DATETIME2(6),
	inscripcion_Alumno BIGINT, --FK a Alumno
	inscripcion_Curso BIGINT --FK a Curso
);
GO

CREATE TABLE LOS_QUERYOSOS.Evaluacion_Curso(
	evaluacion_Curso_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	evaluacion_Curso_FechaEvaluacion DATETIME2(6),
	evaluacion_Curso_Modulo BIGINT --FK a Modulo
	--falta nota, instancia,presente, van en Evaluacion_Alumno
);
GO

CREATE TABLE LOS_QUERYOSOS.Evaluacion_Curso_Alumno(
	evaluacion_Curso_Alumno_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	evaluacion_Curso_Alumno_Alumno BIGINT,
	evaluacion_Curso_Alumno_Instancia BIGINT,
	evaluacion_curso_Alumno_Nota BIGINT,
	evaluacion_curso_Alumno_Presente BIT,
);
GO

CREATE TABLE LOS_QUERYOSOS.Modulo(
	modulo_Numero BIGINT IDENTITY(1,1) PRIMARY KEY,
	modulo_Nombre VARCHAR(255),
	modulo_Descripcion VARCHAR(255),
	modulo_Curso BIGINT --FK a Curso
);
GO

CREATE TABLE LOS_QUERYOSOS.Trabajo_Practico(
	trabajo_Practico_Numero BIGINT IDENTITY(1,1) PRIMARY KEY,
	trabajo_Practico_Nota BIGINT,
	trabajo_Practico_FechaEvaluacion DATETIME2(6),
	trabajo_Practico_Curso BIGINT, --FK a Curso
	trabajo_Practico_Alumno BIGINT --FK a Alumno
);
GO

CREATE TABLE LOS_QUERYOSOS.Encuesta(
	encuesta_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	encuesta_FechaRegistro DATETIME2(6),
	encuesta_Observacion VARCHAR(255),
	encuesta_Curso BIGINT --FK a Curso
	--falta pregunta 1..4, nota 1..4, (tabla pregunta y respuesta)
);
GO
CREATE TABLE LOS_QUERYOSOS.Inscripcion_Final(
	inscripcion_Final_Numero BIGINT IDENTITY(1,1) PRIMARY KEY,
	inscripcion_Final_Fecha DATETIME2(6),
	inscripcion_Final_AlumnoCod BIGINT, --FK a Alumno
	inscripcion_Final_AlumnoLeg BIGINT, --Tambien va este campo? esta en el DER
	inscripcion_Final_ExamenFinal BIGINT --FK a Examen_Final
);
GO

CREATE TABLE LOS_QUERYOSOS.Examen_Final(
	examen_Final_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	examen_Final_Fecha DATETIME2(6),
	examen_Final_Hora VARCHAR(255),
	examen_Final_Descripcion VARCHAR(255),
	examen_Final_Curso BIGINT --FK a Curso
);
GO

CREATE TABLE LOS_QUERYOSOS.Evaluacion_Final(
	evaluacion_Final_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	evaluacion_Final_Nota BIGINT,
	evaluacion_Final_Presente BIT,
	evaluacion_Final_Profesor BIGINT,--FK a Profesor
	evaluacion_Final_Alumno BIGINT --FK a Alumno
);
GO

CREATE TABLE LOS_QUERYOSOS.Factura(
	factura_Numero BIGINT IDENTITY(1,1) PRIMARY KEY,
	factura_FechaEmision DATETIME2(6),
	factura_FechaVencimiento DATETIME2(6) ,
	factura_Alumno BIGINT --FK a Alumno
	--factura_total no esta en el DER pero si en la tabla maestra o es detalleFact_importe?
);
GO

CREATE TABLE LOS_QUERYOSOS.Detalle_Factura(
	detalle_Factura_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	detalle_Factura_Curso BIGINT,--FK a Curso
	detalle_Factura_Periodo BIGINT,--FK a Periodo
	detalle_Factura_Importe DECIMAL(18,2),
	detalle_Factura_Factura BIGINT --FK a Factura
);
GO

CREATE TABLE LOS_QUERYOSOS.Periodo(
	periodo_Numero BIGINT IDENTITY(1,1) PRIMARY KEY,
	periodo_Anio BIGINT,
	periodo_Mes BIGINT
);

GO

CREATE TABLE LOS_QUERYOSOS.Pago(
	pago_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	pago_Fecha DATETIME2(6),
	pago_Importe DECIMAL(18,2),
	pago_Medio_De_Pago VARCHAR(255),--FK a Medio_De_Pago
	pago_Factura BIGINT --FK a Factura
);
GO

CREATE TABLE LOS_QUERYOSOS.Medio_De_Pago(
	medio_De_Pago_ID BIGINT IDENTITY(1,1) PRIMARY KEY,
	medio_De_Pago_Detalle VARCHAR(255)
);
GO

CREATE TABLE LOS_QUERYOSOS.Provincia(
	provincia_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	provincia_Nombre VARCHAR(255)
);
GO

CREATE TABLE LOS_QUERYOSOS.Localidad(
	localidad_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	localidad_Nombre VARCHAR(255),
	localidad_Provincia BIGINT -- fk a provincia
);
GO

CREATE TABLE LOS_QUERYOSOS.Direccion(
	direccion_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	direccion_Calle VARCHAR(255),
	direccion_Numero BIGINT,
	direccion_Localidad BIGINT -- fk a Localidad
);
GO

CREATE TABLE LOS_QUERYOSOS.Contacto(
	contacto_ID BIGINT IDENTITY(1,1) PRIMARY KEY,
	contacto_Mail VARCHAR(255),
	contacto_Telefono BIGINT
);
GO

CREATE TABLE LOS_QUERYOSOS.Dia(
	dia_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	dia_Detalle VARCHAR(255)
);
GO

CREATE TABLE LOS_QUERYOSOS.Dia_Curso(
	dia_Codigo BIGINT,
	curso_Codigo BIGINT
);
GO

CREATE TABLE LOS_QUERYOSOS.Categoria(
	categoria_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	categoria_Detalle VARCHAR(255)
);
GO

CREATE TABLE LOS_QUERYOSOS.Turno(
	turno_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	turno_Detalle VARCHAR(255)
);
GO

CREATE TABLE LOS_QUERYOSOS.Estado(
	estado_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	estado_Detalle VARCHAR(255)
);
GO

--Constrains FKs

-- Localidad -> Provincia
ALTER TABLE LOS_QUERYOSOS.Localidad
ADD CONSTRAINT FK_Localidad_Provincia
FOREIGN KEY (Localidad_Provincia) REFERENCES LOS_QUERYOSOS.Provincia(Provincia_Codigo);

-- Sede -> Institución
ALTER TABLE LOS_QUERYOSOS.Sede
ADD CONSTRAINT FK_Sede_Institucion
FOREIGN KEY (Sede_Institucion) REFERENCES LOS_QUERYOSOS.Institucion(Institucion_Codigo);

-- Dirección -> Localidad
ALTER TABLE LOS_QUERYOSOS.Direccion
ADD CONSTRAINT FK_Direccion_Localidad
FOREIGN KEY (Direccion_Localidad) REFERENCES LOS_QUERYOSOS.Localidad(Localidad_Codigo);


-- Curso -> Sede
ALTER TABLE LOS_QUERYOSOS.Curso
ADD CONSTRAINT FK_Curso_Sede
FOREIGN KEY (Curso_Sede) REFERENCES LOS_QUERYOSOS.Sede(Sede_Codigo);

-- Curso -> Categoría
ALTER TABLE LOS_QUERYOSOS.Curso
ADD CONSTRAINT FK_Curso_Categoria
FOREIGN KEY (Curso_Categoria) REFERENCES LOS_QUERYOSOS.Categoria(Categoria_Codigo);

-- Curso -> Turno
ALTER TABLE LOS_QUERYOSOS.Curso
ADD CONSTRAINT FK_Curso_Turno
FOREIGN KEY (Curso_Turno) REFERENCES LOS_QUERYOSOS.Turno(Turno_Codigo);

-- Dia_Curso -> Curso
ALTER TABLE LOS_QUERYOSOS.Dia_Curso
ADD CONSTRAINT FK_Dia_Curso_Curso
FOREIGN KEY (Dia_Curso_Curso) REFERENCES LOS_QUERYOSOS.Dia_Curso(Curso_Codigo);

-- Dia_Curso -> Dia
ALTER TABLE LOS_QUERYOSOS.Dia_Curso
ADD CONSTRAINT FK_Dia_Curso_Dia
FOREIGN KEY (Dia_Curso_Dia) REFERENCES LOS_QUERYOSOS.Dia(Dia_Codigo);

-- Profesor -> Dirección
ALTER TABLE LOS_QUERYOSOS.Profesor
ADD CONSTRAINT FK_Profesor_Direccion
FOREIGN KEY (Profesor_Direccion) REFERENCES LOS_QUERYOSOS.Direccion(Direccion_Codigo);

-- Alumno -> Dirección
ALTER TABLE LOS_QUERYOSOS.Alumno
ADD CONSTRAINT FK_Alumno_Direccion
FOREIGN KEY (Alumno_Direccion) REFERENCES LOS_QUERYOSOS.Direccion(Direccion_Codigo);

-- Alumno -> Contacto
ALTER TABLE LOS_QUERYOSOS.Alumno
ADD CONSTRAINT FK_Alumno_Contacto
FOREIGN KEY (Alumno_Contacto) REFERENCES LOS_QUERYOSOS.Contacto(Contacto_Codigo);

-- Inscripción -> Alumno
ALTER TABLE LOS_QUERYOSOS.Inscripcion
ADD CONSTRAINT FK_Inscripcion_Alumno
FOREIGN KEY (Inscripcion_Alumno) REFERENCES LOS_QUERYOSOS.Alumno(Alumno_Codigo);

-- Inscripción -> Curso
ALTER TABLE LOS_QUERYOSOS.Inscripcion
ADD CONSTRAINT FK_Inscripcion_Curso
FOREIGN KEY (Inscripcion_Curso) REFERENCES LOS_QUERYOSOS.Curso(Curso_Codigo);

-- Inscripción -> Estado
ALTER TABLE LOS_QUERYOSOS.Inscripcion
ADD CONSTRAINT FK_Inscripcion_Estado
FOREIGN KEY (Inscripcion_Estado) REFERENCES LOS_QUERYOSOS.Estado(Estado_Codigo);

-- Evaluacion_Curso -> Modulo
ALTER TABLE LOS_QUERYOSOS.Evaluacion_Curso
ADD CONSTRAINT FK_Evaluacion_Curso_Modulo
FOREIGN KEY (Evaluacion_Curso_Modulo) REFERENCES LOS_QUERYOSOS.Modulo(Modulo_Codigo);

-- Evaluacion_Alumno -> Evaluacion_Curso
ALTER TABLE LOS_QUERYOSOS.Evaluacion_Alumno
ADD CONSTRAINT FK_Evaluacion_Alumno_Evaluacion_Curso
FOREIGN KEY (Evaluacion_Alumno_Evaluacion) REFERENCES LOS_QUERYOSOS.Evaluacion_Curso(Evaluacion_Curso_Codigo);

-- Evaluacion_Alumno -> Alumno
ALTER TABLE LOS_QUERYOSOS.Evaluacion_Alumno
ADD CONSTRAINT FK_Evaluacion_Alumno_Alumno
FOREIGN KEY (Evaluacion_Alumno_Alumno) REFERENCES LOS_QUERYOSOS.Alumno(Alumno_Codigo);

-- Evaluacion_Alumno -> Alumno
ALTER TABLE LOS_QUERYOSOS.Evaluacion_Alumno
ADD CONSTRAINT FK_Evaluacion_Alumno_Curso
FOREIGN KEY (Evaluacion_Alumno_Curso) REFERENCES LOS_QUERYOSOS.Curso(Curso_Codigo);

-- Examen_Final -> Curso
ALTER TABLE LOS_QUERYOSOS.Examen_Final
ADD CONSTRAINT FK_Examen_Final_Curso
FOREIGN KEY (Examen_Final_Curso) REFERENCES LOS_QUERYOSOS.Curso(Curso_Codigo);

-- Evaluacion_Final -> Profesor
ALTER TABLE LOS_QUERYOSOS.Evaluacion_Final
ADD CONSTRAINT FK_Evaluacion_Final_Profesor
FOREIGN KEY (Evaluacion_Final_Profespr) REFERENCES LOS_QUERYOSOS.Profesor(Profesor_Codigo);

-- Evaluacion_Final -> Alumno
ALTER TABLE LOS_QUERYOSOS.Evaluacion_Final
ADD CONSTRAINT FK_Evaluacion_Final_Alumno
FOREIGN KEY (Evaluacion_Final_Alumno) REFERENCES LOS_QUERYOSOS.Alumno(Alumno_Codigo);

-- Pregunta -> Encuesta
ALTER TABLE LOS_QUERYOSOS.Pregunta
ADD CONSTRAINT FK_Pregunta_Encuesta
FOREIGN KEY (Pregunta_Encuesta) REFERENCES LOS_QUERYOSOS.Encuesta(Encuesta_Codigo);

-- Respuesta -> Pregunta
ALTER TABLE LOS_QUERYOSOS.Respuesta
ADD CONSTRAINT FK_Respuesta_Pregunta
FOREIGN KEY (Respuesta_Pregunta) REFERENCES LOS_QUERYOSOS.Pregunta(Pregunta_Codigo);

-- Factura -> Periodo
ALTER TABLE LOS_QUERYOSOS.Factura
ADD CONSTRAINT FK_Factura_Periodo
FOREIGN KEY (Factura_Periodo) REFERENCES LOS_QUERYOSOS.Periodo(Periodo_Numero);

-- Detalle_Factura -> Factura
ALTER TABLE LOS_QUERYOSOS.Detalle_Factura
ADD CONSTRAINT FK_Detalle_Factura_Factura
FOREIGN KEY (Detalle_Factura_Factura) REFERENCES LOS_QUERYOSOS.Factura(Factura_Codigo);

-- Pago -> Factura
ALTER TABLE LOS_QUERYOSOS.Pago
ADD CONSTRAINT FK_Pago_Factura
FOREIGN KEY (Pago_Factura) REFERENCES LOS_QUERYOSOS.Factura(Factura_Codigo);

-- Pago -> Medio_De_Pago
ALTER TABLE LOS_QUERYOSOS.Pago
ADD CONSTRAINT FK_Pago_Medio_De_Pago
FOREIGN KEY (Pago_Medio_De_Pago) REFERENCES Medio_De_Pago(Medio_De_Pago_Codigo);

-- Modulo -> Curso
ALTER TABLE LOS_QUERYOSOS.Modulo
ADD CONSTRAINT FK_Modulo_Curso
FOREIGN KEY (Modulo_Curso) REFERENCES LOS_QUERYOSOS.Curso(Curso_Codigo);

-- Trabajo_Practico -> Modulo
ALTER TABLE LOS_QUERYOSOS.Trabajo_Practico
ADD CONSTRAINT FK_Trabajo_Practico_Modulo
FOREIGN KEY (Trabajo_Practico_Modulo) REFERENCES LOS_QUERYOSOS.Modulo(Modulo_Codigo);

-- Trabajo_Practico -> Alumno
ALTER TABLE LOS_QUERYOSOS.Trabajo_Practico
ADD CONSTRAINT FK_Trabajo_Practico_Alumno
FOREIGN KEY (Trabajo_Practico_Alumno) REFERENCES LOS_QUERYOSOS.Alumno(Alumno_Codigo);


--Inserts de datos a nuestro modelo
INSERT INTO LOS_QUERYOSOS.Institucion (Institucion_Nombre, Institucion_RazonSocial, Institucion_Cuit)
SELECT DISTINCT
    Institucion_Nombre,
    Institucion_RazonSocial,
    Institucion_Cuit
FROM gd_esquema.Maestra;
