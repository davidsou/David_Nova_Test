
------------------------------------------------------------------------------------------------------------------
--Create ClientType Table. Domain Table
------------------------------------------------------------------------------------------------------------------

CREATE TABLE ClientType (
  idClientType INTEGER  NOT NULL   IDENTITY ,
  stName VARCHAR(20)  NOT NULL  ,
  stDescription VARCHAR(100)    ,
  coTpOperation CHAR(1)  NOT NULL  ,
  coUserOperation VARCHAR(20)  NOT NULL  ,
  dtOperation DATETIME  NOT NULL    ,
PRIMARY KEY(idClientType));
GO

------------------------------------------------------------------------------------------------------------------
--Create Categories Table. Domain Table
------------------------------------------------------------------------------------------------------------------

CREATE TABLE Categories (
  idCategories INTEGER  NOT NULL   IDENTITY ,
  stCategoryName VARCHAR(50)  NOT NULL  ,
  coTpOperation CHAR(1)  NOT NULL  ,
  coUserOperation VARCHAR(20)  NOT NULL  ,
  dtOperation DATETIME  NOT NULL    ,
PRIMARY KEY(idCategories));
GO

------------------------------------------------------------------------------------------------------------------
--Create TimeLine Table. Domain Table
------------------------------------------------------------------------------------------------------------------

CREATE TABLE TimeLine (
  idTimeLine INTEGER  NOT NULL   IDENTITY ,
  stName VARCHAR(20)  NOT NULL  ,
  stDescription VARCHAR(50)    ,
  coTpOperation CHAR(1)  NOT NULL  ,
  coUserOperation VARCHAR(20)  NOT NULL  ,
  dtOperation DATETIME  NOT NULL    ,
PRIMARY KEY(idTimeLine));
GO

------------------------------------------------------------------------------------------------------------------
--Create Client Table
------------------------------------------------------------------------------------------------------------------

CREATE TABLE Clients (
  idClient INTEGER  NOT NULL   IDENTITY ,
  idClientType INTEGER  NOT NULL  ,
  strName VARCHAR(100)  NOT NULL  ,
  chrGender VARCHAR(15)  NOT NULL  ,
  dtBirthday DATETIME  NOT NULL  ,
  coTpOperation CHAR(1)  NOT NULL  ,
  coUserOperation VARCHAR(20)  NOT NULL  ,
  dtOperation DATETIME  NOT NULL    ,
PRIMARY KEY(idClient, idClientType)  ,
  FOREIGN KEY(idClientType)
    REFERENCES ClientType(idClientType));
GO


CREATE INDEX Clients_FKIndex1 ON Clients (idClientType);
GO


CREATE INDEX IFK_Rel_01 ON Clients (idClientType);
GO

------------------------------------------------------------------------------------------------------------------
--Create Adress Table
------------------------------------------------------------------------------------------------------------------


CREATE TABLE Address (
  idAddress INTEGER  NOT NULL   IDENTITY ,
  idClientType INTEGER  NOT NULL  ,
  idClient INTEGER  NOT NULL  ,
  inNumber INTEGER  NOT NULL  ,
  stAdress VARCHAR(100)  NOT NULL  ,
  inPostalCode INTEGER    ,
  stState VARCHAR(50)  NOT NULL  ,
  stCity VARCHAR(50)  NOT NULL  ,
  stCountry VARCHAR(50)  NOT NULL  ,
  stEmail VARCHAR(50)    ,
  coTpOperation CHAR(1)  NOT NULL  ,
  coUserOperation VARCHAR(20)  NOT NULL  ,
  dtOperation DATETIME  NOT NULL  ,
  boIsActive bit  NOT NULL    ,
PRIMARY KEY(idAddress, idClientType, idClient)  ,
  FOREIGN KEY(idClient, idClientType)
    REFERENCES Clients(idClient, idClientType));
GO


CREATE INDEX Address_FKIndex1 ON Address (idClient, idClientType);
GO


CREATE INDEX IFK_Rel_02 ON Address (idClient, idClientType);
GO


------------------------------------------------------------------------------------------------------------------
--Create ClientCategory Table
------------------------------------------------------------------------------------------------------------------

CREATE TABLE ClientCategory (
  idClientCategory INTEGER  NOT NULL   IDENTITY ,
  idClientType INTEGER  NOT NULL  ,
  idClient INTEGER  NOT NULL  ,
  idCategories INTEGER  NOT NULL  ,
  coTpOperation CHAR(1)  NOT NULL  ,
  coUserOperation VARCHAR(20)  NOT NULL  ,
  dtOperation DATETIME  NOT NULL  ,
  boIsActive BIT  NOT NULL    ,
PRIMARY KEY(idClientCategory, idClientType, idClient)    ,
  FOREIGN KEY(idClient, idClientType)
    REFERENCES Clients(idClient, idClientType),
  FOREIGN KEY(idCategories)
    REFERENCES Categories(idCategories));
GO


CREATE INDEX ClientCategory_FKIndex1 ON ClientCategory (idClient, idClientType);
GO
CREATE INDEX ClientCategory_FKIndex2 ON ClientCategory (idCategories);
GO


CREATE INDEX IFK_Rel_04 ON ClientCategory (idClient, idClientType);
GO
CREATE INDEX IFK_Rel_07 ON ClientCategory (idCategories);
GO

------------------------------------------------------------------------------------------------------------------
--Create ClientTimeLine Table. Domain Table
------------------------------------------------------------------------------------------------------------------

