CREATE TABLE Empleado(
    Nombre 		VARCHAR2(30) NOT NULL,
    Apellido1 	VARCHAR2(30) NOT NULL,
    Apellido2 	VARCHAR2(30),
    Dni 		VARCHAR2(30),
    Sueldo		NUMBER(7,2),
	FechaNac 	DATE,
    Sexo		CHAR(1) NOT NULL,	-- Masculino (M), Femenino (F)
    Direccion	VARCHAR2(150),
    Jornada		VARCHAR2(10), -- Matutina , Vespertina, Nocturna
    TipoEmp		VARCHAR2(30),
    Dpto		VARCHAR2(30),
    SuperDni	VARCHAR2(30),
    
    PRIMARY KEY (Dni),
	CONSTRAINT CHK_Empleado CHECK (Sexo in ('M','F'))
);
-- Listo 2
CREATE TABLE TelefonoEmpleado(
	Dni 		VARCHAR2(30),
    Telefono 	VARCHAR2(10),
    
    PRIMARY KEY (Dni,Telefono)
);

-- Listo 2
CREATE TABLE TipoEmpleado(
	IdTipoEmp	    VARCHAR2(30),
    Descripcion		VARCHAR2(30),
    
    PRIMARY KEY (IdTipoEmp)
);

-- LISTO 2
CREATE TABLE Departamento(
	NumDpto		VARCHAR2(30),
	Nombre		VARCHAR2(30) NOT NULL,
    DniGerente	VARCHAR2(30),
		
	PRIMARY KEY	(NumDpto)
);

-- Listo 
CREATE TABLE Producto(
	CodBarra		VARCHAR2(30),
    Marca			VARCHAR2(50),
    Descripcion 	VARCHAR2(40),
    Precio			NUMBER(4,2),
    Ubicacion		VARCHAR2(30),
    
    PRIMARY KEY (CodBarra)
);


-- Listo
CREATE TABLE Area(
	NombreArea		VARCHAR2(40),
    Pasillo			VARCHAR2(10),
    PRIMARY KEY (NombreArea)
);

-- LISTO
CREATE TABLE Cliente(
	Dni 		VARCHAR2(30),	
	Nombre 		VARCHAR2(30),
    Apellido 	VARCHAR2(30),
    
    PRIMARY KEY (Dni)
);

-- LISTO
CREATE TABLE Proveedor(
	CodProv				VARCHAR2(30),
	NombreMarca			VARCHAR2(30),
    NombreEncargado		VARCHAR2(30),
    ApellidoEncargado	VARCHAR2(30),
    Direccion			VARCHAR2(150),
    PRIMARY KEY	(CodProv)
);


-- LISTO
CREATE TABLE TelefonoProveedor(
	CodProv		VARCHAR2(30),
    Telefono 	VARCHAR2(10),
    
    PRIMARY KEY(CodProv,Telefono)
);

-- Listo 
CREATE TABLE Abastecimiento(
	IdAbasto			VARCHAR2(30),
    CodProv				VARCHAR2(30),
    DniEmp		 		VARCHAR2(30),
    Total				NUMBER(7,2),
    Fecha				DATE,
    
    PRIMARY KEY (IdAbasto)
);

-- Listo
CREATE TABLE Caja(
	CodCajero	VARCHAR2(30),
    NumCaja		VARCHAR2(30),
    
    PRIMARY KEY	(CodCajero)
);

-- Listo
CREATE TABLE Factura(
	IdFactura 		VARCHAR2(30),
    DniCliente		VARCHAR2(30),
    TipoPago 		VARCHAR2(10) NOT NULL, -- Credito o tarjeta
	MontoFinal		NUMBER(7,2) NOT NULL, -- Ej: 1,000,000.00 (10 num y 2 despues del punto)
	Fecha			DATE NOT NULL,
    Cajero			VARCHAR2(30),
    
    PRIMARY KEY (IdFactura)
);

-- Listo
CREATE TABLE DetalleFactura(
	IdFactura		VARCHAR2(30),
	NumRegistro		VARCHAR2(30),
    CodProducto		VARCHAR2(30),
    Cantidad		NUMBER(10) NOT NULL,	
    
    PRIMARY KEY (IdFactura,NumRegistro)
);

-- Listo
CREATE TABLE Suministro(
	IdAbasto			VARCHAR2(30),
	CodProd				VARCHAR2(30),
    Stock				NUMBER(10),
    CONSTRAINT PK_Person PRIMARY KEY (IdAbasto,CodProd)
);

--Llaves foraneas
ALTER TABLE Empleado ADD CONSTRAINT FK_Emp_Emp FOREIGN KEY (SuperDni) REFERENCES Empleado(Dni);
ALTER TABLE Empleado ADD CONSTRAINT FK_Emp_Dep FOREIGN KEY (Dpto) REFERENCES Departamento(NumDpto);
ALTER TABLE Empleado ADD CONSTRAINT FK_Emp_Tipo FOREIGN KEY (TipoEmp) REFERENCES TipoEmpleado(IdTipoEmp);

ALTER TABLE Departamento ADD CONSTRAINT FK_Dep_EMP foreign key	(DniGerente) references Empleado(Dni);

ALTER TABLE Producto ADD CONSTRAINT FK_Prod_Area foreign key (Ubicacion) references Area(NombreArea);

-- DETALLEFACTURA FK
ALTER TABLE DetalleFactura ADD CONSTRAINT FK_DT_FAC foreign key (IdFactura) references Factura(IdFactura);
ALTER TABLE DetalleFactura ADD CONSTRAINT FK_DT_PROD foreign key (CodProducto) references Producto(CodBarra);


-- FACTURA FK
ALTER TABLE Factura ADD CONSTRAINT FK_FAC_CJ foreign key (Cajero) references Caja(CodCajero);
ALTER TABLE Factura ADD CONSTRAINT FK_FAC_CLI foreign key (DniCliente) references Cliente(Dni);

-- Caja FK
ALTER TABLE Caja ADD CONSTRAINT FK_CJ_EMP foreign key (CodCajero) references Empleado(Dni);

-- Telefonos FK
ALTER TABLE TelefonoProveedor ADD CONSTRAINT FK_TEL_PRV foreign key (CodProv) references Proveedor(CodProv);
ALTER TABLE TelefonoEmpleado ADD CONSTRAINT FK_TEL_EMP foreign key (Dni) references Empleado(Dni);

-- Abastecimiento FK
ALTER TABLE Abastecimiento ADD CONSTRAINT FK_ABSTO_PRV foreign key (CodProv) references Proveedor(CodProv);
ALTER TABLE Abastecimiento ADD CONSTRAINT FK_ABSTO_EMP foreign key (DniEmp)	references Empleado(Dni);

-- Suministro FK
ALTER TABLE Suministro ADD CONSTRAINT FK_SUM_ABSTO foreign key (IdAbasto) references Abastecimiento(IdAbasto);
ALTER TABLE Suministro ADD CONSTRAINT FK_SUM_PROD foreign key (CodProd) references Producto(CodBarra);

--INSERTS
--AREA
INSERT INTO AREA (NombreArea, Pasillo) VALUES ('Frutas','1'); 
INSERT INTO AREA (NombreArea, Pasillo) VALUES ('Verduras','1'); 
INSERT INTO AREA (NombreArea, Pasillo) VALUES ('Carnes','2');
INSERT INTO AREA (NombreArea, Pasillo) VALUES ('Mariscos','2');
INSERT INTO AREA (NombreArea, Pasillo) VALUES ('Lacteos y Derivados','3'); 
INSERT INTO AREA (NombreArea, Pasillo) VALUES ('Embutidos','3'); --
INSERT INTO AREA (NombreArea, Pasillo) VALUES ('Jugos y Bebidas','4'); 
INSERT INTO AREA (NombreArea, Pasillo) VALUES ('Abarrotes','4'); 
INSERT INTO AREA (NombreArea, Pasillo) VALUES ('Panaderia y tortilleria','5');
INSERT INTO AREA (NombreArea, Pasillo) VALUES ('Higiene','6'); 
INSERT INTO AREA (NombreArea, Pasillo) VALUES ('Belleza','6'); 
INSERT INTO AREA (NombreArea, Pasillo) VALUES ('Limpieza','7'); 
INSERT INTO AREA (NombreArea, Pasillo) VALUES ('Mascotas','7'); 
INSERT INTO AREA (NombreArea, Pasillo) VALUES ('Licores','8');


--CAJEROS
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('-','1');
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('-','1');
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('-','2');
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('-','2');
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('-','3');
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('-','3');
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('-','4');
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('-','4');
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('-','5');
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('-','5');

--TipoEmpleado
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('1', 'Gerente' );
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('2', 'Bodegero' );
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('3', 'Cajero' );
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('4', 'Administrador' );
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('5', 'supervisor' );
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('7', 'reponedor' );
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('8', 'guardia' );
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('9', 'empacador' );
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('10', 'carnes' );

--Departamento
Insert into Departamento (NumDpto , Nombre , DniGerente ) values ('1', 'Recursos humanos',NULL);
Insert into Departamento (NumDpto , Nombre , DniGerente ) values ('2', 'Compras',NULL);
Insert into Departamento (NumDpto , Nombre , DniGerente ) values ('3', 'Seguridad',NULL);
Insert into Departamento (NumDpto , Nombre , DniGerente ) values ('4', 'Bodega',NULL);
Insert into Departamento (NumDpto , Nombre , DniGerente ) values ('5', 'Marketing',NULL);
Insert into Departamento (NumDpto , Nombre , DniGerente ) values ('6', 'Contabilidad',NULL);

