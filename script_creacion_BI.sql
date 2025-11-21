USE GD2C2025
GO


/*---------------TABLAS DIMENSIONES---------------------------*/

CREATE TABLE LOS_QUERYOSOS.BI_Tiempo (
	tiempo_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY, ---CUANDO SE MIGRE EL CAMPMO, HAY QUE HACER CONVERSION A BIGINT
	tiempo_Anio BIGINT,
	tiempo_Mes BIGINT,
	tiempo_Cuatrimestre BIGINT,
	tiempo_Semestre BIGINT
);
GO

CREATE TABLE LOS_QUERYOSOS.BI_Estado (
	estado_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	estado_Detalle VARCHAR(255)
);
GO

CREATE TABLE LOS_QUERYOSOS.BI_Medio_De_Pago (
	medio_De_Pago_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	medio_De_Pago_Detalle VARCHAR(255)
);
GO

CREATE TABLE LOS_QUERYOSOS.BI_Alumno (
    alumno_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
    alumno_Dni BIGINT,
    alumno_Legajo BIGINT,
    alumno_Nombre VARCHAR(255),
    alumno_Apellido VARCHAR(255),
    alumno_FechaNacimiento DATETIME2(6),
    alumno_Localidad NVARCHAR(255),
    alumno_Provincia NVARCHAR(255),
    alumno_Rango_Etario CHAR(8)
);
GO

CREATE TABLE LOS_QUERYOSOS.BI_Sede (
    sede_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
    sede_Nombre NVARCHAR(255),
    sede_Direccion NVARCHAR(255),
    sede_Localidad NVARCHAR(255),
    sede_Provincia NVARCHAR(255),
    sede_Institucion NVARCHAR(255)
);
GO

CREATE TABLE LOS_QUERYOSOS.BI_Curso (
	curso_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	curso_Nombre VARCHAR(255),
	curso_Descripcion VARCHAR(255),
	curso_FechaInicio DATETIME2(6),
	curso_FechaFin DATETIME2(6),
	curso_DuracionMeses BIGINT,
	curso_PrecioMensual DECIMAL(18,2),
	curso_Categoria BIGINT, --no esta como dimensiones porque podemos sacarlas directamente de curso
	curso_Turno BIGINT, 
	curso_Profesor BIGINT,
	curso_Sede BIGINT
);
GO

CREATE TABLE LOS_QUERYOSOS.BI_Profesor (
	profesor_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	profesor_Nombre NVARCHAR(510),
	profesor_Apellido NVARCHAR(510),
	profesor_FechaNacimiento DATETIME2(6),
	profesor_Rango_Etario CHAR(8)
);
GO

CREATE TABLE LOS_QUERYOSOS.BI_Bloque_Satisfaccion ( --no estoy segura como hacer esta parte para la vista 10
	bloque_Satisfaccion_Codigo BIGINT IDENTITY(1,1) PRIMARY KEY,
	bloque_Satisfaccion_Detalle VARCHAR(255),
	bloque_Satisfaccion_Nota_Min BIGINT,
	bloque_Satisfaccion_Nota_Max BIGINT
);
GO
/*---------------TABLAS HECHOS---------------------------*/

/**************************  EVALUACION FINALES  *********************************/

CREATE TABLE LOS_QUERYOSOS.BI_Evaluacion_Finales (
	evaluacion_Finales_Key BIGINT IDENTITY PRIMARY KEY,
	evaluacion_Finales_Tiempo_Fecha BIGINT,
	evaluacion_Finales_Alumno BIGINT,
	evaluacion_Finales_Curso BIGINT,
	evaluacion_Finales_Sede BIGINT,
	evaluacion_Finales_Aprobado BIT,
	evaluacion_Finales_Nota_Final BIGINT,
	evaluacion_Finales_Presente BIT
	--PRIMARY KEY (evaluacion_Finales_Tiempo_Fecha,evaluacion_Finales_Alumno,evaluacion_Finales_Curso,evaluacion_Finales_Sede)
);
GO

ALTER TABLE LOS_QUERYOSOS.BI_Evaluacion_Finales
ADD CONSTRAINT FK_Evaluacion_Finales_Tiempo FOREIGN KEY (evaluacion_Finales_Tiempo_Fecha)
REFERENCES LOS_QUERYOSOS.BI_Tiempo (tiempo_Codigo);

ALTER TABLE LOS_QUERYOSOS.BI_Evaluacion_Finales
ADD CONSTRAINT FK_Evaluacion_Finales_Alumno FOREIGN KEY (evaluacion_Finales_Alumno)
REFERENCES LOS_QUERYOSOS.BI_Alumno (alumno_Codigo);

ALTER TABLE LOS_QUERYOSOS.BI_Evaluacion_Finales
ADD CONSTRAINT FK_Evaluacion_Finales_Curso FOREIGN KEY (evaluacion_Finales_Curso)
REFERENCES LOS_QUERYOSOS.BI_Curso (curso_Codigo);

ALTER TABLE LOS_QUERYOSOS.BI_Evaluacion_Finales
ADD CONSTRAINT FK_Evaluacion_Finales_Sede FOREIGN KEY (evaluacion_Finales_Sede)
REFERENCES LOS_QUERYOSOS.BI_Sede (sede_Codigo);


/**************************  INSCRIPCION CURSOS  *********************************/

CREATE TABLE LOS_QUERYOSOS.BI_Inscripcion(
	inscripcion_Tiempo BIGINT,
	inscripcion_Estado BIGINT,
	inscripcion_Fecha_Respuesta DATETIME2(6),
	inscripcion_Alumno BIGINT,
	inscripcion_Curso BIGINT,
	inscripcion_Sede BIGINT,
	PRIMARY KEY(inscripcion_Tiempo,inscripcion_Estado,inscripcion_Alumno,inscripcion_Curso,inscripcion_Sede)
);
GO

ALTER TABLE LOS_QUERYOSOS.BI_Inscripcion
ADD CONSTRAINT FK_Inscripcion_Tiempo FOREIGN KEY (inscripcion_Tiempo)
REFERENCES LOS_QUERYOSOS.BI_Tiempo (tiempo_Codigo);

ALTER TABLE LOS_QUERYOSOS.BI_Inscripcion
ADD CONSTRAINT FK_Inscripcion_Alumno FOREIGN KEY (inscripcion_Alumno)
REFERENCES LOS_QUERYOSOS.BI_Alumno (alumno_Codigo);

