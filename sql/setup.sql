-- Prerequisites
-- Database server creation with SPN as databaserver admin
-- Database server firewall rules creation
-- Database and schema ceation

-- Database schema ceation
IF NOT EXISTS (
    SELECT *
    FROM sys.schemas
    WHERE name = 'core'
)
    BEGIN
        EXEC sp_executesql N'CREATE SCHEMA [core];';
    END

-- Database role creation
IF NOT EXISTS (
    SELECT *
    FROM sys.database_principals
    WHERE name = 'developer'
)
    BEGIN
        CREATE ROLE [developer] AUTHORIZATION [dbo];
    END;

-- Database users(MSI and Engineers) creation
IF NOT EXISTS (
    SELECT *
    FROM sys.database_principals
    WHERE name = 'testuser'
)
    BEGIN
        CREATE USER [testuser] FROM EXTERNAL PROVIDER ;
    END

-- Database permissions creation
GRANT INSERT ON SCHEMA::[core] TO [developer];
GRANT UPDATE ON SCHEMA::[core] TO [developer];
GRANT DELETE ON SCHEMA::[core] TO [developer];

-- Database tables creation
Create table [core].[dbo].[MyTable] (
    [Id] int identity(1,1) not null,
    [Name] nvarchar(50) not null,
    [Description] nvarchar(100) not null,
    [CreatedDate] datetime not null,
    [CreatedBy] nvarchar(50) not null,
    [ModifiedDate] datetime not null,
    [ModifiedBy] nvarchar(50) not null,
    constraint [PK_MSI] primary key clustered ([Id] asc)
)