--Clientes
insert into Cliente (Dni, Nombre, Apellido) values ('49-960-0265', 'Levin', 'Kubanek');
insert into Cliente (Dni, Nombre, Apellido) values ('96-185-9456', 'Tybie', 'Rylance');
insert into Cliente (Dni, Nombre, Apellido) values ('91-011-1724', 'Gordy', 'Nowland');
insert into Cliente (Dni, Nombre, Apellido) values ('85-830-9463', 'Gelya', 'Whorf');
insert into Cliente (Dni, Nombre, Apellido) values ('82-148-2327', 'Asher', 'Pipworth');
insert into Cliente (Dni, Nombre, Apellido) values ('83-456-0057', 'Matthaeus', 'Yellowlee');
insert into Cliente (Dni, Nombre, Apellido) values ('08-212-7282', 'Elga', 'Hildrew');
insert into Cliente (Dni, Nombre, Apellido) values ('27-233-4526', 'Isac', 'Gimbrett');
insert into Cliente (Dni, Nombre, Apellido) values ('60-591-2746', 'Emmalynne', 'Strond');
insert into Cliente (Dni, Nombre, Apellido) values ('65-313-6286', 'Andra', 'Hearley');
insert into Cliente (Dni, Nombre, Apellido) values ('70-990-2113', 'Bale', 'Offer');
insert into Cliente (Dni, Nombre, Apellido) values ('75-756-9278', 'Blair', 'Tybalt');
insert into Cliente (Dni, Nombre, Apellido) values ('64-070-6943', 'Jelene', 'Simioni');
insert into Cliente (Dni, Nombre, Apellido) values ('30-196-9639', 'Emmit', 'Hein');
insert into Cliente (Dni, Nombre, Apellido) values ('93-639-8685', 'Bradan', 'Leyfield');
insert into Cliente (Dni, Nombre, Apellido) values ('06-941-9213', 'Winifield', 'Brunicke');
insert into Cliente (Dni, Nombre, Apellido) values ('25-729-9547', 'Janos', 'Pelman');
insert into Cliente (Dni, Nombre, Apellido) values ('68-035-1462', 'Gino', 'Walden');
insert into Cliente (Dni, Nombre, Apellido) values ('16-788-9033', 'Filia', 'McLane');
insert into Cliente (Dni, Nombre, Apellido) values ('66-632-2622', 'Jenica', 'Hamprecht');
insert into Cliente (Dni, Nombre, Apellido) values ('53-830-2340', 'Johna', 'Gammell');
insert into Cliente (Dni, Nombre, Apellido) values ('22-350-5314', 'Hector', 'Trattles');
insert into Cliente (Dni, Nombre, Apellido) values ('43-970-3441', 'Anabelle', 'Verni');
insert into Cliente (Dni, Nombre, Apellido) values ('89-373-5382', 'Keriann', 'Bautiste');
insert into Cliente (Dni, Nombre, Apellido) values ('37-792-6713', 'John', 'Phette');
insert into Cliente (Dni, Nombre, Apellido) values ('87-976-2529', 'Jillian', 'Goodricke');
insert into Cliente (Dni, Nombre, Apellido) values ('05-000-1023', 'Marve', 'Burrel');
insert into Cliente (Dni, Nombre, Apellido) values ('25-011-0400', 'Clerissa', 'Akenhead');
insert into Cliente (Dni, Nombre, Apellido) values ('57-409-7871', 'Case', 'Rougier');
insert into Cliente (Dni, Nombre, Apellido) values ('87-439-5853', 'Theodore', 'Shallow');
insert into Cliente (Dni, Nombre, Apellido) values ('90-225-7883', 'Aryn', 'Lacaze');
insert into Cliente (Dni, Nombre, Apellido) values ('32-668-3185', 'Tatum', 'Bugs');
insert into Cliente (Dni, Nombre, Apellido) values ('70-768-0155', 'Artair', 'Aaron');
insert into Cliente (Dni, Nombre, Apellido) values ('91-125-3390', 'Perle', 'Galpen');
insert into Cliente (Dni, Nombre, Apellido) values ('20-524-4418', 'Lucine', 'O''Donoghue');
insert into Cliente (Dni, Nombre, Apellido) values ('41-054-7752', 'Shena', 'Danskine');
insert into Cliente (Dni, Nombre, Apellido) values ('52-115-5850', 'Grace', 'Vaughten');
insert into Cliente (Dni, Nombre, Apellido) values ('85-412-5534', 'Rory', 'Buddington');
insert into Cliente (Dni, Nombre, Apellido) values ('40-119-0044', 'Dru', 'Belin');
insert into Cliente (Dni, Nombre, Apellido) values ('34-816-7095', 'Ketty', 'Taylorson');
insert into Cliente (Dni, Nombre, Apellido) values ('55-444-6831', 'Jamie', 'Pittwood');
insert into Cliente (Dni, Nombre, Apellido) values ('90-350-7575', 'Clyve', 'Capelow');
insert into Cliente (Dni, Nombre, Apellido) values ('26-864-3734', 'Tomkin', 'Nuttey');
insert into Cliente (Dni, Nombre, Apellido) values ('04-169-2028', 'Bill', 'Dowell');
insert into Cliente (Dni, Nombre, Apellido) values ('40-123-7143', 'Marcela', 'Wellan');
insert into Cliente (Dni, Nombre, Apellido) values ('12-056-7959', 'Trisha', 'Titchen');
insert into Cliente (Dni, Nombre, Apellido) values ('78-348-1001', 'Jaimie', 'Androli');
insert into Cliente (Dni, Nombre, Apellido) values ('20-837-2208', 'Crissy', 'Waszczykowski');
insert into Cliente (Dni, Nombre, Apellido) values ('70-551-8751', 'Orrin', 'Gippes');
insert into Cliente (Dni, Nombre, Apellido) values ('51-304-5182', 'Jeffie', 'Amiss');
insert into Cliente (Dni, Nombre, Apellido) values ('12-770-4888', 'Chic', 'Baison');
insert into Cliente (Dni, Nombre, Apellido) values ('45-733-6205', 'Robinett', 'Jakoviljevic');
insert into Cliente (Dni, Nombre, Apellido) values ('11-506-9647', 'Kendall', 'Baseggio');
insert into Cliente (Dni, Nombre, Apellido) values ('16-103-8247', 'Wilton', 'Jeacop');
insert into Cliente (Dni, Nombre, Apellido) values ('33-006-5672', 'Eugine', 'Bernardo');
insert into Cliente (Dni, Nombre, Apellido) values ('72-969-5886', 'Dre', 'De Hoogh');
insert into Cliente (Dni, Nombre, Apellido) values ('28-871-1954', 'Turner', 'Meadows');
insert into Cliente (Dni, Nombre, Apellido) values ('59-671-2550', 'Rhoda', 'Grimmer');
insert into Cliente (Dni, Nombre, Apellido) values ('84-434-9060', 'Hermann', 'Peche');
insert into Cliente (Dni, Nombre, Apellido) values ('54-655-7112', 'Carlene', 'Corsar');
insert into Cliente (Dni, Nombre, Apellido) values ('82-616-5417', 'Keefer', 'Sushams');
insert into Cliente (Dni, Nombre, Apellido) values ('62-493-7635', 'Markos', 'Simes');
insert into Cliente (Dni, Nombre, Apellido) values ('71-112-1374', 'Lulu', 'Grzelewski');
insert into Cliente (Dni, Nombre, Apellido) values ('84-806-7543', 'Guthrie', 'Juliff');
insert into Cliente (Dni, Nombre, Apellido) values ('92-158-8671', 'Leoline', 'Roth');
insert into Cliente (Dni, Nombre, Apellido) values ('65-243-1362', 'Omero', 'Boatright');
insert into Cliente (Dni, Nombre, Apellido) values ('91-674-3733', 'Rourke', 'Clorley');
insert into Cliente (Dni, Nombre, Apellido) values ('21-010-0340', 'Maudie', 'Clews');
insert into Cliente (Dni, Nombre, Apellido) values ('23-593-3973', 'Waylan', 'Vicar');
insert into Cliente (Dni, Nombre, Apellido) values ('19-135-5428', 'Fabiano', 'Edelmann');
insert into Cliente (Dni, Nombre, Apellido) values ('80-716-6478', 'Thedric', 'Gunn');
insert into Cliente (Dni, Nombre, Apellido) values ('56-844-3506', 'Carolin', 'Walden');
insert into Cliente (Dni, Nombre, Apellido) values ('44-742-7181', 'Laurent', 'Howsin');
insert into Cliente (Dni, Nombre, Apellido) values ('59-220-7922', 'Javier', 'Betjeman');
insert into Cliente (Dni, Nombre, Apellido) values ('76-076-0275', 'Marysa', 'McVitty');
insert into Cliente (Dni, Nombre, Apellido) values ('31-402-8559', 'Gene', 'Talman');
insert into Cliente (Dni, Nombre, Apellido) values ('80-082-8536', 'Rem', 'Selby');
insert into Cliente (Dni, Nombre, Apellido) values ('71-504-2253', 'Bartlett', 'Gherardesci');
insert into Cliente (Dni, Nombre, Apellido) values ('82-243-7815', 'Kaycee', 'Summerly');
insert into Cliente (Dni, Nombre, Apellido) values ('37-666-2492', 'Tully', 'Davidov');
insert into Cliente (Dni, Nombre, Apellido) values ('19-885-8026', 'Rosamond', 'Kermitt');
insert into Cliente (Dni, Nombre, Apellido) values ('11-188-2640', 'Archibaldo', 'Faveryear');
insert into Cliente (Dni, Nombre, Apellido) values ('32-202-2364', 'Keven', 'Jonson');
insert into Cliente (Dni, Nombre, Apellido) values ('42-179-8857', 'Darn', 'Wison');
insert into Cliente (Dni, Nombre, Apellido) values ('64-793-5827', 'Annmarie', 'Tripett');
insert into Cliente (Dni, Nombre, Apellido) values ('58-777-2369', 'Bernita', 'Kinchin');
insert into Cliente (Dni, Nombre, Apellido) values ('85-721-8260', 'Barbara', 'Gallard');
insert into Cliente (Dni, Nombre, Apellido) values ('83-198-0634', 'Barry', 'Berresford');
insert into Cliente (Dni, Nombre, Apellido) values ('10-749-6558', 'Jessalyn', 'Durtnall');
insert into Cliente (Dni, Nombre, Apellido) values ('41-178-2763', 'Woodie', 'Begbie');
insert into Cliente (Dni, Nombre, Apellido) values ('18-624-3015', 'Flori', 'Heaslip');
insert into Cliente (Dni, Nombre, Apellido) values ('53-702-0587', 'Ruby', 'MacEllen');
insert into Cliente (Dni, Nombre, Apellido) values ('78-160-0723', 'Bay', 'Godbolt');
insert into Cliente (Dni, Nombre, Apellido) values ('25-889-1174', 'Doralynn', 'Haffner');
insert into Cliente (Dni, Nombre, Apellido) values ('52-828-8902', 'Lucilia', 'Huleatt');
insert into Cliente (Dni, Nombre, Apellido) values ('07-899-9230', 'Gino', 'Kincade');
insert into Cliente (Dni, Nombre, Apellido) values ('47-471-2553', 'Gwenny', 'Harte');
insert into Cliente (Dni, Nombre, Apellido) values ('48-004-1339', 'Marcie', 'Hynes');
insert into Cliente (Dni, Nombre, Apellido) values ('41-762-4380', 'Ade', 'Gallant');
insert into Cliente (Dni, Nombre, Apellido) values ('44-530-8437', 'Donall', 'Gostling');

