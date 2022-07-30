CREATE TABLE Abastecimiento(
    IdAbasto    varchar2(30)    PRIMARY KEY,
    CodProv     varchar2(30)    NOT NULL,
    DniEmp      varchar2(30)    NOT NULL,
    Total       decimal(7,2)    NOT NULL,
    Fecha       date            NOT NULL
);

CREATE TABLE Area(
    NombreArea      varchar2(40) PRIMARY KEY,
    Pasillo         varchar2(10) NOT NULL
);

CREATE TABLE Caja(
    CodCajero   varchar2(30) PRIMARY KEY,
    NumCaja     varchar2(30) NOT NULL
);

CREATE TABLE Cliente(
    Dni         varchar2(30) PRIMARY KEY,
    Nombre      varchar2(30) NOT NULL,
    Apellido    varchar2(30) NOT NULL
);

CREATE TABLE Departamento(
    NumDpto     varchar2(30) PRIMARY KEY,
    Nombre      varchar2(30) NOT NULL,
    DniGerente  varchar2(30)
);

CREATE TABLE DetalleFactura(
    NumRegistro     varchar2(30) NOT NULL,
    IdFactura       varchar2(30) NOT NULL,
    CodProducto     varchar2(30) NOT NULL,
    Cantidad        number(10)   NOT NULL,
    Subtotal        decimal(7,2) NOT NULL,
    
    CONSTRAINT PK_DetFac PRIMARY KEY (NumRegistro,IdFactura)
);

CREATE TABLE Empleado(
    Dni         varchar2(30)  PRIMARY KEY,
    Nombre      varchar2(30)  NOT NULL,
    Apellido1   varchar2(30)  NOT NULL,
    Apellido2   varchar2(30),
    FechaNac    date         NOT NULL,
    Sexo        char(1)      NOT NULL,
    Direccion   varchar2(150) NOT NULL,
    Jornada     varchar2(10)  NOT NULL,
    TipoEmpleado varchar2(30) NOT NULL,
    Sueldo      decimal(7,2) NOT NULL,
    Dpto        varchar2(30),
    SuperDni    varchar2(30),
    
    CONSTRAINT CHK_Empleado1 CHECK (Sexo in ('M','F')),
    CONSTRAINT CHK_Empleado2 CHECK (Sueldo > 0),
    CONSTRAINT CHK_Empleado3 CHECK (Jornada in ('Diurna','Nocturna')), -- Diurna: 6am-8pm ; Nocturna: 8pm-6am
    CONSTRAINT FK_Empleado1 FOREIGN KEY (SuperDni) REFERENCES Empleado(Dni)
    
);

CREATE TABLE Factura(
    IdFactura   varchar2(30)     NOT NULL PRIMARY KEY,
    DniCliente  varchar2(30)     NOT NULL,
    MontoFinal  decimal(7,2)    NOT NULL,
    TipoPago    varchar2(10)     NOT NULL,
    Fecha       date            NOT NULL,
    Cajero      varchar2(30)     NOT NULL,
    
    CONSTRAINT CHK_Factura1 CHECK (TipoPago in ('Contado','Credito')),
    CONSTRAINT CHK_Factura2 CHECK (MontoFinal > 0)
);

CREATE TABLE Producto (
    CodBarra    varchar2(30)     NOT NULL PRIMARY KEY,
    Marca       varchar2(50)     NOT NULL,
    Descripcion varchar2(40)     NOT NULL,
    Precio      decimal(6,2)    NOT NULL,
    Ubicacion   varchar2(30)     NOT NULL,
    
    CONSTRAINT CHK_Producto1 CHECK (Precio > 0)
);

CREATE TABLE Proveedor (
    CodProv         varchar2(30)     NOT NULL PRIMARY KEY,
    NombreMarca     varchar2(30)     NOT NULL,
    Direccion       varchar2(150)    NOT NULL,
    NombreEncargado varchar2(30)     NOT NULL,
    ApellidoEncargado varchar2(30)   NOT NULL
);

CREATE TABLE Suministro(
    CodProducto         varchar2(30) NOT NULL,
    CodAbastecimiento   varchar2(10) NOT NULL,
    Stock               number(10)   NOT NULL,
    
    CONSTRAINT PK_Suministro PRIMARY KEY (CodProducto,CodAbastecimiento),
    CONSTRAINT CHK_Suministro1 CHECK (Stock > 0)
);

CREATE TABLE TelefonoEmpleado(
    Dni      varchar2(30) NOT NULL,
    Telefono varchar2(10) NOT NULL UNIQUE,
    
    CONSTRAINT PK_TelEmp PRIMARY KEY (Dni,Telefono)
);

CREATE TABLE TelefonoProveedor(
    CodProv     varchar2(30) NOT NULL,
    Telefono    varchar2(10) NOT NULL UNIQUE,
    
    CONSTRAINT PK_TelProv PRIMARY KEY (CodProv,Telefono)
);

CREATE TABLE TipoEmpleado(
    idTipoEmp   varchar2(30) NOT NULL PRIMARY KEY,
    Descripcion varchar2(30) NOT NULL
);

-- FK ABASTECIMIENTO
ALTER TABLE Abastecimiento ADD CONSTRAINT FK_Abasto_Prov FOREIGN KEY (CodProv) REFERENCES Proveedor(CodProv);
ALTER TABLE Abastecimiento ADD CONSTRAINT FK_Abasto_Emp FOREIGN KEY (DniEmp) REFERENCES Empleado(Dni);

-- FK CAJA
ALTER TABLE Caja ADD CONSTRAINT FK_Caja_Emp FOREIGN KEY (CodCajero) REFERENCES Empleado(Dni);

-- FK DEPARTAMENTO
ALTER TABLE Departamento ADD CONSTRAINT FK_Dept_Emp FOREIGN KEY (DniGerente) REFERENCES Empleado(Dni);

-- FK DETALLE FACTURA
ALTER TABLE DetalleFactura ADD CONSTRAINT FK_DetFact_Fact FOREIGN KEY (IdFactura) REFERENCES Factura(IdFactura);

-- FK EMPLEADO
ALTER TABLE Empleado ADD CONSTRAINT FK_Emp_Tipo FOREIGN KEY (TipoEmpleado) REFERENCES TipoEmpleado(idTipoEmp);
ALTER TABLE Empleado ADD CONSTRAINT FK_Emp_Dept FOREIGN KEY (Dpto) REFERENCES Departamento(NumDpto);

-- FK FACTURA
ALTER TABLE Factura ADD CONSTRAINT FK_Fac_Cli FOREIGN KEY (DniCliente) REFERENCES Cliente(Dni);
ALTER TABLE Factura ADD CONSTRAINT FK_Fac_Caja FOREIGN KEY (Cajero) REFERENCES Caja(CodCajero);

-- FK PRODUCTO
ALTER TABLE Producto ADD CONSTRAINT FK_Prod_Area FOREIGN KEY (Ubicacion) REFERENCES Area(NombreArea);

-- FK Suministro
ALTER TABLE Suministro ADD CONSTRAINT FK_Sum_Prod FOREIGN KEY (CodProducto) REFERENCES Producto(CodBarra);
ALTER TABLE Suministro ADD CONSTRAINT FK_Sum_Abasto FOREIGN KEY (CodAbastecimiento) REFERENCES Abastecimiento(IdAbasto);

-- FK Telefono Empleado
ALTER TABLE TelefonoEmpleado ADD CONSTRAINT FK_TelEmp_Emp FOREIGN KEY (Dni) REFERENCES Empleado(Dni);

-- FK Telefono Proveedor
ALTER TABLE TelefonoProveedor ADD CONSTRAINT FK_TelProv_Prov FOREIGN KEY (CodProv) REFERENCES Proveedor(CodProv);

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

--TipoEmpleado
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('1', 'Gerente' ); --
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('2', 'Bodeguero' ); --
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('3', 'Cajero' ); --
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('4', 'Guardia de Seguridad' ); --
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('5', 'Reponedor' ); --
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('6', 'Oficial de Monitoreo'); --
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('7', 'Reclutador' ); --
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('8', 'Comprador'); --
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('9', 'Contador'); --
Insert into TipoEmpleado (idTipoEmp  , Descripcion  ) values ('10', 'Mercadologo'); --