CREATE TABLE ClientTimeLine (
  idTimeLine INTEGER  NOT NULL   IDENTITY ,
  idClientType INTEGER  NOT NULL  ,
  idClient INTEGER  NOT NULL  ,
  coTpOperation CHAR(1)  NOT NULL  ,
  coUserOperation VARCHAR(20)  NOT NULL  ,
  dtOperation DATETIME  NOT NULL  ,
  boIsActive BIT  NOT NULL      ,
PRIMARY KEY(idTimeLine, idClientType, idClient)    ,
  FOREIGN KEY(idClient, idClientType)
    REFERENCES Clients(idClient, idClientType),
  FOREIGN KEY(idTimeLine)
    REFERENCES TimeLine(idTimeLine));
GO


CREATE INDEX ClientTimeLine_FKIndex1 ON ClientTimeLine (idClient, idClientType);
GO
CREATE INDEX ClientTimeLine_FKIndex2 ON ClientTimeLine (idTimeLine);
GO


CREATE INDEX IFK_Rel_05 ON ClientTimeLine (idClient, idClientType);
GO
CREATE INDEX IFK_Rel_06 ON ClientTimeLine (idTimeLine);
GO


------------------------------------------------------------------------------------------------------------------
--Script for populate Clients table with distincts categories availables
------------------------------------------------------------------------------------------------------------------



insert into  ClientType ( stName,stdescription,cotpoperation,coUserOperation,dtOperation)
values('Person','Personal Information','I','davidsou@gmail.com',getdate()),
('Company','Company Information','I','davidsou@gmail.com',getdate())


insert into  TimeLine ( stName,stDescription,coTpOperation,coUserOperation,dtOperation)
values
('Create','New Client Created','I','davidsou@gmail.com',getdate()),
('Update','Client Updated','I','davidsou@gmail.com',getdate()),
('Delete','Client Deleted','I','davidsou@gmail.com',getdate()),
('Hidden','Client Hidden','I','davidsou@gmail.com',getdate())




;WITH a as
(
SELECT [Name], [Gender], [Date Of Birth],
rn = row_number() over (partition by Name, Gender order by Name)
FROM [SampleData] where [Gender]  in ( 'Female', 'Male')
)

INSERT INTO Clients ( 
 [idClientType],
 [strName],
 [chrGender],
 [dtBirthday],
 [coTpOperation],
 [coUserOperation],
 [dtOperation])
 SELECT 
  1, 
[Name], 
[Gender], 
convert(datetime,[Date Of Birth],111),
'I',
'davidsou@gmail.com',
GETDATE()
from a where rn = 1

------------------------------------------------------------------------------------------------------------------
--Script for populate Adresses table with distincts categories availables
------------------------------------------------------------------------------------------------------------------

;WITH b as
(
SELECT
 [Name],
 [Gender],
 [House Number],
 [Address Line 1],
 [State], 
 [Country],
rn = row_number() over (partition by Name, Gender order by Name)
FROM [SampleData] where [Gender]  in ( 'Female', 'Male')
)

INSERT INTO [Address]
([idClientType],
[idClient],
[inNumber],
[stAdress],
[inPostalCode],
[stState],
[stCity],
[stCountry],
[stEmail],
[coTpOperation],
[coUserOperation],
[dtOperation],
[boIsActive])
SELECT
CI.[idClientType],
 CI.[idClient],
 b.[House Number],
 b.[Address Line 1],
 0, 
 b.[State],
 '',
 b.[Country],
  '',
  'I',
  'davidsou@gmail.com',
  GETDATE(),
  1

   FROM Clients CI 
INNER JOIN b ON b.Name=CI.[strName] AND b.Gender=CI.[chrGender]
WHERE b.rn=1


 
------------------------------------------------------------------------------------------------------------------
--Script for populate categories table with distincts categories availables
------------------------------------------------------------------------------------------------------------------
;WITH c as
(
SELECT Distinct 
 [Category]
FROM [SampleData] where [Gender]  in ('Female','Male')
)

Insert into [Categories] 
(stCategoryName,
 [coTpOperation],
[coUserOperation],
[dtOperation])

Select 
c.Category,
  'I',
  'davidsou@gmail.com',
  GETDATE()
  From c

------------------------------------------------------------------------------------------------------------------
--Script for populate table ClientCategories
------------------------------------------------------------------------------------------------------------------

;WITH d as
(
SELECT
 [Name],
 [Gender],
[Category],
rn = row_number() over (partition by Name, Gender order by Name)
FROM [SampleData] where [Gender]  in ( 'Female', 'Male')
)

INSERT INTO [ClientCategory]
([idClientType],
[idClient],
[idCategories],
[coTpOperation],
[coUserOperation],
[dtOperation],
[boIsActive])
SELECT
CI.[idClientType],
CI.[idClient],
CT.[idCategories],
'I',
'davidsou@gmail.com',
GETDATE(),
1

FROM Clients CI 
INNER JOIN d ON d.Name = CI.[strName] AND d.Gender = CI.[chrGender] --and d.Category = ct.stCategoryName 
inner join Categories ct on  ct.stCategoryName= d.Category 
WHERE d.rn=1 

--select * from ClientCategory 


--;WITH d as
--(
--SELECT
-- [Name],
-- [Gender],
--[Category],
--rn = row_number() over (partition by Name, Gender order by Name)
--FROM [SampleData] where [Gender]  in ( 'Female', 'Male')
--)


--select  s.idClient  , s.idClientType, b.stCategoryName , b.idCategories  from Clients  s , Categories b , d data
--where 
--data.Category = b.stCategoryName 
--and data.Name = s.strName 
--and data.Gender = data.Gender
--and data.rn=1  

--select * from clients


--select distinct s.Name , s.Gender, s.Category , b.idCategories  from sampledata s , Categories b , d data
--where 
--s.Category = b.stCategoryName
--and data.Category=s.Category 
--and data.Category = b.stCategoryName   