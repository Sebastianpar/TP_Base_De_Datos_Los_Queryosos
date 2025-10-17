USE GD2C2025
GO

/*CREATE SCHEMA LOS_QUERYOSOS;
GO*/

CREATE TABLE LOS_QUERYOSOS.Institucion(
	institucion_Codigo BIGINT PRIMARY KEY,
	institucion_Nombre NVARCHAR(255),
	institucion_RazonSocial NVARCHAR(255),
	institucion_Cuit NVARCHAR(255)
);
GO

CREATE TABLE LOS_QUERYOSOS.Sede(
	sede_Codigo BIGINT PRIMARY KEY,
	sede_Nombre NVARCHAR(255),
	sede_Direccion BIGINT, --falta FK a direccion en DER? 
	sede_Contacto BIGINT,
	sede_Institucion BIGINT -- FK a Institucion
);
GO

CREATE TABLE LOS_QUERYOSOS.Curso(
	curso_Codigo BIGINT PRIMARY KEY,
	curso_Nombre VARCHAR(255),
	curso_Descripcion VARCHAR(255),
	curso_FechaInicio DATETIME2(6),
	curso_FechaFin DATETIME2(6),
	curso_DuracionMeses BIGINT,
	curso_PrecioMensual DECIMAL(38,2),
	curso_Categoria VARCHAR(255), --FK a Categoria
	curso_Turno VARCHAR(255), -- FK a Turno
	curso_Profesor BIGINT,--FK a Profesor
	curso_Sede BIGINT--FK a Sede
	--falta curso_Dia en la tabla curso?
);
GO

CREATE TABLE LOS_QUERYOSOS.Profesor(
	profesor_Codigo BIGINT PRIMARY KEY,
	profesor_Dni NVARCHAR(255),
	profesor_Nombre NVARCHAR(255),
	profesor_Apellido NVARCHAR(255),
	profesor_FechaNacimiento DATETIME2(6),
	profesor_Direccion BIGINT, --FK a Direccion
	profesor_Contacto BIGINT --FK a Contacto
);

GO

CREATE TABLE LOS_QUERYOSOS.Alumno(
	alumno_Codigo BIGINT PRIMARY KEY,
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
	inscripcion_Numero BIGINT PRIMARY KEY,
	inscripcion_Fecha DATETIME2(6),
	inscripcion_Estado VARCHAR(255),
	inscripcion_FechaRespuesta DATETIME2(6),
	inscripcion_Alumno BIGINT, --FK a Alumno
	inscripcion_Curso BIGINT --FK a Curso
);
GO

CREATE TABLE LOS_QUERYOSOS.Evaluacion_Curso(
	evaluacion_Curso_Codigo BIGINT PRIMARY KEY,
	evaluacion_Curso_FechaEvaluacion DATETIME2(6),
	evaluacion_Curso_Modulo BIGINT --FK a Modulo
	--falta nota, instancia,presente, van en Evaluacion_Alumno
);
GO

CREATE TABLE LOS_QUERYOSOS.Modulo(
	modulo_Numero BIGINT PRIMARY KEY,
	modulo_Nombre VARCHAR(255),
	modulo_Descripcion VARCHAR(255),
	modulo_Curso BIGINT --FK a Curso
);
GO

CREATE TABLE LOS_QUERYOSOS.Trabajo_Practico(
	trabajo_Practico_Numero BIGINT PRIMARY KEY,
	trabajo_Practico_Nota BIGINT,
	trabajo_Practico_FechaEvaluacion DATETIME2(6),
	trabajo_Practico_Curso BIGINT, --FK a Curso
	trabajo_Practico_Alumno BIGINT --FK a Alumno
);
GO

CREATE TABLE LOS_QUERYOSOS.Encuesta(
	encuesta_Codigo BIGINT PRIMARY KEY,
	encuesta_FechaRegistro DATETIME2(6),
	encuesta_Observacion VARCHAR(255),
	encuesta_Curso BIGINT --FK a Curso
	--falta pregunta 1..4, nota 1..4, (tabla pregunta y respuesta)
);
GO
CREATE TABLE LOS_QUERYOSOS.Inscripcion_Final(
	inscripcion_Final_Numero BIGINT PRIMARY KEY,
	inscripcion_Final_Fecha DATETIME2(6),
	inscripcion_Final_AlumnoCod BIGINT, --FK a Alumno
	inscripcion_Final_AlumnoLeg BIGINT, --Tambien va este campo? esta en el DER
	inscripcion_Final_ExamenFinal BIGINT --FK a Examen_Final
);
GO

CREATE TABLE LOS_QUERYOSOS.Examen_Final(
	examen_Final_Codigo BIGINT PRIMARY KEY,
	examen_Final_Fecha DATETIME2(6),
	examen_Final_Hora VARCHAR(255),
	examen_Final_Descripcion VARCHAR(255),
	examen_Final_Curso BIGINT --FK a Curso
);
GO

CREATE TABLE LOS_QUERYOSOS.Evaluacion_Final(
	evaluacion_Final_Codigo BIGINT PRIMARY KEY,
	evaluacion_Final_Nota BIGINT,
	evaluacion_Final_Presente BIT,
	evaluacion_Final_Profesor BIGINT,--FK a Profesor
	evaluacion_Final_Alumno BIGINT --FK a Alumno
);
GO

CREATE TABLE LOS_QUERYOSOS.Factura(
	factura_Numero BIGINT PRIMARY KEY,
	factura_FechaEmision DATETIME2(6),
	factura_FechaVencimiento DATETIME2(6) ,
	factura_Alumno BIGINT --FK a Alumno
	--factura_total no esta en el DER pero si en la tabla maestra o es detalleFact_importe?
);
GO

CREATE TABLE LOS_QUERYOSOS.Detalle_Factura(
	detalle_Factura_Codigo BIGINT PRIMARY KEY,
	detalle_Factura_Curso BIGINT,--FK a Curso
	detalle_Factura_Periodo BIGINT,--FK a Periodo
	detalle_Factura_Importe DECIMAL(18,2),
	detalle_Factura_Factura BIGINT --FK a Factura
);
GO

CREATE TABLE LOS_QUERYOSOS.Periodo(
	periodo_Numero BIGINT PRIMARY KEY,
	periodo_Anio BIGINT,
	periodo_Mes BIGINT
);

GO

CREATE TABLE LOS_QUERYOSOS.Pago(
	pago_Codigo BIGINT PRIMARY KEY,
	pago_Fecha DATETIME2(6),
	pago_Importe DECIMAL(18,2),
	pago_Medio_De_Pago VARCHAR(255),--FK a Medio_De_Pago
	pago_Factura BIGINT --FK a Factura
);
GO


