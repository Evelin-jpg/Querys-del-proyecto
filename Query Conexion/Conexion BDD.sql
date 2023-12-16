--El "10.235.242.150" viene siendo la ip del otro servidor al que se esta vinculando
EXEC sp_addlinkedserver
@server = '10.235.242.164',
@srvproduct = 'SQL SERVER';
GO

--El "sa" es el usuario que se esta utilizando para poder tener acceso a las bases de datos
exec sp_addlinkedsrvlogin
@rmtsrvname = N'10.235.242.164',
@useself = 'false',
@rmtuser = N'sa',
@rmtpassword = N'tec123';
GO

SELECT * FROM [10.235.242.164].SchoolServices.dbo.EmployeeType

INSERT INTO [10.235.242.164].SchoolServices.dbo.EmployeeType (Name, Credits, Code)
VALUES ('Introduction to Programming', 4, 'PROG303');

UPDATE [10.235.242.164].SchoolServices.dbo.EmployeeType
SET name = 'Full-Time'
WHERE CourseID = 4;

DELETE FROM [10.235.242.164].SchoolServices.dbo.EmployeeType WHERE EmployeeTypeID = 3;



--Aqui se puede ver una consulta entre las tablas del otro servidor y las mias
SELECT count(a.idAsistencia) as Asistencias,
al.nombre + ' ' + al.apellidoPaterno + ' ' + al.apellidoMAterno As Nombre
FROM [10.235.242.150].AssistControl.dbo.Alumno al
inner join AssistControl.dbo.Asistencia a on al.idAlumno = a.idAlumno
WHERE a.presente = 1
GROUP BY al.nombre, al.apellidoPaterno, al.apellidoMAterno
GO

--Aqui se realiza una insercion en las tablas del otro servidor y se muestra la tabla
INSERT INTO [10.235.242.164].AssistControl.dbo.Alumno (nombre, apellidoPaterno, apellidoMAterno, matricula)
	VALUES	('Axel Abdiel', 'Martinez', 'Salazar', 'I1820090');

SELECT * FROM [10.235.242.150].AssistControl.dbo.Alumno;
GO

--Aqui se realiza lo que seria un cambio en un campo en las tablas del otro servidor y se muestra el cambio
UPDATE [10.235.242.164].AssistControl.dbo.Alumno
SET matricula = 'E1820090'
WHERE idAlumno = 7;

SELECT * FROM [10.235.242.164].AssistControl.dbo.Alumno;
GO

--Aqui se realiza lo que seria la "eliminacion" de un registro en las tablas del otro servidor y se muestra el cambio
DELETE FROM [10.235.242.164].AssistControl.dbo.Alumno WHERE idAlumno = 7;

SELECT * FROM [10.235.242.164].AssistControl.dbo.Alumno;
GO