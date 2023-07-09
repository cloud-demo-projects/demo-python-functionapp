-- TODO

-- Database server creation with SPN as databaserver admin
-- Database server firewall rules creation
-- Database and schema ceation

-- Database schema ceation
Create schema [core]

-- Database role creation
Create role [MSI]

-- Database users(MSI and Engineers) creation
Create user [MSI] as external user
Create user [AD-Group] as external user

-- Database permissions creation
Grant select on schema::[MSI] to [MSI]
Grant select on schema::[MSI] to [Engineers]
Grant insert on schema::[MSI] to [Engineers]
Grant update on schema::[MSI] to [Engineers]
Grant delete on schema::[MSI] to [Engineers]

-- Database tables creation
Create table [MSI].[dbo].[MSI] (
    [Id] int identity(1,1) not null,
    [Name] nvarchar(50) not null,
    [Description] nvarchar(100) not null,
    [CreatedDate] datetime not null,
    [CreatedBy] nvarchar(50) not null,
    [ModifiedDate] datetime not null,
    [ModifiedBy] nvarchar(50) not null,
    constraint [PK_MSI] primary key clustered ([Id] asc)
)