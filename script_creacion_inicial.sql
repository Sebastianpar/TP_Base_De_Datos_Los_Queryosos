USE GD2C2025
GO

/*CREATE SCHEMA LOS_QUERYOSOS;
GO*/

CREATE TABLE LOS_QUERYOSOS.Factura(
	factura_Numero BIGINT,
	factura_FechaEmision DATETIME2(6),
	factura_FechaVencimiento DATETIME2(6) 
	--falta factura_total? no esta en el DER pero si en la tabla maestra o es detalleFact_importe?
);
GO

CREATE TABLE LOS_QUERYOSOS.Institucion(
	institucion_Nombre NVARCHAR(255),
	institucion_RazonSocial NVARCHAR(255),
	institucion_Cuit NVARCHAR(255)
);
GO

CREATE TABLE LOS_QUERYOSOS.Sede(
	sede_Nombre NVARCHAR(255) 
	--falta direccion (sede_Provincia, sede_Localidad,sede_Direccion )y contacto (sede_telefono,sede_mail)
);
GO

CREATE TABLE LOS_QUERYOSOS.Curso(
	curso_Codigo BIGINT PRIMARY KEY,
	curso_Nombre NVARCHAR(255),
	curso_Descripcion NVARCHAR(255),
	curso_FechaInicio DATETIME2(6),
	curso_FechaFin DATETIME2(6),
	curso_DuracionMeses BIGINT,
	curso_PrecioMensual DECIMAL(38,2),
	curso_Categoria VARCHAR(255),
	curso_Turno VARCHAR(255)
	--falta curso_profesor, curso_sede, y falta curso_Dia en la tabla curso?
);
GO

CREATE TABLE LOS_QUERYOSOS.Profesor(
	profesor_Dni NVARCHAR(255),
	profesor_Nombre NVARCHAR(255),
	profesor_Apellido NVARCHAR(255),
	profesor_FechaNacimiento DATETIME2(6)
	--falta direccion(profesor_Direccion,profesor_Localidad,profesor_Provincia) y contacto (profesor_Mail,profesor_Telefono)
);

GO

CREATE TABLE LOS_QUERYOSOS.Alumno(
	alumno_Legajo BIGINT,
	alumno_Dni BIGINT,
	alumno_Nombre VARCHAR(255),
	alumno_Apellido VARCHAR(255),
	alumno_FechaNacimiento DATETIME2(6)
	--falta direccion(alumno_Direccion,alumno_Localidad,alumno_Provincia) y contacto (alumno_Mail,alumno_Telefono)
);
GO

CREATE TABLE LOS_QUERYOSOS.Inscripcion(
	inscripcion_Numero BIGINT PRIMARY KEY,
	inscripcion_Fecha DATETIME2(6),
	inscripcion_Estado VARCHAR(255),
	inscripcion_FechaRespuesta DATETIME2(6)
	--falta inscripcion_Alumno, inscripcion_Curso
);
GO

CREATE TABLE LOS_QUERYOSOS.Evaluacion_Curso(
	evaluacion_Curso_FechaEvaluacion DATETIME2(6),
	--falta modulo, nota, instancia,presente
);
GO

CREATE TABLE LOS_QUERYOSOS.Modulo(
	modulo_Nombre VARCHAR(255),
	modulo_descripcion VARCHAR(255)
	--falta modulo, curso,
);
GO

CREATE TABLE LOS_QUERYOSOS.Trabajo_Practico(
	trabajo_Practico_Nota BIGINT,
	trabajo_Practico_FechaEvaluacion DATETIME2(6)
	--falta curso, alumno
);
GO

CREATE TABLE LOS_QUERYOSOS.Encuesta(
	encuesta_FechaRegistro DATETIME2(6),
	encuesta_Observacion VARCHAR(255)
	--falta pregunta 1..4, nota 1..4, (tabla pregunta y respuesta)
);
GO
CREATE TABLE LOS_QUERYOSOS.Inscripcion_Final(
	inscripcion_Final_Numero BIGINT,
	inscripcion_Final_Fecha DATETIME2(6)
	--falta alumnoCod, alumnoLeg, examenFinal .. Tambien va alumno legajo? esta en el DER
);
GO

CREATE TABLE LOS_QUERYOSOS.Examen_Final(
	examen_Final_Fecha DATETIME2(6),
	examen_Final_Hora VARCHAR(255),
	examen_Final_Descripcion VARCHAR(255),
	--falta curso
);
GO

CREATE TABLE LOS_QUERYOSOS.Evaluacion_Final(
	evaluacion_Final_Nota BIGINT,
	evaluacion_Final_Presente BIT
	--falta profesor,alumno
);
GO

CREATE TABLE LOS_QUERYOSOS.Detalle_Factura( ---- en el DER esta como DetalleFact
	detalle_Factura_Importe DECIMAL(18,2)
	--falta curso, periodo, factura
);
GO

CREATE TABLE LOS_QUERYOSOS.Periodo(
	periodo_Anio BIGINT,
	periodo_Mes BIGINT
);

GO

CREATE TABLE LOS_QUERYOSOS.Pago(
	pago_Fecha DATETIME2(6),
	pago_Importe DECIMAL(18,2),
	pago_MedioPago BIGINT(8) --en DER esta como Medio_De_Pago
	--falta factura
);
GO