-- Departamentos
INSERT INTO Departamento (NumDpto, Nombre, DniGerente)VALUES ('1', 'Recursos Humanos', '-');
INSERT INTO Departamento (NumDpto, Nombre, DniGerente)VALUES ('2', 'Compras', '-');
INSERT INTO Departamento (NumDpto, Nombre, DniGerente)VALUES ('3', 'Seguridad', '-');
INSERT INTO Departamento (NumDpto, Nombre, DniGerente)VALUES ('4', 'Bodega', '-');
INSERT INTO Departamento (NumDpto, Nombre, DniGerente)VALUES ('5', 'Marketing', '-');
INSERT INTO Departamento (NumDpto, Nombre, DniGerente)VALUES ('6', 'Contabilidad', '-'); 

--Empleados
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('44451', 'Ricardo', 'Nantes', 'Ramos', to_date('04-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 82560, '1', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('01111', 'Pablo', 'Nantes', 'Moroni', to_date('06-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 12560, '6', 44451);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('45454', 'beto', 'videa', 'yani', to_date('05-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 12560, '6',  44451);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('48225', 'jueas', 'pavon', 'juz', to_date('02-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 12560, '6',  44451);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('78155', 'martin', 'yuca', 'ruiz', to_date('05-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 12560, '3', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('48528', 'Carol', 'yuka', 'bengstoni', to_date('12-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 12560, '3', 78155);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('12884', 'Lorena', 'mas', 'roca', to_date('08-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 12560, '6', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('57421', 'miguel', 'gomes', 'rus', to_date('15-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 452560, '6', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('14845', 'jaime', 'dias', 'Moni', to_date('20-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 12560, '6', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('57121', 'Pablo', 'figueroa', 'Moroni', to_date('09-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 112560, '6', 44451);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('32542', 'diego', 'Nantes', 'mendezi', to_date('05-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 44560, '4',NULL );
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('51212', 'lucas', 'Nantes', 'Moroni', to_date('04-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 12560, '4', 57121);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('15421', 'mateo', 'Nantes', 'Ramos', to_date('01-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 45545, '5', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('21121', 'anita', 'Nantes', 'Mola', to_date('02-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '1', 12560, '5', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('21212', 'Karen', 'Nantes', 'Mendoza', to_date('03-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Nucturna', '1', 12560, '6', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('15454', 'Andrea', 'Nantes', 'medina', to_date('04-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '1', 12560, '5', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('013333', 'Pedro', 'Juarez', 'Zenon', to_date('07-MAY-01','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '2', 12560, '5', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('02111', 'Alexa', 'Niquel', 'Medina', to_date('05-abr-99','DD-MON-RR'),'F', 'Tegucigalpa', 'Diurna', '3', 12000, '3', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('33111', 'Mario', 'Fernandez', 'Ramirez', to_date('02-DEC-91','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '4', 12560, '3', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('01331', 'Jeremias', 'Ledesma', 'Castillo', to_date('17-JUN-02','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '3', 12570, '2', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('01661', 'Fernanda', 'Lopez', 'Obrador', to_date('02-JUL-95','DD-MON-RR'),'f', 'Tegucigalpa', 'Diurna', '4', 12580, '2', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('07711', 'Pablo', 'Nantes', 'Moroni', to_date('07-JUN-89','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '3', 12680, '2', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('09911', 'Francisco', 'Mejia', 'robert', to_date('14-JUN-78','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '2', 13560, '6', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('12211', 'Ramiro', 'Nantes', 'Moroni', to_date('22-feb-03','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '3', 16560, '4', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('51181', 'Heber', 'Nantes', 'Moroni', to_date('14-Nov-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '6', 17560, '5', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('52051', 'Omar', 'Castro', 'Pineda', to_date('17-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '4', 12560, '6', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('45622', 'jueas', 'pavon', 'juz', to_date('02-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '6', 12560, '4', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('45544', 'martin', 'yuca', 'ruiz', to_date('05-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '5', 12560, '2', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('2544', 'Soniam', 'yamir', 'bengston', to_date('12-JUN-20','DD-MON-RR'),'F', 'Tegucigalpa', 'Diurna', '1', 12560, '6', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('78884', 'Loren', 'Garcia', 'Umanzor', to_date('45-JUN-20','DD-MON-RR'),'F', 'Tegucigalpa', 'Diurna', '1', 12560, '4', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('27421', 'miguel', 'gomes', 'rus', to_date('15-JUN-20','DD-MON-RR'),'F', 'Tegucigalpa', 'Diurna', '1', 452560, '4', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('52121', 'Pablo', 'figueroa', 'Batanco', to_date('09-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '2', 12560, '6', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('32682', 'diego', 'segovia', 'mendez', to_date('05-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '6', 4560, '6', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('52252', 'lucas', 'Medina', 'Moroni', to_date('04-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '4', 12560, '6', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('42422', 'mateo', 'Videa', 'Ramos', to_date('01-JUN-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '3', 45545, '6', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('51251', 'Juanita', 'Rosa', 'Mola', to_date('02-JUN-20','DD-MON-RR'),'F', 'Tegucigalpa', 'Nocturna', '4', 12560, '6', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('42012', 'Yolibeth', 'Walker', 'Mendoza', to_date('03-JUN-20','DD-MON-RR'),'f', 'Tegucigalpa', 'Nucturna', '3', 12560, '6', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('1144', 'Andreina', 'Sky', 'medina', to_date('04-JUN-20','DD-MON-RR'),'F', 'Tegucigalpa', 'Nocturna', '2', 12560, '6', NULL);4
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('02433', 'Pedro', 'Juarez', 'Zenon', to_date('07-MAY-01','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '5', 12560, '5', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('07891', 'Alexa', 'Niquel', 'Medina', to_date('05-abr-99','DD-MON-RR'),'F', 'Tegucigalpa', 'Diurna', '6', 12000, '2', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('14411', 'Marto', 'Adonis', 'Ramirez', to_date('02-DEC-91','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '4', 12560, '3', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('04541', 'Jeremias', 'Ledesma', 'Castillo', to_date('17-JUN-02','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '3', 12570, '2', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('75221', 'Fernanda', 'Lopez', 'Obrador', to_date('02-JUL-95','DD-MON-RR'),'F', 'SPS', 'Diurna', '4', 12580, '4', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('07821', 'Pablo', 'sion', 'blandoi', to_date('07-JUN-89','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '7', 12680, '4', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('17871', 'carlos', 'amsa', 'robert', to_date('14-JUN-78','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '2', 13560, '6', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('13371', 'Rmson', 'Ness', 'Moroni', to_date('22-feb-03','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '8', 16560, '4', NULL);
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('51181' 'Heber', 'Norl', 'Moroni', to_date('14-Nov-20','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '9', 17560, '5', NULL);

--TelefonoEmpleado
insert into TelefonoEmpleado (Dni, Telefono) values ('51181', '176-647-1405');
insert into TelefonoEmpleado (Dni, Telefono) values ('13371', '190-709-4772');
insert into TelefonoEmpleado (Dni, Telefono) values ('17871', '870-676-1940');
insert into TelefonoEmpleado (Dni, Telefono) values ('07821', '409-925-5975');
insert into TelefonoEmpleado (Dni, Telefono) values ('75221', '455-130-2219');
insert into TelefonoEmpleado (Dni, Telefono) values ('04541', '490-490-3273');
insert into TelefonoEmpleado (Dni, Telefono) values ('14411', '281-949-7275');
insert into TelefonoEmpleado (Dni, Telefono) values ('07891', '922-798-4734');
insert into TelefonoEmpleado (Dni, Telefono) values ('02433', '998-207-1033');
insert into TelefonoEmpleado (Dni, Telefono) values ('1144', '260-864-1350');
insert into TelefonoEmpleado (Dni, Telefono) values ('42012', '437-467-8867');
insert into TelefonoEmpleado (Dni, Telefono) values ('51251', '425-990-1156');
insert into TelefonoEmpleado (Dni, Telefono) values ('42422', '177-798-3184');
insert into TelefonoEmpleado (Dni, Telefono) values ('52252', '286-916-5997');
insert into TelefonoEmpleado (Dni, Telefono) values ('32682', '950-284-6065');
insert into TelefonoEmpleado (Dni, Telefono) values ('52121', '399-501-1001');
insert into TelefonoEmpleado (Dni, Telefono) values ('27421', '877-153-0477');
insert into TelefonoEmpleado (Dni, Telefono) values ('78884', '967-748-1900');
insert into TelefonoEmpleado (Dni, Telefono) values ('2544', '261-722-8027');
insert into TelefonoEmpleado (Dni, Telefono) values ('45544', '822-775-6146');
insert into TelefonoEmpleado (Dni, Telefono) values ('45622', '187-309-2349');
insert into TelefonoEmpleado (Dni, Telefono) values ('52051', '276-858-9862');
insert into TelefonoEmpleado (Dni, Telefono) values ('51181', '755-937-9815');
insert into TelefonoEmpleado (Dni, Telefono) values ('12211', '203-104-5663');
insert into TelefonoEmpleado (Dni, Telefono) values ('09911', '709-828-4781');
insert into TelefonoEmpleado (Dni, Telefono) values ('07711', '903-970-1358');
insert into TelefonoEmpleado (Dni, Telefono) values ('01661', '405-737-2833');
insert into TelefonoEmpleado (Dni, Telefono) values ('01331', '118-291-3687');
insert into TelefonoEmpleado (Dni, Telefono) values ('33111', '601-876-7041');
insert into TelefonoEmpleado (Dni, Telefono) values ('02111', '376-386-6541');
insert into TelefonoEmpleado (Dni, Telefono) values ('013333', '514-772-2116');
insert into TelefonoEmpleado (Dni, Telefono) values ('15454', '429-939-0915');
insert into TelefonoEmpleado (Dni, Telefono) values ('21212', '307-376-8463');
insert into TelefonoEmpleado (Dni, Telefono) values ('21121', '894-941-2081');
insert into TelefonoEmpleado (Dni, Telefono) values ('15421', '690-399-3804');
insert into TelefonoEmpleado (Dni, Telefono) values ('51212', '367-652-3200');
insert into TelefonoEmpleado (Dni, Telefono) values ('32542', '427-258-0535');
insert into TelefonoEmpleado (Dni, Telefono) values ('57121', '718-784-4339');
insert into TelefonoEmpleado (Dni, Telefono) values ('14845', '161-571-3565');
insert into TelefonoEmpleado (Dni, Telefono) values ('57421', '592-885-3540');
insert into TelefonoEmpleado (Dni, Telefono) values ('12884', '402-105-4009');
insert into TelefonoEmpleado (Dni, Telefono) values ('48528', '961-325-9844');
insert into TelefonoEmpleado (Dni, Telefono) values ('78155', '941-412-7670');
insert into TelefonoEmpleado (Dni, Telefono) values ('48225', '388-550-9089');
insert into TelefonoEmpleado (Dni, Telefono) values ('45454', '661-615-6396');
insert into TelefonoEmpleado (Dni, Telefono) values ('01111', '366-185-9569');
insert into TelefonoEmpleado (Dni, Telefono) values ('44451', '553-270-1173');

--Proveedor
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('1', 'Wahaha', 'Natal', 'Mosconi', 'Fuling');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('2', 'Fortune', 'Norman', 'Moakler', 'Ust’-Isha');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('3', 'Olay', 'Selby', 'Kendall', 'Oklahoma City');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('4', 'Whiskas', 'Nick', 'Londors', 'Lam Sonthi');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('5', 'Clinique', 'Lesya', 'Ladbury', 'Banjar Susut Kaja');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('6', 'Quaker', 'Elyse', 'Brundale', 'Skoútari');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('7', 'Georgia', 'Felisha', 'Napoleon', 'Zapala');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('8', 'Oreo', 'Betta', 'Robrose', 'Allanridge');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('9', 'Amul', 'Brandy', 'Penkethman', 'Vera Cruz');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('10', 'Nutrilite', 'Xenia', 'Callan', 'Arroyo Naranjo');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('11', 'Cheetos', 'Lamar', 'Glentz', 'Hamilton');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('12', 'Shineway', 'Emmet', 'MacUchadair', 'Järna');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('13', 'Bath & Body Works', 'Maible', 'Mattke', 'Bratislava');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('14', 'Rexona', 'Esme', 'McCarlich', 'Santiago de Cao');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('15', 'Starbucks', 'Willey', 'Jewise', 'Kabakovo');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('16', 'Christian Dior', 'Amelina', 'Olin', 'Ribeira');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('17', 'Dr Pepper', 'Barnabas', 'Benoy', 'Daphu');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('18', 'Palmolive', 'Mellisent', 'Lusgdin', 'Hihy?');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('19', 'Purina Friskies', 'Ambur', 'Spittal', 'Saint-Louis du Nord');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('20', 'Pringles', 'Bambi', 'O''Gavin', 'Libertad');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('21', 'Neutrogena', 'Tynan', 'Galliver', 'Loimaan Kunta');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('22', 'Président', 'Alon', 'German', 'Diébougou');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('23', 'Snickers', 'Gottfried', 'Hourahan', 'Sydney');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('24', 'Similac', 'Zebulen', 'Gribbon', 'Sepulu');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('25', 'Hersheys', 'Engelbert', 'Shadfourth', 'Las Palmas');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('26', 'Barilla', 'Ferdie', 'Curling', 'Tuwiri Wetan');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('27', 'Charmin', 'Stavros', 'Sorel', 'Loay');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('28', 'Persil', 'Hetty', 'Catteroll', 'Cosmópolis');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('29', 'Yoplait', 'Darbie', 'Marzelli', 'Ciparay');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('30', 'Boss', 'Melvyn', 'Barnsley', 'Erétria');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('31', 'Enfamil', 'Amy', 'Pentycross', 'Inuvik');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('32', 'Danone', 'Dody', 'Laying', 'La Gloria');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('33', 'Arla', 'Pearla', 'Liffey', 'Shubenka');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('34', 'Milka', 'Reynold', 'Maxwaile', 'Itapecerica da Serra');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('35', 'Yamazaki', 'Emmy', 'Sheddan', 'Aldeia da Piedade');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('36', 'Bimbo', 'Nehemiah', 'Shrimpton', 'Prost?ední Be?va');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('37', 'Garnier', 'Dayle', 'Iacoboni', 'Tarouca');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('38', 'Knorr', 'Cherianne', 'Scemp', 'Al Qur?');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('39', 'Pedigree', 'Kevon', 'Janouch', 'F?r?z?b?d');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('40', 'Lipton', 'Missy', 'Wort', 'Solana');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('41', 'Oscar Mayer', 'Korey', 'Calven', 'Kampong Cham');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('42', 'Shiseido', 'Elissa', 'Humphrey', 'Dahe');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('43', 'Gemey', 'Jaymee', 'Padillo', 'Philadelphia');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('44', 'Natura', 'Claudia', 'Regelous', 'Guaraciaba do Norte');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('45', 'Doritos', 'Butch', 'Wetherill', 'K?nosu');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('46', 'Pantene', 'Tanner', 'Bowich', 'Klavdiyevo-Tarasove');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('47', 'Heinz', 'Pat', 'Betham', 'Abuyog');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('48', 'Nutricia', 'Bess', 'Haliday', 'Cali');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('49', 'Minute Maid', 'Gal', 'Bedle', 'Wiyayu Barat');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('50', 'Lancôme', 'Corissa', 'Innman', 'Kibondo');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('51', 'Herbalife', 'Austine', 'Grimolbie', 'Qiaole');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('52', 'Activia', 'Eyde', 'Hanmore', 'Chile Chico');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('53', 'Kleenex', 'Dorie', 'Hegerty', 'Lagoa de Albufeira');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('54', 'Yakult', 'Elene', 'Dilke', 'Longtou');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('55', 'Mary Kay', 'Gabriele', 'Titman', 'Kezilei');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('56', 'Omo', 'Karel', 'Eckert', 'Limeil-Brévannes');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('57', 'Coca-Cola Zero', 'Wilhelmine', 'Pruce', 'Xikou');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('58', 'Oral-B', 'Bili', 'Edelheit', 'Lanshan');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('59', 'Nestlé', 'Lorelle', 'Bywaters', 'Yeniugou');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('60', 'Maggi', 'Francine', 'Cowtherd', 'Bogdaniec');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('61', 'Johnson', 'Marylee', 'Ferryn', 'Guapimirim');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('62', 'Estée Lauder', 'Shaylah', 'Dawe', 'Canedo');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('63', 'Jiaduobao', 'Koressa', 'Mouncey', 'Betong');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('64', 'Mountain Dew', 'Derrick', 'Jeffree', 'Palca');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('65', 'Chanel', 'Mitchael', 'Arnholz', 'Rantepang');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('66', 'M&M', 'Caryn', 'Gozard', 'Naperville');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('67', 'Nespresso', 'Arliene', 'Broadey', 'Nor Yerznka');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('68', 'Nissin', 'Cale', 'Orsi', 'Glagahdowo');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('69', 'Tropicana', 'Sibylla', 'Murrie', 'Yangyu');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('70', 'Always', 'Louisa', 'Mancer', 'Kalianyar Selatan');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('71', 'Head & Shoulders', 'Jacques', 'Watt', 'Non Sang');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('72', '7-Up', 'Gib', 'Allderidge', 'Amsterdam Westpoort');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('73', 'Coca-Cola', 'Nancee', 'Hardiker', 'Steinkjer');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('74', 'Pepsi', 'Clayborn', 'Bagnell', 'Qiaozhen');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('75', 'Nescafé', 'Arnoldo', 'De Francesco', 'Taloko');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('76', 'Lay-s', 'Rafaelita', 'Hedling', 'Göteborg');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('77', 'LOreal Paris', 'Shalne', 'Jacmar', 'Adamantina');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('78', 'Red Bull', 'Blakeley', 'Feaver', 'Fenyan');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('79', 'Pampers', 'Vally', 'Walkley', 'Longshan');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('80', 'Tide', 'Gregorius', 'Grewar', 'Abuyog');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('81', 'Ariel', 'Tootsie', 'Glave', 'Klapagada');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('82', 'Nivea', 'Lorri', 'Bonhan', 'Alexandria');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('83', 'Huggies', 'Editha', 'Savege', 'Cruz de Pau');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('84', 'Colgate', 'Marsh', 'Mervyn', 'Calvinia');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('85', 'Master Kong', 'Tiffie', 'Pittet', 'Velikiye Borki');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('86', 'Sprite', 'Rey', 'Cratchley', 'Baochang');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('87', 'Gillette', 'Elisabet', 'Pirrie', 'San Isidro');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('88', 'Kelloggs', 'Fowler', 'Hallawell', 'Malumfashi');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('89', 'Mengniu', 'Cori', 'Kenan', 'Anning');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('90', 'Gatorade', 'Chance', 'Brogden', 'Huskvarna');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('91', 'Yili', 'Merry', 'Philippon', 'Nangahale');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('92', 'Diet Coke', 'Vaclav', 'Boch', 'Horní Cerekev');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('93', 'Fanta', 'Ashlan', 'Salla', 'Tabaquite');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('94', 'Avon', 'Darlleen', 'MacCosto', 'Kuantan');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('95', 'Dove', 'Galven', 'Hexum', 'At Tibn?');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('96', 'Wrigleys', 'Lari', 'Gaddas', 'Vitina');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('97', 'Arawana', 'Geoffry', 'Boycott', 'Gaomiaoji');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('98', 'Monster', 'Garrot', 'Ruby', 'La Motte-Servolex');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('99', 'Kraft', 'Zonda', 'Guest', 'Liutang');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('100', 'Cadbury', 'Benoite', 'Spurret', 'Huangdu');

--TelefonoProveedor
insert into TelefonoProveedor (CodProv, Telefono) values ('1', '611-4584');
insert into TelefonoProveedor (CodProv, Telefono) values ('2', '530-7516');
insert into TelefonoProveedor (CodProv, Telefono) values ('3', '223-5452');
insert into TelefonoProveedor (CodProv, Telefono) values ('4', '336-6670');
insert into TelefonoProveedor (CodProv, Telefono) values ('5', '583-6131');
insert into TelefonoProveedor (CodProv, Telefono) values ('6', '690-6475');
insert into TelefonoProveedor (CodProv, Telefono) values ('7', '931-5920');
insert into TelefonoProveedor (CodProv, Telefono) values ('8', '585-2362');
insert into TelefonoProveedor (CodProv, Telefono) values ('9', '379-9532');
insert into TelefonoProveedor (CodProv, Telefono) values ('10', '963-0649');
insert into TelefonoProveedor (CodProv, Telefono) values ('11', '581-4507');
insert into TelefonoProveedor (CodProv, Telefono) values ('12', '679-0500');
insert into TelefonoProveedor (CodProv, Telefono) values ('13', '751-9462');
insert into TelefonoProveedor (CodProv, Telefono) values ('14', '925-3305');
insert into TelefonoProveedor (CodProv, Telefono) values ('15', '779-3349');
insert into TelefonoProveedor (CodProv, Telefono) values ('16', '681-8454');
insert into TelefonoProveedor (CodProv, Telefono) values ('17', '620-2984');
insert into TelefonoProveedor (CodProv, Telefono) values ('18', '871-1653');
insert into TelefonoProveedor (CodProv, Telefono) values ('19', '233-7369');
insert into TelefonoProveedor (CodProv, Telefono) values ('20', '878-1760');
insert into TelefonoProveedor (CodProv, Telefono) values ('21', '467-8237');
insert into TelefonoProveedor (CodProv, Telefono) values ('22', '533-5550');
insert into TelefonoProveedor (CodProv, Telefono) values ('23', '327-5477');
insert into TelefonoProveedor (CodProv, Telefono) values ('24', '526-0816');
insert into TelefonoProveedor (CodProv, Telefono) values ('25', '710-2856');
insert into TelefonoProveedor (CodProv, Telefono) values ('26', '613-4738');
insert into TelefonoProveedor (CodProv, Telefono) values ('27', '103-4235');
insert into TelefonoProveedor (CodProv, Telefono) values ('28', '917-6023');
insert into TelefonoProveedor (CodProv, Telefono) values ('29', '755-3923');
insert into TelefonoProveedor (CodProv, Telefono) values ('30', '795-3154');
insert into TelefonoProveedor (CodProv, Telefono) values ('31', '580-3918');
insert into TelefonoProveedor (CodProv, Telefono) values ('32', '771-8330');
insert into TelefonoProveedor (CodProv, Telefono) values ('33', '264-7160');
insert into TelefonoProveedor (CodProv, Telefono) values ('34', '752-8070');
insert into TelefonoProveedor (CodProv, Telefono) values ('35', '135-5576');
insert into TelefonoProveedor (CodProv, Telefono) values ('36', '261-2313');
insert into TelefonoProveedor (CodProv, Telefono) values ('37', '868-7088');
insert into TelefonoProveedor (CodProv, Telefono) values ('38', '641-6679');
insert into TelefonoProveedor (CodProv, Telefono) values ('39', '582-0885');
insert into TelefonoProveedor (CodProv, Telefono) values ('40', '374-4761');
insert into TelefonoProveedor (CodProv, Telefono) values ('41', '147-2611');
insert into TelefonoProveedor (CodProv, Telefono) values ('42', '162-8072');
insert into TelefonoProveedor (CodProv, Telefono) values ('43', '935-0650');
insert into TelefonoProveedor (CodProv, Telefono) values ('44', '225-8057');
insert into TelefonoProveedor (CodProv, Telefono) values ('45', '620-1892');
insert into TelefonoProveedor (CodProv, Telefono) values ('46', '855-8941');
insert into TelefonoProveedor (CodProv, Telefono) values ('47', '852-4237');
insert into TelefonoProveedor (CodProv, Telefono) values ('48', '429-0512');
insert into TelefonoProveedor (CodProv, Telefono) values ('49', '998-1031');
insert into TelefonoProveedor (CodProv, Telefono) values ('50', '915-8052');
insert into TelefonoProveedor (CodProv, Telefono) values ('51', '769-0652');
insert into TelefonoProveedor (CodProv, Telefono) values ('52', '266-2637');
insert into TelefonoProveedor (CodProv, Telefono) values ('53', '656-3014');
insert into TelefonoProveedor (CodProv, Telefono) values ('54', '421-0871');
insert into TelefonoProveedor (CodProv, Telefono) values ('55', '617-1227');
insert into TelefonoProveedor (CodProv, Telefono) values ('56', '240-4830');
insert into TelefonoProveedor (CodProv, Telefono) values ('57', '473-9084');
insert into TelefonoProveedor (CodProv, Telefono) values ('58', '884-6369');
insert into TelefonoProveedor (CodProv, Telefono) values ('59', '218-0990');
insert into TelefonoProveedor (CodProv, Telefono) values ('60', '856-2783');
insert into TelefonoProveedor (CodProv, Telefono) values ('61', '647-3187');
insert into TelefonoProveedor (CodProv, Telefono) values ('62', '418-3131');
insert into TelefonoProveedor (CodProv, Telefono) values ('63', '182-5043');
insert into TelefonoProveedor (CodProv, Telefono) values ('64', '115-7972');
insert into TelefonoProveedor (CodProv, Telefono) values ('65', '611-3067');
insert into TelefonoProveedor (CodProv, Telefono) values ('66', '394-7455');
insert into TelefonoProveedor (CodProv, Telefono) values ('67', '715-0102');
insert into TelefonoProveedor (CodProv, Telefono) values ('68', '349-4630');
insert into TelefonoProveedor (CodProv, Telefono) values ('69', '268-3769');
insert into TelefonoProveedor (CodProv, Telefono) values ('70', '810-5114');
insert into TelefonoProveedor (CodProv, Telefono) values ('71', '446-3036');
insert into TelefonoProveedor (CodProv, Telefono) values ('72', '325-4922');
insert into TelefonoProveedor (CodProv, Telefono) values ('73', '637-4794');
insert into TelefonoProveedor (CodProv, Telefono) values ('74', '554-5358');
insert into TelefonoProveedor (CodProv, Telefono) values ('75', '408-4293');
insert into TelefonoProveedor (CodProv, Telefono) values ('76', '446-6367');
insert into TelefonoProveedor (CodProv, Telefono) values ('77', '802-8186');
insert into TelefonoProveedor (CodProv, Telefono) values ('78', '406-2600');
insert into TelefonoProveedor (CodProv, Telefono) values ('79', '124-2638');
insert into TelefonoProveedor (CodProv, Telefono) values ('80', '417-1141');
insert into TelefonoProveedor (CodProv, Telefono) values ('81', '780-7472');
insert into TelefonoProveedor (CodProv, Telefono) values ('82', '581-2287');
insert into TelefonoProveedor (CodProv, Telefono) values ('83', '197-5418');
insert into TelefonoProveedor (CodProv, Telefono) values ('84', '404-8202');
insert into TelefonoProveedor (CodProv, Telefono) values ('85', '582-8630');
insert into TelefonoProveedor (CodProv, Telefono) values ('86', '836-7650');
insert into TelefonoProveedor (CodProv, Telefono) values ('87', '216-3616');
insert into TelefonoProveedor (CodProv, Telefono) values ('88', '368-0289');
insert into TelefonoProveedor (CodProv, Telefono) values ('89', '610-4958');
insert into TelefonoProveedor (CodProv, Telefono) values ('90', '862-9203');
insert into TelefonoProveedor (CodProv, Telefono) values ('91', '343-3416');
insert into TelefonoProveedor (CodProv, Telefono) values ('92', '906-9945');
insert into TelefonoProveedor (CodProv, Telefono) values ('93', '710-7291');
insert into TelefonoProveedor (CodProv, Telefono) values ('94', '652-4300');
insert into TelefonoProveedor (CodProv, Telefono) values ('95', '939-4199');
insert into TelefonoProveedor (CodProv, Telefono) values ('96', '950-9711');
insert into TelefonoProveedor (CodProv, Telefono) values ('97', '267-0975');
insert into TelefonoProveedor (CodProv, Telefono) values ('98', '868-2097');
insert into TelefonoProveedor (CodProv, Telefono) values ('99', '207-8534');
insert into TelefonoProveedor (CodProv, Telefono) values ('100', '760-2075');

-- Otros registros para que algunos Proveedores posean 2 telefonos
insert into TelefonoProveedor (CodProv, Telefono) values ('90', '862-9893');
insert into TelefonoProveedor (CodProv, Telefono) values ('91', '343-3646');
insert into TelefonoProveedor (CodProv, Telefono) values ('92', '676-9785');
insert into TelefonoProveedor (CodProv, Telefono) values ('93', '235-7961');
insert into TelefonoProveedor (CodProv, Telefono) values ('94', '667-9860');
insert into TelefonoProveedor (CodProv, Telefono) values ('95', '945-7839');

--Factura
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('60505-2865','49-960-0265','Tarjeta', 7548.78, '1958-05-31','04541');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('42254-023','96-185-9456','Tarjeta', 1389.1, '1977-10-21','04541');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('13537-434','91-011-1724','Credito', 8273.82, '2001-09-25','04541');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('10742-8582','85-830-9463','Credito', 8073.88, '1968-11-04','04541');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('37000-069','82-148-2327','Tarjeta', 6239.7, '1964-12-18','04541');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('52959-772','83-456-0057','Credito', 7805.15, '2008-10-21','04541');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('57237-066','08-212-7282','Tarjeta', 1993.17, '2006-02-20','04541');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('52125-534','27-233-4526','Credito', 1878.96, '1996-10-21','04541');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('33342-026','60-591-2746','Tarjeta', 4826.46, '1963-06-01','04541');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('60232-2290','65-313-6286','Credito', 8564.31, '2001-01-29','42012');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('14783-328','70-990-2113','Tarjeta', 3289.49, '1970-06-08','42012');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('37205-637','75-756-9278','Credito', 2337.24, '1984-09-26','42012');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('55289-315','64-070-6943','Tarjeta', 7239.5, '1979-04-12','42012');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('53877-009','30-196-9639','Credito', 7533.89, '1983-03-01','42012');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('62011-0012','93-639-8685','Tarjeta', 2667.0, '1960-06-19','42012');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('49653-001','06-941-9213','Credito', 2648.04, '1997-12-17','42422');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('55111-166','25-729-9547','Tarjeta', 124.85, '1973-07-15','42422');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('16590-416','68-035-1462','Credito', 7642.45, '1979-01-30','42422');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0093-7304','16-788-9033','Tarjeta', 433.99, '1952-01-19','42422');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0009-0039','66-632-2622','Credito', 7318.96, '1996-10-17','42422');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('64720-153','53-830-2340','Tarjeta', 3285.77, '1956-04-09','42422');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('68016-115','22-350-5314', 'Tarjeta', 6201.33, '1973-03-22','42422');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('58060-002','43-970-3441','Credito', 3277.91, '1954-09-02','42422');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('52270-001','89-373-5382','Credito', 9698.3, '1982-03-08','42422');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0299-5908','37-792-6713','Tarjeta', 2874.93, '1968-07-29','12211');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('52125-248','87-976-2529','Credito', 8582.12, '1992-02-08','12211');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('11523-4140','05-000-1023','Credito', 7780.9, '1999-01-30','12211');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('52959-558','25-011-0400','Tarjeta', 7773.68, '1983-02-10','12211');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('31511-008','57-409-7871','Credito', 9482.61, '1975-06-28','12211');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('60429-174','87-439-5853','Tarjeta', 7903.88, '1950-08-05','12211');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('10893-083','90-225-7883','Credito', 391.72, '1951-11-03','12211');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0024-5810','32-668-3185','Tarjeta', 5609.69, '1995-10-10','12211');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('54868-0736','70-768-0155','Credito', 8047.62, '1972-12-08','12211');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('36987-3012','91-125-3390','Credito', 6149.11, '1978-11-19','12211');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('24471-200','20-524-4418','Credito', 6700.76, '1951-01-22','12211');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('55154-8255','41-054-7752','Credito', 6994.45, '1951-05-06','12211');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('68788-9702','52-115-5850','Tarjeta', 2382.87, '1983-09-18','12211');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('36987-3046','85-412-5534','Tarjeta', 5972.59, '1958-07-04','07711');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('55111-441','40-119-0044','Tarjeta', 7507.78, '1959-04-19,'07711'');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('54868-2149','34-816-7095','Tarjeta', 6568.45, '1968-06-10','07711');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('54973-2911','55-444-6831','Tarjeta', 7960.28, '1991-07-04','07711');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('64942-1059','90-350-7575','Tarjeta', 5093.43, '1992-08-13','07711');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('98132-725','26-864-3734','Tarjeta',8251.17, '2010-09-07','07711');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('67777-244','04-169-2028','Credito', 342.14, '1997-05-05','07711');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('52642-010','40-123-7143','Credito', 9788.23, '1950-09-16','07711');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('76187-850','12-056-7959','Credito', 6831.39, '1977-02-07','07711');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('37000-613','78-348-1001','Credito', 630.55, '1979-07-03','07711');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0615-7656','20-837-2208', 'Tarjeta',4505.54, '1999-11-20','07711');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('48951-8080','70-551-8751','Credito', 2838.06, '1990-06-06','07711');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('60512-6997','51-304-5182','Credito', 171.4, '1991-09-16','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('68472-104','12-770-4888','Tarjeta', 1343.19, '1989-12-21','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('50268-512','45-733-6205','Credito', 3644.69, '1970-03-21','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0485-0208','11-506-9647','Tarjeta', 3970.98, '1982-05-28','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('75981-210','16-103-8247','Credito', 4665.7, '1966-05-02','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('54868-5826','33-006-5672','Tarjeta', 1827.87, '2010-10-27','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('51079-385','72-969-5886','Tarjeta', 6832.68, '1998-05-28','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('51345-111','28-871-1954','Tarjeta', 7575.3, '1979-04-18','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('36987-2504','59-671-2550','Tarjeta', 9448.29, '1995-10-21','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('58443-0034','84-434-9060','Tarjeta', 7976.41, '1988-08-21','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('54569-2411','54-655-7112','Tarjeta', 8875.78, '2007-04-02','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0187-5525','82-616-5417','Tarjeta', 969.39, '1968-09-17','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0085-1279','62-493-7635','Tarjeta', 8061.65, '1955-09-04','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0615-7607','71-112-1374','Tarjeta', 3010.21, '1985-11-22','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('49643-113','84-806-7543','Tarjeta', 7248.66, '2010-02-18','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('54973-2158','92-158-8671','Tarjeta', 2562.1, '1965-09-23','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0135-0510','65-243-1362','Tarjeta', 8076.15, '1989-11-02','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('14290-377','91-674-3733','Tarjeta', 1129.45, '1952-04-01','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('75854-302','21-010-0340','Tarjeta', 5790.05, '1989-06-12','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('36987-3112','23-593-3973','Tarjeta', 7629.57, '1956-09-30','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0573-0169','19-135-5428','Tarjeta', 1175.46, '1966-11-29','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('43406-0112','80-716-6478','Tarjeta', 8615.51, '1963-01-30','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('16729-043','56-844-3506','Tarjeta', 2809.71, '1982-10-07','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0378-6410','44-742-7181','Tarjeta', 1933.03, '1980-03-27','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('42507-282','59-220-7922','Tarjeta', 4577.66, '1992-04-25','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('75981-602','76-076-0275','Tarjeta', 3487.2, '1998-10-28','01331');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('54973-0622','31-402-8559','Tarjeta', 4510.79, '1982-05-20','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('55154-2710','80-082-8536','Tarjeta', 3087.46, '1952-01-20','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('55289-523','71-504-2253','Tarjeta', 9658.48, '1967-05-08','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('42549-615','82-243-7815','Tarjeta', 6205.83, '1956-07-28','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('52137-1001','37-666-2492','Tarjeta', 525.8, '1969-04-01','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('49643-105','19-885-8026','Credito', 7350.92, '1977-11-15','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0093-5141','11-188-2640','Credito', 4977.16, '2005-01-23','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('59262-262','32-202-2364','Credito', 2934.98, '1965-12-27','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('49884-311','42-179-8857','Credito', 7741.28, '2011-07-09','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('63736-410','64-793-5827','Credito', 5694.13, '1980-09-10','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('66336-147','58-777-2369','Credito', 7077.99, '1953-09-16','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('44911-0117','85-721-8260','Credito', 702.4, '1988-03-17','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('59746-338','83-198-0634','Credito', 4689.03, '1961-01-29','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('64942-1287','10-749-6558','Credito', 6162.0, '1975-03-28','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('60505-3276','41-178-2763','Credito', 7977.2, '2007-09-08','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('55154-2418','18-624-3015','Credito', 5087.43, '1953-07-15','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('16729-212','53-702-0587','Credito', 3324.84, '2004-01-20','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('68258-6972','78-160-0723','Credito', 3635.17, '1988-05-05','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('48951-1219','25-889-1174','Credito', 9552.64, '1970-05-18','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('59900-120','52-828-8902','Credito', 4382.61, '2010-05-13','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('31720-209','07-899-9230','Credito', 2510.43, '1974-09-06','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0178-0821','47-471-2553','Credito', 7877.28, '1984-12-04','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('49967-699','48-004-1339','Credito', 9480.32, '1987-05-10','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0603-6150','41-762-4380','Credito', 4782.58, '1969-01-22','02111');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('41520-361','44-530-8437','Credito', 4823.61, '1997-07-21','02111');

--Detalle Factura
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('60505-2865','894834','2540610000000', 7,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('60505-2865','894834','7422540015611', 3,54);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('42254-023','831819','2572780000009', 4,91);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('42254-023','831819','7421000812012', 8,84);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('13537-434','726245','2545620000002', 5,91);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('13537-434','726245','0795893101414', 10,1);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('10742-8582','374002','0795893410110', 1,24);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('10742-8582','374002','2540830000002', 4,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('37000-069','243943','0000000040501', 5,65);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('37000-069','243943','0795893301319', 10,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52959-772','938692','2540160000000', 6,45);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52959-772','938692','7441008169857', 1,56);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('57237-066','738402','0000000071963', 2,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('57237-066','738402','7406131001870', 6,65);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52125-534', '478905','2540930000001', 2,76);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52125-534','478905','7441078230150', 7,92);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('33342-026','925863','0000000040716', 3,74);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('33342-026','925863','7441078224395', 7,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('60232-2290','86926','0000000048996', 4,92);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('60232-2290','86926','7441078228980', 6,74);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('14783-328','95425','428630102117', 1,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('14783-328','95425','7406131004789', 1,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('37205-637','146371','2571530000009', 5,45);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('37205-637','146371','7441008162278', 2,45);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55289-315','482048','0000000044332', 5,25);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55289-315','482048','7441078229130', 5,24);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('53877-009','768522','0000000071789', 4,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('53877-009','768522','7501072210302', 4,93);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('62011-0012','314958','2533830000004', 3,32);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('62011-0012','314958','0023100041049', 3,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('49653-001','494141','7421000811367', 3,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('49653-001''494141','7411000315033', 8,92);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55111-166','462420','7421000840817', 7,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55111-166','462420','7411000313985', 8,23);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('16590-416','290009','7421000843030', 8,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('16590-416','290009','7411000345061', 9,92);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0093-7304','725459','7401004510114', 1,28);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0093-7304','725459','0750894600267', 2,43);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0009-0039','92330','7401004530938', 8,43);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0009-0039','92330','7590011151110', 3,54);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('64720-153','737738','7441008941705', 10,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('64720-153','737738','0750894600717', 6,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('68016-115','327045','7441008943143', 10,23);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('68016-115','327045','2517230000000', 8,12);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('58060-002','44433','2589290000009', 2,12);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('58060-002','44433','2583000000006', 8,32);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52270-001','783357','7421000952404', 9,43);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52270-001','783357','2583020000000', 5,45);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0299-5908','34413','7421000910022', 7,65);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0299-5908','34413','2565160000003', 5,76);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52125-248','259263','0722304206963', 7,87);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52125-248','259263','7420001000411', 2,96);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('11523-4140','941072','7501072206725', 1,74);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('11523-4140','941072','0611594000019', 1,73);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52959-558','445295','0023100051048', 5,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52959-558','445295','7422110100556', 5,92);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('31511-008','870172','7501777001151', 4,72);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('31511-008','870172','0784562010508', 8,91);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('60429-174','976167','0721282301059', 2,72);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('60429-174','976167','0784562010652', 3,23);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('10893-083','827710','7590011105106', 10,);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('10893-083','827710','7622210864536', 7,83);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0024-5810','996131','7622210673688', 1,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0024-5810','996131','7622210864680', 3,73);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('54868-0736','439041','7421900703144', 4,54);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('54868-0736','439041','7622210864734', 5,32);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('36987-3012','683478','2511930000001', 10,32);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('36987-3012','683478','7622210864116', 1,45);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('24471-200','524988','2520230000000', 7,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('24471-200','524988','7622210863263', 9,73);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55154-8255','414801','7441029500110', 2,83);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55154-8255','414801','7421900700525', 9,72);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('68788-9702','184972','2593000000005', 6,52);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('68788-9702','184972','7622210864154', 8,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('36987-3046','25900','7622210863492', 4,83);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('36987-3046','25900','7421601102109', 5,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55111-441','737247','7421601100013', 2,92);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55111-441','737247','7421601100037', 9,62);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('41520-361','799128','7421600300087', 8,22);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('41520-361','799128','7441029514179', 9,74);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0603-6150','988050','7441029555660', 5,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0603-6150','988050','7441029556735', 2,73);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('49967-699','559945','7401006713308', 2,93);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('49967-699','559945','7441029518009', 4,83);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0178-0821','628556','7441029511987', 8,43);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0178-0821','628556','7506306246546', 3,24);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('31720-209','663690','7506306213357', 10,92);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('31720-209','663690','7411000356487', 2,72);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('48951-1219','690322','7702191001097', 10,73);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('48951-1219','690322','7509546000350', 10,63);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('68258-6972','255946','7509546052861', 4,74);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('68258-6972','255946','0000042277095', 6,91);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('16729-212','866089','8715200813061', 4,73);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('16729-212','866089','7501054503095', 3,65);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55154-2418','895826','4005808239603', 4,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55154-2418','895826','4005900734129', 2,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('60505-3276','262735','0784562403058', 1,35);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('60505-3276','787657','7422110101331', 2,57);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('64942-1287','879256','7422110101348', 10,80);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('64942-1287','195449','0715126400022', 6,99);


--Producto
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('2540610000000','Hortifruti','Lechuga', 18.50 ,'Verduras');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('2572780000009','Hortifruti','Tomate 6 ud', 16.60 ,'Verduras');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('2545620000002','Hortifruti','Zanahoria', 8,'Verduras');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('2540830000002','Hortifruti','Papa 2Lb', 25,'Verduras');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0000000040501','Hortifruti','Melon Criollo', 29,'Frutas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('2540160000000','Hortifruti','Manzana', 9.50, 'Frutas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0000000071963','Hortifruti','Coco',14.50,'Frutas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('2540930000001','Hortifruti','Cebolla Amarilla 1Lb',23.00,'Verduras');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0000000040716','Hortifruti','Apio Mazo',6.00,'Verduras');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0000000048996','Hortifruti','Perejil En Manojo',5.90,'Verduras');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('428630102117','Hortifruti','Rabano Rojo paquete',10.90,'Verduras');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('2571530000009','Hortifruti','Cebolla Morada 1Lb',26.50,'Verduras');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0000000044332','Hortifruti','Pina',38.50,'Frutas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0000000071789','Hortifruti','Limón Persa ud',3.50,'Frutas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('2533830000004','Hortifruti','Mandarina Clementina 1Lb',49.00,'Frutas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7421000811367','Sula','Leche Entera', 36.70,'Lacteos y Derivados');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7421000840817','Sula','Leche Deslactosada', 38.10,'Lacteos y Derivados');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7421000843030','Sula','Queso Procesado', 38.40,'Lacteos y Derivados');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7421000812012','Sula','Crema', 30.80,'Lacteos y Derivados');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7422540015611','Leyde','Leche con Chocolate', 34.60,'Lacteos y Derivados');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0795893101414','Leyde','Leche Entera', 54.30,'Lacteos y Derivados');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0795893410110','Leyde','Queso Procesado', 30.70, 'Lacteos y Derivados');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0795893301319','Leyde','Crema Acida', 35.30,'Lacteos y Derivados');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7441008169857','Scott','Papel Higienico 12 Rollos', 227.50,'Limpieza');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7406131001870','Supermax','Papel Higienico 4 Rollos', 65.00,'Limpieza');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7441078230150','Suli','Cloro 1000ml',22.00,'Limpieza');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7441078224395','Suli','Detergente 1000g',35.00,'Limpieza');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7441078228980','Suli','Bolsa para basura S',17.00,'Limpieza');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7406131004789','Suli','Servilleta Cuadrada 100 ud',11.00,'Limpieza');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7441008162278','Scott','Toalla de Papel 1 ud',68.10,'Limpieza');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7441078229130','Supermax','Lavaplatos Limon 1000gr',39.50,'Limpieza');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7401004510114','Toledo','Jamon Prensado 10ud', 34,'Embutidos');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7401004530938','Toledo','Salchicha 7ud', 71,'Embutidos');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7441008941705','Fud','Jamon Prensado', 45,'Embutidos');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7441008943143','Fud','Salchicha Ahumada', 56,'Embutidos');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('2589290000009','Delicia ','Chorizo Criollo 4ud', 14,'Embutidos');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7421000952404','Delicia ','Tocino 150gr', 68,'Embutidos');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7421000910022','Delicia ','Mortadela 70 oz', 27.50,'Embutidos');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0722304206963','Gati','Alimento Gato',665,'Mascotas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7501072206725','Purina','Alimento Perro Cachorro', 415,'Mascotas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0023100051048','Pedigree','Alimento Perro Adulto', 195,'Mascotas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7501777001151','Purina','Alimento Gato Adulto Pescado 1.5Kg',192.10,'Mascotas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7501072210302','Purina','Alimento Humedo Perro Adulto 100gr',27.90,'Mascotas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0023100041049','Pedigree','Comida Perro Cachorro 2Kgs',199.00,'Mascotas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7411000315033','Naturas','Salsa Ketchup', 46.50, 'Abarrotes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7411000313985','Naturas','Pasta de Tomate', 23.30,'Abarrotes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7411000345061','Naturas','Frijol Rojo Volteados', 23.00,'Abarrotes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0750894600267','Yummies','Zambos Chile', 31.60, 'Abarrotes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7590011151110','Nabisco','Galleta Oreo 12 ud', 78.00, 'Abarrotes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0750894600717','Yummies','Zambos Salsa Verde',29.50,'Abarrotes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0721282301059','Yummies','Cheetos Extra queso', 23.50,'Abarrotes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7590011105106','Nabisco','Galleta Club Social 9 ud',28.50,'Abarrotes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7622210673688','Nabisco','Galleta Ritz', 49.00,'Abarrotes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7421900703144','El Corral','Carne Molida 1Lb', 60.25,'Carnes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('2511930000001','El Corral', 'Chuleta Cerdo 1Lb', 40, 'Carnes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('2520230000000','El Corral','Fajitas Res 1Lb', 123.00,'Carnes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7421900700525','El Corral','Paquete Bistec Res', 90.00,'Carnes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('2593000000005','Don Cristobal','Pollo Entero', 34.20,'Carnes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('2517230000000','Don Cristobal','Chuleta de Cerdo 5Lb', 39.50,'Carnes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('2583000000006','Don Cristobal','Alas de Pollo 1Lb', 56.00,'Carnes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('2583020000000','Don Cristobal','Menudo de Pollo 1Lb', 25.00,'Carnes');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('2565160000003','El Corral','Filete Tilapia 1Lb',131.50,'Mariscos');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7420001000411','El Corral','Camaron 200gr', 94.00,'Mariscos');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0611594000019','Aguazul','Agua Bote 1 gal', 22.40,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7422110100556','Coca-Cola','Coca Cola 3Lt',56.10,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0784562010508','Coca-Cola','Coca Cola 2Lt',37.70,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0784562010652','Coca-Cola','Coca Cola 500ml',13.40,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7622210864536','Tang','Bebida en Polvo Manzana',5.70,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7622210864680','Tang','Bebida en Polvo Uva',5.70,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7622210864734','Tang','Bebida en Polvo Guayaba-Piña',5.70,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7622210864116','Tang','Bebida en Polvo Naranaja',5.70,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7622210863263','Tang','Bebida en Polvo Fresa',5.70,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7622210864154','Tang','Bebida en Polvo Limon',5.70,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7622210863492','Tang','Bebida en Polvo Piña',5.70,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7421601102109','Pepsi','Pepsi 3Lts',52.80,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7421601100013','Pepsi','Pepsi 2Lts',32.80,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7421601100037','Pepsi','Pepsi 1.5 Lts',26.60,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7421600300087','Pepsi','Pepsi 500ml',13,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7441029555660','Bimbo','Tortilla Trigo Mediana', 27.70,'Panaderia y tortilleria');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7441029500110','Bimbo','Pan integral Gr',53.90,'Panaderia y tortilleria');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7441029514179','Bimbo','Pan Artesano mediano',54.80,'Panaderia y tortilleria');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7441029556735','Bimbo','Pan Sandwich Gr',55.60,'Panaderia y tortilleria');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7401006713308','Monarca','Pan molde',46.80,'Panaderia y tortilleria');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7441029518009','Monarca','Pan integral',44.00,'Panaderia y tortilleria');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7441029511987','Monarca','Tortilla de trigo',19.50,'Panaderia y tortilleria');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7506306246546','Dove','3 pack Desodorante',250.00,'Higiene');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7506306213357','Dove','Shampoo Reconstruccion',198.00,'Higiene');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7411000356487','Dove','3 Pack Jabon Granada',76.00,'Higiene');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7702191001097','Dove','6 Pack Jabon Original',145.30,'Higiene');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7509546000350','Colgate','Pasta Dental 150ml',55.00,'Higiene');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7509546052861','Colgate','Pasta Dental Total Encias',90.00,'Higiene');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0000042277095','Nivea','Crema Antiarrugas 100ml',100.00,'Belleza');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('8715200813061','Nivea','Locion de afeitar 100ml',227.00,'Belleza');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7501054503095','Nivea','Crema Facial 100ml', 106.00,'Belleza');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('4005808239603','Nivea','Bloqueador solar 50ml',245.00,'Belleza');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('4005900734129','Nivea','Bloqueador solar 200ml',367.00,'Belleza');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0784562403058','Imperial','Cerveza lata',13.80,'Licores');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7422110101331','Barena','Cerveza lata',25.20,'Licores');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7422110101348','Salva Vida','Cerveza lata',23.10,'Licores');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0715126400022','Montes','Vino Tinto Malbec',290.90,'Licores');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0715126000017','Montes','Vino Tinto Clasico',290.90,'Licores');
    

-- Suministro
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0795893301319', '1', '80');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('2540610000000', '2', '50');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7422110101348', '3', '70');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7421000811367', '4', '110');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7441008169857', '5', '90');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0715126000017', '6', '70');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7622210864536', '7', '150');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7421601102109', '8', '240');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7441029556735', '9', '310');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7401006713308', '10', '420');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7506306213357', '11', '250');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7501054503095', '12', '300');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0784562403058', '13', '70');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7411000356487', '14', '40');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('2572780000009', '15', '30');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('2545620000002', '16', '100');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7422540015611', '17', '330');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7509546000350', '18', '200');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7506306246546', '19', '340');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7622210864734', '20', '420');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7622210863263', '21', '80');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7622210864154', '22', '30');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7622210863492', '23', '70');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7441029555660', '24', '90');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7702191001097', '25', '80');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7509546052861', '26', '100');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('2540830000002', '27', '55');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0000000040501', '28', '60');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('2540160000000', '29', '80');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0000000071963', '30', '110');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('2540930000001', '31', '80');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7422110101331', '32', '60');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0715126400022', '33', '450');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('4005900734129', '34', '80');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('4005808239603', '35', '200');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('8715200813061', '36', '210');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0000042277095', '37', '150');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7441029511987', '38', '300');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7441029518009', '39', '120');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7421601100013', '40', '140');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7421601100037', '41', '240');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7421600300087', '42', '70');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7441029500110', '43', '280');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7441029514179', '44', '80');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7622210864116', '45', '330');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7622210864680', '46', '120');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0000000040716', '47', '500');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0795893101414', '48', '480');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7441078230150', '49', '90');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7441078224395', '50', '100');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0000000048996', '51', '90');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('428630102117', '52', '145');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0000000044332', '53', '70');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('2571530000009', '54', '120');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0611594000019', '55', '110');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0784562010652', '56', '90');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7421900703144', '57', '200');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('2583000000006', '58', '330');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('2511930000001', '59', '140');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7421900700525', '60', '70');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('2520230000000', '61', '90');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('2593000000005', '62', '240');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7420001000411', '63', '340');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('2583020000000', '64', '310');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('2565160000003', '65', '420');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7422110100556', '66', '400');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0784562010508', '67', '390');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('2517230000000', '68', '90');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7622210673688', '69', '80');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7590011105106', '70', '350');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('2533830000004', '71', '230');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7421000812012', '72', '500');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7421000840817', '73', '90');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7421000843030', '74', '310');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0795893410110', '75', '50');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7406131001870', '76', '90');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7406131004789', '77', '250');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7441078228980', '78', '100');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0721282301059', '79', '150');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7441008162278', '80', '145');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0000000071789', '81', '230');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7441078229130', '82', '540');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7401004510114', '83', '30');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0750894600717', '84', '500');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7411000345061', '85', '510');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0750894600267', '86', '610');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0722304206963', '87', '170');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7411000315033', '88', '340');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7590011151110', '89', '90');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7411000313985', '90', '50');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0023100041049', '91', '210');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7401004530938', '92', '330');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7441008941705', '93', '80');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7501072210302', '94', '720');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7441008943143', '95', '610');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('0023100051048', '96', '700');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7501777001151', '97', '150');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('2589290000009', '98', '360');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7421000952404', '99', '150');
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7421000910022', '100', '280'); 
INSERT INTO Suministro (CodProducto, CodAbastecimiento, Stock) values ('7501072206725', '101', '50');