--Departamento
Insert into Departamento (NumDpto , Nombre , DniGerente ) values ('1', 'Recursos humanos',NULL);
Insert into Departamento (NumDpto , Nombre , DniGerente ) values ('2', 'Compras',NULL);
Insert into Departamento (NumDpto , Nombre , DniGerente ) values ('3', 'Seguridad',NULL);
Insert into Departamento (NumDpto , Nombre , DniGerente ) values ('4', 'Bodega',NULL);
Insert into Departamento (NumDpto , Nombre , DniGerente ) values ('5', 'Marketing',NULL);
Insert into Departamento (NumDpto , Nombre , DniGerente ) values ('6', 'Contabilidad',NULL);

--Clientes
insert into Cliente (Dni, Nombre, Apellido) values ('499600265', 'Levin', 'Kubanek');
insert into Cliente (Dni, Nombre, Apellido) values ('961859456', 'Tybie', 'Rylance');
insert into Cliente (Dni, Nombre, Apellido) values ('910111724', 'Gordy', 'Nowland');
insert into Cliente (Dni, Nombre, Apellido) values ('858309463', 'Gelya', 'Whorf');
insert into Cliente (Dni, Nombre, Apellido) values ('821482327', 'Asher', 'Pipworth');
insert into Cliente (Dni, Nombre, Apellido) values ('834560057', 'Matthaeus', 'Yellowlee');
insert into Cliente (Dni, Nombre, Apellido) values ('082127282', 'Elga', 'Hildrew');
insert into Cliente (Dni, Nombre, Apellido) values ('272334526', 'Isac', 'Gimbrett');
insert into Cliente (Dni, Nombre, Apellido) values ('605912746', 'Emmalynne', 'Strond');
insert into Cliente (Dni, Nombre, Apellido) values ('653136286', 'Andra', 'Hearley');
insert into Cliente (Dni, Nombre, Apellido) values ('709902113', 'Bale', 'Offer');
insert into Cliente (Dni, Nombre, Apellido) values ('757569278', 'Blair', 'Tybalt');
insert into Cliente (Dni, Nombre, Apellido) values ('640706943', 'Jelene', 'Simioni');
insert into Cliente (Dni, Nombre, Apellido) values ('301969639', 'Emmit', 'Hein');
insert into Cliente (Dni, Nombre, Apellido) values ('936398685', 'Bradan', 'Leyfield');
insert into Cliente (Dni, Nombre, Apellido) values ('069419213', 'Winifield', 'Brunicke');
insert into Cliente (Dni, Nombre, Apellido) values ('257299547', 'Janos', 'Pelman');
insert into Cliente (Dni, Nombre, Apellido) values ('680351462', 'Gino', 'Walden');
insert into Cliente (Dni, Nombre, Apellido) values ('167889033', 'Filia', 'McLane');
insert into Cliente (Dni, Nombre, Apellido) values ('666322622', 'Jenica', 'Hamprecht');
insert into Cliente (Dni, Nombre, Apellido) values ('538302340', 'Johna', 'Gammell');
insert into Cliente (Dni, Nombre, Apellido) values ('223505314', 'Hector', 'Trattles');
insert into Cliente (Dni, Nombre, Apellido) values ('439703441', 'Anabelle', 'Verni');
insert into Cliente (Dni, Nombre, Apellido) values ('893735382', 'Keriann', 'Bautiste');
insert into Cliente (Dni, Nombre, Apellido) values ('377926713', 'John', 'Phette');
insert into Cliente (Dni, Nombre, Apellido) values ('879762529', 'Jillian', 'Goodricke');
insert into Cliente (Dni, Nombre, Apellido) values ('050001023', 'Marve', 'Burrel');
insert into Cliente (Dni, Nombre, Apellido) values ('250110400', 'Clerissa', 'Akenhead');
insert into Cliente (Dni, Nombre, Apellido) values ('574097871', 'Case', 'Rougier');
insert into Cliente (Dni, Nombre, Apellido) values ('874395853', 'Theodore', 'Shallow');
insert into Cliente (Dni, Nombre, Apellido) values ('902257883', 'Aryn', 'Lacaze');
insert into Cliente (Dni, Nombre, Apellido) values ('326683185', 'Tatum', 'Bugs');
insert into Cliente (Dni, Nombre, Apellido) values ('707680155', 'Artair', 'Aaron');
insert into Cliente (Dni, Nombre, Apellido) values ('911253390', 'Perle', 'Galpen');
insert into Cliente (Dni, Nombre, Apellido) values ('205244418', 'Lucine', 'O''Donoghue');
insert into Cliente (Dni, Nombre, Apellido) values ('410547752', 'Shena', 'Danskine');
insert into Cliente (Dni, Nombre, Apellido) values ('521155850', 'Grace', 'Vaughten');
insert into Cliente (Dni, Nombre, Apellido) values ('854125534', 'Rory', 'Buddington');
insert into Cliente (Dni, Nombre, Apellido) values ('401190044', 'Dru', 'Belin');
insert into Cliente (Dni, Nombre, Apellido) values ('348167095', 'Ketty', 'Taylorson');
insert into Cliente (Dni, Nombre, Apellido) values ('554446831', 'Jamie', 'Pittwood');
insert into Cliente (Dni, Nombre, Apellido) values ('903507575', 'Clyve', 'Capelow');
insert into Cliente (Dni, Nombre, Apellido) values ('268643734', 'Tomkin', 'Nuttey');
insert into Cliente (Dni, Nombre, Apellido) values ('041692028', 'Bill', 'Dowell');
insert into Cliente (Dni, Nombre, Apellido) values ('401237143', 'Marcela', 'Wellan');
insert into Cliente (Dni, Nombre, Apellido) values ('120567959', 'Trisha', 'Titchen');
insert into Cliente (Dni, Nombre, Apellido) values ('783481001', 'Jaimie', 'Androli');
insert into Cliente (Dni, Nombre, Apellido) values ('208372208', 'Crissy', 'Waszczykowski');
insert into Cliente (Dni, Nombre, Apellido) values ('705518751', 'Orrin', 'Gippes');
insert into Cliente (Dni, Nombre, Apellido) values ('513045182', 'Jeffie', 'Amiss');
insert into Cliente (Dni, Nombre, Apellido) values ('127704888', 'Chic', 'Baison');
insert into Cliente (Dni, Nombre, Apellido) values ('457336205', 'Robinett', 'Jakoviljevic');
insert into Cliente (Dni, Nombre, Apellido) values ('115069647', 'Kendall', 'Baseggio');
insert into Cliente (Dni, Nombre, Apellido) values ('161038247', 'Wilton', 'Jeacop');
insert into Cliente (Dni, Nombre, Apellido) values ('330065672', 'Eugine', 'Bernardo');
insert into Cliente (Dni, Nombre, Apellido) values ('729695886', 'Dre', 'De Hoogh');
insert into Cliente (Dni, Nombre, Apellido) values ('288711954', 'Turner', 'Meadows');
insert into Cliente (Dni, Nombre, Apellido) values ('596712550', 'Rhoda', 'Grimmer');
insert into Cliente (Dni, Nombre, Apellido) values ('844349060', 'Hermann', 'Peche');
insert into Cliente (Dni, Nombre, Apellido) values ('546557112', 'Carlene', 'Corsar');
insert into Cliente (Dni, Nombre, Apellido) values ('826165417', 'Keefer', 'Sushams');
insert into Cliente (Dni, Nombre, Apellido) values ('624937635', 'Markos', 'Simes');
insert into Cliente (Dni, Nombre, Apellido) values ('711121374', 'Lulu', 'Grzelewski');
insert into Cliente (Dni, Nombre, Apellido) values ('848067543', 'Guthrie', 'Juliff');
insert into Cliente (Dni, Nombre, Apellido) values ('921588671', 'Leoline', 'Roth');
insert into Cliente (Dni, Nombre, Apellido) values ('652431362', 'Omero', 'Boatright');
insert into Cliente (Dni, Nombre, Apellido) values ('916743733', 'Rourke', 'Clorley');
insert into Cliente (Dni, Nombre, Apellido) values ('210100340', 'Maudie', 'Clews');
insert into Cliente (Dni, Nombre, Apellido) values ('235933973', 'Waylan', 'Vicar');
insert into Cliente (Dni, Nombre, Apellido) values ('191355428', 'Fabiano', 'Edelmann');
insert into Cliente (Dni, Nombre, Apellido) values ('807166478', 'Thedric', 'Gunn');
insert into Cliente (Dni, Nombre, Apellido) values ('568443506', 'Carolin', 'Walden');
insert into Cliente (Dni, Nombre, Apellido) values ('447427181', 'Laurent', 'Howsin');
insert into Cliente (Dni, Nombre, Apellido) values ('592207922', 'Javier', 'Betjeman');
insert into Cliente (Dni, Nombre, Apellido) values ('760760275', 'Marysa', 'McVitty');
insert into Cliente (Dni, Nombre, Apellido) values ('314028559', 'Gene', 'Talman');
insert into Cliente (Dni, Nombre, Apellido) values ('800828536', 'Rem', 'Selby');
insert into Cliente (Dni, Nombre, Apellido) values ('715042253', 'Bartlett', 'Gherardesci');
insert into Cliente (Dni, Nombre, Apellido) values ('822437815', 'Kaycee', 'Summerly');
insert into Cliente (Dni, Nombre, Apellido) values ('376662492', 'Tully', 'Davidov');
insert into Cliente (Dni, Nombre, Apellido) values ('198858026', 'Rosamond', 'Kermitt');
insert into Cliente (Dni, Nombre, Apellido) values ('111882640', 'Archibaldo', 'Faveryear');
insert into Cliente (Dni, Nombre, Apellido) values ('322022364', 'Keven', 'Jonson');
insert into Cliente (Dni, Nombre, Apellido) values ('421798857', 'Darn', 'Wison');
insert into Cliente (Dni, Nombre, Apellido) values ('647935827', 'Annmarie', 'Tripett');
insert into Cliente (Dni, Nombre, Apellido) values ('587772369', 'Bernita', 'Kinchin');
insert into Cliente (Dni, Nombre, Apellido) values ('857218260', 'Barbara', 'Gallard');
insert into Cliente (Dni, Nombre, Apellido) values ('831980634', 'Barry', 'Berresford');
insert into Cliente (Dni, Nombre, Apellido) values ('107496558', 'Jessalyn', 'Durtnall');
insert into Cliente (Dni, Nombre, Apellido) values ('411782763', 'Woodie', 'Begbie');
insert into Cliente (Dni, Nombre, Apellido) values ('186243015', 'Flori', 'Heaslip');
insert into Cliente (Dni, Nombre, Apellido) values ('537020587', 'Ruby', 'MacEllen');
insert into Cliente (Dni, Nombre, Apellido) values ('781600723', 'Bay', 'Godbolt');
insert into Cliente (Dni, Nombre, Apellido) values ('258891174', 'Doralynn', 'Haffner');
insert into Cliente (Dni, Nombre, Apellido) values ('528288902', 'Lucilia', 'Huleatt');
insert into Cliente (Dni, Nombre, Apellido) values ('078999230', 'Gino', 'Kincade');
insert into Cliente (Dni, Nombre, Apellido) values ('474712553', 'Gwenny', 'Harte');
insert into Cliente (Dni, Nombre, Apellido) values ('480041339', 'Marcie', 'Hynes');
insert into Cliente (Dni, Nombre, Apellido) values ('417624380', 'Ade', 'Gallant');
insert into Cliente (Dni, Nombre, Apellido) values ('445308437', 'Donall', 'Gostling');

