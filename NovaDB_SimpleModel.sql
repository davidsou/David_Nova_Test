--Add a new database named NovaBM
--right-click the new database and go to task - import data
--select flat file option in Data Source Combobox.
--Follow the directions and load the new table.
-- Any question, look the link https://support.discountasp.net/kb/a1179/importing-a-csv-file-into-your-database-with-sql-server-management-studio.aspx
--Execute the script below



CREATE TABLE Clients (
  idClient INTEGER  NOT NULL   IDENTITY ,
  Name VARCHAR(100)  NOT NULL  ,
  Gender VARCHAR(15)  NOT NULL  ,
  Birthday DATETIME  NOT NULL  ,
  Category VARCHAR(20)  NOT NULL  ,
  Number INTEGER  NOT NULL  ,
  [Address] VARCHAR(100)  NOT NULL  ,
  [State] VARCHAR(50)  NOT NULL  ,
  Country VARCHAR(50)  NOT NULL  ,
  TypeOperation CHAR(1)    ,
  UserOperation VARCHAR(20)  NOT NULL  ,
  DataOperation DATETIME  NOT NULL    ,
  IsActive bit  NOT NULL    ,
PRIMARY KEY(idClient));
GO


;WITH a as
(
SELECT 
[Name], 
[Gender],
 [Date Of Birth],
 [Category],
 [House Number],
 [Address Line 1],
 [State], 
 [Country],
rn = row_number() over (partition by Name, Gender order by Name)
FROM [SampleData] where [Gender]  in ( 'Female', 'Male')
)

INSERT INTO Clients ( 
  Name,
  Gender,
  Birthday,
  Category,
  [Number],
  [Address] ,
  [State],
   Country ,
  TypeOperation,
  UserOperation,
  DataOperation,
  [IsActive])
 SELECT  
[Name], 
[Gender],
convert(datetime,[Date Of Birth],111),
[Category],
 [House Number],
 [Address Line 1],
 [State],
 [Country],
'I',
'davidsou@gmail.com',
GETDATE(),
1
from a where rn = 1



;with b as
(
SELECT 
[Name], 
[Gender],
 [Date Of Birth],
 [Category],
 [House Number],
 [Address Line 1],
 [State], 
 [Country],
rn = row_number() over (partition by Name, Gender order by Name)
FROM [SampleData]  
)

select * from b where [Gender] not in ( 'Female', 'Male') or b.rn >1