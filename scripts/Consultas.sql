--Traer el empleado mejor pagado del departamento de Recursos Humanos
Select * 
From Supermercado Empleado 
Where Dpto = '1' AND Sueldo =(Select Max(sueldo) From Empleado Where Dpto = '1');

--Traer al empleado mas Viejo del departamento de Compras
Select * 
From Empleado 
Where Dpto = '2' AND FechaNac = (SELECT MIN(FechaNac) FROM Empleado E WHERE Dpto = '2');

-- Traer todos los suministros que tienen CodAbastecimiento = 59
SELECT A.CodProv 
        ,P.NombreMarca
        , P.NombreEncargado 
        , P.ApellidoEncargado
        ,S.CodProducto
        ,S.Stock
        , A.Fecha
FROM Suministro S
INNER JOIN Abastecimiento A
ON S.CodAbastecimiento = A.IdAbasto
INNER JOIN Proveedor P
ON A.CodProv = P.CodProv
WHERE CodAbastecimiento = '59' 

--Traer todas las lineas de la factura numero == (Solamente Nombre de producto, Cantidad y Precio)
SELECT  Descripcion
        ,Cantidad 
        ,Subtotal 
FROM DetalleFactura DF
INNER JOIN Producto P
ON DF.CodProducto = P.CodBarra
WHERE IdFactura = '60505-2865'

-- Traer el nombre y el pasillo donde se encuentran los diferentes producos de Sula en el supermercado
SELECT Descripcion
        , Pasillo
FROM Producto P
INNER JOIN Area A
ON P.Ubicacion = A.NombreArea
WHERE P.Marca = 'Sula'

-- Traer todos los telefonos del proveedor 90
SELECT Telefono
FROM TelefonoProveedor
WHERE CodProv = '90';

--Traer el nombre, apellido, Dni y rol que desempeña los empleados del departamento de seguridad
SELECT   E.Nombre
        ,E.Apellido1
        ,E.Dni
        ,TE.Descripcion
        ,D.Nombre Departamento
FROM Empleado e
INNER JOIN TipoEmpleado TE
ON E.TipoEmpleado = TE.IdTipoEmp
INNER JOIN Departamento D
ON E.Dpto = D.NumDpto
WHERE Dpto = '3';