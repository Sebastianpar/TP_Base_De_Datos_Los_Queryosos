/*
SELECT * 
FROM gd_esquema.Maestra
*/

USE GD2C2025
GO

CREATE SCHEMA LOS_QUERYOSOS;
GO

-- Creacion de tablas

CREATE TABLE LOS_QUERYOSOS.Institucion(
	Institucion_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	Institucion_Nombre NVARCHAR(510),
	Institucion_RazonSocial NVARCHAR(510),
	Institucion_Cuit NVARCHAR(510)
);
GO

CREATE TABLE LOS_QUERYOSOS.Sede(
	sede_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	sede_Nombre NVARCHAR(510),
	sede_Direccion BIGINT,  --fk a direccion
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
	curso_Categoria BIGINT, --FK a Categoria
	curso_Turno BIGINT, -- FK a Turno
	curso_Profesor BIGINT,--FK a Profesor
	curso_Sede BIGINT,--FK a Sede
	--falta curso_Dia en la tabla curso? 
	--pero esta la tabla diaCurso que ya lo relaciona
);
GO

CREATE TABLE LOS_QUERYOSOS.Profesor(
	profesor_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	profesor_Dni NVARCHAR(510),
	profesor_Nombre NVARCHAR(510),
	profesor_Apellido NVARCHAR(510),
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
	inscripcion_Estado BIGINT, --FK a estado
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

CREATE TABLE LOS_QUERYOSOS.Evaluacion_Alumno(
	evaluacion_Alumno_Codigo BIGINT, --IDENTITY(1,1) PRIMARY KEY,
	evaluacion_Alumno_Alumno BIGINT,
	evaluacion_Alumno_Instancia BIGINT,
	evaluacion_Alumno_Nota BIGINT,
	evaluacion_Alumno_Presente BIT,
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

CREATE TABLE LOS_QUERYOSOS.Pregunta (
    pregunta_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
    pregunta_Detalle VARCHAR(255),
    pregunta_Encuesta BIGINT -- FK a Encuesta
);
GO

CREATE TABLE LOS_QUERYOSOS.Respuesta (
    respuesta_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
    respuesta_Detalle VARCHAR(255),
    respuesta_Pregunta BIGINT -- FK a Pregunta
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
	--factura_total no esta en el DER pero si en la tabla maestra o es detalleFact_importe?  : Como era algo calculable no se ponia
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
	pago_Medio_De_Pago BIGINT,--FK a Medio_De_Pago
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
	provincia_Nombre VARCHAR(510)
);
GO

CREATE TABLE LOS_QUERYOSOS.Localidad(
	localidad_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	localidad_Nombre VARCHAR(510),
	localidad_Provincia BIGINT -- fk a provincia
);
GO

CREATE TABLE LOS_QUERYOSOS.Direccion(
	direccion_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	direccion_Calle VARCHAR(510),
	direccion_Numero BIGINT,
	direccion_Localidad BIGINT -- fk a Localidad
);
GO

CREATE TABLE LOS_QUERYOSOS.Contacto(
	contacto_ID BIGINT IDENTITY(1,1) PRIMARY KEY,
	contacto_Mail VARCHAR(255),
	contacto_Telefono VARCHAR(255)
);
GO

CREATE TABLE LOS_QUERYOSOS.Dia(
	dia_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	dia_Detalle VARCHAR(255)
);
GO

CREATE TABLE LOS_QUERYOSOS.Dia_Curso(
	dia_Curso_Dia BIGINT,--FK a dia
	dia_Curso_Curso BIGINT--FK a curso
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

-- Curso -> Profesor
ALTER TABLE LOS_QUERYOSOS.Curso
ADD CONSTRAINT FK_Curso_Profesor
FOREIGN KEY (Curso_Profesor) REFERENCES LOS_QUERYOSOS.Profesor(Profesor_Codigo);

-- Dia_Curso -> Curso
ALTER TABLE LOS_QUERYOSOS.Dia_Curso
ADD CONSTRAINT FK_Dia_Curso_Curso
FOREIGN KEY (Dia_Curso_Curso) REFERENCES LOS_QUERYOSOS.Curso(Curso_Codigo);

-- Dia_Curso -> Dia
ALTER TABLE LOS_QUERYOSOS.Dia_Curso
ADD CONSTRAINT FK_Dia_Curso_Dia
FOREIGN KEY (Dia_Curso_Dia) REFERENCES LOS_QUERYOSOS.Dia(Dia_Codigo);

-- Profesor -> Dirección
ALTER TABLE LOS_QUERYOSOS.Profesor
ADD CONSTRAINT FK_Profesor_Direccion
FOREIGN KEY (Profesor_Direccion) REFERENCES LOS_QUERYOSOS.Direccion(Direccion_Codigo);

-- Profesor -> Contacto
ALTER TABLE LOS_QUERYOSOS.Profesor
ADD CONSTRAINT FK_Profesor_Contacto
FOREIGN KEY (Profesor_Contacto) REFERENCES LOS_QUERYOSOS.Contacto(Contacto_ID);

-- Alumno -> Dirección
ALTER TABLE LOS_QUERYOSOS.Alumno
ADD CONSTRAINT FK_Alumno_Direccion
FOREIGN KEY (Alumno_Direccion) REFERENCES LOS_QUERYOSOS.Direccion(Direccion_Codigo);

-- Alumno -> Contacto
ALTER TABLE LOS_QUERYOSOS.Alumno
ADD CONSTRAINT FK_Alumno_Contacto
FOREIGN KEY (Alumno_Contacto) REFERENCES LOS_QUERYOSOS.Contacto(Contacto_ID);

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
FOREIGN KEY (Evaluacion_Curso_Modulo) REFERENCES LOS_QUERYOSOS.Modulo(Modulo_Numero);

-- Evaluacion_Alumno -> Evaluacion_Curso
ALTER TABLE LOS_QUERYOSOS.Evaluacion_Alumno
ADD CONSTRAINT FK_Evaluacion_Alumno_Codigo
FOREIGN KEY (Evaluacion_Alumno_Codigo) REFERENCES LOS_QUERYOSOS.Evaluacion_Curso(Evaluacion_Curso_Codigo);

-- Evaluacion_Alumno -> Alumno
ALTER TABLE LOS_QUERYOSOS.Evaluacion_Alumno
ADD CONSTRAINT FK_Evaluacion_Alumno_Alumno
FOREIGN KEY (Evaluacion_Alumno_Alumno) REFERENCES LOS_QUERYOSOS.Alumno(Alumno_Codigo);

/*Creo que este no va
-- Evaluacion_Alumno -> Alumno
ALTER TABLE LOS_QUERYOSOS.Evaluacion_Alumno
ADD CONSTRAINT FK_Evaluacion_Alumno_Curso
FOREIGN KEY (Evaluacion_Alumno_Curso) REFERENCES LOS_QUERYOSOS.Curso(Curso_Codigo);
*/
-- Examen_Final -> Curso
ALTER TABLE LOS_QUERYOSOS.Examen_Final
ADD CONSTRAINT FK_Examen_Final_Curso
FOREIGN KEY (Examen_Final_Curso) REFERENCES LOS_QUERYOSOS.Curso(Curso_Codigo);

-- Evaluacion_Final -> Profesor
ALTER TABLE LOS_QUERYOSOS.Evaluacion_Final
ADD CONSTRAINT FK_Evaluacion_Final_Profesor
FOREIGN KEY (Evaluacion_Final_Profesor) REFERENCES LOS_QUERYOSOS.Profesor(Profesor_Codigo);

-- Evaluacion_Final -> Alumno
ALTER TABLE LOS_QUERYOSOS.Evaluacion_Final
ADD CONSTRAINT FK_Evaluacion_Final_Alumno
FOREIGN KEY (Evaluacion_Final_Alumno) REFERENCES LOS_QUERYOSOS.Alumno(Alumno_Codigo);

-- Encuesta -> Curso
ALTER TABLE LOS_QUERYOSOS.Encuesta
ADD CONSTRAINT FK_Encuesta_Curso
FOREIGN KEY (Encuesta_Curso) REFERENCES LOS_QUERYOSOS.Curso(Curso_Codigo);

-- Pregunta -> Encuesta
ALTER TABLE LOS_QUERYOSOS.Pregunta
ADD CONSTRAINT FK_Pregunta_Encuesta
FOREIGN KEY (Pregunta_Encuesta) REFERENCES LOS_QUERYOSOS.Encuesta(Encuesta_Codigo);

-- Respuesta -> Pregunta
ALTER TABLE LOS_QUERYOSOS.Respuesta
ADD CONSTRAINT FK_Respuesta_Pregunta
FOREIGN KEY (Respuesta_Pregunta) REFERENCES LOS_QUERYOSOS.Pregunta(Pregunta_Codigo);

-- Factura -> Periodo
ALTER TABLE LOS_QUERYOSOS.Detalle_Factura
ADD CONSTRAINT FK_Detalle_Factura_Periodo
FOREIGN KEY (Detalle_Factura_Periodo) REFERENCES LOS_QUERYOSOS.Periodo(Periodo_Numero);

-- Detalle_Factura -> Factura
ALTER TABLE LOS_QUERYOSOS.Detalle_Factura
ADD CONSTRAINT FK_Detalle_Factura_Factura
FOREIGN KEY (Detalle_Factura_Factura) REFERENCES LOS_QUERYOSOS.Factura(Factura_Numero);

-- Pago -> Factura
ALTER TABLE LOS_QUERYOSOS.Pago
ADD CONSTRAINT FK_Pago_Factura
FOREIGN KEY (Pago_Factura) REFERENCES LOS_QUERYOSOS.Factura(Factura_Numero);

-- Pago -> Medio_De_Pago
ALTER TABLE LOS_QUERYOSOS.Pago
ADD CONSTRAINT FK_Pago_Medio_De_Pago
FOREIGN KEY (Pago_Medio_De_Pago) REFERENCES LOS_QUERYOSOS.Medio_De_Pago(medio_De_Pago_ID);

-- Modulo -> Curso
ALTER TABLE LOS_QUERYOSOS.Modulo
ADD CONSTRAINT FK_Modulo_Curso
FOREIGN KEY (Modulo_Curso) REFERENCES LOS_QUERYOSOS.Curso(Curso_Codigo);

-- Trabajo_Practico -> Curso
ALTER TABLE LOS_QUERYOSOS.Trabajo_Practico
ADD CONSTRAINT FK_Trabajo_Practico_Curso
FOREIGN KEY (Trabajo_Practico_Curso) REFERENCES LOS_QUERYOSOS.Curso(Curso_Codigo);

-- Trabajo_Practico -> Alumno
ALTER TABLE LOS_QUERYOSOS.Trabajo_Practico
ADD CONSTRAINT FK_Trabajo_Practico_Alumno
FOREIGN KEY (Trabajo_Practico_Alumno) REFERENCES LOS_QUERYOSOS.Alumno(Alumno_Codigo);


--Inserts de datos a nuestro modelo

--Datos de Institucion
INSERT INTO LOS_QUERYOSOS.Institucion (Institucion_Nombre, Institucion_RazonSocial, Institucion_Cuit)
SELECT DISTINCT
    Institucion_Nombre,
    Institucion_RazonSocial,
    Institucion_Cuit
FROM gd_esquema.Maestra
WHERE Institucion_Cuit IS NOT NULL;

--Datos de provincias
INSERT INTO LOS_QUERYOSOS.Provincia (Provincia_Nombre)
SELECT DISTINCT sede_provincia
FROM gd_esquema.Maestra
WHERE sede_provincia IS NOT NULL
UNION
SELECT DISTINCT profesor_provincia
FROM gd_esquema.Maestra
WHERE profesor_provincia IS NOT NULL
UNION
SELECT DISTINCT alumno_provincia
FROM gd_esquema.Maestra
WHERE alumno_provincia IS NOT NULL;

--datos de localidades
INSERT INTO LOS_QUERYOSOS.Localidad (Localidad_Nombre, Localidad_Provincia)
SELECT DISTINCT m.Sede_Localidad, p.provincia_Codigo
FROM gd_esquema.Maestra m
	JOIN LOS_QUERYOSOS.Provincia p ON p.Provincia_Nombre = m.Sede_Provincia
WHERE m.Sede_Localidad IS NOT NULL
UNION
SELECT DISTINCT m.Profesor_Localidad, p.provincia_Codigo
FROM gd_esquema.Maestra m
	JOIN LOS_QUERYOSOS.Provincia p ON p.Provincia_Nombre = m.Profesor_Provincia
WHERE m.Profesor_Localidad IS NOT NULL
UNION
SELECT DISTINCT m.Alumno_Localidad, p.provincia_Codigo
FROM gd_esquema.Maestra m
	JOIN LOS_QUERYOSOS.Provincia p ON p.Provincia_Nombre = m.Alumno_Provincia
WHERE m.Alumno_Localidad IS NOT NULL;

--Datos de direcciones
INSERT INTO LOS_QUERYOSOS.Direccion (Direccion_Calle, Direccion_Numero, Direccion_Localidad)
SELECT DISTINCT
    LEFT(m.Sede_Direccion, CHARINDEX('N°', m.Sede_Direccion) - 2) AS Direccion_Calle,
    RIGHT(m.Sede_Direccion, LEN(m.Sede_Direccion) - CHARINDEX('N°', m.Sede_Direccion) - 1) AS Direccion_Numero,
    l.localidad_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Localidad l ON l.Localidad_Nombre = m.Sede_Localidad
WHERE m.Sede_Direccion IS NOT NULL

UNION

SELECT DISTINCT
    LEFT(m.Profesor_Direccion, CHARINDEX('N°', m.Profesor_Direccion) - 2),
    RIGHT(m.Profesor_Direccion, LEN(m.Profesor_Direccion) - CHARINDEX('N°', m.Profesor_Direccion) - 1),
    l.localidad_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Localidad l ON l.Localidad_Nombre = m.Profesor_Localidad
WHERE m.Profesor_Direccion IS NOT NULL

UNION

SELECT DISTINCT
    LEFT(m.Alumno_Direccion, CHARINDEX('N°', m.Alumno_Direccion) - 2),
    RIGHT(m.Alumno_Direccion, LEN(m.Alumno_Direccion) - CHARINDEX('N°', m.Alumno_Direccion) - 1),
    l.localidad_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Localidad l ON l.Localidad_Nombre = m.Alumno_Localidad
WHERE m.Alumno_Direccion IS NOT NULL;

--Datos de Contactos
INSERT INTO LOS_QUERYOSOS.Contacto (Contacto_Mail, Contacto_Telefono)
SELECT DISTINCT m.Sede_Mail, m.Sede_Telefono
FROM gd_esquema.Maestra m
WHERE m.Sede_Mail IS NOT NULL OR m.Sede_Telefono IS NOT NULL

UNION

SELECT DISTINCT m.Profesor_Mail, m.Profesor_Telefono
FROM gd_esquema.Maestra m
WHERE m.Profesor_Mail IS NOT NULL OR m.Profesor_Telefono IS NOT NULL

UNION

SELECT DISTINCT m.Alumno_Mail, m.Alumno_Telefono
FROM gd_esquema.Maestra m
WHERE m.Alumno_Mail IS NOT NULL OR m.Alumno_Telefono IS NOT NULL;

--Datos Sede
INSERT INTO LOS_QUERYOSOS.Sede (Sede_Nombre, Sede_Institucion, Sede_Direccion, Sede_Contacto)
SELECT DISTINCT
    m.Sede_Nombre,
    i.Institucion_Codigo,
    d.direccion_Codigo,
    c.Contacto_ID
FROM gd_esquema.Maestra m
	JOIN LOS_QUERYOSOS.Institucion i ON i.Institucion_Cuit = m.Institucion_Cuit
	JOIN LOS_QUERYOSOS.Direccion d ON 
		d.Direccion_Calle = LEFT(m.Sede_Direccion, CHARINDEX('N°', m.Sede_Direccion) - 2) AND
		d.Direccion_Numero = RIGHT(m.Sede_Direccion, LEN(m.Sede_Direccion) - CHARINDEX('N°', m.Sede_Direccion) - 1)
	JOIN LOS_QUERYOSOS.Contacto c ON 
		c.Contacto_Mail = m.Sede_Mail AND
		c.Contacto_Telefono = m.Sede_Telefono
WHERE m.Sede_Nombre IS NOT NULL;

-- CategoriaCurso
INSERT INTO LOS_QUERYOSOS.Categoria (categoria_Detalle)
SELECT DISTINCT Curso_Categoria
FROM gd_esquema.Maestra
WHERE Curso_Categoria IS NOT NULL;

-- Turno
INSERT INTO LOS_QUERYOSOS.Turno (turno_Detalle)
SELECT DISTINCT Curso_Turno
FROM gd_esquema.Maestra
WHERE Curso_Turno IS NOT NULL;

--Profesor
INSERT INTO LOS_QUERYOSOS.Profesor (
    Profesor_Dni,
    Profesor_Nombre,
    Profesor_Apellido,
    Profesor_FechaNacimiento,
    Profesor_Direccion,
    Profesor_Contacto
)
SELECT DISTINCT
    m.Profesor_Dni,
    m.Profesor_Nombre,
    m.Profesor_Apellido,
    m.Profesor_FechaNacimiento,
    d.direccion_Codigo,
    c.contacto_ID
FROM gd_esquema.Maestra m
	JOIN LOS_QUERYOSOS.Direccion d ON 
		d.Direccion_Calle = LEFT(m.Profesor_Direccion, CHARINDEX('N°', m.Profesor_Direccion) - 2) AND
		d.Direccion_Numero = RIGHT(m.Profesor_Direccion, LEN(m.Profesor_Direccion) - CHARINDEX('N°', m.Profesor_Direccion) - 1)
	JOIN LOS_QUERYOSOS.Contacto c ON 
		c.Contacto_Mail = m.Profesor_Mail AND
		c.Contacto_Telefono = m.Profesor_Telefono
WHERE m.Profesor_Dni IS NOT NULL;

--Curso
INSERT INTO LOS_QUERYOSOS.Curso (
    Curso_Nombre,
    Curso_Descripcion,
    Curso_FechaInicio,
    Curso_FechaFin,
    Curso_DuracionMeses,
    Curso_PrecioMensual,
    Curso_Categoria,
    Curso_Turno,
    Curso_Profesor,
    Curso_Sede
)
SELECT DISTINCT
    m.Curso_Nombre,
    m.Curso_Descripcion,
    m.Curso_FechaInicio,
    m.Curso_FechaFin,
    m.Curso_DuracionMeses,
    m.Curso_PrecioMensual,
    cat.categoria_Codigo,
    t.turno_Codigo,
    p.profesor_Codigo,
    s.sede_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Categoria cat ON cat.categoria_Detalle = m.Curso_Categoria
JOIN LOS_QUERYOSOS.Turno t ON t.turno_Detalle = m.Curso_Turno
JOIN LOS_QUERYOSOS.Profesor p ON p.Profesor_Dni = m.Profesor_Dni
JOIN LOS_QUERYOSOS.Sede s ON s.Sede_Nombre = m.Sede_Nombre
WHERE m.Curso_Nombre IS NOT NULL;

--Dia
INSERT INTO LOS_QUERYOSOS.Dia (dia_Detalle)
SELECT DISTINCT m.Curso_Dia
FROM gd_esquema.Maestra m
WHERE m.Curso_Dia IS NOT NULL;

--Dia Curso
INSERT INTO LOS_QUERYOSOS.Dia_Curso (
    dia_Curso_Dia,
    dia_Curso_Curso
)
SELECT DISTINCT
    d.dia_Codigo,
    c.Curso_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Dia d ON d.dia_Detalle = m.Curso_Dia
JOIN LOS_QUERYOSOS.Curso c ON c.Curso_Nombre = m.Curso_Nombre
WHERE m.Curso_Dia IS NOT NULL;

--Modulo
INSERT INTO LOS_QUERYOSOS.Modulo (
    Modulo_Nombre,
    Modulo_Descripcion,
    Modulo_Curso
)
SELECT DISTINCT
    m.Modulo_Nombre,
    m.Modulo_Descripcion,
    c.Curso_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Curso c ON c.Curso_Nombre = m.Curso_Nombre
WHERE m.Modulo_Nombre IS NOT NULL;

--Evaluacion_Curso
INSERT INTO LOS_QUERYOSOS.Evaluacion_Curso (
    Evaluacion_Curso_FechaEvaluacion,
    Evaluacion_Curso_Modulo
)
SELECT DISTINCT
    m.Evaluacion_Curso_fechaEvaluacion,
    mo.modulo_Numero
FROM gd_esquema.Maestra m
	JOIN LOS_QUERYOSOS.Modulo mo ON mo.Modulo_Nombre = m.Modulo_Nombre
WHERE m.Evaluacion_Curso_fechaEvaluacion IS NOT NULL;

--Alumno
INSERT INTO LOS_QUERYOSOS.Alumno (
    Alumno_Legajo,
    Alumno_Dni,
    Alumno_Nombre,
    Alumno_Apellido,
    Alumno_FechaNacimiento,
    Alumno_Contacto,
    Alumno_Direccion
)
SELECT DISTINCT
    m.Alumno_Legajo,
    m.Alumno_Dni,
    m.Alumno_Nombre,
    m.Alumno_Apellido,
    m.Alumno_FechaNacimiento,
    c.contacto_ID,
    d.direccion_Codigo
FROM gd_esquema.Maestra m
	JOIN LOS_QUERYOSOS.Contacto c ON 
		c.Contacto_Mail = m.Alumno_Mail AND
		c.Contacto_Telefono = m.Alumno_Telefono
	JOIN LOS_QUERYOSOS.Direccion d ON 
		d.Direccion_Calle = LEFT(m.Alumno_Direccion, CHARINDEX('N°', m.Alumno_Direccion) - 2) AND
		d.Direccion_Numero = RIGHT(m.Alumno_Direccion, LEN(m.Alumno_Direccion) - CHARINDEX('N°', m.Alumno_Direccion) - 1)
WHERE m.Alumno_Dni IS NOT NULL;

--Encuesta
INSERT INTO LOS_QUERYOSOS.Encuesta (
    encuesta_FechaRegistro,
    encuesta_Observacion,
    encuesta_Curso
)
SELECT DISTINCT
    m.Encuesta_FechaRegistro,
    m.Encuesta_Observacion,
    c.Curso_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Curso c ON c.Curso_Nombre = m.Curso_Nombre
WHERE m.Encuesta_FechaRegistro IS NOT NULL;

--Pregunta
INSERT INTO LOS_QUERYOSOS.Pregunta (
    pregunta_Detalle,
    pregunta_Encuesta
)
SELECT DISTINCT
    m.Encuesta_Pregunta1,
    e.encuesta_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Encuesta e ON 
    e.encuesta_FechaRegistro = m.Encuesta_FechaRegistro AND
    e.encuesta_Observacion = m.Encuesta_Observacion
WHERE m.Encuesta_Pregunta1 IS NOT NULL

UNION ALL

SELECT DISTINCT
    m.Encuesta_Pregunta2,
    e.encuesta_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Encuesta e ON 
    e.encuesta_FechaRegistro = m.Encuesta_FechaRegistro AND
    e.encuesta_Observacion = m.Encuesta_Observacion
WHERE m.Encuesta_Pregunta2 IS NOT NULL

UNION ALL

SELECT DISTINCT
    m.Encuesta_Pregunta3,
    e.encuesta_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Encuesta e ON 
    e.encuesta_FechaRegistro = m.Encuesta_FechaRegistro AND
    e.encuesta_Observacion = m.Encuesta_Observacion
WHERE m.Encuesta_Pregunta3 IS NOT NULL

UNION ALL

SELECT DISTINCT
    m.Encuesta_Pregunta4,
    e.encuesta_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Encuesta e ON 
    e.encuesta_FechaRegistro = m.Encuesta_FechaRegistro AND
    e.encuesta_Observacion = m.Encuesta_Observacion
WHERE m.Encuesta_Pregunta4 IS NOT NULL;

--Respuesta
INSERT INTO LOS_QUERYOSOS.Respuesta (
    respuesta_Detalle,
    respuesta_Pregunta
)
SELECT DISTINCT
    m.Encuesta_Nota1,
    p1.pregunta_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Pregunta p1 ON p1.pregunta_Detalle = m.Encuesta_Pregunta1

UNION ALL

SELECT DISTINCT
    m.Encuesta_Nota2,
    p2.pregunta_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Pregunta p2 ON p2.pregunta_Detalle = m.Encuesta_Pregunta2

UNION ALL

SELECT DISTINCT
    m.Encuesta_Nota3,
    p3.pregunta_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Pregunta p3 ON p3.pregunta_Detalle = m.Encuesta_Pregunta3

UNION ALL

SELECT DISTINCT
    m.Encuesta_Nota4,
    p4.pregunta_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Pregunta p4 ON p4.pregunta_Detalle = m.Encuesta_Pregunta4;

--Estado
INSERT INTO LOS_QUERYOSOS.Estado (estado_Detalle)
SELECT DISTINCT m.Inscripcion_Estado
FROM gd_esquema.Maestra m
WHERE m.Inscripcion_Estado IS NOT NULL;

--Inscripcion
INSERT INTO LOS_QUERYOSOS.Inscripcion (
    inscripcion_Fecha,
    inscripcion_Estado,
    inscripcion_FechaRespuesta,
    inscripcion_Alumno,
    inscripcion_Curso
)
SELECT DISTINCT
    m.Inscripcion_Fecha,
    e.estado_Codigo,
    m.Inscripcion_Fecha,
    a.alumno_Codigo,
    c.Curso_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Estado e ON e.estado_Detalle = m.Inscripcion_Estado
JOIN LOS_QUERYOSOS.Alumno a ON a.Alumno_Dni = m.Alumno_Dni
JOIN LOS_QUERYOSOS.Curso c ON c.Curso_Nombre = m.Curso_Nombre
WHERE m.Inscripcion_Fecha IS NOT NULL;

--ExamenFinal
INSERT INTO LOS_QUERYOSOS.Examen_Final (
    examen_Final_Fecha,
    examen_Final_Hora,
    examen_Final_Descripcion,
    examen_Final_Curso
)
SELECT DISTINCT
    m.Examen_Final_Fecha,
    m.Examen_Final_Hora,
    m.Examen_Final_Descripcion,
    c.Curso_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Curso c ON c.Curso_Nombre = m.Curso_Nombre
WHERE m.Examen_Final_Fecha IS NOT NULL;

--InscripcionFinal
INSERT INTO LOS_QUERYOSOS.Inscripcion_Final (
    inscripcion_Final_Fecha,
    inscripcion_Final_AlumnoCod,
    inscripcion_Final_AlumnoLeg,
    inscripcion_Final_ExamenFinal
)
SELECT DISTINCT
    m.Inscripcion_Final_Fecha,
    a.alumno_Codigo,
    m.Alumno_Legajo,
    ef.examen_Final_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Alumno a ON a.Alumno_Dni = m.Alumno_Dni
JOIN LOS_QUERYOSOS.Examen_Final ef ON 
    ef.examen_Final_Fecha = m.Examen_Final_Fecha AND
    ef.examen_Final_Descripcion = m.Examen_Final_Descripcion
WHERE m.Inscripcion_Final_Fecha IS NOT NULL;

--EvaluacionFinal
INSERT INTO LOS_QUERYOSOS.Evaluacion_Final (
    evaluacion_Final_Nota,
    evaluacion_Final_Presente,
    evaluacion_Final_Profesor,
    evaluacion_Final_Alumno
)
SELECT DISTINCT
    m.Evaluacion_Final_Nota,
    m.Evaluacion_Final_Presente,
    p.Profesor_Codigo,
    a.alumno_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Profesor p ON p.Profesor_Dni = m.Profesor_Dni
JOIN LOS_QUERYOSOS.Alumno a ON a.Alumno_Dni = m.Alumno_Dni
WHERE m.Evaluacion_Final_Nota IS NOT NULL;

--TrabajoPractico
INSERT INTO LOS_QUERYOSOS.Trabajo_Practico (
    trabajo_Practico_Nota,
    trabajo_Practico_FechaEvaluacion,
    trabajo_Practico_Curso,
    trabajo_Practico_Alumno
)
SELECT DISTINCT
    m.Trabajo_Practico_Nota,
    m.Trabajo_Practico_FechaEvaluacion,
    c.Curso_Codigo,
    a.alumno_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Curso c ON c.Curso_Nombre = m.Curso_Nombre
JOIN LOS_QUERYOSOS.Alumno a ON a.Alumno_Dni = m.Alumno_Dni
WHERE m.Trabajo_Practico_Nota IS NOT NULL;

--Evaluacion_Alumno
INSERT INTO LOS_QUERYOSOS.Evaluacion_Alumno (
    Evaluacion_Alumno_Codigo,
    Evaluacion_Alumno_Alumno,
    Evaluacion_Alumno_Nota,
    Evaluacion_Alumno_Instancia,
    Evaluacion_Alumno_Presente
)
SELECT DISTINCT
    ec.evaluacion_Curso_Codigo,
    a.alumno_Codigo,
    m.Evaluacion_Curso_Nota,
    m.Evaluacion_Curso_Instancia,
    m.Evaluacion_Curso_Presente
FROM gd_esquema.Maestra m
JOIN LOS_QUERYOSOS.Alumno a ON a.Alumno_Dni = m.Alumno_Dni
JOIN LOS_QUERYOSOS.Modulo mo ON mo.Modulo_Nombre = m.Modulo_Nombre
JOIN LOS_QUERYOSOS.Evaluacion_Curso ec ON 
    ec.Evaluacion_Curso_Modulo = mo.modulo_Numero AND
    ec.Evaluacion_Curso_FechaEvaluacion = m.Evaluacion_Curso_fechaEvaluacion
WHERE m.Evaluacion_Curso_Nota IS NOT NULL;








-- Eliminar todas las Foreign Keys del esquema
DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += N'ALTER TABLE [' + s.name + '].[' + t.name + '] DROP CONSTRAINT [' + fk.name + '];'
FROM sys.foreign_keys fk
JOIN sys.tables t ON fk.parent_object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = 'LOS_QUERYOSOS';

EXEC sp_executesql @sql;

-- Eliminar todas las tablas del esquema
SET @sql = N'';

SELECT @sql += N'DROP TABLE [' + s.name + '].[' + t.name + '];'
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = 'LOS_QUERYOSOS';

EXEC sp_executesql @sql;

-- Finalmente eliminar el esquema
DROP SCHEMA IF EXISTS LOS_QUERYOSOS;