--Empleados
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('44451', 'Ricardo', 'Nantes', 'Ramos', to_date('2-Ene-1995','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 82560, NULL, NULL); -- GERENTE GENERAL No necesita un dept
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('01111', 'Pablo', 'Nantes', 'Moroni', to_date('8/Ago/1977','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 12560, '2','44451' ); --GERENTE DE COMPRAS
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('45454', 'beto', 'videa', 'yani', to_date('17/Oct/1981','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 12560, '1', '44451' ); --GERENTE DE RECURSOS HUMANOS
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('48225', 'jueas', 'pavon', 'juz', to_date('18/Ene/1992','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 12560, '3',  '44451'); -- GERENTE DE SEGURIDAD
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('78155', 'martin', 'yuca', 'ruiz', to_date('14/Ene/1974','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 12560, '4', '44451'); -- GERENTE DE BODEGA
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('48528', 'Carol', 'yuka', 'bengstoni', to_date('21/May/1999','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 12560, '5', '44451'); -- GERENTE DE MARKETING
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('12884', 'Lorena', 'mas', 'roca', to_date('16/Jun/1997','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '1', 12560, '6', '44451'); -- GERENTE DE Contabilidad
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('57421', 'miguel', 'gomes', 'rus', to_date('23/Jul/1987','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '3', 42560, '6', '12884'); -- CAJERO 1
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('14845', 'jaime', 'dias', 'Moni', to_date('28/Jul/1983','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '3', 12560, '6', '12884');-- CAJERO 2
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('57121', 'Pablo', 'figueroa', 'Moroni', to_date('21/May/1974','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '3', 11560, '6','12884' );-- CAJERO 3
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('32542', 'diego', 'Nantes', 'mendezi', to_date('7/Abr/1980','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '3', 44560, '6','12884' );-- CAJERO 4
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('51212', 'lucas', 'Nantes', 'Moroni', to_date('24/Ago/1981','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '3', 12560, '6','12884' );-- CAJERO 5
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('15421', 'mateo', 'Nantes', 'Ramos', to_date('4/Feb/1974','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '3', 45545, '6', '12884');-- CAJERO 6
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('21121', 'anita', 'Nantes', 'Mola', to_date('10/Dic/1990','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '3', 12560, '6', '12884');-- CAJERO 7
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('21212', 'Karen', 'Nantes', 'Mendoza', to_date('2/Ene/1996','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '3', 12560, '6', '12884');-- CAJERO 8
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('15454', 'Andrea', 'Nantes', 'medina', to_date('30/Mar/1993','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '3', 12560, '6', '12884');-- CAJERO 9
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('013333', 'Pedro', 'Juarez', 'Zenon', to_date('12/Ago/1973','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '3', 12560, '6', '12884');-- CAJERO 10
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('02111', 'Alexa', 'Niquel', 'Medina', to_date('6/Dic/1977','DD-MON-RR'),'F', 'Tegucigalpa', 'Diurna', '2', 12000, '4', '78155'); --Bodeguero
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('33111', 'Mario', 'Fernandez', 'Ramirez', to_date('3/Feb/2000','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '2', 12560, '4', '78155'); --Bodeguero
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('01331', 'Jeremias', 'Ledesma', 'Castillo', to_date('12/May/1981','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '2', 12570, '4', '78155'); --Bodeguero
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('01661', 'Fernanda', 'Lopez', 'Obrador', to_date('11/Ene/1982','DD-MON-RR'),'F', 'Tegucigalpa', 'Diurna', '5', 12580, '4', '78155'); --Reponedor
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('07711', 'Pablo', 'Nantes', 'Moroni', to_date('15/Sep/1972','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '5', 12680, '4', '78155'); --Reponedor
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('09911', 'Francisco', 'Mejia', 'robert', to_date('13/Mar/1987','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '5', 13560, '4', '78155'); --Reponedor
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('12211', 'Ramiro', 'Nantes', 'Moroni', to_date('31/Ene/1970','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '5', 16560, '4', '78155');--Reponedor
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('51181', 'Heber', 'Nantes', 'Moroni', to_date('4/Mar/1973','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '4', 17560, '3', '48225'); --Guardia de Seguridad
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('52051', 'Omar', 'Castro', 'Pineda', to_date('24/Abr/1974','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '4', 12560, '3', '48225'); --Guardia de Seguridad
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('45622', 'jueas', 'pavon', 'juz', to_date('4/May/1997','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '4', 12560, '3', '48225');--Guardia de Seguridad
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('45544', 'martin', 'yuca', 'ruiz', to_date('9/Sep/1976','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '4', 12560, '3', '48225');--Guardia de Seguridad
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('2544', 'Soniam', 'yamir', 'bengston', to_date('31/Ene/1989','DD-MON-RR'),'F', 'Tegucigalpa', 'Diurna', '6', 12560, '3', '48225'); --Oficial de monitoreo
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('78884', 'Loren', 'Garcia', 'Umanzor', to_date('9/Ene/1996','DD-MON-RR'),'F', 'Tegucigalpa', 'Diurna', '6', 12560, '3', '48225');--Oficial de monitoreo
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('27421', 'miguel', 'gomes', 'rus', to_date('19/Jul/1974','DD-MON-RR'),'F', 'Tegucigalpa', 'Diurna', '6', 45560, '3', '48225');--Oficial de monitoreo
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('52121', 'Pablo', 'figueroa', 'Batanco', to_date('31/Jul/1974','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '7', 12560, '1', '45454'); --Reclutador
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('32682', 'diego', 'segovia', 'mendez', to_date('29/Mar/1998','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '7', 4560, '1', '45454'); --Reclutador
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('52252', 'lucas', 'Medina', 'Moroni', to_date('27/Jul/1979','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '7', 12560, '1', '45454'); --Reclutador
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('42422', 'mateo', 'Videa', 'Ramos', to_date('22/Oct/1982','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '7', 45545, '1', '45454'); --Reclutador
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('51251', 'Juanita', 'Rosa', 'Mola', to_date('7/May/1997','DD-MON-RR'),'F', 'Tegucigalpa', 'Nocturna', '8', 12560, '2', '01111'); -- COMPRADOR
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('42016', 'Yolibeth', 'Walker', 'Mendoza', to_date('17/Sep/1972','DD-MON-RR'),'F', 'Tegucigalpa', 'Nocturna', '8', 12560, '2', '01111');-- COMPRADOR
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('1144', 'Andreina', 'Sky', 'medina', to_date('29/Nov/1987','DD-MON-RR'),'F', 'Tegucigalpa', 'Nocturna', '8', 12560, '2', '01111');-- COMPRADOR
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('02433', 'Pedro', 'Juarez', 'Zenon', to_date('29/Nov/1971','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '8', 12560, '2', '01111');-- COMPRADOR
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('07891', 'Alexa', 'Niquel', 'Medina', to_date('13/Nov/1991','DD-MON-RR'),'F', 'Tegucigalpa', 'Diurna', '8', 12000, '2', '01111');-- COMPRADOR
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('14411', 'Marto', 'Adonis', 'Ramirez', to_date('7/Nov/1990','DD-MON-RR'),'M', 'Tegucigalpa', 'Diurna', '8', 12560, '2', '01111');-- COMPRADOR
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('04541', 'Jeremias', 'Ledesma', 'Castillo', to_date('14/Feb/1975','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '9', 12570, '6', '12884'); -- CONTADOR
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('75221', 'Fernanda', 'Lopez', 'Obrador', to_date('23/Nov/1975','DD-MON-RR'),'F', 'SPS', 'Diurna', '9', 12580, '6', '12884');-- CONTADOR
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('07821', 'Pablo', 'sion', 'blandoi', to_date('14/Oct/1972','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '9', 12680, '6', '12884');-- CONTADOR
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('17871', 'carlos', 'amsa', 'robert', to_date('1/Abr/1987','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '10', 13560, '5', '48528');-- Mercadologo
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('13371', 'Rmson', 'Ness', 'Moroni', to_date('24/May/1979','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '10', 16560, '5', '48528');-- Mercadologo
insert into Empleado( Dni , Nombre, Apellido1, Apellido2, FechaNac,Sexo, Direccion, Jornada,TipoEmpleado,Sueldo,Dpto,SuperDni) values ('51589', 'Heber', 'Norl', 'Moroni', to_date('16/Sep/1992','DD-MON-RR'),'M', 'Tegucigalpa', 'Nocturna', '10', 17560, '5', '48528');-- Mercadologo

--TelefonoEmpleado
insert into TelefonoEmpleado (Dni, Telefono) values ('44451', '1766471405');
insert into TelefonoEmpleado (Dni, Telefono) values ('01111', '1907094772');
insert into TelefonoEmpleado (Dni, Telefono) values ('01111', '8706761940');
insert into TelefonoEmpleado (Dni, Telefono) values ('45454', '4099255975');
insert into TelefonoEmpleado (Dni, Telefono) values ('48225', '4551302219');
insert into TelefonoEmpleado (Dni, Telefono) values ('78155', '4904903273');
insert into TelefonoEmpleado (Dni, Telefono) values ('48528', '2819497275');
insert into TelefonoEmpleado (Dni, Telefono) values ('12884', '9227984734');
insert into TelefonoEmpleado (Dni, Telefono) values ('57421', '9982071033');
insert into TelefonoEmpleado (Dni, Telefono) values ('14845', '2608641350');
insert into TelefonoEmpleado (Dni, Telefono) values ('14845', '4374678867');
insert into TelefonoEmpleado (Dni, Telefono) values ('15421', '4259901156');
insert into TelefonoEmpleado (Dni, Telefono) values ('12211', '1777983184');
insert into TelefonoEmpleado (Dni, Telefono) values ('07891', '2869165997');
insert into TelefonoEmpleado (Dni, Telefono) values ('51181', '9502846065');
insert into TelefonoEmpleado (Dni, Telefono) values ('13371', '3995011001');
insert into TelefonoEmpleado (Dni, Telefono) values ('12211', '8771530477');
insert into TelefonoEmpleado (Dni, Telefono) values ('09911', '9677481900');
insert into TelefonoEmpleado (Dni, Telefono) values ('75221', '2617228027');
insert into TelefonoEmpleado (Dni, Telefono) values ('75221', '8227756146');
insert into TelefonoEmpleado (Dni, Telefono) values ('32682', '1873092349');
insert into TelefonoEmpleado (Dni, Telefono) values ('51181', '2768589862');
insert into TelefonoEmpleado (Dni, Telefono) values ('42422', '7559379815');
insert into TelefonoEmpleado (Dni, Telefono) values ('013333', '2031045663');
insert into TelefonoEmpleado (Dni, Telefono) values ('57421', '7098284781');
insert into TelefonoEmpleado (Dni, Telefono) values ('42422', '9039701358');
insert into TelefonoEmpleado (Dni, Telefono) values ('04541', '4057372833');
insert into TelefonoEmpleado (Dni, Telefono) values ('17871', '1182913687');
insert into TelefonoEmpleado (Dni, Telefono) values ('14411', '6018767041');
insert into TelefonoEmpleado (Dni, Telefono) values ('51181', '3763866541');
insert into TelefonoEmpleado (Dni, Telefono) values ('2544', '5147722116');
insert into TelefonoEmpleado (Dni, Telefono) values ('2544', '4299390915');
insert into TelefonoEmpleado (Dni, Telefono) values ('27421', '3073768463');
insert into TelefonoEmpleado (Dni, Telefono) values ('52051', '8949412081');
insert into TelefonoEmpleado (Dni, Telefono) values ('09911', '6903993804');
insert into TelefonoEmpleado (Dni, Telefono) values ('09911', '3676523200');
insert into TelefonoEmpleado (Dni, Telefono) values ('27421', '4272580535');
insert into TelefonoEmpleado (Dni, Telefono) values ('27421', '7187844339');
insert into TelefonoEmpleado (Dni, Telefono) values ('57121', '1615713565');
insert into TelefonoEmpleado (Dni, Telefono) values ('57121', '5928853540');
insert into TelefonoEmpleado (Dni, Telefono) values ('27421', '4021054009');
insert into TelefonoEmpleado (Dni, Telefono) values ('27421', '9613259844');
insert into TelefonoEmpleado (Dni, Telefono) values ('33111', '9414127670');
insert into TelefonoEmpleado (Dni, Telefono) values ('33111', '3885509089');
insert into TelefonoEmpleado (Dni, Telefono) values ('12211', '6616156396');
insert into TelefonoEmpleado (Dni, Telefono) values ('78884', '3661859569');
insert into TelefonoEmpleado (Dni, Telefono) values ('12211', '5532701173');

--Proveedor
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('1', 'Hortifruti', 'Natal', 'Mosconi', 'Fuling'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('2', 'Hortifruti', 'Norman', 'Moakler', 'Ust-Isha');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('3', 'Hortifruti', 'Selby', 'Kendall', 'Oklahoma City');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('4', 'Hortifruti', 'Nick', 'Londors', 'Lam Sonthi');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('5', 'Hortifruti', 'Lesya', 'Ladbury', 'Banjar Susut Kaja');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('6', 'Hortifruti', 'Elyse', 'Brundale', 'Sko�tari');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('7', 'Hortifruti', 'Felisha', 'Napoleon', 'Zapala');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('8', 'Cerveceria Hondurena', 'Betta', 'Robrose', 'Allanridge');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('9', 'Sula', 'Brandy', 'Penkethman', 'Vera Cruz');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('10','Sula', 'Xenia', 'Callan', 'Arroyo Naranjo');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('11', 'Sula', 'Lamar', 'Glentz', 'Hamilton');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('12', 'Sula', 'Emmet', 'MacUchadair', 'J�rna'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('13', 'Tang', 'Maible', 'Mattke', 'Bratislava'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('14', 'Leyde', 'Esme', 'McCarlich', 'Santiago de Cao'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('15', 'Leyde', 'Willey', 'Jewise', 'Kabakovo'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('16', 'Leyde', 'Amelina', 'Olin', 'Ribeira'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('17', 'Leyde', 'Barnabas', 'Benoy', 'Daphu'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('18', 'Scott', 'Mellisent', 'Lusgdin', 'London'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('19', 'Scott', 'Ambur', 'Spittal', 'Saint-Louis du Nord');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('20', 'Tang', 'Bambi', 'Gavin', 'Libertad');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('21', 'Supermax', 'Tynan', 'Galliver', 'Loimaan Kunta'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('22', 'Supermax', 'Alon', 'German', 'Di�bougou'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('23', 'Supermax', 'Gottfried', 'Hourahan', 'Sydney');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('24', 'Suli', 'Zebulen', 'Gribbon', 'Sepulu'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('25', 'Suli', 'Engelbert', 'Shadfourth', 'Las Palmas'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('26', 'Suli', 'Ferdie', 'Curling', 'Tuwiri Wetan'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('27', 'Suli', 'Stavros', 'Sorel', 'Loay'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('28', 'Toledo', 'Hetty', 'Catteroll', 'Cosm�polis'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('29', 'Toledo', 'Darbie', 'Marzelli', 'Ciparay'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('30', 'Tang', 'Melvyn', 'Barnsley', 'Er�tria'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('31', 'Fud', 'Amy', 'Pentycross', 'Inuvik'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('32', 'Fud', 'Dody', 'Laying', 'La Gloria'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('33', 'Dove', 'Pearla', 'Liffey', 'Shubenka'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('34', 'Delicia', 'Reynold', 'Maxwaile', 'Itapecerica da Serra'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('35', 'Delicia', 'Emmy', 'Sheddan', 'Aldeia da Piedade'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('36', 'Delicia', 'Nehemiah', 'Shrimpton', 'London'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('37', 'Nivea', 'Dayle', 'Iacoboni', 'Tarouca'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('38', 'Gati', 'Cherianne', 'Scemp', 'London'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('39', 'Bimbo', 'Kevon', 'Janouch', 'Sydney'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('40', 'Purina', 'Missy', 'Wort', 'Solana');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('41', 'Purina', 'Korey', 'Calven', 'Kampong Cham');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('42', 'Purina', 'Elissa', 'Humphrey', 'Dahe');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('43', 'Purina', 'Jaymee', 'Padillo', 'Philadelphia'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('44', 'Bimbo', 'Claudia', 'Regelous', 'Guaraciaba do Norte');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('45', 'Pedigree', 'Butch', 'Wetherill', 'Sydney');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('46', 'Tang', 'Tanner', 'Bowich', 'Klavdiyevo-Tarasove');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('47', 'Hortifutri', 'Pat', 'Betham', 'Abuyog');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('48', 'Naturas', 'Bess', 'Haliday', 'Cali');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('49', 'Naturas', 'Gal', 'Bedle', 'Wiyayu Barat'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('50', 'Naturas', 'Corissa', 'Innman', 'Kibondo'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('51', 'Hortifruti', 'Austine', 'Grimolbie', 'Qiaole');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('52', 'Hortifruti', 'Eyde', 'Hanmore', 'Chile Chico'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('53', 'Yummies', 'Dorie', 'Hegerty', 'Lagoa de Albufeira');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('54', 'Yummies', 'Elene', 'Dilke', 'Longtou'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('55', 'Hortifutri', 'Gabriele', 'Titman', 'Kezilei'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('56', 'Hortifruti', 'Karel', 'Eckert', 'Limeil-Br�vannes'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('57', 'Yummies', 'Wilhelmine', 'Pruce', 'Xikou'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('58', 'Nabisco', 'Bili', 'Edelheit', 'Lanshan'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('59', 'Nabisco', 'Lorelle', 'Bywaters', 'Yeniugou'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('60', 'Nabisco', 'Francine', 'Cowtherd', 'Bogdaniec');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('61', 'Aguazul', 'Marylee', 'Ferryn', 'Guapimirim'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('62', 'El Corral', 'Shaylah', 'Dawe', 'Canedo'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('63', 'El Corral', 'Koressa', 'Mouncey', 'Betong'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('64', 'El Corral', 'Derrick', 'Jeffree', 'Palca'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('65', 'El Corral', 'Mitchael', 'Arnholz', 'Rantepang'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('66', 'El Corral', 'Caryn', 'Gozard', 'Naperville'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('67', 'Don Cristobal', 'Arliene', 'Broadey', 'Nor Yerznka'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('68', 'Don Cristobal', 'Cale', 'Orsi', 'Glagahdowo'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('69', 'Don Cristobal', 'Sibylla', 'Murrie', 'Yangyu'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('70', 'Don Cristobal', 'Louisa', 'Mancer', 'Kalianyar Selatan'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('71', 'El Corral', 'Jacques', 'Watt', 'Non Sang'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('72', 'Coca-Colal', 'Gib', 'Allderidge', 'Amsterdam Westpoort'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('73', 'Hortifruti', 'Nancee', 'Hardiker', 'Steinkjer'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('74', 'Pepsi', 'Clayborn', 'Bagnell', 'Qiaozhen'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('75', 'Coca-Cola', 'Arnoldo', 'De Francesco', 'Taloko'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('76', 'Coca-Cola', 'Rafaelita', 'Hedling', 'G�teborg'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('77', 'Tang', 'Shalne', 'Jacmar', 'Adamantina'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('78', 'Tang', 'Blakeley', 'Feaver', 'Fenyan');  
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('79', 'Tang', 'Vally', 'Walkley', 'Longshan');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('80', 'Pepsi', 'Gregorius', 'Grewar', 'Abuyog');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('81', 'Pepsi', 'Tootsie', 'Glave', 'Klapagada'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('82', 'Pepsi', 'Lorri', 'Bonhan', 'Alexandria'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('83', 'Bimbo', 'Editha', 'Savege', 'Cruz de Pau');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('84', 'Bimbo', 'Marsh', 'Mervyn', 'Calvinia'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('85', 'Bimbo', 'Tiffie', 'Pittet', 'Velikiye Borki'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('86', 'Monarca', 'Rey', 'Cratchley', 'Baochang'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('87', 'Monarca', 'Elisabet', 'Pirrie', 'San Isidro');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('88', 'Hortifruti', 'Fowler', 'Hallawell', 'Malumfashi');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('89', 'Nivea', 'Cori', 'Kenan', 'Anning'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('90', 'Nivea', 'Chance', 'Brogden', 'Huskvarna'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('91', 'Nivea', 'Merry', 'Philippon', 'Nangahale');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('92', 'Nivea', 'Vaclav', 'Boch', 'Horn� Cerekev'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('93', 'Colgate', 'Ashlan', 'Salla', 'Tabaquite'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('94', 'Colgate', 'Darlleen', 'MacCosto', 'Kuantan'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('95', 'Dove', 'Galven', 'Hexum', 'At Tibn?'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('96', 'Dove', 'Lari', 'Gaddas', 'Vitina'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('97', 'Dove', 'Geoffry', 'Boycott', 'Gaomiaoji'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('98', 'Cerveceria Hondurena', 'Garrot', 'Ruby', 'La Motte-Servolex'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('99', 'Cerveceria Hondurena', 'Zonda', 'Guest', 'Liutang'); 
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('100', 'Cerveceria Hondurena', 'Benoite', 'Spurret', 'Huangdu');
insert into Proveedor (CodProv, NombreMarca, NombreEncargado, ApellidoEncargado, Direccion) values ('101', 'Cerveceria Hondurena', 'Alejandro', 'Ramos', 'Los Prados'); 

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
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('0000000071789','Hortifruti','Lim�n Persa ud',3.50,'Frutas');
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
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7622210864734','Tang','Bebida en Polvo Guayaba-Pi�a',5.70,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7622210864116','Tang','Bebida en Polvo Naranaja',5.70,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7622210863263','Tang','Bebida en Polvo Fresa',5.70,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7622210864154','Tang','Bebida en Polvo Limon',5.70,'Jugos y Bebidas');
INSERT INTO Producto (CodBarra , Marca, Descripcion, Precio, Ubicacion) VALUES ('7622210863492','Tang','Bebida en Polvo Pi�a',5.70,'Jugos y Bebidas');
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

--CAJEROS
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('57421','1'); 
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('14845','2'); 
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('57121','3');
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('32542','4');
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('51212','5');
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('15421','1');
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('21121','2');
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('21212','3');
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('15454','4');
INSERT INTO CAJA (CodCajero, NumCaja) VALUES ('013333','5');

--Factura
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('60505-2865','499600265','Credito', 7548.78, to_date('31-Ene-1958','DD-MON-RR'),'57421');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('42254-023','961859456','Contado', 1389.1, to_date('21-Oct-1977','DD-MON-RR'),'14845');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('13537-434','910111724','Credito', 8273.82, to_date('2001-09-25','RRRR-MM-DD'),'14845');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('10742-8582','858309463','Credito', 8073.88, to_date('1968-11-04','RRRR-MM-DD'),'32542');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('37000-069','821482327','Credito', 6239.7, to_date('1964-12-18','RRRR-MM-DD'),'32542');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('52959-772','834560057','Credito', 7805.15, to_date('2008-10-21','RRRR-MM-DD'),'32542');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('57237-066','082127282','Contado', 1993.17, to_date('2006-02-20','RRRR-MM-DD'),'32542');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('52125-534','272334526','Credito', 1878.96, to_date('1996-10-21','RRRR-MM-DD'),'32542');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('33342-026','605912746','Contado', 4826.46, to_date('1963-06-01','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('60232-2290','653136286','Credito', 8564.31, to_date('2001-01-29','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('14783-328','709902113','Contado', 3289.49, to_date('1970-06-08','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('37205-637','757569278','Credito', 2337.24, to_date('1984-09-26','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('55289-315','640706943','Contado', 7239.5, to_date('1979-04-12','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('53877-009','301969639','Credito', 7533.89, to_date('1983-03-01','RRRR-MM-DD'),'15421');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('62011-0012','936398685','Credito', 2667.0, to_date('1960-06-19','RRRR-MM-DD'),'15421');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('49653-001','069419213','Credito', 2648.04, to_date('1997-12-17','RRRR-MM-DD'),'15421');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('55111-166','257299547','Contado', 124.85, to_date('1973-07-15','RRRR-MM-DD'),'15421');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('16590-416','680351462','Credito', 7642.45, to_date('1979-01-30','RRRR-MM-DD'),'32542');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0093-7304','167889033','Credito', 433.99, to_date('1952-01-19','RRRR-MM-DD'),'32542');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0009-0039','666322622','Contado', 7318.96, to_date('1996-10-17','RRRR-MM-DD'),'32542');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('64720-153','538302340','Credito', 3285.77, to_date('1956-04-09','RRRR-MM-DD'),'32542');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('68016-115','223505314', 'Credito', 6201.33, to_date('1973-03-22','RRRR-MM-DD'),'32542');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('58060-002','439703441','Contado', 3277.91, to_date('1954-09-02','RRRR-MM-DD'),'32542');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('52270-001','893735382','Credito', 9698.3, to_date('1982-03-08','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0299-5908','377926713','Credito', 2874.93, to_date('1968-07-29','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('52125-248','879762529','Credito', 8582.12, to_date('1992-02-08','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('11523-4140','050001023','Contado', 7780.9, to_date('1999-01-30','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('52959-558','250110400','Credito', 7773.68, to_date('1983-02-10','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('31511-008','574097871','Contado', 9482.61, to_date('1975-06-28','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('60429-174','874395853','Credito', 7903.88, to_date('1950-08-05','RRRR-MM-DD'),'15421');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('10893-083','902257883','Credito', 391.72, to_date('1951-11-03','RRRR-MM-DD'),'15421');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0024-5810','326683185','Contado', 5609.69, to_date('1995-10-10','RRRR-MM-DD'),'15421');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('54868-0736','707680155','Credito', 8047.62, to_date('1972-12-08','RRRR-MM-DD'),'15421');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('36987-3012','911253390','Credito', 6149.11, to_date('1978-11-19','RRRR-MM-DD'),'15421');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('24471-200','205244418','Contado', 6700.76, to_date('1951-01-22','RRRR-MM-DD'),'14845');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('55154-8255','410547752','Contado', 6994.45, to_date('1951-05-06','RRRR-MM-DD'),'14845');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('68788-9702','521155850','Credito', 2382.87, to_date('1983-09-18','RRRR-MM-DD'),'14845');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('36987-3046','854125534','Contado', 5972.59, to_date('1958-07-04','RRRR-MM-DD'),'14845');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('55111-441','401190044','Credito', 7507.78, to_date('1959-04-19','RRRR-MM-DD'),'14845');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('54868-2149','348167095','Credito', 6568.45, to_date('1968-06-10','RRRR-MM-DD'),'14845');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('54973-2911','554446831','Credito', 7960.28, to_date('1991-07-04','RRRR-MM-DD'),'14845');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('64942-1059','903507575','Contado', 5093.43, to_date('1992-08-13','RRRR-MM-DD'),'14845');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('98132-725','268643734','Credito',8251.17, to_date('2010-09-07','RRRR-MM-DD'),'14845');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('67777-244','041692028','Contado', 342.14, to_date('1997-05-05','RRRR-MM-DD'),'14845');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('52642-010','401237143','Contado', 9788.23, to_date('1950-09-16','RRRR-MM-DD'),'013333');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('76187-850','120567959','Credito', 6831.39, to_date('1977-02-07','RRRR-MM-DD'),'013333');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('37000-613','783481001','Contado', 630.55, to_date('1979-07-03','RRRR-MM-DD'),'013333');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0615-7656','208372208', 'Credito',4505.54, to_date('1999-11-20','RRRR-MM-DD'),'013333');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('48951-8080','705518751','Contado', 2838.06, to_date('1990-06-06','RRRR-MM-DD'),'013333');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('60512-6997','513045182','Credito', 171.4, to_date('1991-09-16','RRRR-MM-DD'),'013333');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('68472-104','127704888','Credito', 1343.19, to_date('1989-12-21','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('50268-512','457336205','Contado', 3644.69, to_date('1970-03-21','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0485-0208','115069647','Credito', 3970.98, to_date('1982-05-28','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('75981-210','161038247','Contado', 4665.7, to_date('1966-05-02','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('54868-5826','330065672','Credito', 1827.87, to_date('2010-10-27','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('51079-385','729695886','Contado', 6832.68, to_date('1998-05-28','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('51345-111','288711954','Credito', 7575.3, to_date('1979-04-18','RRRR-MM-DD'),'15454');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('36987-2504','596712550','Credito', 9448.29, to_date('1995-10-21','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('58443-0034','844349060','Contado', 7976.41, to_date('1988-08-21','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('54569-2411','546557112','Credito', 8875.78, to_date('2007-04-02','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0187-5525','826165417','Contado', 969.39, to_date('1968-09-17','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0085-1279','624937635','Contado', 8061.65, to_date('1955-09-04','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0615-7607','711121374','Credito', 3010.21, to_date('1985-11-22','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('49643-113','848067543','Contado', 7248.66, to_date('2010-02-18','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('54973-2158','921588671','Credito', 2562.1, to_date('1965-09-23','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0135-0510','652431362','Credito', 8076.15, to_date('1989-11-02','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('14290-377','916743733','Contado', 1129.45, to_date('1952-04-01','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('75854-302','210100340','Credito', 5790.05, to_date('1989-06-12','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('36987-3112','235933973','Credito', 7629.57, to_date('1956-09-30','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0573-0169','191355428','Credito', 1175.46, to_date('1966-11-29','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('43406-0112','807166478','Credito', 8615.51, to_date('1963-01-30','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('16729-043','568443506','Credito', 2809.71, to_date('1982-10-07','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0378-6410','447427181','Credito', 1933.03, to_date('1980-03-27','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('42507-282','592207922','Contado', 4577.66, to_date('1992-04-25','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('75981-602','760760275','Credito', 3487.2, to_date('1998-10-28','RRRR-MM-DD'),'21212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('54973-0622','314028559','Credito', 4510.79, to_date('1982-05-20','RRRR-MM-DD'),'21121');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('55154-2710','800828536','Credito', 3087.46, to_date('1952-01-20','RRRR-MM-DD'),'21121');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('55289-523','715042253','Credito', 9658.48, to_date('1967-05-08','RRRR-MM-DD'),'21121');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('42549-615','822437815','Credito', 6205.83, to_date('1956-07-28','RRRR-MM-DD'),'21121');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('52137-1001','376662492','Contado', 525.8, to_date('1969-04-01','RRRR-MM-DD'),'21121');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('49643-105','198858026','Credito', 7350.92, to_date('1977-11-15','RRRR-MM-DD'),'21121');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0093-5141','111882640','Contado', 4977.16, to_date('2005-01-23','RRRR-MM-DD'),'21121');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('59262-262','322022364','Credito', 2934.98, to_date('1965-12-27','RRRR-MM-DD'),'21121');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('49884-311','421798857','Credito', 7741.28, to_date('2011-07-09','RRRR-MM-DD'),'15421');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('63736-410','647935827','Credito', 5694.13, to_date('1980-09-10','RRRR-MM-DD'),'15421');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('66336-147','587772369','Contado', 7077.99, to_date('1953-09-16','RRRR-MM-DD'),'15421');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('44911-0117','857218260','Credito', 702.4, to_date('1988-03-17','RRRR-MM-DD'),'15421');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('59746-338','831980634','Credito', 4689.03, to_date('1961-01-29','RRRR-MM-DD'),'15421');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('64942-1287','107496558','Contado', 6162.0, to_date('1975-03-28','RRRR-MM-DD'),'51212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('60505-3276','411782763','Credito', 7977.2, to_date('2007-09-08','RRRR-MM-DD'),'51212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('55154-2418','186243015','Credito', 5087.43, to_date('1953-07-15','RRRR-MM-DD'),'51212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('16729-212','537020587','Contado', 3324.84, to_date('2004-01-20','RRRR-MM-DD'),'51212');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('68258-6972','781600723','Credito', 3635.17, to_date('1988-05-05','RRRR-MM-DD'),'32542');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('48951-1219','258891174','Contado', 9552.64, to_date('1970-05-18','RRRR-MM-DD'),'32542');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('59900-120','528288902','Contado', 4382.61, to_date('2010-05-13','RRRR-MM-DD'),'32542');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('31720-209','078999230','Credito', 2510.43, to_date('1974-09-06','RRRR-MM-DD'),'57121');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0178-0821','474712553','Credito', 7877.28, to_date('1984-12-04','RRRR-MM-DD'),'57121');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('49967-699','480041339','Credito', 9480.32, to_date('1987-05-10','RRRR-MM-DD'),'57121');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('0603-6150','417624380','Contado', 4782.58, to_date('1969-01-22','RRRR-MM-DD'),'14845');
insert into Factura (IdFactura,DniCliente,TipoPago, MontoFinal, Fecha,Cajero) values ('41520-361','445308437','Credito', 4823.61, to_date('1997-07-21','RRRR-MM-DD'),'57421');

--Detalle Factura
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('60505-2865','1','2540610000000', 7,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('60505-2865','2','7422540015611', 3,54);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('42254-023','3','2572780000009', 4,91);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('42254-023','4','7421000812012', 8,84);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('13537-434','5','2545620000002', 5,91);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('13537-434','6','0795893101414', 10,1);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('10742-8582','7','0795893410110', 1,24);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('10742-8582','8','2540830000002', 4,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('37000-069','9','0000000040501', 5,65);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('37000-069','10','0795893301319', 10,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52959-772','11','2540160000000', 6,45);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52959-772','12','7441008169857', 1,56);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('57237-066','13','0000000071963', 2,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('57237-066','14','7406131001870', 6,65);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52125-534', '15','2540930000001', 2,76);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52125-534','16','7441078230150', 7,92);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('33342-026','17','0000000040716', 3,74);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('33342-026','18','7441078224395', 7,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('60232-2290','19','0000000048996', 4,92);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('60232-2290','20','7441078228980', 6,74);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('14783-328','21','428630102117', 1,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('14783-328','22','7406131004789', 1,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('37205-637','23','2571530000009', 5,45);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('37205-637','24','7441008162278', 2,45);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55289-315','25','0000000044332', 5,25);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55289-315','26','7441078229130', 5,24);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('53877-009','27','0000000071789', 4,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('53877-009','28','7501072210302', 4,93);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('62011-0012','29','2533830000004', 3,32);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('62011-0012','30','0023100041049', 3,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('49653-001','31','7421000811367', 3,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('49653-001','32','7411000315033', 8,92);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55111-166','33','7421000840817', 7,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55111-166','34','7411000313985', 8,23);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('16590-416','35','7421000843030', 8,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('16590-416','36','7411000345061', 9,92);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0093-7304','37','7401004510114', 1,28);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0093-7304','38','0750894600267', 2,43);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0009-0039','39','7401004530938', 8,43);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0009-0039','40','7590011151110', 3,54);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('64720-153','41','7441008941705', 10,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('64720-153','42','0750894600717', 6,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('68016-115','43','7441008943143', 10,23);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('68016-115','44','2517230000000', 8,12);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('58060-002','45','2589290000009', 2,12);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('58060-002','46','2583000000006', 8,32);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52270-001','47','7421000952404', 9,43);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52270-001','48','2583020000000', 5,45);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0299-5908','49','7421000910022', 7,65);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0299-5908','50','2565160000003', 5,76);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52125-248','51','0722304206963', 7,87);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52125-248','52','7420001000411', 2,96);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('11523-4140','53','7501072206725', 1,74);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('11523-4140','54','0611594000019', 1,73);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52959-558','55','0023100051048', 5,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('52959-558','56','7422110100556', 5,92);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('31511-008','56','7501777001151', 4,72);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('31511-008','58','0784562010508', 8,91);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('60429-174','59','0721282301059', 2,72);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('60429-174','60','0784562010652', 3,23);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('10893-083','61','7590011105106', 4,10);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('10893-083','62','7622210864536', 7,83);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0024-5810','63','7622210673688', 1,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0024-5810','64','7622210864680', 3,73);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('54868-0736','65','7421900703144', 4,54);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('54868-0736','66','7622210864734', 5,32);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('36987-3012','67','2511930000001', 10,32);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('36987-3012','68','7622210864116', 1,45);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('24471-200','69','2520230000000', 7,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('24471-200','70','7622210863263', 9,73);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55154-8255','71','7441029500110', 2,83);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55154-8255','72','7421900700525', 9,72);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('68788-9702','73','2593000000005', 6,52);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('68788-9702','74','7622210864154', 8,82);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('36987-3046','75','7622210863492', 4,83);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('36987-3046','76','7421601102109', 5,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55111-441','77','7421601100013', 2,92);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55111-441','78','7421601100037', 9,62);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('41520-361','79','7421600300087', 8,22);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('41520-361','80','7441029514179', 9,74);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0603-6150','81','7441029555660', 5,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0603-6150','82','7441029556735', 2,73);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('49967-699','83','7401006713308', 2,93);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('49967-699','84','7441029518009', 4,83);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0178-0821','85','7441029511987', 8,43);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('0178-0821','86','7506306246546', 3,24);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('31720-209','87','7506306213357', 10,92);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('31720-209','88','7411000356487', 2,72);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('48951-1219','89','7702191001097', 10,73);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('48951-1219','90','7509546000350', 10,63);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('68258-6972','91','7509546052861', 4,74);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('68258-6972','92','0000042277095', 6,91);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('16729-212','93','8715200813061', 4,73);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('16729-212','94','7501054503095', 3,65);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55154-2418','95','4005808239603', 4,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('55154-2418','96','4005900734129', 2,34);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('60505-3276','97','0784562403058', 1,35);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('60505-3276','98','7422110101331', 2,57);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('64942-1287','99','7422110101348', 10,80);
insert into DetalleFactura (IdFactura, NumRegistro, CodProducto, Cantidad, SubTotal) values ('64942-1287','100','0715126400022', 6,99);

-- Abastecimiento
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('1', '17', '013333', 2824, to_date('07-01-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('2', '1', '013333',  925, to_date('13-01-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('3', '8', '013333', 1617, to_date('30-01-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('4', '9', '013333', 4037, to_date('10-02-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('5', '18', '013333', 20475, to_date('12-02-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('6', '100', '52121', 20363, to_date('23-02-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('7', '77', '1144', 855, to_date('27-02-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('8', '80', '1144', 12672, to_date('06-03-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('9', '85', '52121', 17236, to_date('07-03-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('10', '86', '1144', 19656, to_date('10-03-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('11', '96', '1144', 49500, to_date('28-03-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('12', '91', '52121', 31800, to_date('01-04-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('13', '98', '1144', 966, to_date('12-04-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('14', '97', '52121', 3040, to_date('27-04-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('15', '2', '1144', 498, to_date('05-05-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('16', '3', '013333', 800, to_date('15-05-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('17', '14', '1144', 11418, to_date('21-05-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('18', '93', '1144', 11000, to_date('30-05-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('19', '95', '1144', 85000, to_date('07-06-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('20', '79', '013333', 2394, to_date('17-06-2021','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('21', '13', '013333', 456, to_date('27-06-2021','DD-MM-RRRR'));            
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('22', '20', '1144', 171, to_date('27-06-2021','DD-MM-RRRR'));            
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('23', '30', '52121', 399, to_date('27-06-2021','DD-MM-RRRR'));            
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('24', '83', '1144', 2493, to_date('27-06-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('25', '33', '52121', 11624, to_date('27-06-2021','DD-MM-RRRR'));            
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('26', '94', '013333', 9000, to_date('27-06-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('27', '40', '1144', 10565, to_date('27-06-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('28', '5', '1144', 1740, to_date('27-06-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('29', '6', '52121', 760, to_date('27-06-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('30', '7', '17871', 1595, to_date('27-06-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('31', '4', '17871', 1840, to_date('04-07-2021','DD-MM-RRRR'));            
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('32', '99', '52121', 1512, to_date('10-07-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('33', '101', '17871', 13905, to_date('20-07-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('34', '37', '17871', 29360, to_date('02-08-2021','DD-MM-RRRR'));            
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('35', '92', '17871', 49000, to_date('12-08-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('36', '90', '17871', 47670, to_date('20-08-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('37', '89', '17871', 15000, to_date('26-08-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('38', '88', '17871', 5850, to_date('03-09-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('39', '87', '013333', 5280, to_date('17-09-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('40', '81', '013333', 4592, to_date('23-09-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('41', '82', '17871', 3120, to_date('30-09-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('42', '74', '17871', 910, to_date('05-10-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('43', '84', '17871', 15092, to_date('15-10-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('44', '39', '17871', 4384, to_date('27-10-2021','DD-MM-RRRR'));             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('45', '46', '17871', 1881, to_date('10-11-2021','DD-MM-RRRR'));             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('46', '78', '013333', 684, to_date('11-11-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('47', '47', '17871', 3000, to_date('23-11-2021','DD-MM-RRRR'));             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('48', '15', '17871', 4500, to_date('29-11-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('49', '24', '17871', 1980, to_date('05-12-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('50', '25', '17871', 3500, to_date('17-12-2021','DD-MM-RRRR')); 
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('51', '51', '09911', 531, to_date('30-12-2021','DD-MM-RRRR'));             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('52', '52', '09911', 1580.5, to_date('02-01-2022','DD-MM-RRRR'));             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('53', '55', '17871', 2695, to_date('10-01-2022','DD-MM-RRRR'));             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('54', '56', '09911', 3180, to_date('31-01-2022','DD-MM-RRRR'));             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('55', '61', '09911', 2464, to_date('07-02-2022','DD-MM-RRRR'));             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('56', '75', '17871', 1206, to_date('20-02-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('57', '62', '17871', 12050, to_date('27-02-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('58', '69', '09911', 18480, to_date('01-03-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('59', '63', '17871', 5600, to_date('11-03-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('60', '65', '013333', 6300, to_date('29-03-2022','DD-MM-RRRR'));       
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('61', '64', '17871', 11070, to_date('12-04-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('62', '67', '1144', 8208, to_date('17-04-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('63', '66', '013333', 31960, to_date('30-04-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('64', '70', '52121', 7750, to_date('04-05-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('65', '71', '09911', 55230, to_date('12-05-2022','DD-MM-RRRR'));             
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('66', '72', '52121', 22440, to_date('25-05-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('67', '76', '52121', 14703, to_date('10-06-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('68', '68', '09911', 3555, to_date('20-06-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('69', '59', '013333', 3920, to_date('30-06-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('70', '58', '1144', 9975, to_date('01-07-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('71', '73', '09911', 11270, to_date('07-07-2022','DD-MM-RRRR'));              
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('72', '12', '52121', 15400, to_date('21-07-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('73', '10', '013333', 3429, to_date('28-07-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('74', '11', '013333', 11904, to_date('02-08-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('75', '16', '013333', 1535, to_date('12-08-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('76', '21', '09911', 5850, to_date('31-08-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('77', '27', '09911', 2750, to_date('07-09-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('78', '26', '1144', 1700, to_date('13-09-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('79', '54', '09911', 3525, to_date('22-09-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('80', '19', '1144', 9874.5, to_date('29-09-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('81', '88', '09911', 805, to_date('06-10-2022','DD-MM-RRRR'));       
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('82', '22', '52121', 21330, to_date('16-10-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('83', '28', '1144', 1020, to_date('27-10-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('84', '53', '013333', 14750, to_date('30-10-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('85', '50', '013333', 11730, to_date('02-11-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('86', '57', '52121', 19276, to_date('14-11-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('87', '38', '09911', 11050, to_date('24-11-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('88', '48', '1144', 15810, to_date('27-11-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('89', '60', '09911', 7020, to_date('29-11-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('90', '49', '52121', 1165, to_date('30-11-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('91', '44', '09911', 41790, to_date('01-12-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('92', '29', '52121', 23430, to_date('07-12-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('93', '31', '09911', 3600, to_date('13-12-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('94', '41', '52121', 20088, to_date('18-12-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('95', '32', '09911', 34160, to_date('20-12-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('96', '45', '09911', 13500, to_date('22-12-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('97', '42', '52121', 28815, to_date('24-12-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('98', '34', '09911', 5040, to_date('26-12-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('99', '35', '52121', 10200, to_date('27-12-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('100', '36', '09911', 7700, to_date('28-12-2022','DD-MM-RRRR'));
INSERT INTO Abastecimiento (IdAbasto, CodProv, DniEmp, Total, Fecha) values ('101', '43', '52121', 20750, to_date('30-12-2022','DD-MM-RRRR'));


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