ALTER TABLE LOS_QUERYOSOS.BI_Inscripcion
ADD CONSTRAINT FK_Inscripcion_Curso FOREIGN KEY (inscripcion_Curso)
REFERENCES LOS_QUERYOSOS.BI_Curso (curso_Codigo);

ALTER TABLE LOS_QUERYOSOS.BI_Inscripcion
ADD CONSTRAINT FK_Inscripcion_Sede FOREIGN KEY (inscripcion_Sede)
REFERENCES LOS_QUERYOSOS.BI_Sede (sede_Codigo);

ALTER TABLE LOS_QUERYOSOS.BI_Inscripcion
ADD CONSTRAINT FK_Inscripcion_Estado FOREIGN KEY (inscripcion_Estado)
REFERENCES LOS_QUERYOSOS.BI_Estado (estado_Codigo);

/**************************  EVALUACION ALUMNO  *********************************/

CREATE TABLE LOS_QUERYOSOS.BI_Evaluacion_Alumno (
	evaluacion_Alumno_Tiempo BIGINT,
	evaluacion_Alumno_Alumno BIGINT,
	evaluacion_Alumno_Curso BIGINT,
	evaluacion_Alumno_Sede BIGINT,
	evaluacion_Alumno_Aprobado BIT,
	evaluacion_Alumno_Nota_Modulo BIGINT,
	evaluacion_Alumno_Nota_TP BIGINT,
	PRIMARY KEY(evaluacion_Alumno_Tiempo,evaluacion_Alumno_Alumno,evaluacion_Alumno_Curso,evaluacion_Alumno_Sede)
);
GO

ALTER TABLE LOS_QUERYOSOS.BI_Evaluacion_Alumno
ADD CONSTRAINT FK_Evaluacion_Alumno_Tiempo FOREIGN KEY (evaluacion_Alumno_Tiempo)
REFERENCES LOS_QUERYOSOS.BI_Tiempo (tiempo_Codigo);

ALTER TABLE LOS_QUERYOSOS.BI_Evaluacion_Alumno
ADD CONSTRAINT FK_Evaluacion_Alumno_Alumno FOREIGN KEY (evaluacion_Alumno_Alumno)
REFERENCES LOS_QUERYOSOS.BI_Alumno (alumno_Codigo);

ALTER TABLE LOS_QUERYOSOS.BI_Evaluacion_Alumno
ADD CONSTRAINT FK_Evaluacion_Alumno_Curso FOREIGN KEY (evaluacion_Alumno_Curso)
REFERENCES LOS_QUERYOSOS.BI_Curso (curso_Codigo);

ALTER TABLE LOS_QUERYOSOS.BI_Evaluacion_Alumno
ADD CONSTRAINT FK_Evaluacion_Alumno_Sede FOREIGN KEY (evaluacion_Alumno_Sede)
REFERENCES LOS_QUERYOSOS.BI_Sede (sede_Codigo);

/**************************   PAGOS  *********************************/


CREATE TABLE LOS_QUERYOSOS.BI_Pagos (
	pagos_Tiempo_Fecha BIGINT,
	pagos_Medio_De_Pago BIGINT,
	pagos_Alumno BIGINT,
	pagos_Monto_Factura DECIMAL(18,2),
	pagos_Monto_Pagado DECIMAL(18,2),
	pagos_Pagado_En_Termino BIT, --calcular al de migrar
	pagos_Adeudado DECIMAL(18,2),
	pagos_Fecha_Vencimiento DATETIME2(6),
	PRIMARY KEY(pagos_Tiempo_Fecha,pagos_Medio_De_Pago,pagos_Alumno)
);
GO

ALTER TABLE LOS_QUERYOSOS.BI_Pagos
ADD CONSTRAINT FK_Pagos_Tiempo FOREIGN KEY (pagos_Tiempo_Fecha)
REFERENCES LOS_QUERYOSOS.BI_Tiempo (tiempo_Codigo);

ALTER TABLE LOS_QUERYOSOS.BI_Pagos
ADD CONSTRAINT FK_Pagos_Medio FOREIGN KEY (pagos_Medio_De_Pago)
REFERENCES LOS_QUERYOSOS.BI_Medio_De_Pago (medio_De_Pago_Codigo);

ALTER TABLE LOS_QUERYOSOS.BI_Pagos
ADD CONSTRAINT FK_Pagos_Alumno FOREIGN KEY (pagos_Alumno)
REFERENCES LOS_QUERYOSOS.BI_Alumno (alumno_Codigo);


/**************************   SATISFACCION  *********************************/


CREATE TABLE LOS_QUERYOSOS.BI_Satisfaccion (
	satisfaccion_Tiempo BIGINT,
	satisfaccion_Profesor BIGINT,
	satisfaccion_Sede BIGINT,
	satisfaccion_Satisfaccion BIGINT,
	satisfaccion_Nota DECIMAL(18,2),
	PRIMARY KEY(satisfaccion_Tiempo,satisfaccion_Profesor,satisfaccion_Sede,satisfaccion_Satisfaccion)
);
GO

ALTER TABLE LOS_QUERYOSOS.BI_Satisfaccion
ADD CONSTRAINT FK_Satisfaccion_Sede FOREIGN KEY (satisfaccion_Sede)
REFERENCES LOS_QUERYOSOS.BI_Sede (sede_Codigo);

ALTER TABLE LOS_QUERYOSOS.BI_Satisfaccion
ADD CONSTRAINT FK_Satisfaccion_Tiempo FOREIGN KEY (satisfaccion_Tiempo)
REFERENCES LOS_QUERYOSOS.BI_Tiempo (tiempo_Codigo);

ALTER TABLE LOS_QUERYOSOS.BI_Satisfaccion
ADD CONSTRAINT FK_Satisfaccion_Profesor FOREIGN KEY (satisfaccion_Profesor)
REFERENCES LOS_QUERYOSOS.BI_Profesor (profesor_Codigo);

ALTER TABLE LOS_QUERYOSOS.BI_Satisfaccion
ADD CONSTRAINT FK_Satisfaccion_Satis FOREIGN KEY (satisfaccion_Satisfaccion)
REFERENCES LOS_QUERYOSOS.BI_Bloque_Satisfaccion (bloque_Satisfaccion_Codigo);
go