-- Abastecimiento
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('1', '17', '013333', '2824', '07-01-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('2', '1', '013333', '925', '13-01-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('3', '8', '013333', '1617', '30-01-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('4', '9', '013333', '4037', '10-02-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('5', '18', '013333', '20475', '12-02-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('6', '100', '52121', '20363', '-23-02-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('7', '77', '1144', '855', '27-02-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('8', '80', '1144', '12672', '06-03-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('9', '85', '52121', '17236', '07-03-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('10', '86', '1144', '19656', '10-03-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('11', '96', '1144', '49500', '28-03-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('12', '91', '52121', '31800', '01-04-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('13', '98', '1144', '966', '12-04-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('14', '97', 52121', '3040', '27-04-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('15', '2', '1144', '498', '05-05-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('16', '3', '013333', '800', '15-05-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('17', '14', '1144', '11418', '21-05-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('18', '93', '1144', '11000', '30-05-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('19', '95', '1144', '85000', '07-06-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('20', '79', '013333', '2394', '17-06-2021');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('21', '13', '013333', '456', '27-06-2021');            
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('22', '20', '1144', '171', '27-06-2021');            
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('23', '30', '52121', '399', '27-06-2021');            
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('24', '83', '1144', '2493', '27-06-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('25', '33', '52121', '11624', '27-06-2021');            
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('26', '94', '013333', '9000', '27-06-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('27', '40', '1144', '10565.5', '27-06-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('28', '5', '1144', '1740', '27-06-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('29', '6', '52121', '760', '27-06-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('30', '7', '17871', '1595', '27-06-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('31', '4', '17871', '1840', '04-07-2021');            
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('32', '99', '52121', '1512', '10-07-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('33', '101', '17871', '130905', '20-07-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('34', '37', '17871', '29360', '02-08-2021');            
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('35', '92', '17871', '49000', '12-08-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('36', '90', '17871', '47670', '20-08-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('37', '89', '17871', '15000', '26-08-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('38', '88', '17871', '5850', '03-09-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('39', '87', '013333', '5280', '17-09-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('40', '81', '013333', '4592', '23-09-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('41', '82', '17871', '3120', '30-09-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('42', '74', '17871', '910', '05-10-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('43', '84', '17871', '15092', '15-10-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('44', '39', '17871', '4384', '27-10-2021');             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('45', '46', '17871', '1881', '10-11-2021');             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('46', '78', '013333', '684', '11-11-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('47', '47', '17871', '3000', '23-11-2021');             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('48', '15', '17871', '4500', '29-11-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('49', '24', '17871', '1980', '05-12-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('50', '25', '17871', '3500', '17-12-2021'); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('51', '51', '09911', '531', '30-12-2021');             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('52', '52', '09911', '1580.5', '02-01-2022');             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('53', '55', '17871', '2695', '10-01-2022');             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('54', '56', '09911', '3180', '31-01-2022');             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('55', '61', '09911', '2464', '07-02-2022');             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('56', '75', '17871', '1206', '20-02-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('57', '62', '17871', '12050', '27-02-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('58', '69', '09911', '18480', '01-03-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('59', '63', '17871', '5600', '11-03-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('60', '65', '013333', '6300', '29-03-2022');       
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('61', '64', '17871', '11070', '12-04-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('62', '67', '1144', '8208', '17-04-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('63', '66', '013333', '31960', '30-04-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('64', '70', '52121', '7750', '04-05-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('65', '71', '09911', '55230', '12-05-2022');             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('66', '72', '52121', '22440', '25-05-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('67', '76', '52121', '14703', '10-06-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('68', '68', '09911', '3555', '20-06-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('69', '59', '013333', '3920', '30-06-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('70', '58', '1144', '9975', '01-07-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('71', '73', '09911', '11270', '07-07-2022');              
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('72', '12', '52121', '15400', '21-07-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('73', '10', '013333', '3429', '28-07-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('74', '11', '013333', '11904', '02-08-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('75', '16', '013333', '1535', '12-08-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('76', '21', '09911', '5850', '31-08-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('77', '27', '09911', '2750', '07-09-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('78', '26', '1144', '1700', '13-09-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('79', '54', '09911', '3525', '22-09-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('80', '19', '1144', '9874.5', '29-09-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('81', '88', '09911', '805', '06-10-2022');       
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('82', '22', '52121', '21330', '16-10-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('83', '28', '1144', '1020', '27-10-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('84', '53', '013333', '14750', '30-10-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('85', '50', '013333', '11730', '02-11-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('86', '57', '52121', '19276', '14-11-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('87', '38', '09911', '113050', '24-11-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('88', '48', '1144', '15810', '27-11-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('89', '60', '09911', '7020', '29-11-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('90', '49', '52121', '1165', '30-11-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('91', '44', '09911', '41790', '01-12-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('92', '29', '52121', '23430', '07-12-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('93', '31', '09911', '3600', '13-12-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('94', '41', '52121', '20088', '18-12-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('95', '32', '09911', '34160', '20-12-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('96', '45', '09911', '136500', '22-12-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('97', '42', '52121', '28815', '24-12-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('98', '34', '09911', '5040', '26-12-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('99', '35', '52121', '10200', '27-12-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('100', '36', '09911', '7700', '28-12-2022');
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmpleado, Total, Fecha) values ('101', '43', '52121', '20750', '30-12-2022');

--Selects
SELECT * FROM EMPLEADO;
SELECT * FROM TelefonoEmpleado;
SELECT * FROM TipoEmpleado;
SELECT * FROM Departamento;
SELECT * FROM Producto;
SELECT * FROM Area;
SELECT * FROM Cliente;
SELECT * FROM Proveedor;
SELECT * FROM TelefonoProveedor;
SELECT * FROM Abastecimiento;
SELECT * FROM Caja;
SELECT * FROM Factura;
SELECT * FROM DetalleFactura;
SELECT * FROM Suministro;
--