/**************************** FUNCIONES AUXILIARES *******************************/

CREATE FUNCTION LOS_QUERYOSOS.devolverCuatri(@FECHA DATETIME)
RETURNS INT
AS
BEGIN
    DECLARE @MES INT, @CUATRI INT;
    SET @MES = MONTH(@FECHA);

    IF(@MES >= 1 AND @MES <= 4)
    BEGIN
        SET @CUATRI = 1;
    END

    IF(@MES >= 5 AND @MES <= 8)
    BEGIN
        SET @CUATRI = 2;
    END

    IF(@MES >= 9 AND @MES <= 12)
    BEGIN
        SET @CUATRI = 3;
    END

    RETURN @CUATRI;
END;
GO

CREATE FUNCTION LOS_QUERYOSOS.devolverSemestre(@FECHA DATETIME)
RETURNS INT
AS
BEGIN
    DECLARE @MES INT, @SEMESTRE INT;
    SET @MES = MONTH(@FECHA);

    IF(@MES >= 1 AND @MES <= 6)
    BEGIN
        SET @SEMESTRE = 1;
    END

    IF(@MES >= 7 AND @MES <= 12)
    BEGIN
        SET @SEMESTRE = 2;
    END

    RETURN @SEMESTRE;
END;
GO

CREATE FUNCTION LOS_QUERYOSOS.devolverRangoEtareo(@FECHA_NACIMIENTO DATETIME)
RETURNS CHAR(8)
AS
BEGIN
    DECLARE @FECHA_ACTUAL DATETIME, @DIFF INT, @RANGO CHAR(8);
    SET @FECHA_ACTUAL = GETDATE();

    SET @DIFF = DATEDIFF(YEAR, @FECHA_NACIMIENTO, @FECHA_ACTUAL);

    IF(@DIFF < 25)
    BEGIN
        SET @RANGO = '<25';
    END

    IF(@DIFF >= 25 AND @DIFF <= 35)
    BEGIN
        SET @RANGO = '25-35';
    END

    IF(@DIFF >= 35 AND @DIFF <= 50)
    BEGIN
        SET @RANGO = '35-50';
    END

    IF(@DIFF > 50)
    BEGIN
        SET @RANGO = '>50';
    END

	ELSE
	BEGIN
	   SET @RANGO = 'Desconocido'
	END

    RETURN @RANGO;
END;
GO

CREATE FUNCTION LOS_QUERYOSOS.pagadoEnTermino(@FECHA_PAGO DATETIME, @FECHA_VENCIMIENTO DATETIME)
RETURNS BIT
BEGIN
    DECLARE @BIT BIT
    IF( @FECHA_PAGO <= @FECHA_VENCIMIENTO)
	BEGIN
	    SET @BIT = 1
	END
	ELSE
	BEGIN
	    SET @BIT = 0
	END
	RETURN @BIT
END
GO

CREATE FUNCTION LOS_QUERYOSOS.aproboFinal(@NOTA BIGINT) --para tabla Evaluacion_Finales
RETURNS BIT
BEGIN
    DECLARE @BIT BIT

    IF( @NOTA >= 6)
	BEGIN
	    SET @BIT = 1
	END
	ELSE
	BEGIN
	    SET @BIT = 0
	END
	RETURN @BIT
END
GO

CREATE FUNCTION LOS_QUERYOSOS.aproboAlumno(@NOTA BIGINT) --para tabla Evaluacion_Alumno o la sacamos y el calclo de la vista 3 lo hacemos en el momento?
RETURNS BIT
BEGIN
    DECLARE @BIT BIT

    IF( @NOTA >= 6)
	BEGIN
	    SET @BIT = 1
	END
	ELSE
	BEGIN
	    SET @BIT = 0
	END
	RETURN @BIT
END
GO

/**************************** PROCEDIMIENTOS *******************************/

CREATE PROCEDURE LOS_QUERYOSOS.MigrarTiemposSinRepetir
AS
BEGIN
    CREATE TABLE #TempTiempo (
        tiempo_anio INT,
        tiempo_mes INT,
        tiempo_cuatri INT,
        tiempo_semest INT
    );

    INSERT INTO #TempTiempo
    SELECT DISTINCT 
        YEAR(x.fecha), 
        MONTH(x.fecha),
        LOS_QUERYOSOS.devolverCuatri(x.fecha),
        LOS_QUERYOSOS.devolverSemestre(x.fecha)
    FROM (
        SELECT examen_Final_Fecha AS fecha FROM LOS_QUERYOSOS.Examen_Final
        WHERE examen_Final_Fecha IS NOT NULL
        UNION
        SELECT inscripcion_Fecha FROM LOS_QUERYOSOS.Inscripcion 
        WHERE inscripcion_Fecha IS NOT NULL
        UNION
        SELECT evaluacion_Curso_FechaEvaluacion FROM LOS_QUERYOSOS.Evaluacion_Curso
        WHERE evaluacion_Curso_FechaEvaluacion IS NOT NULL
        UNION
        SELECT trabajo_Practico_FechaEvaluacion FROM LOS_QUERYOSOS.Trabajo_Practico
        WHERE trabajo_Practico_FechaEvaluacion IS NOT NULL
        UNION
        SELECT pago_Fecha FROM LOS_QUERYOSOS.Pago
        WHERE pago_Fecha IS NOT NULL
        UNION
        SELECT factura_FechaVencimiento FROM LOS_QUERYOSOS.Factura
        WHERE factura_FechaVencimiento IS NOT NULL
        UNION
        SELECT encuesta_FechaRegistro FROM LOS_QUERYOSOS.Encuesta
        WHERE encuesta_FechaRegistro IS NOT NULL
    ) x;

    INSERT INTO LOS_QUERYOSOS.BI_Tiempo (tiempo_anio, tiempo_mes, tiempo_Cuatrimestre, tiempo_semestre)
    SELECT tt.tiempo_anio, tt.tiempo_mes, tt.tiempo_cuatri, tt.tiempo_semest
    FROM #TempTiempo tt
    WHERE NOT EXISTS (
        SELECT 1 FROM LOS_QUERYOSOS.BI_Tiempo bt
        WHERE bt.tiempo_anio = tt.tiempo_anio
          AND bt.tiempo_mes = tt.tiempo_mes
          AND bt.tiempo_Cuatrimestre = tt.tiempo_cuatri
          AND bt.tiempo_Semestre = tt.tiempo_semest
    );

    DROP TABLE #TempTiempo;
END;
GO


CREATE FUNCTION LOS_QUERYOSOS.devolverTiempoDeFecha (@fecha SMALLDATETIME)
RETURNS INT
AS
BEGIN
    DECLARE @anio INT;
    DECLARE @mes INT;
    DECLARE @cuatri INT;
    DECLARE @semest INT;
    DECLARE @tiempo_codig INT;

    SET @anio = YEAR(@fecha);
    SET @mes = MONTH(@fecha);
    SET @cuatri = LOS_QUERYOSOS.devolverCuatri(@fecha); 
    SET @semest = LOS_QUERYOSOS.devolverSemestre(@fecha);

    
    SELECT @tiempo_codig = tiempo_Codigo
    FROM LOS_QUERYOSOS.BI_Tiempo
    WHERE tiempo_anio = @anio
      AND tiempo_mes = @mes
      AND tiempo_Cuatrimestre = @cuatri
      AND tiempo_Semestre = @semest

    RETURN @tiempo_codig;
END
GO

CREATE PROCEDURE LOS_QUERYOSOS.MigrarEstados
AS
BEGIN
	INSERT INTO LOS_QUERYOSOS.BI_Estado (estado_Detalle)
	SELECT DISTINCT inscripcion_Estado
	FROM LOS_QUERYOSOS.Inscripcion
	WHERE inscripcion_Estado IS NOT NULL;
END
GO	

CREATE PROCEDURE LOS_QUERYOSOS.MigrarMediosDePago
AS
BEGIN
	INSERT INTO LOS_QUERYOSOS.BI_Medio_De_Pago (medio_De_Pago_Detalle)
	SELECT DISTINCT pago_Medio_De_Pago
	FROM LOS_QUERYOSOS.Pago
	WHERE pago_Medio_De_Pago IS NOT NULL;
END
GO	

CREATE PROCEDURE LOS_QUERYOSOS.MigrarBloquessatisfaccion
AS
BEGIN
	INSERT INTO LOS_QUERYOSOS.BI_Bloque_Satisfaccion 
	(bloque_Satisfaccion_Detalle, bloque_Satisfaccion_Nota_Min, bloque_Satisfaccion_Nota_Max)
	VALUES 
	('Satisfechos', 7, 10),
	('Neutrales', 5, 6),
	('Insatisfechos', 1, 4);
END
GO	

CREATE PROCEDURE LOS_QUERYOSOS.MigrarAlumnos
AS
BEGIN
	INSERT INTO LOS_QUERYOSOS.BI_Alumno (
		alumno_Dni,
		alumno_Legajo,
		alumno_Nombre,
		alumno_Apellido,
		alumno_FechaNacimiento,
		alumno_Localidad,
		alumno_Provincia,
		alumno_Rango_Etario
	)
	SELECT DISTINCT
		a.alumno_Dni,
		a.alumno_Legajo,
		a.alumno_Nombre,
		a.alumno_Apellido,
		a.alumno_FechaNacimiento,
		loc.localidad_Nombre,
		prov.provincia_Nombre,
		LOS_QUERYOSOS.devolverRangoEtareo(a.alumno_FechaNacimiento)
	FROM LOS_QUERYOSOS.Alumno a
	LEFT JOIN LOS_QUERYOSOS.Direccion dir ON dir.direccion_Codigo = alumno_Direccion
	LEFT JOIN LOS_QUERYOSOS.Localidad loc ON loc.localidad_Codigo = dir.direccion_Localidad
	LEFT JOIN LOS_QUERYOSOS.Provincia prov ON prov.provincia_Codigo = loc.localidad_Provincia;
						
END
GO	

CREATE PROCEDURE LOS_QUERYOSOS.MigrarProfesores
AS
BEGIN
	INSERT INTO LOS_QUERYOSOS.BI_Profesor (
		profesor_Nombre,
		profesor_Apellido,
		profesor_FechaNacimiento,
		profesor_Rango_Etario
	)
	SELECT DISTINCT
		profesor_Nombre,
		profesor_Apellido,
		profesor_FechaNacimiento,
		LOS_QUERYOSOS.devolverRangoEtareo(profesor_FechaNacimiento)
	FROM LOS_QUERYOSOS.Profesor;				
END
GO	

CREATE PROCEDURE LOS_QUERYOSOS.MigrarSedes
AS
BEGIN
	INSERT INTO LOS_QUERYOSOS.BI_Sede (
		sede_Nombre,
		sede_Direccion,
		sede_Localidad,
		sede_Provincia,
		sede_Institucion
	)
	SELECT DISTINCT
		s.sede_Nombre,
		s.sede_Direccion,
		loc.localidad_Nombre,
		prov.provincia_Nombre,
		inst.institucion_Nombre
	FROM LOS_QUERYOSOS.Sede s
	LEFT JOIN LOS_QUERYOSOS.Direccion dir ON dir.direccion_Codigo = s.sede_Direccion
	LEFT JOIN LOS_QUERYOSOS.Localidad loc ON loc.localidad_Codigo = dir.direccion_Localidad
	LEFT JOIN LOS_QUERYOSOS.Provincia prov ON prov.provincia_Codigo = loc.localidad_Provincia
	LEFT JOIN LOS_QUERYOSOS.Institucion inst ON inst.institucion_Codigo = s.sede_Institucion;		
END
GO	

CREATE PROCEDURE LOS_QUERYOSOS.MigrarCursos
AS
BEGIN
	INSERT INTO LOS_QUERYOSOS.BI_Curso (
		curso_Nombre,
		curso_Descripcion,
		curso_FechaInicio,
		curso_FechaFin,
		curso_DuracionMeses,
		curso_PrecioMensual,
		curso_Categoria,
		curso_Turno,
		curso_Profesor,
		curso_Sede
	)
	SELECT DISTINCT
		curso_Nombre,
		curso_Descripcion,
		curso_FechaInicio,
		curso_FechaFin,
		curso_DuracionMeses,
		curso_PrecioMensual,
		curso_Categoria,
		curso_Turno,
		curso_Profesor,
		curso_Sede
	FROM LOS_QUERYOSOS.Curso;	
END
GO


CREATE PROCEDURE LOS_QUERYOSOS.MigrarInscripciones
AS
BEGIN
	INSERT INTO LOS_QUERYOSOS.BI_Inscripcion (
		inscripcion_Tiempo,
		inscripcion_Estado,
		inscripcion_Fecha_Respuesta,
		inscripcion_Alumno,
		inscripcion_Curso,
		inscripcion_Sede
	)
	SELECT
		LOS_QUERYOSOS.devolverTiempoDeFecha(i.inscripcion_Fecha),
		est.estado_Codigo,
		i.inscripcion_FechaRespuesta,
    
		bal.alumno_Codigo,
		bcu.curso_Codigo,
		bse.sede_Codigo
	FROM LOS_QUERYOSOS.Inscripcion i
	JOIN LOS_QUERYOSOS.Curso c on c.curso_Codigo = i.inscripcion_Curso
	JOIN LOS_QUERYOSOS.Sede s ON c.curso_Sede = s.sede_Codigo 
	JOIN LOS_QUERYOSOS.BI_Alumno bal ON bal.alumno_Dni = i.inscripcion_Alumno
	JOIN LOS_QUERYOSOS.BI_Curso bcu ON bcu.curso_Codigo = i.inscripcion_Curso
	JOIN LOS_QUERYOSOS.BI_Estado est ON est.estado_Detalle = i.inscripcion_Estado
	JOIN LOS_QUERYOSOS.BI_Sede bse ON bse.sede_Nombre = s.sede_Nombre
END
GO

CREATE PROCEDURE LOS_QUERYOSOS.MigrarEvaluacion
AS
BEGIN
	INSERT INTO LOS_QUERYOSOS.BI_Evaluacion_Alumno (
		evaluacion_Alumno_Tiempo,
		evaluacion_Alumno_Alumno,
		evaluacion_Alumno_Curso,
		evaluacion_Alumno_Sede,
		evaluacion_Alumno_Aprobado,
		evaluacion_Alumno_Nota_Modulo,
		evaluacion_Alumno_Nota_TP
	)
	SELECT
		LOS_QUERYOSOS.devolverTiempoDeFecha(ec.evaluacion_Curso_FechaEvaluacion),
		bal.alumno_Codigo,
		bcu.curso_Codigo,
		bse.sede_Codigo,
		LOS_QUERYOSOS.aproboAlumno(ea.evaluacion_Alumno_Nota),
		ea.evaluacion_Alumno_Nota,
		tp.trabajo_Practico_Nota
	FROM LOS_QUERYOSOS.Evaluacion_Alumno ea
	JOIN LOS_QUERYOSOS.Alumno a on ea.evaluacion_Alumno_Alumno = a.alumno_Codigo
	JOIN LOS_QUERYOSOS.Evaluacion_Curso ec ON ea.evaluacion_Alumno_Codigo = ec.evaluacion_Curso_Codigo
	JOIN LOS_QUERYOSOS.Modulo m on ec.evaluacion_Curso_Modulo = m.modulo_Numero
	JOIN LOS_QUERYOSOS.Curso c on c.curso_Codigo = m.modulo_Curso
	JOIN LOS_QUERYOSOS.Sede s ON c.curso_Sede = s.sede_Codigo 
	JOIN LOS_QUERYOSOS.Trabajo_Practico TP on tp.trabajo_Practico_Alumno = a.alumno_Codigo 
	JOIN LOS_QUERYOSOS.BI_Alumno bal ON bal.alumno_Dni = a.alumno_Dni
	JOIN LOS_QUERYOSOS.BI_Curso bcu ON bcu.curso_Codigo = c.curso_Codigo
	JOIN LOS_QUERYOSOS.BI_Sede bse ON bse.sede_Nombre = s.sede_Nombre

	
END
GO

CREATE PROCEDURE LOS_QUERYOSOS.MigrarEvaluacionFinales
AS
BEGIN
	INSERT INTO LOS_QUERYOSOS.BI_Evaluacion_Finales (
		evaluacion_Finales_Tiempo_Fecha,
		evaluacion_Finales_Alumno,
		evaluacion_Finales_Curso,
		evaluacion_Finales_Sede,
		evaluacion_Finales_Aprobado,
		evaluacion_Finales_Nota_Final,
		evaluacion_Finales_Presente
	)
	SELECT
		LOS_QUERYOSOS.devolverTiempoDeFecha(ex.examen_Final_Fecha),
		bal.alumno_Codigo,
		bcu.curso_Codigo,
		bse.sede_Codigo,
		LOS_QUERYOSOS.aproboFinal(ex.examen_Final_Nota),
		ex.examen_Final_Nota,
		ex.examen_Final_Presente
	FROM LOS_QUERYOSOS.Examen_Final ex
	JOIN LOS_QUERYOSOS.Inscripcion_Final insc ON insc.inscripcion_Final_ExamenFinal = ex.examen_Final_Codigo
	JOIN LOS_QUERYOSOS.Curso c on c.curso_Codigo = ex.examen_Final_Curso
	JOIN LOS_QUERYOSOS.Sede s on s.sede_Codigo = c.curso_Sede
	JOIN LOS_QUERYOSOS.Alumno a on insc.inscripcion_Final_AlumnoCod = a.alumno_Codigo
	JOIN LOS_QUERYOSOS.BI_Alumno bal ON bal.alumno_Dni = a.alumno_Dni
	JOIN LOS_QUERYOSOS.BI_Curso bcu ON bcu.curso_Codigo = ex.examen_Final_Curso
	JOIN LOS_QUERYOSOS.BI_Sede bse ON bse.sede_Nombre = s.sede_Nombre		
END
GO

CREATE PROCEDURE LOS_QUERYOSOS.MigrarPagos
AS
BEGIN
	INSERT INTO LOS_QUERYOSOS.BI_Pagos (
		pagos_Tiempo_Fecha,
		pagos_Medio_De_Pago,
		pagos_Alumno,
		pagos_Monto_Factura,
		pagos_Monto_Pagado,
		pagos_Pagado_En_Termino,
		pagos_Adeudado,
		pagos_Fecha_Vencimiento
	)
	SELECT
		LOS_QUERYOSOS.devolverTiempoDeFecha(p.pago_Fecha),
		bmp.medio_De_Pago_Codigo,
		bal.alumno_Codigo,
		df.detalle_Factura_Importe,
		p.pago_Importe,
		LOS_QUERYOSOS.pagadoEnTermino(p.pago_Fecha, f.factura_FechaVencimiento),
		(df.detalle_Factura_Importe - p.pago_Importe),
		f.factura_FechaVencimiento
	FROM LOS_QUERYOSOS.Pago p
	JOIN LOS_QUERYOSOS.Factura f ON f.factura_Numero = p.pago_Factura
	JOIN LOS_QUERYOSOS.Detalle_Factura df ON F.factura_Numero = df.detalle_Factura_Factura
	JOIN LOS_QUERYOSOS.Alumno a on a.alumno_Codigo = f.factura_Alumno
	JOIN LOS_QUERYOSOS.BI_Alumno bal ON bal.alumno_Dni = a.alumno_Dni
	JOIN LOS_QUERYOSOS.BI_Medio_De_Pago bmp ON bmp.medio_De_Pago_Detalle = p.pago_Medio_De_Pago;		
END
GO

--CREATE PROCEDURE LOS_QUERYOSOS.MigrarSatisfaccion
--AS
--BEGIN
--	INSERT INTO LOS_QUERYOSOS.BI_Satisfaccion (
--		satisfaccion_Tiempo,
--		satisfaccion_Profesor,
--		satisfaccion_Sede,
--		satisfaccion_Satisfaccion,
--		satisfaccion_Nota
--	)
--	SELECT
--		dbo.devolverTiempoDeFecha(enc.encuesta_FechaRegistro),
--		bp.profesor_Codigo,
--		(SELECT sede_Codigo FROM LOS_QUERYOSOS.BI_Sede bs WHERE bs.sede_Nombre = s.sede_Nombre),
--		bsat.bloque_Satisfaccion_Codigo,
--		enc.encuesta_Nota
--	FROM LOS_QUERYOSOS.Encuesta enc
--	JOIN LOS_QUERYOSOS.Curso c ON c.curso_Codigo = enc.encuesta_Curso
--	JOIN LOS_QUERYOSOS.Profesor p ON p.profesor_Codigo = c.curso_Profesor
--	JOIN LOS_QUERYOSOS.Sede s on s.sede_Codigo = c.curso_Sede
--	JOIN LOS_QUERYOSOS.Pregunta pr on pr.pregunta_Encuesta
--	JOIN LOS_QUERYOSOS.BI_Profesor bp ON bp.profesor_Nombre = p.profesor_Nombre and bp.profesor_Nombre = p.profesor_Apellido
--	JOIN LOS_QUERYOSOS.BI_Sede bs ON bs.sede_Nombre = c.curso_Categoria
--	JOIN LOS_QUERYOSOS.BI_Bloque_Satisfaccion bsat 
--		ON enc.encuesta_Nota BETWEEN bsat.bloque_Satisfaccion_Nota_Min 
--								 AND bsat.bloque_Satisfaccion_Nota_Max;
	
--END
--GO

/**************************** MIGRACION DIMENSIONES *******************************/

PRINT 'Migrando dimensión TIEMPO...';
EXEC LOS_QUERYOSOS.MigrarTiemposSinRepetir;
GO

PRINT 'Migrando ESTADOS...';
EXEC LOS_QUERYOSOS.MigrarEstados;
GO

PRINT 'Migrando MEDIOS DE PAGO...';
EXEC LOS_QUERYOSOS.MigrarMediosDePago;
GO

PRINT 'Migrando BLOQUES DE SATISFACCION...';
EXEC LOS_QUERYOSOS.MigrarBloquessatisfaccion;
GO

PRINT 'Migrando ALUMNOS...';
EXEC LOS_QUERYOSOS.MigrarAlumnos;
GO

PRINT 'Migrando PROFESORES...';
EXEC LOS_QUERYOSOS.MigrarProfesores;
GO

PRINT 'Migrando SEDES...';
EXEC LOS_QUERYOSOS.MigrarSedes;
GO

PRINT 'Migrando CURSOS...';
EXEC LOS_QUERYOSOS.MigrarCursos;
GO


/**************************** MIGRACION HECHOS *******************************/

PRINT 'Migrando INSCRIPCIONES...';
EXEC LOS_QUERYOSOS.MigrarInscripciones;
GO

PRINT 'Migrando EVALUACION CURSO...';
EXEC LOS_QUERYOSOS.MigrarEvaluacion;
GO

PRINT 'Migrando EVALUACION FINALES...';
EXEC LOS_QUERYOSOS.MigrarEvaluacionFinales;
GO

PRINT 'Migrando PAGOS...';
EXEC LOS_QUERYOSOS.MigrarPagos;
GO

-- Falta Satisfaccion cuando esté listo
PRINT 'Migración BI finalizada.';
GO


/**************************** VISTAS *******************************/

/*1-Categorías y turnos más solicitados. Las 3 categorías de cursos y turnos con mayor cantidad de inscriptos por año por sede.*/

CREATE VIEW BI_Categorias_Turnos_Solicitados AS
SELECT
    T.tiempo_Anio AS Anio,
    S.sede_Nombre AS Sede,
    C.curso_Categoria AS Categoria,
    C.curso_Turno AS Turno,
    COUNT(*) AS CantInscriptos
FROM LOS_QUERYOSOS.BI_Inscripcion I
JOIN LOS_QUERYOSOS.BI_Tiempo T 
    ON I.inscripcion_Tiempo = T.tiempo_Codigo
JOIN LOS_QUERYOSOS.BI_Curso C 
    ON I.inscripcion_Curso = C.curso_Codigo
JOIN LOS_QUERYOSOS.BI_Sede S
    ON I.inscripcion_Sede = S.sede_Codigo
GROUP BY
    T.tiempo_Anio,
    S.sede_Nombre,
    C.curso_Categoria,
    C.curso_Turno;
GO

/*2-Tasa de rechazo de inscripciones: Porcentaje de inscripciones rechazadas por mes por sede (sobre el total de inscripciones).*/

CREATE VIEW BI_Tasa_Rechazo_Inscripciones AS
SELECT
    T.tiempo_Anio AS Anio,
    T.tiempo_Mes AS Mes,
    S.sede_Nombre AS Sede,

    COUNT(*) AS TotalInscriptos,

    SUM(
        CASE WHEN E.estado_Detalle = 'Rechazada' THEN 1 ELSE 0 END
    ) AS CantRechazados,

    SUM(
        CASE WHEN E.estado_Detalle = 'Rechazada' THEN 1 ELSE 0 END
    ) * 100.0 / COUNT(*) AS TasaRechazo
FROM LOS_QUERYOSOS.BI_Inscripcion I
JOIN LOS_QUERYOSOS.BI_Tiempo T 
    ON I.inscripcion_Tiempo = T.tiempo_Codigo
JOIN LOS_QUERYOSOS.BI_Estado E
    ON I.inscripcion_Estado = E.estado_Codigo
JOIN LOS_QUERYOSOS.BI_Sede S
    ON I.inscripcion_Sede = S.sede_Codigo
GROUP BY
    T.tiempo_Anio,
    T.tiempo_Mes,
    S.sede_Nombre;
GO

/*3-Comparación de desempeño de cursada por sede:. Porcentaje de aprobación de cursada por sede, por año. Se considera aprobada la cursada de un alumno
cuando tiene nota mayor o igual a 4 en todos los módulos y el TP.*/

CREATE VIEW LOS_QUERYOSOS.V_Porcentaje_Aprobacion_Cursada_Por_Sede AS
SELECT 
    s.sede_Nombre AS Sede,
    t.tiempo_Anio AS Anio,
    
    COUNT(*) AS Total_Cursadas,
    
    SUM(CASE WHEN e.evaluacion_Alumno_Nota_Modulo >= 4 
             AND e.evaluacion_Alumno_Nota_TP >= 4 
                THEN 1 ELSE 0  END ) AS Total_Aprobadas,
    
    CAST( SUM( CASE  WHEN e.evaluacion_Alumno_Nota_Modulo >= 4 
                 AND e.evaluacion_Alumno_Nota_TP >= 4 
                    THEN 1 ELSE 0  END) * 100.0 / COUNT(*) AS DECIMAL(10,2) ) AS Porcentaje_Aprobacion

FROM LOS_QUERYOSOS.BI_Evaluacion_Alumno e
JOIN LOS_QUERYOSOS.BI_Tiempo t
    ON e.evaluacion_Alumno_Tiempo = t.tiempo_Codigo
JOIN LOS_QUERYOSOS.BI_Sede s
    ON e.evaluacion_Alumno_Sede = s.sede_Codigo

GROUP BY 
    s.sede_Nombre,
    t.tiempo_Anio;
GO
---otra opcion:
CREATE VIEW LOS_QUERYOSOS.V_DesempenoCursadaPorSede AS
SELECT 
    ea.evaluacion_Alumno_Sede AS Sede,
    t.tiempo_Anio AS Anio,
    SUM(CASE WHEN ea.evaluacion_Alumno_Aprobado = 1 THEN 1 ELSE 0 END) * 1.0
        / COUNT(*) AS PorcentajeAprobacion
FROM LOS_QUERYOSOS.BI_Evaluacion_Alumno ea
JOIN LOS_QUERYOSOS.BI_Tiempo t 
    ON t.tiempo_Codigo = ea.evaluacion_Alumno_Tiempo
GROUP BY 
    ea.evaluacion_Alumno_Sede,
    t.tiempo_Anio;
GO
/*4-Tiempo promedio de finalización de curso: Tiempo promedio entre el inicio del curso y la aprobación del final según la categoría de los cursos, por año.
(Tener en cuenta el año de inicio del curso)*/

CREATE VIEW LOS_QUERYOSOS.V_TiempoPromedioFinalizacion AS
SELECT
    c.curso_Categoria AS Categoria,
    YEAR(c.curso_FechaInicio) AS Anio,
    AVG(DATEDIFF(
            DAY,
            c.curso_FechaInicio,
            CAST(CONCAT(t.tiempo_Anio,'-',t.tiempo_Mes,'-01') AS DATE)
        )) AS PromedioDiasFinalizacion
FROM LOS_QUERYOSOS.BI_Evaluacion_Finales f
JOIN LOS_QUERYOSOS.BI_Curso c 
    ON c.curso_Codigo = f.evaluacion_Finales_Curso
JOIN LOS_QUERYOSOS.BI_Tiempo t 
    ON t.tiempo_Codigo = f.evaluacion_Finales_Tiempo_Fecha
WHERE f.evaluacion_Finales_Aprobado = 1
GROUP BY 
    c.curso_Categoria,
    YEAR(c.curso_FechaInicio);
GO

/*5-Nota promedio de finales. Promedio de nota de finales según el rango etario del alumno y la categoría del curso por semestre.*/

CREATE VIEW LOS_QUERYOSOS.BI_V_Promedio_Finales_Semestre AS
SELECT
    T.tiempo_Anio AS Anio,
    T.tiempo_Semestre AS Semestre,
    A.alumno_Rango_Etario AS RangoEtario,
    C.curso_Categoria AS Categoria,
    AVG(EF.evaluacion_Finales_Nota_Final) AS PromedioNotaFinal
FROM LOS_QUERYOSOS.BI_Evaluacion_Finales EF
JOIN LOS_QUERYOSOS.BI_Tiempo T
    ON EF.evaluacion_Finales_Tiempo_Fecha = T.tiempo_Codigo
JOIN LOS_QUERYOSOS.BI_Alumno A
    ON EF.evaluacion_Finales_Alumno = A.alumno_Codigo
JOIN LOS_QUERYOSOS.BI_Curso C
    ON EF.evaluacion_Finales_Curso = C.curso_Codigo
GROUP BY
    T.tiempo_Anio,
    T.tiempo_Semestre,
    A.alumno_Rango_Etario,
    C.curso_Categoria;
GO

/*6-Tasa de ausentismo finales: Porcentaje de ausentes a finales (sobre la cantidad de inscriptos) por semestre por sede.*/

CREATE VIEW LOS_QUERYOSOS.V_TasaAusentismo AS
SELECT 
    f.evaluacion_Finales_Sede AS Sede,
    t.tiempo_Anio AS Anio,
    t.tiempo_Semestre AS Semestre,
    
    COUNT(*) AS TotalFinales,
    
    SUM(CASE WHEN f.evaluacion_Finales_Presente = 0 THEN 1 ELSE 0 END) AS CantAusentes,
    
    SUM(CASE WHEN f.evaluacion_Finales_Presente = 0 THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*) AS TasaAusentismo
FROM LOS_QUERYOSOS.BI_Evaluacion_Finales f
JOIN LOS_QUERYOSOS.BI_Tiempo t
    ON t.tiempo_Codigo = f.evaluacion_Finales_Tiempo_Fecha
GROUP BY 
    f.evaluacion_Finales_Sede,
    t.tiempo_Anio,
    t.tiempo_Semestre; --es por sede y semestre
GO 

/*7-Desvío de pagos: Porcentaje de pagos realizados fuera de término por semestre.*/

CREATE VIEW LOS_QUERYOSOS.V_DesvioPagos AS
SELECT
    t.tiempo_Anio AS Anio,
    t.tiempo_Semestre AS Semestre,

    COUNT(*) AS TotalPagos,

    SUM(CASE WHEN p.pagos_Pagado_En_Termino = 0 THEN 1 ELSE 0 END) AS PagosFueraTermino,

    SUM(CASE WHEN p.pagos_Pagado_En_Termino = 0 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS PorcentajeDesvio
FROM LOS_QUERYOSOS.BI_Pagos p
JOIN LOS_QUERYOSOS.BI_Tiempo t
    ON t.tiempo_Codigo = p.pagos_Tiempo_Fecha
GROUP BY 
    t.tiempo_Anio,
    t.tiempo_Semestre;
GO

/*8-Tasa de Morosidad Financiera mensual. Se calcula teniendo en cuenta el total de importes adeudados sobre facturación esperada en el mes. 
El monto adeudado se obtiene a partir de las facturas que no tengan pago registrado en dicho mes.*/

CREATE VIEW LOS_QUERYOSOS.vw_MorosidadMensual AS
SELECT
    t.tiempo_Anio AS Anio,
    t.tiempo_Mes AS Mes,

    SUM(p.pagos_Monto_Factura) AS TotalFacturado,
    SUM(p.pagos_Adeudado) AS TotalAdeudado,

    CASE WHEN SUM(p.pagos_Monto_Factura) > 0 THEN
        SUM(p.pagos_Adeudado) * 100.0 / SUM(p.pagos_Monto_Factura)
    ELSE 0 END AS TasaMorosidad
FROM LOS_QUERYOSOS.BI_Pagos p
JOIN LOS_QUERYOSOS.BI_Tiempo t
    ON t.tiempo_Codigo = p.pagos_Tiempo_Fecha
GROUP BY 
    t.tiempo_Anio,
    t.tiempo_Mes;
GO

/*9-Ingresos por categoría de cursos: Las 3 categorías de cursos que generan mayores ingresos por sede, por año*/

CREATE VIEW LOS_QUERYOSOS.Top3_Ingresos_Categoria AS
SELECT 
    *
FROM (
    SELECT
        s.sede_Nombre,
        t.tiempo_Anio,
        c.curso_Categoria,
        SUM(c.curso_PrecioMensual) AS Ingresos,
        ROW_NUMBER() OVER (
            PARTITION BY s.sede_Codigo, t.tiempo_Anio
            ORDER BY SUM(c.curso_PrecioMensual) DESC
        ) AS rn
    FROM LOS_QUERYOSOS.BI_Inscripcion i
    JOIN LOS_QUERYOSOS.BI_Curso c
        ON c.curso_Codigo = i.inscripcion_Curso
    JOIN LOS_QUERYOSOS.BI_Sede s
        ON s.sede_Codigo = c.curso_Sede
    JOIN LOS_QUERYOSOS.BI_Tiempo t
        ON t.tiempo_Codigo = i.inscripcion_Tiempo
    GROUP BY
        s.sede_Codigo,
        s.sede_Nombre,
        t.tiempo_Anio,
        c.curso_Categoria
) X
WHERE rn <= 3;
GO
/*10-Índice de satisfacción. Índice de satisfacción anual, según rango etario de los profesores y sede. 
El índice de satisfacción es igual a ((%satisfechos - oinsatisfechos) +100)/2.
Teniendo en cuenta que
o Satisfechos: Notas entre 7 y 10
o Neutrales: Notas entre 5 y 6
o Insatisfechos: Notas entre 1 y 4 */

--CREATE VIEW LOS_QUERYOSOS.vw_IndiceSatisfaccion AS
--SELECT
--    t.tiempo_Anio AS Anio,
--    s.sede_Codigo AS Sede,
--    p.profesor_Rango_Etario AS RangoEtario,

--    COUNT(*) AS TotalRespuestas,

--    SUM(CASE WHEN sat.satisfaccion_Nota BETWEEN 7 AND 10 THEN 1 ELSE 0 END) AS Satisfechos,
--    SUM(CASE WHEN sat.satisfaccion_Nota BETWEEN 5 AND 6 THEN 1 ELSE 0 END) AS Neutrales,
--    SUM(CASE WHEN sat.satisfaccion_Nota BETWEEN 1 AND 4 THEN 1 ELSE 0 END) AS Insatisfechos,

--    (
--        (
--            (SUM(CASE WHEN sat.satisfaccion_Nota BETWEEN 7 AND 10 THEN 1 ELSE 0 END) * 100.0 / COUNT(*))
--            -
--            (SUM(CASE WHEN sat.satisfaccion_Nota BETWEEN 1 AND 4 THEN 1 ELSE 0 END) * 100.0 / COUNT(*))
--        ) + 100
--    ) / 2 AS IndiceSatisfaccion

--FROM LOS_QUERYOSOS.BI_Satisfaccion sat
--JOIN LOS_QUERYOSOS.BI_Profesor p
--    ON p.profesor_Codigo = sat.satisfaccion_Profesor
--JOIN LOS_QUERYOSOS.BI_Sede s
--    ON s.sede_Codigo = sat.satisfaccion_Sede
--JOIN LOS_QUERYOSOS.BI_Tiempo t
--    ON t.tiempo_Codigo = sat.satisfaccion_Tiempo
--GROUP BY
--    t.tiempo_Anio,
--    s.sede_Codigo,
--    p.profesor_Rango_Etario;
--GO
