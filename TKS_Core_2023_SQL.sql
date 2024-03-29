USE [master]
GO
/****** Object:  Database [TKS_Core_2023]    Script Date: 01/24/2024 7:42:16 PM ******/
CREATE DATABASE [TKS_Core_2023]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TKS_Core_2023', FILENAME = N'D:\SQLSERVER\MSSQL16.MSSQLSERVER01\MSSQL\DATA\TKS_Core_2023.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TKS_Core_2023_log', FILENAME = N'D:\SQLSERVER\MSSQL16.MSSQLSERVER01\MSSQL\DATA\TKS_Core_2023_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TKS_Core_2023] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TKS_Core_2023].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TKS_Core_2023] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET ARITHABORT OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TKS_Core_2023] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TKS_Core_2023] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TKS_Core_2023] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TKS_Core_2023] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET RECOVERY FULL 
GO
ALTER DATABASE [TKS_Core_2023] SET  MULTI_USER 
GO
ALTER DATABASE [TKS_Core_2023] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TKS_Core_2023] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TKS_Core_2023] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TKS_Core_2023] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TKS_Core_2023] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TKS_Core_2023] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'TKS_Core_2023', N'ON'
GO
ALTER DATABASE [TKS_Core_2023] SET QUERY_STORE = OFF
GO
USE [TKS_Core_2023]
GO
USE [TKS_Core_2023]
GO
/****** Object:  Sequence [dbo].[Seq_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
CREATE SEQUENCE [dbo].[Seq_ID] 
 AS [bigint]
 START WITH 10000000
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
/****** Object:  UserDefinedFunction [dbo].[fnConvert_Ngay_To_NULL]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnConvert_Ngay_To_NULL] (
	@Date datetime
)
RETURNS datetime
AS
BEGIN
	if (convert(varchar, @Date, 105) = '01-01-1900' or convert(varchar, @Date, 105) = '30-12-1899' or convert(varchar, @Date, 105) = '31-12-1899')
		return null
	
	return @Date
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnConvert_To_Cuoi_Ngay]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnConvert_To_Cuoi_Ngay] (
	@Date datetime
)
RETURNS DateTime
AS
BEGIN
	return convert(datetime, convert(varchar, @Date , 106) + ' 23:59:59')
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnConvert_To_Dau_Ngay]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnConvert_To_Dau_Ngay] (
	@Date datetime
)
RETURNS DateTime
AS
BEGIN
	return convert(datetime, convert(varchar, @Date, 105), 105)
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnList_Nhom_Thanh_Vien_By_Ma_Dang_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION  [dbo].[fnList_Nhom_Thanh_Vien_By_Ma_Dang_Nhap]
(
	@Ma_Dang_Nhap nvarchar(200)
)
RETURNS nvarchar(2000)
AS
BEGIN	
	   declare @Res nvarchar(2000)
       set @Res = ''
       declare @Ten_Nhom_Thanh_Vien nvarchar(200)
 
       declare Nhom_Thanh_Vien_Cursor CURSOR FOR
       SELECT Ten_Nhom_Thanh_Vien
       FROM view_Sys_Nhom_Thanh_Vien_User with (nolock) 
	   where 
			Ma_Dang_Nhap = @Ma_Dang_Nhap
       order by Ten_Nhom_Thanh_Vien ASC
 
       OPEN Nhom_Thanh_Vien_Cursor
       FETCH NEXT FROM Nhom_Thanh_Vien_Cursor
       INTO @Ten_Nhom_Thanh_Vien
 
       WHILE @@FETCH_STATUS = 0
       BEGIN 
              if (isnull(@Ten_Nhom_Thanh_Vien, '') <> '')
              BEGIN
					if (@Res = '')
						set @Res = @Ten_Nhom_Thanh_Vien
					else
						set @Res = @Res + ', ' + @Ten_Nhom_Thanh_Vien
              END
 
              FETCH NEXT FROM Nhom_Thanh_Vien_Cursor
			  INTO @Ten_Nhom_Thanh_Vien
       END
       CLOSE Nhom_Thanh_Vien_Cursor
       DEALLOCATE Nhom_Thanh_Vien_Cursor
 
       return @Res	
END
GO
/****** Object:  Table [dbo].[tbl_DM_Nha_Cung_Cap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_DM_Nha_Cung_Cap](
	[Auto_ID] [int] NOT NULL,
	[Ten_Nha_Cung_Cap] [nvarchar](200) NULL,
	[Dia_Chi] [nvarchar](200) NULL,
	[Dien_Thoai] [nvarchar](200) NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [nvarchar](200) NULL,
	[Created_By_Function] [nvarchar](50) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](200) NULL,
	[Last_Updated_By_Function] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_DM_Nha_Cung_Cap] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_DM_Nha_Cung_Cap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_DM_Nha_Cung_Cap]
AS
SELECT A.Auto_ID, A.Ten_Nha_Cung_Cap, A.Dia_Chi, A.Dien_Thoai, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_DM_Nha_Cung_Cap AS A
WHERE
	(deleted = 0)
GO
/****** Object:  Table [dbo].[tbl_DM_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_DM_Kho](
	[Auto_ID] [int] NOT NULL,
	[Ten_Kho] [nvarchar](200) NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [nvarchar](200) NULL,
	[Created_By_Function] [nvarchar](50) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](200) NULL,
	[Last_Updated_By_Function] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_DM_Kho] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_DM_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_DM_Kho]
AS
SELECT A.Auto_ID, A.Ten_Kho, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_DM_Kho AS A
WHERE
	(deleted = 0)

GO
/****** Object:  Table [dbo].[tbl_DM_Khu_Vuc_Nhiet_Do]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_DM_Khu_Vuc_Nhiet_Do](
	[Auto_ID] [int] NOT NULL,
	[Ma_KVND] [nvarchar](200) NULL,
	[Ten_KVND] [nvarchar](200) NULL,
	[Tu_Nhiet_Do] [nvarchar](200) NULL,
	[Den_Nhiet_Do] [nvarchar](200) NULL,
	[Ghi_Chu] [nvarchar](200) NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [char](10) NULL,
	[Created_By_Function] [char](10) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](200) NULL,
	[Last_Updated_By_Function] [nvarchar](200) NULL,
 CONSTRAINT [PK_tbl_DM_Khu_Vuc_Nhiet_Do] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_DM_Khu_Vuc_Nhiet_Do]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_DM_Khu_Vuc_Nhiet_Do]
AS
SELECT A.Auto_ID, A.Ma_KVND, A.Ten_KVND, A.Tu_Nhiet_Do, A.Den_Nhiet_Do, A.Ghi_Chu, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_DM_Khu_Vuc_Nhiet_Do AS A
WHERE
	(deleted = 0)



GO
/****** Object:  Table [dbo].[tbl_XNK_Nhap_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_XNK_Nhap_Kho_Chi_Tiet](
	[Auto_ID] [int] NOT NULL,
	[Nhap_Kho_ID] [int] NULL,
	[Ma_San_Pham] [nvarchar](200) NULL,
	[Ten_San_Pham] [nvarchar](200) NULL,
	[So_Luong] [float] NULL,
	[Don_Gia] [float] NULL,
	[Tri_Gia] [float] NULL,
	[Ngay_San_Xuat] [datetime] NULL,
	[Ngay_Het_Hang] [datetime] NULL,
	[So_LPN] [nvarchar](200) NULL,
	[Kien] [int] NULL,
	[So_Luong_Chan] [int] NULL,
	[So_Luong_Le] [int] NULL,
	[Tong_So_Luong] [int] NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [nvarchar](200) NULL,
	[Created_By_Function] [nvarchar](50) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](200) NULL,
	[Last_Updated_By_Function] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_Nhap_Kho_Chi_Tiet] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_XNK_Nhap_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[view_XNK_Nhap_Kho_Chi_Tiet]

as
select Auto_ID, Nhap_Kho_ID , Ma_San_Pham, Ten_San_Pham, So_Luong, Don_Gia,(So_Luong * Don_Gia) as Tri_Gia, Ngay_San_Xuat, Ngay_Het_Hang, So_LPN, Kien, So_Luong_Chan, So_Luong_Le, (So_Luong_Chan + So_Luong_Le) as Tong_So_Luong, deleted, Created, Created_By, Created_By_Function, Last_Updated, Last_Updated_By,Last_Updated_By_Function
from tbl_XNK_Nhap_Kho_Chi_Tiet
where

	(deleted=0)
GO
/****** Object:  Table [dbo].[tbl_DM_Phan_Quyen_Kho_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_DM_Phan_Quyen_Kho_User](
	[Auto_ID] [int] NOT NULL,
	[Kho_ID] [int] NULL,
	[Ma_Dang_Nhap] [nvarchar](200) NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [nvarchar](200) NULL,
	[Created_By_Function] [nvarchar](50) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](200) NULL,
	[Last_Updated_By_Function] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_DM_Phan_Quyen_Kho_User] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_DM_Phan_Quyen_Kho_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_DM_Phan_Quyen_Kho_User]
AS
SELECT A.Auto_ID, A.Kho_ID, A.Ma_Dang_Nhap, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_DM_Phan_Quyen_Kho_User AS A
WHERE
	(deleted = 0)


GO
/****** Object:  Table [dbo].[tbl_DM_Loai_San_Pham]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_DM_Loai_San_Pham](
	[Auto_ID] [int] NOT NULL,
	[Ten_Loai_San_Pham] [nvarchar](200) NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [nvarchar](200) NULL,
	[Created_By_Function] [nvarchar](50) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](200) NULL,
	[Last_Updated_By_Function] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_DM_Loai_San_Pham] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_DM_Loai_San_Pham]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_DM_Loai_San_Pham]
AS
SELECT A.Auto_ID, A.Ten_Loai_San_Pham, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_DM_Loai_San_Pham AS A
WHERE
	(deleted = 0)



GO
/****** Object:  Table [dbo].[tbl_DM_Vi_Tri]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_DM_Vi_Tri](
	[Auto_ID] [int] NOT NULL,
	[Ten_Vi_Tri] [nvarchar](200) NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [char](10) NULL,
	[Created_By_Function] [nvarchar](50) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](200) NULL,
	[Last_Updated_By_Function] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_DM_Vi_Tri] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_DM_Vi_Tri]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_DM_Vi_Tri]
AS
SELECT A.Auto_ID, A.Ten_Vi_Tri, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_DM_Vi_Tri AS A
WHERE
	(deleted = 0)



GO
/****** Object:  Table [dbo].[tbl_Sys_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Sys_Thanh_Vien](
	[Auto_ID] [bigint] NOT NULL,
	[Ma_Dang_Nhap] [nvarchar](50) NULL,
	[Mat_Khau] [nvarchar](50) NULL,
	[Ho_Ten] [nvarchar](100) NULL,
	[Email] [nvarchar](250) NULL,
	[Dien_Thoai] [nvarchar](200) NULL,
	[Hinh_Dai_Dien_URL] [nvarchar](200) NULL,
	[Trang_Thai_ID] [int] NULL,
	[Ten_Nhom_Thanh_Vien_Text] [nvarchar](400) NULL,
	[Ghi_Chu] [nvarchar](200) NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [nvarchar](50) NULL,
	[Created_By_Function] [nvarchar](50) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](50) NULL,
	[Last_Updated_By_Function] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_Sys_Thanh_Vien] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_Sys_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Sys_Thanh_Vien]
AS
SELECT A.Auto_ID, A.Ma_Dang_Nhap, A.Mat_Khau, A.Ho_Ten, A.Email, A.Dien_Thoai, A.Hinh_Dai_Dien_URL, A.Trang_Thai_ID, A.Ten_Nhom_Thanh_Vien_Text, A.Ghi_Chu, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_Sys_Thanh_Vien AS A
WHERE
	(deleted = 0)
GO
/****** Object:  Table [dbo].[tbl_XNK_Xuat_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_XNK_Xuat_Kho](
	[Auto_ID] [int] NOT NULL,
	[So_Phieu_Xuat_Kho] [nvarchar](200) NULL,
	[Ngay_Xuat_Kho] [datetime] NULL,
	[Kho] [nvarchar](200) NULL,
	[Ghi_Chu] [nvarchar](200) NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [nvarchar](200) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](200) NULL,
 CONSTRAINT [PK_tbl_XNK_Xuat_Kho] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_XNK_Xuat_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_XNK_Xuat_Kho]
AS
SELECT A.Auto_ID, A.So_Phieu_Xuat_Kho, A.Ngay_Xuat_Kho, A.Kho, A.Ghi_Chu, A.deleted, A.Created, A.Created_By, A.Last_Updated, A.Last_Updated_By 
FROM dbo.tbl_XNK_Xuat_Kho AS A
WHERE
	(deleted = 0)



GO
/****** Object:  Table [dbo].[tbl_XNK_Ton_Kho_CT]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_XNK_Ton_Kho_CT](
	[Auto_ID] [int] NOT NULL,
	[Nhap_Kho_ID] [int] NULL,
	[So_Phieu_Nhap] [nvarchar](200) NULL,
	[Ma_San_Pham] [nvarchar](200) NULL,
	[Ten_San_Pham] [nvarchar](200) NULL,
	[So_Luong] [float] NULL,
	[Don_Gia] [float] NULL,
	[Tri_Gia] [float] NULL,
	[Ngay_San_Xuat] [datetime] NULL,
	[Ngay_Het_Hang] [datetime] NULL,
	[So_LPN] [nvarchar](200) NULL,
	[Kien] [int] NULL,
	[So_Luong_Chan] [int] NULL,
	[So_Luong_Le] [int] NULL,
	[Tong_So_Luong] [int] NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [nvarchar](200) NULL,
	[Created_By_Function] [nvarchar](50) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](200) NULL,
	[Last_Updated_By_Function] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_XNK_Ton_Kho] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_XNK_Ton_Kho_CT]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_XNK_Ton_Kho_CT]
AS
SELECT A.Auto_ID, A.Nhap_Kho_ID, A.So_Phieu_Nhap, A.Ma_San_Pham, A.Ten_San_Pham, A.So_Luong, A.Don_Gia, A.Tri_Gia, A.Ngay_San_Xuat, A.Ngay_Het_Hang, A.So_LPN, A.Kien, A.So_Luong_Chan, A.So_Luong_Le, A.Tong_So_Luong, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_XNK_Ton_Kho_CT AS A
WHERE
	(deleted = 0)



GO
/****** Object:  Table [dbo].[tbl_DM_Don_Vi_Tinh]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_DM_Don_Vi_Tinh](
	[Auto_ID] [int] NOT NULL,
	[Ten_Don_Vi_Tinh] [nvarchar](200) NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [char](10) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](200) NULL,
 CONSTRAINT [PK_tbl_DM_Don_Vi_Tinh] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_DM_Don_Vi_Tinh]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_DM_Don_Vi_Tinh]
AS
SELECT A.Auto_ID, A.Ten_Don_Vi_Tinh, A.deleted, A.Created, A.Created_By, A.Last_Updated, A.Last_Updated_By 
FROM dbo.tbl_DM_Don_Vi_Tinh AS A
WHERE
	(deleted = 0)
GO
/****** Object:  Table [dbo].[tbl_DM_San_Pham]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_DM_San_Pham](
	[Auto_ID] [int] NOT NULL,
	[Ma_San_Pham] [nvarchar](200) NULL,
	[Loai_San_Pham] [nvarchar](200) NULL,
	[Ten_San_Pham] [nvarchar](200) NULL,
	[Don_Vi_Tinh] [nvarchar](200) NULL,
	[Ghi_Chu] [nvarchar](200) NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [nvarchar](200) NULL,
	[Created_By_Function] [nvarchar](50) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](200) NULL,
	[Last_Updated_By_Function] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_DM_San_Pham] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_DM_San_Pham]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_DM_San_Pham]
AS
SELECT A.Auto_ID, A.Ma_San_Pham, A.Loai_San_Pham, A.Ten_San_Pham, A.Don_Vi_Tinh, A.Ghi_Chu, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_DM_San_Pham AS A
WHERE
	(deleted = 0)



GO
/****** Object:  View [dbo].[view_Sys_Nhom_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Sys_Nhom_Thanh_Vien]
AS
SELECT A.Auto_ID, A.Ten_Nhom_Thanh_Vien, A.Ghi_Chu, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_Sys_Nhom_Thanh_Vien AS A
WHERE
	(deleted = 0)
GO
/****** Object:  View [dbo].[view_Sys_Nhom_Thanh_Vien_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Sys_Nhom_Thanh_Vien_User]
AS
SELECT A.Auto_ID, A.Nhom_Thanh_Vien_ID, A.Ma_Dang_Nhap, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function, B.Ho_Ten, C.Ten_Nhom_Thanh_Vien
FROM     dbo.tbl_Sys_Nhom_Thanh_Vien_User AS A INNER JOIN
                  dbo.view_Sys_Thanh_Vien AS B ON A.Ma_Dang_Nhap = B.Ma_Dang_Nhap INNER JOIN
                  dbo.view_Sys_Nhom_Thanh_Vien AS C ON A.Nhom_Thanh_Vien_ID = C.Auto_ID
WHERE  (A.deleted = 0)
GO
/****** Object:  Table [dbo].[tbl_XNK_Xuat_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_XNK_Xuat_Kho_Chi_Tiet](
	[Auto_ID] [int] NOT NULL,
	[Xuat_Kho_ID] [int] NULL,
	[Ma_San_Pham] [nvarchar](200) NULL,
	[Ten_San_Pham] [nvarchar](200) NULL,
	[So_Luong] [float] NULL,
	[Don_Gia] [float] NULL,
	[Tri_Gia] [float] NULL,
	[Ngay_San_Xuat] [datetime] NULL,
	[Ngay_Het_Hang] [datetime] NULL,
	[Kien] [int] NULL,
	[So_Luong_Chan] [int] NULL,
	[So_Luong_Le] [int] NULL,
	[Tong_So_Luong] [int] NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [nvarchar](200) NULL,
	[Created_By_Function] [nvarchar](50) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](200) NULL,
	[Last_Updated_By_Function] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_Xuat_Kho_Chi_Tiet] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_XNK_Xuat_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_XNK_Xuat_Kho_Chi_Tiet]
AS
SELECT A.Auto_ID, A.Xuat_Kho_ID, A.Ma_San_Pham, A.Ten_San_Pham, A.So_Luong, A.Don_Gia, Tri_Gia=(So_Luong*Don_Gia), A.Ngay_San_Xuat, A.Ngay_Het_Hang, A.Kien, A.So_Luong_Chan, A.So_Luong_Le, A.Tong_So_Luong, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_XNK_Xuat_Kho_Chi_Tiet AS A
WHERE
	(deleted = 0)
GO
/****** Object:  Table [dbo].[tbl_XNK_Nhap_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_XNK_Nhap_Kho](
	[Auto_ID] [int] NOT NULL,
	[So_Phieu_Nhap] [nvarchar](200) NULL,
	[Ngay_Nhap_Kho] [datetime] NULL,
	[Nha_Cung_Cap] [nvarchar](200) NULL,
	[Kho] [nvarchar](200) NULL,
	[Trang_Thai] [int] NULL,
	[Ghi_Chu] [nvarchar](200) NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [nvarchar](200) NULL,
	[Created_By_Function] [nvarchar](50) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](200) NULL,
	[Last_Updated_By_Function] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_Nhap_Kho] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_XNK_Nhap_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_XNK_Nhap_Kho]
AS
SELECT A.Auto_ID, A.So_Phieu_Nhap, A.Ngay_Nhap_Kho, A.Nha_Cung_Cap, A.Kho, A.Trang_Thai, A.Ghi_Chu, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_XNK_Nhap_Kho AS A
WHERE
	(deleted = 0)



GO
/****** Object:  Table [dbo].[tbl_Sys_Phan_Quyen_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Sys_Phan_Quyen_Chuc_Nang](
	[Auto_ID] [bigint] NOT NULL,
	[Nhom_Thanh_Vien_ID] [bigint] NULL,
	[Chuc_Nang_ID] [bigint] NULL,
	[Is_Have_View_Permission] [bit] NULL,
	[Is_Have_Add_Permission] [bit] NULL,
	[Is_Have_Edit_Permission] [bit] NULL,
	[Is_Have_Delete_Permission] [bit] NULL,
	[Is_Have_Export_Permission] [bit] NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [nvarchar](50) NULL,
	[Created_By_Function] [nvarchar](50) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](50) NULL,
	[Last_Updated_By_Function] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_Sys_Phan_Quyen_Chuc_Nang] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_Sys_Phan_Quyen_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Sys_Phan_Quyen_Chuc_Nang]
AS
SELECT Auto_ID, Nhom_Thanh_Vien_ID, Chuc_Nang_ID, Is_Have_View_Permission, Is_Have_Add_Permission, Is_Have_Edit_Permission, Is_Have_Delete_Permission, deleted, Created, Created_By, Created_By_Function, Last_Updated, 
                  Last_Updated_By, Last_Updated_By_Function, Is_Have_Export_Permission
FROM     dbo.tbl_Sys_Phan_Quyen_Chuc_Nang AS A
WHERE  (deleted = 0)
GO
/****** Object:  Table [dbo].[tbl_Sys_Token]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Sys_Token](
	[Auto_ID] [bigint] NOT NULL,
	[Token_ID] [nvarchar](50) NULL,
	[Ma_Dang_Nhap] [nvarchar](50) NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [nvarchar](50) NULL,
	[Created_By_Function] [nvarchar](50) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](50) NULL,
	[Last_Updated_By_Function] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_Sys_Token] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_Sys_Token]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Sys_Token]
AS
SELECT A.Auto_ID, A.Token_ID, A.Ma_Dang_Nhap, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_Sys_Token AS A
WHERE
	(deleted = 0)
GO
/****** Object:  Table [dbo].[tbl_XNK_Quan_Ly_Phieu_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_XNK_Quan_Ly_Phieu_Nhap](
	[Auto_ID] [int] NOT NULL,
	[So_Phieu_Nhap] [nvarchar](200) NULL,
	[Ngay_Nhap_Kho] [datetime] NULL,
	[Nha_Cung_Cap] [nvarchar](200) NULL,
	[Kho] [nvarchar](200) NULL,
	[Tong_So_Luong] [int] NULL,
	[Tong_Tri_Gia] [int] NULL,
	[Trang_Thai] [int] NULL,
	[Trang_Thai_Putaway] [int] NULL,
	[Ghi_Chu] [nvarchar](200) NULL,
	[deleted] [int] NULL,
	[Created] [datetime] NULL,
	[Created_By] [nvarchar](200) NULL,
	[Created_By_Function] [nvarchar](50) NULL,
	[Last_Updated] [datetime] NULL,
	[Last_Updated_By] [nvarchar](200) NULL,
	[Last_Updated_By_Function] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_XNK_Quan_Ly_Phieu_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_XNK_Quan_Ly_Phieu_Nhap]
AS
SELECT A.Auto_ID, A.So_Phieu_Nhap, A.Ngay_Nhap_Kho, A.Nha_Cung_Cap, A.Kho, A.Tong_So_Luong, A.Tong_Tri_Gia, A.Trang_Thai, A.Trang_Thai_Putaway, A.Ghi_Chu, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_XNK_Quan_Ly_Phieu_Nhap AS A
WHERE
	(deleted = 0)



GO
/****** Object:  View [dbo].[view_DM_Customer_Zone]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_DM_Customer_Zone]
AS
SELECT A.Auto_ID, A.Customer_Zone_Code, A.Customer_Zone_Name, A.Customer_Zone_Status, A.Notes, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_DM_Customer_Zone AS A
WHERE
	(deleted = 0)



GO
/****** Object:  View [dbo].[view_Log_Import_Excel]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Log_Import_Excel]
AS
SELECT A.Auto_ID, A.Ma_Chuc_Nang, A.Ten_Chuc_Nang, A.Link_URL, A.Trang_Thai_ID, A.Ghi_Chu, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_Log_Import_Excel AS A
WHERE
	(deleted = 0)
GO
/****** Object:  View [dbo].[view_Log_Nhat_Ky_Dang_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Log_Nhat_Ky_Dang_Nhap]
AS
SELECT A.Auto_ID, A.Ma_Dang_Nhap, A.IP, A.User_Agent, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_Log_Nhat_Ky_Dang_Nhap AS A
WHERE
	(deleted = 0)
GO
/****** Object:  View [dbo].[view_Log_Nhat_Ky_Truy_Cap_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Log_Nhat_Ky_Truy_Cap_Chuc_Nang]
AS
SELECT Auto_ID, Ma_Chuc_Nang, Ten_Chuc_Nang, deleted, Created, Created_By, Ma_Dang_Nhap
FROM     dbo.tbl_Log_Nhat_Ky_Truy_Cap_Chuc_Nang AS A
WHERE  (deleted = 0)
GO
/****** Object:  View [dbo].[view_Log_Record_Action_History]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Log_Record_Action_History]
AS
SELECT Auto_ID, Ref_ID, Ten_Hanh_Dong, Ten_Moi_Truong, Ma_Chuc_Nang, deleted, Created, Created_By, Ten_Chuc_Nang, Noi_Dung_Action
FROM     dbo.tbl_Log_Record_Action_History AS A
WHERE  (deleted = 0)
GO
/****** Object:  View [dbo].[view_Sys_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Sys_Chuc_Nang]
AS
SELECT Auto_ID, Ma_Chuc_Nang, Ten_Chuc_Nang, Sort_Priority, Chuc_Nang_Parent_ID, Nhom_Chuc_Nang_ID, Func_URL, Image_URL, Is_View, Is_New, Is_Edit, Is_Delete, Ghi_Chu, deleted, Created, Created_By, Created_By_Function, 
                  Last_Updated, Last_Updated_By, Last_Updated_By_Function, Is_Export
FROM     dbo.tbl_Sys_Chuc_Nang AS A
WHERE  (deleted = 0)
GO
/****** Object:  View [dbo].[view_Sys_Column_Width]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Sys_Column_Width]
AS
SELECT A.Auto_ID, A.Field_Name, A.Do_Rong, A.Format_Number, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_Sys_Column_Width AS A
WHERE
	(deleted = 0)
GO
/****** Object:  View [dbo].[view_Sys_Drill_Down]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Sys_Drill_Down]
AS
SELECT A.Auto_ID, A.Field_Name, A.Link_URL, A.Parameter_Field, A.Func_ID, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_Sys_Drill_Down AS A
WHERE
	(deleted = 0)
GO
/****** Object:  View [dbo].[view_Sys_Filter_Date_Default]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Sys_Filter_Date_Default]
AS
SELECT A.Auto_ID, A.Ma_Chuc_Nang, A.Duration_Days_From, A.Duration_Days_To, A.Ghi_Chu, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_Sys_Filter_Date_Default AS A
WHERE
	(deleted = 0)
GO
/****** Object:  View [dbo].[view_Sys_Frozen_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Sys_Frozen_Column]
AS
SELECT A.Auto_ID, A.Ma_Chuc_Nang, A.SL_Cot_Frozen, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_Sys_Frozen_Column AS A
WHERE
	(deleted = 0)
GO
/****** Object:  View [dbo].[view_Sys_Help_Guide]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Sys_Help_Guide]
AS
SELECT A.Auto_ID, A.Khach_Hang_ID, A.Ma_Chuc_Nang, A.Ngon_Ngu, A.Noi_Dung, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_Sys_Help_Guide AS A
WHERE
	(deleted = 0)
GO
/****** Object:  View [dbo].[view_Sys_Hien_An_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Sys_Hien_An_Column]
AS
SELECT A.Auto_ID, A.Chu_Hang_ID, A.Field_Name, A.Option_ID, A.Ma_Chuc_Nang, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_Sys_Hien_An_Column AS A
WHERE
	(deleted = 0)
GO
/****** Object:  View [dbo].[view_Sys_Language]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Sys_Language]
AS
SELECT A.Auto_ID, A.Field_Name, A.Lang_1, A.Lang_2, A.Lang_3, A.Lang_4, A.Lang_5, A.Type_ID, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_Sys_Language AS A
WHERE
	(deleted = 0)
GO
/****** Object:  View [dbo].[view_Sys_Mau_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_Sys_Mau_Column]
AS
SELECT A.Auto_ID, A.Field_Name, A.Ma_So_Mau, A.Ghi_Chu, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_Sys_Mau_Column AS A
WHERE
	(deleted = 0)
GO
/****** Object:  View [dbo].[view_XNK_Ton_Kho_A]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_XNK_Ton_Kho_A]
AS
SELECT A.Auto_ID, A.So_Phieu_Nhap, A.Ngay_Nhap_Kho, A.Nha_Cung_Cap, A.Kho, A.Trang_Thai, A.Ghi_Chu, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_XNK_Ton_Kho_A AS A
WHERE
	(deleted = 0)



GO
/****** Object:  View [dbo].[view_XNK_Ton_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_XNK_Ton_Kho_Chi_Tiet]
AS
SELECT A.Auto_ID, A.Nhap_Kho_ID, A.Ma_San_Pham, A.Ten_San_Pham, A.So_Phieu, A.Ngay_Nhap_Kho, A.Vi_Tri, A.So_Luong, A.Don_Gia, A.Tri_Gia, A.Kien, A.So_Luong_Chan, A.So_Luong_Le, A.Tong_So_Luong, A.deleted, A.Created, A.Created_By, A.Created_By_Function, A.Last_Updated, A.Last_Updated_By, A.Last_Updated_By_Function 
FROM dbo.tbl_XNK_Ton_Kho_Chi_Tiet AS A
WHERE
	(deleted = 0)



GO
/****** Object:  Table [dbo].[tbl_Don_Vi_Tinh]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Don_Vi_Tinh](
	[Auto_ID] [int] NOT NULL,
	[Ten_Don_Vi_Tinh] [nvarchar](200) NULL,
	[Ghi_Chu] [nvarchar](200) NULL,
 CONSTRAINT [PK_DM_Don_Vi_Tinh] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [idx_tbl_Sys_Phan_Quyen_Chuc_Nang_Chuc_Nang_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
CREATE NONCLUSTERED INDEX [idx_tbl_Sys_Phan_Quyen_Chuc_Nang_Chuc_Nang_ID] ON [dbo].[tbl_Sys_Phan_Quyen_Chuc_Nang]
(
	[Chuc_Nang_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_tbl_Sys_Phan_Quyen_Chuc_Nang_Created]    Script Date: 01/24/2024 7:42:17 PM ******/
CREATE NONCLUSTERED INDEX [idx_tbl_Sys_Phan_Quyen_Chuc_Nang_Created] ON [dbo].[tbl_Sys_Phan_Quyen_Chuc_Nang]
(
	[Created] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_tbl_Sys_Phan_Quyen_Chuc_Nang_Nhom_Thanh_Vien_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
CREATE NONCLUSTERED INDEX [idx_tbl_Sys_Phan_Quyen_Chuc_Nang_Nhom_Thanh_Vien_ID] ON [dbo].[tbl_Sys_Phan_Quyen_Chuc_Nang]
(
	[Nhom_Thanh_Vien_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_tbl_Sys_Thanh_Vien_Created]    Script Date: 01/24/2024 7:42:17 PM ******/
CREATE NONCLUSTERED INDEX [idx_tbl_Sys_Thanh_Vien_Created] ON [dbo].[tbl_Sys_Thanh_Vien]
(
	[Created] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_tbl_Sys_Thanh_Vien_Ma_Dang_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
CREATE NONCLUSTERED INDEX [idx_tbl_Sys_Thanh_Vien_Ma_Dang_Nhap] ON [dbo].[tbl_Sys_Thanh_Vien]
(
	[Ma_Dang_Nhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_tbl_Sys_Thanh_Vien_Ten_Nhom_Thanh_Vien_Text]    Script Date: 01/24/2024 7:42:17 PM ******/
CREATE NONCLUSTERED INDEX [idx_tbl_Sys_Thanh_Vien_Ten_Nhom_Thanh_Vien_Text] ON [dbo].[tbl_Sys_Thanh_Vien]
(
	[Ten_Nhom_Thanh_Vien_Text] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_tbl_Sys_Thanh_Vien_Trang_Thai_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
CREATE NONCLUSTERED INDEX [idx_tbl_Sys_Thanh_Vien_Trang_Thai_ID] ON [dbo].[tbl_Sys_Thanh_Vien]
(
	[Trang_Thai_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_tbl_Sys_Token_Created]    Script Date: 01/24/2024 7:42:17 PM ******/
CREATE NONCLUSTERED INDEX [idx_tbl_Sys_Token_Created] ON [dbo].[tbl_Sys_Token]
(
	[Created] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_tbl_Sys_Token_Ma_Dang_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
CREATE NONCLUSTERED INDEX [idx_tbl_Sys_Token_Ma_Dang_Nhap] ON [dbo].[tbl_Sys_Token]
(
	[Ma_Dang_Nhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[F1001_sp_del_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1001_sp_del_Chuc_Nang]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Chuc_Nang SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1001_sp_ins_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1001_sp_ins_Chuc_Nang]
	@Ma_Chuc_Nang nvarchar(50),
	@Ten_Chuc_Nang nvarchar(200),
	@Sort_Priority int,
	@Chuc_Nang_Parent_ID bigint,
	@Nhom_Chuc_Nang_ID int,
	@Func_URL nvarchar(200),
	@Image_URL nvarchar(50),
	@Is_View bit,
	@Is_New bit,
	@Is_Edit bit,
	@Is_Delete bit,
	@Is_Export bit,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ten_Chuc_Nang = LTRIM(RTRIM(@Ten_Chuc_Nang))
	set @Func_URL = LTRIM(RTRIM(@Func_URL))
	set @Image_URL = LTRIM(RTRIM(@Image_URL))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	if (isnull(@Ma_Chuc_Nang, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Mã chức năng.', 11, 1)
		return
	end

	if (isnull(@Ten_Chuc_Nang, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Tên chức năng.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Chuc_Nang with (nolock) where Ma_Chuc_Nang = @Ma_Chuc_Nang)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Mã chức năng đã tồn tại.', 11, 1)
		return
	end

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Chuc_Nang
	(
		Auto_ID,
		Ma_Chuc_Nang,
		Ten_Chuc_Nang,
		Sort_Priority,
		Chuc_Nang_Parent_ID,
		Nhom_Chuc_Nang_ID,
		Func_URL,
		Image_URL,
		Is_View,
		Is_New,
		Is_Edit,
		Is_Delete,
		Is_Export,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ma_Chuc_Nang,
		@Ten_Chuc_Nang,
		@Sort_Priority,
		@Chuc_Nang_Parent_ID,
		@Nhom_Chuc_Nang_ID,
		@Func_URL,
		@Image_URL,
		@Is_View,
		@Is_New,
		@Is_Edit,
		@Is_Delete,
		@Is_Export,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1001_sp_sel_List_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1001_sp_sel_List_Chuc_Nang]
	@Nhom_Chuc_Nang_ID int,
	@Parent_Func_ID bigint
	with recompile
AS
BEGIN
	SELECT Auto_ID, Ma_Chuc_Nang, Ten_Chuc_Nang, Sort_Priority, Chuc_Nang_Parent_ID, Nhom_Chuc_Nang_ID, Func_URL, Image_URL, Is_View, Is_New, Is_Edit, Is_Delete, Ghi_Chu
	FROM 
		view_Sys_Chuc_Nang with (nolock) 
	WHERE 
		Nhom_Chuc_Nang_ID = @Nhom_Chuc_Nang_ID
		and isnull(Chuc_Nang_Parent_ID, 0) = @Parent_Func_ID
	ORDER BY Sort_Priority ASC
END
GO
/****** Object:  StoredProcedure [dbo].[F1001_sp_upd_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1001_sp_upd_Chuc_Nang]
	@Auto_ID bigint,
	@Ma_Chuc_Nang nvarchar(50),
	@Ten_Chuc_Nang nvarchar(200),
	@Sort_Priority int,
	@Chuc_Nang_Parent_ID bigint,
	@Nhom_Chuc_Nang_ID int,
	@Func_URL nvarchar(200),
	@Image_URL nvarchar(50),
	@Is_View bit,
	@Is_New bit,
	@Is_Edit bit,
	@Is_Delete bit,
	@Is_Export bit,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ten_Chuc_Nang = LTRIM(RTRIM(@Ten_Chuc_Nang))
	set @Func_URL = LTRIM(RTRIM(@Func_URL))
	set @Image_URL = LTRIM(RTRIM(@Image_URL))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	if (isnull(@Ma_Chuc_Nang, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Mã chức năng.', 11, 1)
		return
	end

	if (isnull(@Ten_Chuc_Nang, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Tên chức năng.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Chuc_Nang with (nolock) where Ma_Chuc_Nang = @Ma_Chuc_Nang and Auto_ID <> @Auto_ID)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Mã chức năng đã tồn tại.', 11, 1)
		return
	end

	UPDATE tbl_Sys_Chuc_Nang SET
		Ma_Chuc_Nang = @Ma_Chuc_Nang,
		Ten_Chuc_Nang = @Ten_Chuc_Nang,
		Sort_Priority = @Sort_Priority,
		Chuc_Nang_Parent_ID = @Chuc_Nang_Parent_ID,
		Nhom_Chuc_Nang_ID = @Nhom_Chuc_Nang_ID,
		Func_URL = @Func_URL,
		Image_URL = @Image_URL,
		Is_View = @Is_View,
		Is_New = @Is_New,
		Is_Edit = @Is_Edit,
		Is_Delete = @Is_Delete,
		Is_Export = @Is_Export,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1002_sp_del_Nhom_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1002_sp_del_Nhom_Thanh_Vien]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Nhom_Thanh_Vien SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1002_sp_ins_Nhom_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1002_sp_ins_Nhom_Thanh_Vien]
	@Ten_Nhom_Thanh_Vien nvarchar(200),
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ten_Nhom_Thanh_Vien = LTRIM(RTRIM(@Ten_Nhom_Thanh_Vien))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	if (isnull(@Ten_Nhom_Thanh_Vien, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Tên nhóm thành viên.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Nhom_Thanh_Vien with (nolock) where Ten_Nhom_Thanh_Vien = @Ten_Nhom_Thanh_Vien)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Tên nhóm thành viên đã tồn tại.', 11, 1)
		return
	end

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Nhom_Thanh_Vien
	(
		Auto_ID,
		Ten_Nhom_Thanh_Vien,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ten_Nhom_Thanh_Vien,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1002_sp_sel_List_Nhom_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1002_sp_sel_List_Nhom_Thanh_Vien]
	@Date_From datetime,
	@Date_To datetime
	with recompile
AS
BEGIN
	set @Date_From = dbo.fnConvert_To_Dau_Ngay(@Date_From)
	set @Date_To = dbo.fnConvert_To_Cuoi_Ngay(@Date_To)

	SELECT Auto_ID, Ten_Nhom_Thanh_Vien, Ghi_Chu
	FROM 
		view_Sys_Nhom_Thanh_Vien with (nolock) 
	WHERE 
		Created between @Date_From and @Date_To
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1002_sp_upd_Nhom_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1002_sp_upd_Nhom_Thanh_Vien]
	@Auto_ID bigint,
	@Ten_Nhom_Thanh_Vien nvarchar(200),
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ten_Nhom_Thanh_Vien = LTRIM(RTRIM(@Ten_Nhom_Thanh_Vien))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	if (isnull(@Ten_Nhom_Thanh_Vien, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Tên nhóm thành viên.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Nhom_Thanh_Vien with (nolock) where Ten_Nhom_Thanh_Vien = @Ten_Nhom_Thanh_Vien and Auto_ID <> @Auto_ID)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Tên nhóm thành viên đã tồn tại.', 11, 1)
		return
	end

	UPDATE tbl_Sys_Nhom_Thanh_Vien SET
		Ten_Nhom_Thanh_Vien = @Ten_Nhom_Thanh_Vien,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1003_sp_del_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1003_sp_del_Thanh_Vien]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Thanh_Vien SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1003_sp_ins_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1003_sp_ins_Thanh_Vien]
	@Ma_Dang_Nhap nvarchar(50),
	@Mat_Khau nvarchar(50),
	@Ho_Ten nvarchar(100),
	@Email nvarchar(250),
	@Dien_Thoai nvarchar(200),
	@Trang_Thai_ID int,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))
	set @Ho_Ten = LTRIM(RTRIM(@Ho_Ten))
	set @Email = LTRIM(RTRIM(@Email))
	set @Dien_Thoai = LTRIM(RTRIM(@Dien_Thoai))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	if (isnull(@Ma_Dang_Nhap, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Mã đăng nhập.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Thanh_Vien with (nolock) where Ma_Dang_Nhap = @Ma_Dang_Nhap)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Mã đăng nhập đã tồn tại.', 11, 1)
		return
	end

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Thanh_Vien
	(
		Auto_ID,
		Ma_Dang_Nhap,
		Mat_Khau,
		Ho_Ten,
		Email,
		Dien_Thoai,
		Trang_Thai_ID,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ma_Dang_Nhap,
		@Mat_Khau,
		@Ho_Ten,
		@Email,
		@Dien_Thoai,
		@Trang_Thai_ID,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1003_sp_sel_List_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1003_sp_sel_List_Thanh_Vien]
	@Date_From datetime,
	@Date_To datetime
	with recompile
AS
BEGIN
	set @Date_From = dbo.fnConvert_To_Dau_Ngay(@Date_From)
	set @Date_To = dbo.fnConvert_To_Cuoi_Ngay(@Date_To)

	SELECT Auto_ID, Ma_Dang_Nhap, Mat_Khau, Ho_Ten, Email, Dien_Thoai, Hinh_Dai_Dien_URL, Trang_Thai_ID, Ten_Nhom_Thanh_Vien_Text, Ghi_Chu
	FROM 
		view_Sys_Thanh_Vien with (nolock) 
	WHERE 
		Created between @Date_From and @Date_To
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1003_sp_upd_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1003_sp_upd_Thanh_Vien]
	@Auto_ID bigint,
	@Ma_Dang_Nhap nvarchar(50),
	@Mat_Khau nvarchar(50),
	@Ho_Ten nvarchar(100),
	@Email nvarchar(250),
	@Dien_Thoai nvarchar(200),
	@Trang_Thai_ID int,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))
	set @Ho_Ten = LTRIM(RTRIM(@Ho_Ten))
	set @Email = LTRIM(RTRIM(@Email))
	set @Dien_Thoai = LTRIM(RTRIM(@Dien_Thoai))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	if (isnull(@Ma_Dang_Nhap, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Mã đăng nhập.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Thanh_Vien with (nolock) where Ma_Dang_Nhap = @Ma_Dang_Nhap and Auto_ID <> @Auto_ID)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Mã đăng nhập đã tồn tại.', 11, 1)
		return
	end

	UPDATE tbl_Sys_Thanh_Vien SET
		Ma_Dang_Nhap = @Ma_Dang_Nhap,
		Mat_Khau = @Mat_Khau,
		Ho_Ten = @Ho_Ten,
		Email = @Email,
		Dien_Thoai = @Dien_Thoai,
		Trang_Thai_ID = @Trang_Thai_ID,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1004_sp_del_Nhom_Thanh_Vien_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1004_sp_del_Nhom_Thanh_Vien_User]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	declare @Ma_Dang_Nhap nvarchar(50) = (select Ma_Dang_Nhap from view_Sys_Nhom_Thanh_Vien_User where Auto_ID = @Auto_ID)

	UPDATE tbl_Sys_Nhom_Thanh_Vien_User SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID

	exec FTotal_sp_upd_Thanh_Vien @Ma_Dang_Nhap
END
GO
/****** Object:  StoredProcedure [dbo].[F1004_sp_ins_Nhom_Thanh_Vien_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1004_sp_ins_Nhom_Thanh_Vien_User]
	@Nhom_Thanh_Vien_ID bigint,
	@Ma_Dang_Nhap nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))

	if (isnull(@Ma_Dang_Nhap, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Mã đăng nhập.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Nhom_Thanh_Vien_User with (nolock) where Ma_Dang_Nhap = @Ma_Dang_Nhap and Nhom_Thanh_Vien_ID = @Nhom_Thanh_Vien_ID)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Mã đăng nhập đã tồn tại.', 11, 1)
		return
	end

	declare @Check_ID_2 bigint = (select top 1 Auto_ID from view_Sys_Thanh_Vien with (nolock) where Ma_Dang_Nhap = @Ma_Dang_Nhap)
	if(isnull(@Check_ID_2, 0) = 0)
	begin
		RAISERROR(N'Mã đăng nhập không tồn tại trong danh sách thành viên.', 11, 1)
		return
	end

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Nhom_Thanh_Vien_User
	(
		Auto_ID,
		Nhom_Thanh_Vien_ID,
		Ma_Dang_Nhap,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Nhom_Thanh_Vien_ID,
		@Ma_Dang_Nhap,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	exec FTotal_sp_upd_Thanh_Vien @Ma_Dang_Nhap

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1004_sp_sel_List_Nhom_Thanh_Vien_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1004_sp_sel_List_Nhom_Thanh_Vien_User]
	@Nhom_Thanh_Vien_ID int
	with recompile
AS
BEGIN
	SELECT Auto_ID, Nhom_Thanh_Vien_ID, Ma_Dang_Nhap, Ho_Ten
	FROM 
		view_Sys_Nhom_Thanh_Vien_User with (nolock) 
	WHERE 
		Nhom_Thanh_Vien_ID = @Nhom_Thanh_Vien_ID
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1004_sp_sel_List_Thanh_Vien_Khong_Thuoc_Nhom]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1004_sp_sel_List_Thanh_Vien_Khong_Thuoc_Nhom]
	@Nhom_Thanh_Vien_ID int
	with recompile
AS
BEGIN
	SELECT A.Auto_ID, A.Ma_Dang_Nhap, A.Ho_Ten
	FROM 
		view_Sys_Thanh_Vien A with (nolock) 
	WHERE 
		A.Ma_Dang_Nhap not in (select Ma_Dang_Nhap from view_Sys_Nhom_Thanh_Vien_User where Nhom_Thanh_Vien_ID = @Nhom_Thanh_Vien_ID)
	ORDER BY Ma_Dang_Nhap ASC
END
GO
/****** Object:  StoredProcedure [dbo].[F1005_sp_sel_List_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1005_sp_sel_List_Chuc_Nang]
	@Nhom_Chuc_Nang_ID int,
	@Parent_Func_ID bigint,
	@Nhom_Thanh_Vien_ID bigint
	with recompile
AS
BEGIN
	select Chuc_Nang_ID, Is_Have_View_Permission, Is_Have_Add_Permission, Is_Have_Edit_Permission, 
		Is_Have_Delete_Permission, Is_Have_Export_Permission
	into #Temp_Phan_Quyen_7262
	from 
		view_Sys_Phan_Quyen_Chuc_Nang with (nolock) 
	where
		Nhom_Thanh_Vien_ID = @Nhom_Thanh_Vien_ID

	SELECT A.Auto_ID, A.Ma_Chuc_Nang, A.Ten_Chuc_Nang, A.Sort_Priority, A.Chuc_Nang_Parent_ID, A.Nhom_Chuc_Nang_ID, 
		A.Func_URL, A.Image_URL, A.Is_View, A.Is_New, A.Is_Edit, A.Is_Delete, A.Is_Export, A.Ghi_Chu, B.Is_Have_View_Permission,
		B.Is_Have_Add_Permission, B.Is_Have_Edit_Permission, B.Is_Have_Delete_Permission, B.Is_Have_Export_Permission
	FROM 
		view_Sys_Chuc_Nang A with (nolock) left join #Temp_Phan_Quyen_7262 B on (A.Auto_ID = B.Chuc_Nang_ID)
	WHERE 
		A.Nhom_Chuc_Nang_ID = @Nhom_Chuc_Nang_ID
		and isnull(A.Chuc_Nang_Parent_ID, 0) = @Parent_Func_ID
	ORDER BY Sort_Priority ASC
END
GO
/****** Object:  StoredProcedure [dbo].[F1005_sp_sel_List_Phan_Quyen_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1005_sp_sel_List_Phan_Quyen_Chuc_Nang]
	@Nhom_Thanh_Vien_ID int
	with recompile
AS
BEGIN
	SELECT Auto_ID, Nhom_Thanh_Vien_ID, Chuc_Nang_ID, Is_Have_View_Permission, 
		Is_Have_Add_Permission, Is_Have_Edit_Permission, Is_Have_Delete_Permission,
		Is_Have_Export_Permission
	FROM 
		view_Sys_Phan_Quyen_Chuc_Nang with (nolock) 
	WHERE 
		Nhom_Thanh_Vien_ID = @Nhom_Thanh_Vien_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1005_sp_upd_Phan_Quyen_Chuc_Nang_Add]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1005_sp_upd_Phan_Quyen_Chuc_Nang_Add]
	@Nhom_Thanh_Vien_ID bigint,
	@Chuc_Nang_ID bigint,
	@Is_Have_Add_Permission bit,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	declare @Auto_ID bigint = (select top 1 Auto_ID from view_Sys_Phan_Quyen_Chuc_Nang with (nolock) where Nhom_Thanh_Vien_ID = @Nhom_Thanh_Vien_ID and Chuc_Nang_ID = @Chuc_Nang_ID)

	if (isnull(@Auto_ID, 0) <> 0)
	begin
		UPDATE tbl_Sys_Phan_Quyen_Chuc_Nang SET
			Is_Have_Add_Permission = @Is_Have_Add_Permission,
			Last_Updated = getdate(),
			Last_Updated_By = @Last_Updated_By,
			Last_Updated_By_Function = @Last_Updated_By_Function
		WHERE
			Auto_ID = @Auto_ID
	end
	else
	begin
		set @Auto_ID = (next value for dbo.Seq_ID)

		INSERT INTO tbl_Sys_Phan_Quyen_Chuc_Nang
		(
			Auto_ID,
			Nhom_Thanh_Vien_ID,
			Chuc_Nang_ID,
			Is_Have_Add_Permission,
			deleted,
			Created,
			Created_By,
			Created_By_Function,
			Last_Updated,
			Last_Updated_By,
			Last_Updated_By_Function
		)
		VALUES
		(
			@Auto_ID,
			@Nhom_Thanh_Vien_ID,
			@Chuc_Nang_ID,
			@Is_Have_Add_Permission,
			0,
			getdate(),
			@Last_Updated_By,
			@Last_Updated_By_Function,
			getdate(),
			@Last_Updated_By,
			@Last_Updated_By_Function
		)
	end
END
GO
/****** Object:  StoredProcedure [dbo].[F1005_sp_upd_Phan_Quyen_Chuc_Nang_Delete]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1005_sp_upd_Phan_Quyen_Chuc_Nang_Delete]
	@Nhom_Thanh_Vien_ID bigint,
	@Chuc_Nang_ID bigint,
	@Is_Have_Delete_Permission bit,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	declare @Auto_ID bigint = (select top 1 Auto_ID from view_Sys_Phan_Quyen_Chuc_Nang with (nolock) where Nhom_Thanh_Vien_ID = @Nhom_Thanh_Vien_ID and Chuc_Nang_ID = @Chuc_Nang_ID)

	if (isnull(@Auto_ID, 0) <> 0)
	begin
		UPDATE tbl_Sys_Phan_Quyen_Chuc_Nang SET
			Is_Have_Delete_Permission = @Is_Have_Delete_Permission,
			Last_Updated = getdate(),
			Last_Updated_By = @Last_Updated_By,
			Last_Updated_By_Function = @Last_Updated_By_Function
		WHERE
			Auto_ID = @Auto_ID
	end
	else
	begin
		set @Auto_ID = (next value for dbo.Seq_ID)

		INSERT INTO tbl_Sys_Phan_Quyen_Chuc_Nang
		(
			Auto_ID,
			Nhom_Thanh_Vien_ID,
			Chuc_Nang_ID,
			Is_Have_Delete_Permission,
			deleted,
			Created,
			Created_By,
			Created_By_Function,
			Last_Updated,
			Last_Updated_By,
			Last_Updated_By_Function
		)
		VALUES
		(
			@Auto_ID,
			@Nhom_Thanh_Vien_ID,
			@Chuc_Nang_ID,
			@Is_Have_Delete_Permission,
			0,
			getdate(),
			@Last_Updated_By,
			@Last_Updated_By_Function,
			getdate(),
			@Last_Updated_By,
			@Last_Updated_By_Function
		)
	end
END
GO
/****** Object:  StoredProcedure [dbo].[F1005_sp_upd_Phan_Quyen_Chuc_Nang_Edit]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1005_sp_upd_Phan_Quyen_Chuc_Nang_Edit]
	@Nhom_Thanh_Vien_ID bigint,
	@Chuc_Nang_ID bigint,
	@Is_Have_Edit_Permission bit,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	declare @Auto_ID bigint = (select top 1 Auto_ID from view_Sys_Phan_Quyen_Chuc_Nang with (nolock) where Nhom_Thanh_Vien_ID = @Nhom_Thanh_Vien_ID and Chuc_Nang_ID = @Chuc_Nang_ID)

	if (isnull(@Auto_ID, 0) <> 0)
	begin
		UPDATE tbl_Sys_Phan_Quyen_Chuc_Nang SET
			Is_Have_Edit_Permission = @Is_Have_Edit_Permission,
			Last_Updated = getdate(),
			Last_Updated_By = @Last_Updated_By,
			Last_Updated_By_Function = @Last_Updated_By_Function
		WHERE
			Auto_ID = @Auto_ID
	end
	else
	begin
		set @Auto_ID = (next value for dbo.Seq_ID)

		INSERT INTO tbl_Sys_Phan_Quyen_Chuc_Nang
		(
			Auto_ID,
			Nhom_Thanh_Vien_ID,
			Chuc_Nang_ID,
			Is_Have_Edit_Permission,
			deleted,
			Created,
			Created_By,
			Created_By_Function,
			Last_Updated,
			Last_Updated_By,
			Last_Updated_By_Function
		)
		VALUES
		(
			@Auto_ID,
			@Nhom_Thanh_Vien_ID,
			@Chuc_Nang_ID,
			@Is_Have_Edit_Permission,
			0,
			getdate(),
			@Last_Updated_By,
			@Last_Updated_By_Function,
			getdate(),
			@Last_Updated_By,
			@Last_Updated_By_Function
		)
	end
END
GO
/****** Object:  StoredProcedure [dbo].[F1005_sp_upd_Phan_Quyen_Chuc_Nang_Export]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1005_sp_upd_Phan_Quyen_Chuc_Nang_Export]
	@Nhom_Thanh_Vien_ID bigint,
	@Chuc_Nang_ID bigint,
	@Is_Have_Export_Permission bit,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	declare @Auto_ID bigint = (select top 1 Auto_ID from view_Sys_Phan_Quyen_Chuc_Nang with (nolock) where Nhom_Thanh_Vien_ID = @Nhom_Thanh_Vien_ID and Chuc_Nang_ID = @Chuc_Nang_ID)

	if (isnull(@Auto_ID, 0) <> 0)
	begin
		UPDATE tbl_Sys_Phan_Quyen_Chuc_Nang SET
			Is_Have_Export_Permission = @Is_Have_Export_Permission,
			Last_Updated = getdate(),
			Last_Updated_By = @Last_Updated_By,
			Last_Updated_By_Function = @Last_Updated_By_Function
		WHERE
			Auto_ID = @Auto_ID
	end
	else
	begin
		set @Auto_ID = (next value for dbo.Seq_ID)

		INSERT INTO tbl_Sys_Phan_Quyen_Chuc_Nang
		(
			Auto_ID,
			Nhom_Thanh_Vien_ID,
			Chuc_Nang_ID,
			Is_Have_Export_Permission,
			deleted,
			Created,
			Created_By,
			Created_By_Function,
			Last_Updated,
			Last_Updated_By,
			Last_Updated_By_Function
		)
		VALUES
		(
			@Auto_ID,
			@Nhom_Thanh_Vien_ID,
			@Chuc_Nang_ID,
			@Is_Have_Export_Permission,
			0,
			getdate(),
			@Last_Updated_By,
			@Last_Updated_By_Function,
			getdate(),
			@Last_Updated_By,
			@Last_Updated_By_Function
		)
	end
END
GO
/****** Object:  StoredProcedure [dbo].[F1005_sp_upd_Phan_Quyen_Chuc_Nang_View]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1005_sp_upd_Phan_Quyen_Chuc_Nang_View]
	@Nhom_Thanh_Vien_ID bigint,
	@Chuc_Nang_ID bigint,
	@Is_Have_View_Permission bit,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	declare @Auto_ID bigint = (select top 1 Auto_ID from view_Sys_Phan_Quyen_Chuc_Nang with (nolock) where Nhom_Thanh_Vien_ID = @Nhom_Thanh_Vien_ID and Chuc_Nang_ID = @Chuc_Nang_ID)

	if (isnull(@Auto_ID, 0) <> 0)
	begin
		UPDATE tbl_Sys_Phan_Quyen_Chuc_Nang SET
			Is_Have_View_Permission = @Is_Have_View_Permission,
			Last_Updated = getdate(),
			Last_Updated_By = @Last_Updated_By,
			Last_Updated_By_Function = @Last_Updated_By_Function
		WHERE
			Auto_ID = @Auto_ID
	end
	else
	begin
		set @Auto_ID = (next value for dbo.Seq_ID)

		INSERT INTO tbl_Sys_Phan_Quyen_Chuc_Nang
		(
			Auto_ID,
			Nhom_Thanh_Vien_ID,
			Chuc_Nang_ID,
			Is_Have_View_Permission,
			deleted,
			Created,
			Created_By,
			Created_By_Function,
			Last_Updated,
			Last_Updated_By,
			Last_Updated_By_Function
		)
		VALUES
		(
			@Auto_ID,
			@Nhom_Thanh_Vien_ID,
			@Chuc_Nang_ID,
			@Is_Have_View_Permission,
			0,
			getdate(),
			@Last_Updated_By,
			@Last_Updated_By_Function,
			getdate(),
			@Last_Updated_By,
			@Last_Updated_By_Function
		)
	end
END
GO
/****** Object:  StoredProcedure [dbo].[F1006_sp_sel_List_Log_Nhat_Ky_Dang_Nhap_By_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1006_sp_sel_List_Log_Nhat_Ky_Dang_Nhap_By_User]
	@Ma_Dang_Nhap nvarchar(50)
	with recompile
AS
BEGIN
	SELECT Auto_ID, Ma_Dang_Nhap, User_Agent, IP, Created
	FROM 
		view_Log_Nhat_Ky_Dang_Nhap with (nolock)
	where
		Ma_Dang_Nhap = @Ma_Dang_Nhap
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1006_sp_sel_List_Log_Nhat_Ky_Truy_Cap_Chuc_Nang_By_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1006_sp_sel_List_Log_Nhat_Ky_Truy_Cap_Chuc_Nang_By_User]
	@Ma_Dang_Nhap nvarchar(50)
	with recompile
AS
BEGIN
	SELECT top 300 Auto_ID, Ma_Dang_Nhap, Ma_Chuc_Nang, Ten_Chuc_Nang, Created, Created_By
	FROM 
		view_Log_Nhat_Ky_Truy_Cap_Chuc_Nang with (nolock)
	where
		Ma_Dang_Nhap = @Ma_Dang_Nhap
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1007_sp_upd_Doi_Mat_Khau]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1007_sp_upd_Doi_Mat_Khau]
	@Auto_ID int,
	@Mat_Khau_Moi nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	update tbl_Sys_Thanh_Vien set
		Mat_Khau = @Mat_Khau_Moi
	where
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1009_sp_sel_List_Nhat_Ky_Dang_Nhap_Ca_Nhan]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1009_sp_sel_List_Nhat_Ky_Dang_Nhap_Ca_Nhan]
	@Date_From datetime,
	@Date_To datetime,
	@Ma_Dang_Nhap nvarchar(50)
	with recompile
AS
BEGIN
	set @Date_From = dbo.fnConvert_To_Dau_Ngay(@Date_From)
	set @Date_To = dbo.fnConvert_To_Cuoi_Ngay(@Date_To)

	SELECT Auto_ID, Ma_Dang_Nhap, IP, User_Agent, Created
	FROM 
		view_Log_Nhat_Ky_Dang_Nhap with (nolock) 
	WHERE 
		Created between @Date_From and @Date_To
		and Ma_Dang_Nhap = @Ma_Dang_Nhap
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1010_sp_sel_List_Nhat_Ky_Dang_Nhap_All]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1010_sp_sel_List_Nhat_Ky_Dang_Nhap_All]
	@Date_From datetime,
	@Date_To datetime
	with recompile
AS
BEGIN
	set @Date_From = dbo.fnConvert_To_Dau_Ngay(@Date_From)
	set @Date_To = dbo.fnConvert_To_Cuoi_Ngay(@Date_To)

	SELECT Auto_ID, Ma_Dang_Nhap, IP, User_Agent, Created
	FROM 
		view_Log_Nhat_Ky_Dang_Nhap with (nolock) 
	WHERE 
		Created between @Date_From and @Date_To
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1013_sp_del_Dinh_Nghia_Mau_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1013_sp_del_Dinh_Nghia_Mau_Column]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Mau_Column SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1013_sp_ins_Dinh_Nghia_Mau_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1013_sp_ins_Dinh_Nghia_Mau_Column]
	@Field_Name nvarchar(50),
	@Ma_So_Mau nvarchar(50),
	@Ghi_Chu nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Ma_So_Mau = LTRIM(RTRIM(@Ma_So_Mau))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	if (isnull(@Field_Name, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Field name.', 11, 1)
		return
	end

	declare @Check_ID_2 bigint = (select top 1 Auto_ID from view_Sys_Mau_Column with (nolock) where Field_Name = @Field_Name)
	if(isnull(@Check_ID_2, 0) > 0)
	begin
		RAISERROR(N'Field name đã tồn tại.', 11, 1)
		return
	end

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Mau_Column
	(
		Auto_ID,
		Field_Name,
		Ma_So_Mau,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Field_Name,
		@Ma_So_Mau,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1013_sp_sel_List_Dinh_Nghia_Mau_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1013_sp_sel_List_Dinh_Nghia_Mau_Column]
	@Date_From datetime,
	@Date_To datetime
	with recompile
AS
BEGIN
	set @Date_From = dbo.fnConvert_To_Dau_Ngay(@Date_From)
	set @Date_To = dbo.fnConvert_To_Cuoi_Ngay(@Date_To)

	SELECT Auto_ID, Field_Name, Ma_So_Mau, Ghi_Chu
	FROM 
		view_Sys_Mau_Column with (nolock) 
	WHERE 
		Created between @Date_From and @Date_To
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1013_sp_upd_Dinh_Nghia_Mau_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1013_sp_upd_Dinh_Nghia_Mau_Column]
	@Auto_ID bigint,
	@Field_Name nvarchar(50),
	@Ma_So_Mau nvarchar(50),
	@Ghi_Chu nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Ma_So_Mau = LTRIM(RTRIM(@Ma_So_Mau))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	if (isnull(@Field_Name, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Field name.', 11, 1)
		return
	end

	declare @Check_ID_2 bigint = (select top 1 Auto_ID from view_Sys_Mau_Column with (nolock) where Field_Name = @Field_Name and Auto_ID <> @Auto_ID)
	if(isnull(@Check_ID_2, 0) > 0)
	begin
		RAISERROR(N'Field name đã tồn tại.', 11, 1)
		return
	end

	UPDATE tbl_Sys_Mau_Column SET
		Field_Name = @Field_Name,
		Ma_So_Mau = @Ma_So_Mau,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1014_sp_del_Multilanguage]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1014_sp_del_Multilanguage]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Language SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1014_sp_ins_Multilanguage]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1014_sp_ins_Multilanguage]
	@Field_Name nvarchar(200),
	@Lang_1 nvarchar(200),
	@Lang_2 nvarchar(200),
	@Lang_3 nvarchar(200),
	@Lang_4 nvarchar(200),
	@Lang_5 nvarchar(200),
	@Type_ID int,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Lang_1 = LTRIM(RTRIM(@Lang_1))
	set @Lang_2 = LTRIM(RTRIM(@Lang_2))
	set @Lang_3 = LTRIM(RTRIM(@Lang_3))
	set @Lang_4 = LTRIM(RTRIM(@Lang_4))
	set @Lang_5 = LTRIM(RTRIM(@Lang_5))

	if (isnull(@Field_Name, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Field name.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Language with (nolock) where Field_Name = @Field_Name)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Field name đã tồn tại.', 11, 1)
		return
	end

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Language
	(
		Auto_ID,
		Field_Name,
		Lang_1,
		Lang_2,
		Lang_3,
		Lang_4,
		Lang_5,
		Type_ID,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Field_Name,
		@Lang_1,
		@Lang_2,
		@Lang_3,
		@Lang_4,
		@Lang_5,
		@Type_ID,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1014_sp_sel_List_Multilanguage]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1014_sp_sel_List_Multilanguage]
	@Date_From datetime,
	@Date_To datetime
	with recompile
AS
BEGIN
	set @Date_From = dbo.fnConvert_To_Dau_Ngay(@Date_From)
	set @Date_To = dbo.fnConvert_To_Cuoi_Ngay(@Date_To)

	SELECT Auto_ID, Field_Name, Lang_1, Lang_2, Lang_3, Lang_4, Lang_5, Type_ID
	FROM 
		view_Sys_Language with (nolock) 
	WHERE 
		Created between @Date_From and @Date_To
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1014_sp_upd_Multilanguage]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1014_sp_upd_Multilanguage]
	@Auto_ID bigint,
	@Field_Name nvarchar(200),
	@Lang_1 nvarchar(200),
	@Lang_2 nvarchar(200),
	@Lang_3 nvarchar(200),
	@Lang_4 nvarchar(200),
	@Lang_5 nvarchar(200),
	@Type_ID int,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Lang_1 = LTRIM(RTRIM(@Lang_1))
	set @Lang_2 = LTRIM(RTRIM(@Lang_2))
	set @Lang_3 = LTRIM(RTRIM(@Lang_3))
	set @Lang_4 = LTRIM(RTRIM(@Lang_4))
	set @Lang_5 = LTRIM(RTRIM(@Lang_5))

	if (isnull(@Field_Name, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Field name.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Language with (nolock) where Field_Name = @Field_Name and Auto_ID <> @Auto_ID)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Field name đã tồn tại.', 11, 1)
		return
	end

	UPDATE tbl_Sys_Language SET
		Field_Name = @Field_Name,
		Lang_1 = @Lang_1,
		Lang_2 = @Lang_2,
		Lang_3 = @Lang_3,
		Lang_4 = @Lang_4,
		Lang_5 = @Lang_5,
		Type_ID = @Type_ID,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1019_sp_del_Drill_Down]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1019_sp_del_Drill_Down]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Drill_Down SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1019_sp_ins_Drill_Down]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1019_sp_ins_Drill_Down]
	@Field_Name nvarchar(50),
	@Link_URL nvarchar(200),
	@Parameter_Field nvarchar(50),
	@Func_ID nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Link_URL = LTRIM(RTRIM(@Link_URL))
	set @Parameter_Field = LTRIM(RTRIM(@Parameter_Field))
	set @Func_ID = LTRIM(RTRIM(@Func_ID))

	if (isnull(@Field_Name, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Field name.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Drill_Down with (nolock) where Field_Name = @Field_Name)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Field name đã tồn tại.', 11, 1)
		return
	end

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Drill_Down
	(
		Auto_ID,
		Field_Name,
		Link_URL,
		Parameter_Field,
		Func_ID,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Field_Name,
		@Link_URL,
		@Parameter_Field,
		@Func_ID,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1019_sp_sel_List_Drill_Down]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1019_sp_sel_List_Drill_Down]
	@Date_From datetime,
	@Date_To datetime
	with recompile
AS
BEGIN
	set @Date_From = dbo.fnConvert_To_Dau_Ngay(@Date_From)
	set @Date_To = dbo.fnConvert_To_Cuoi_Ngay(@Date_To)

	SELECT Auto_ID, Field_Name, Link_URL, Parameter_Field, Func_ID
	FROM 
		view_Sys_Drill_Down with (nolock) 
	WHERE 
		Created between @Date_From and @Date_To
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1019_sp_upd_Drill_Down]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1019_sp_upd_Drill_Down]
	@Auto_ID bigint,
	@Field_Name nvarchar(50),
	@Link_URL nvarchar(200),
	@Parameter_Field nvarchar(50),
	@Func_ID nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Link_URL = LTRIM(RTRIM(@Link_URL))
	set @Parameter_Field = LTRIM(RTRIM(@Parameter_Field))
	set @Func_ID = LTRIM(RTRIM(@Func_ID))

	if (isnull(@Field_Name, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Field name.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Drill_Down with (nolock) where Field_Name = @Field_Name and Auto_ID <> @Auto_ID)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Field name đã tồn tại.', 11, 1)
		return
	end

	UPDATE tbl_Sys_Drill_Down SET
		Field_Name = @Field_Name,
		Link_URL = @Link_URL,
		Parameter_Field = @Parameter_Field,
		Func_ID = @Func_ID,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1020_sp_del_Hien_An_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1020_sp_del_Hien_An_Column]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Hien_An_Column SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1020_sp_ins_Hien_An_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1020_sp_ins_Hien_An_Column]
	@Chu_Hang_ID bigint,
	@Field_Name nvarchar(50),
	@Option_ID int,
	@Ma_Chuc_Nang nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))

	if (isnull(@Field_Name, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Field name.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Hien_An_Column with (nolock) where Field_Name = @Field_Name and Ma_Chuc_Nang = @Ma_Chuc_Nang and Chu_Hang_ID = @Chu_Hang_ID)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Field name đã tồn tại.', 11, 1)
		return
	end

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Hien_An_Column
	(
		Auto_ID,
		Chu_Hang_ID,
		Field_Name,
		Option_ID,
		Ma_Chuc_Nang,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Chu_Hang_ID,
		@Field_Name,
		@Option_ID,
		@Ma_Chuc_Nang,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1020_sp_sel_List_Hien_An_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1020_sp_sel_List_Hien_An_Column]
	@Date_From datetime,
	@Date_To datetime
	with recompile
AS
BEGIN
	set @Date_From = dbo.fnConvert_To_Dau_Ngay(@Date_From)
	set @Date_To = dbo.fnConvert_To_Cuoi_Ngay(@Date_To)

	SELECT Auto_ID, Chu_Hang_ID, Field_Name, Option_ID, Ma_Chuc_Nang
	FROM 
		view_Sys_Hien_An_Column with (nolock) 
	WHERE 
		Created between @Date_From and @Date_To
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1020_sp_upd_Hien_An_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1020_sp_upd_Hien_An_Column]
	@Auto_ID bigint,
	@Chu_Hang_ID bigint,
	@Field_Name nvarchar(50),
	@Option_ID int,
	@Ma_Chuc_Nang nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))

	if (isnull(@Field_Name, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Field name.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Hien_An_Column with (nolock) where Field_Name = @Field_Name and Chu_Hang_ID = @Chu_Hang_ID and Ma_Chuc_Nang = @Ma_Chuc_Nang and Auto_ID <> @Auto_ID)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Field name đã tồn tại.', 11, 1)
		return
	end

	UPDATE tbl_Sys_Hien_An_Column SET
		Chu_Hang_ID = @Chu_Hang_ID,
		Field_Name = @Field_Name,
		Option_ID = @Option_ID,
		Ma_Chuc_Nang = @Ma_Chuc_Nang,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1027_sp_del_Dieu_Chinh_Do_Rong_Cot]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1027_sp_del_Dieu_Chinh_Do_Rong_Cot]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Column_Width SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1027_sp_ins_Dieu_Chinh_Do_Rong_Cot]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1027_sp_ins_Dieu_Chinh_Do_Rong_Cot]
	@Field_Name nvarchar(50),
	@Do_Rong int,
	@Format_Number nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Format_Number = LTRIM(RTRIM(@Format_Number))

	if (isnull(@Field_Name, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Field name.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Column_Width with (nolock) where Field_Name = @Field_Name)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Field name đã tồn tại.', 11, 1)
		return
	end

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Column_Width
	(
		Auto_ID,
		Field_Name,
		Do_Rong,
		Format_Number,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Field_Name,
		@Do_Rong,
		@Format_Number,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1027_sp_sel_List_Dieu_Chinh_Do_Rong_Cot]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1027_sp_sel_List_Dieu_Chinh_Do_Rong_Cot]
	@Date_From datetime,
	@Date_To datetime
	with recompile
AS
BEGIN
	set @Date_From = dbo.fnConvert_To_Dau_Ngay(@Date_From)
	set @Date_To = dbo.fnConvert_To_Cuoi_Ngay(@Date_To)

	SELECT Auto_ID, Field_Name, Do_Rong, Format_Number
	FROM 
		view_Sys_Column_Width with (nolock) 
	WHERE 
		Created between @Date_From and @Date_To
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1027_sp_upd_Dieu_Chinh_Do_Rong_Cot]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1027_sp_upd_Dieu_Chinh_Do_Rong_Cot]
	@Auto_ID bigint,
	@Field_Name nvarchar(50),
	@Do_Rong int,
	@Format_Number nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Format_Number = LTRIM(RTRIM(@Format_Number))

	if (isnull(@Field_Name, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Field name.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Column_Width with (nolock) where Field_Name = @Field_Name and Auto_ID <> @Auto_ID)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Field name đã tồn tại.', 11, 1)
		return
	end

	UPDATE tbl_Sys_Column_Width SET
		Field_Name = @Field_Name,
		Do_Rong = @Do_Rong,
		Format_Number = @Format_Number,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1028_sp_del_Filter_Date_Default]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1028_sp_del_Filter_Date_Default]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Filter_Date_Default SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1028_sp_ins_Filter_Date_Default]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1028_sp_ins_Filter_Date_Default]
	@Ma_Chuc_Nang nvarchar(50),
	@Duration_Days_From float,
	@Duration_Days_To float,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	if (isnull(@Ma_Chuc_Nang, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Mã chức năng.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Filter_Date_Default with (nolock) where Ma_Chuc_Nang = @Ma_Chuc_Nang)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Mã chức năng đã tồn tại.', 11, 1)
		return
	end

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Filter_Date_Default
	(
		Auto_ID,
		Ma_Chuc_Nang,
		Duration_Days_From,
		Duration_Days_To,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ma_Chuc_Nang,
		@Duration_Days_From,
		@Duration_Days_To,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1028_sp_sel_List_Filter_Date_Default]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1028_sp_sel_List_Filter_Date_Default]
	@Date_From datetime,
	@Date_To datetime
	with recompile
AS
BEGIN
	set @Date_From = dbo.fnConvert_To_Dau_Ngay(@Date_From)
	set @Date_To = dbo.fnConvert_To_Cuoi_Ngay(@Date_To)

	SELECT Auto_ID, Ma_Chuc_Nang, Duration_Days_From, Duration_Days_To, Ghi_Chu
	FROM 
		view_Sys_Filter_Date_Default with (nolock) 
	WHERE 
		Created between @Date_From and @Date_To
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1028_sp_upd_Filter_Date_Default]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1028_sp_upd_Filter_Date_Default]
	@Auto_ID bigint,
	@Ma_Chuc_Nang nvarchar(50),
	@Duration_Days_From float,
	@Duration_Days_To float,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	if (isnull(@Ma_Chuc_Nang, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Mã chức năng.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Filter_Date_Default with (nolock) where Ma_Chuc_Nang = @Ma_Chuc_Nang and Auto_ID <> @Auto_ID)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Mã chức năng đã tồn tại.', 11, 1)
		return
	end

	UPDATE tbl_Sys_Filter_Date_Default SET
		Ma_Chuc_Nang = @Ma_Chuc_Nang,
		Duration_Days_From = @Duration_Days_From,
		Duration_Days_To = @Duration_Days_To,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1029_sp_sel_List_Nhat_Ky_Import_Excel]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1029_sp_sel_List_Nhat_Ky_Import_Excel]
	@Date_From datetime,
	@Date_To datetime
	with recompile
AS
BEGIN
	set @Date_From = dbo.fnConvert_To_Dau_Ngay(@Date_From)
	set @Date_To = dbo.fnConvert_To_Cuoi_Ngay(@Date_To)

	SELECT Auto_ID, Ma_Chuc_Nang, Ten_Chuc_Nang, Link_URL, Trang_Thai_ID, Ghi_Chu, Created, Created_By
	FROM 
		view_Log_Import_Excel with (nolock) 
	WHERE 
		Created between @Date_From and @Date_To
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1030_sp_sel_List_Nhat_Ky_Truy_Cap_Tinh_Nang_All]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1030_sp_sel_List_Nhat_Ky_Truy_Cap_Tinh_Nang_All]
	@Date_From datetime,
	@Date_To datetime
	with recompile
AS
BEGIN
	set @Date_From = dbo.fnConvert_To_Dau_Ngay(@Date_From)
	set @Date_To = dbo.fnConvert_To_Cuoi_Ngay(@Date_To)

	SELECT Auto_ID, Ma_Dang_Nhap, Ma_Chuc_Nang, Ten_Chuc_Nang, Created
	FROM 
		view_Log_Nhat_Ky_Truy_Cap_Chuc_Nang with (nolock) 
	WHERE 
		Created between @Date_From and @Date_To
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1031_sp_del_Help_Guide]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1031_sp_del_Help_Guide]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Help_Guide SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1031_sp_ins_Help_Guide]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1031_sp_ins_Help_Guide]
	@Khach_Hang_ID bigint,
	@Ma_Chuc_Nang nvarchar(50),
	@Ngon_Ngu nvarchar(50),
	@Noi_Dung ntext,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ngon_Ngu = LTRIM(RTRIM(@Ngon_Ngu))

	if (isnull(@Ma_Chuc_Nang, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Mã chức năng.', 11, 1)
		return
	end

	if (isnull(@Ngon_Ngu, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập ngôn ngữ.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Help_Guide with (nolock) where Ma_Chuc_Nang = @Ma_Chuc_Nang and Khach_Hang_ID = @Khach_Hang_ID and Ngon_Ngu = @Ngon_Ngu)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Mã chức năng đã tồn tại.', 11, 1)
		return
	end

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Help_Guide
	(
		Auto_ID,
		Khach_Hang_ID,
		Ma_Chuc_Nang,
		Ngon_Ngu,
		Noi_Dung,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Khach_Hang_ID,
		@Ma_Chuc_Nang,
		@Ngon_Ngu,
		@Noi_Dung,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1031_sp_sel_List_Help_Guide]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1031_sp_sel_List_Help_Guide]
	@Date_From datetime,
	@Date_To datetime
	with recompile
AS
BEGIN
	set @Date_From = dbo.fnConvert_To_Dau_Ngay(@Date_From)
	set @Date_To = dbo.fnConvert_To_Cuoi_Ngay(@Date_To)

	SELECT Auto_ID, Khach_Hang_ID, Ma_Chuc_Nang, Ngon_Ngu
	FROM 
		view_Sys_Help_Guide with (nolock) 
	WHERE 
		Created between @Date_From and @Date_To
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1031_sp_upd_Help_Guide]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1031_sp_upd_Help_Guide]
	@Auto_ID bigint,
	@Khach_Hang_ID bigint,
	@Ma_Chuc_Nang nvarchar(50),
	@Ngon_Ngu nvarchar(50),
	@Noi_Dung ntext,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ngon_Ngu = LTRIM(RTRIM(@Ngon_Ngu))

	if (isnull(@Ma_Chuc_Nang, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Mã chức năng.', 11, 1)
		return
	end

	if (isnull(@Ngon_Ngu, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập ngôn ngữ.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Help_Guide with (nolock) where Ma_Chuc_Nang = @Ma_Chuc_Nang and Khach_Hang_ID = @Khach_Hang_ID and Ngon_Ngu = @Ngon_Ngu and Auto_ID <> @Auto_ID)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Mã chức năng đã tồn tại.', 11, 1)
		return
	end

	UPDATE tbl_Sys_Help_Guide SET
		Khach_Hang_ID = @Khach_Hang_ID,
		Ma_Chuc_Nang = @Ma_Chuc_Nang,
		Ngon_Ngu = @Ngon_Ngu,
		Noi_Dung = @Noi_Dung,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1032_sp_del_Dong_Bang_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1032_sp_del_Dong_Bang_Column]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Frozen_Column SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1032_sp_ins_Dong_Bang_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1032_sp_ins_Dong_Bang_Column]
	@Ma_Chuc_Nang nvarchar(50),
	@SL_Cot_Frozen int,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))

	if (isnull(@Ma_Chuc_Nang, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Mã chức năng.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Frozen_Column with (nolock) where Ma_Chuc_Nang = @Ma_Chuc_Nang)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Mã chức năng đã tồn tại.', 11, 1)
		return
	end

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Frozen_Column
	(
		Auto_ID,
		Ma_Chuc_Nang,
		SL_Cot_Frozen,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ma_Chuc_Nang,
		@SL_Cot_Frozen,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1032_sp_sel_List_Dong_Bang_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1032_sp_sel_List_Dong_Bang_Column]
	@Date_From datetime,
	@Date_To datetime
	with recompile
AS
BEGIN
	set @Date_From = dbo.fnConvert_To_Dau_Ngay(@Date_From)
	set @Date_To = dbo.fnConvert_To_Cuoi_Ngay(@Date_To)

	SELECT Auto_ID, Ma_Chuc_Nang, SL_Cot_Frozen
	FROM 
		view_Sys_Frozen_Column with (nolock) 
	WHERE 
		Created between @Date_From and @Date_To
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F1032_sp_upd_Dong_Bang_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1032_sp_upd_Dong_Bang_Column]
	@Auto_ID bigint,
	@Ma_Chuc_Nang nvarchar(50),
	@SL_Cot_Frozen int,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))

	if (isnull(@Ma_Chuc_Nang, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Mã chức năng.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_Sys_Frozen_Column with (nolock) where Ma_Chuc_Nang = @Ma_Chuc_Nang and Auto_ID <> @Auto_ID)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N'Mã chức năng đã tồn tại.', 11, 1)
		return
	end

	UPDATE tbl_Sys_Frozen_Column SET
		Ma_Chuc_Nang = @Ma_Chuc_Nang,
		SL_Cot_Frozen = @SL_Cot_Frozen,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F1033_sp_sel_List_Record_Action_History_All]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[F1033_sp_sel_List_Record_Action_History_All]
	@Date_From datetime,
	@Date_To datetime
	with recompile
AS
BEGIN
	set @Date_From = dbo.fnConvert_To_Dau_Ngay(@Date_From)
	set @Date_To = dbo.fnConvert_To_Cuoi_Ngay(@Date_To)

	SELECT Auto_ID, Ref_ID, Ten_Hanh_Dong, Ten_Moi_Truong, Ma_Chuc_Nang, Ten_Chuc_Nang, Noi_Dung_Action
	FROM 
		view_Log_Record_Action_History with (nolock) 
	WHERE 
		Created between @Date_From and @Date_To
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F2001_sp_ins_Don_Vi_Tinh]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[F2001_sp_ins_Don_Vi_Tinh]
	@Ten_Don_Vi_Tinh nvarchar(200),
	@Last_Updated_By nvarchar(200)
AS
BEGIN
	SET NOCOUNT ON;

	declare @Check_ID int
	set @Check_ID = (select Auto_ID from view_DM_Don_Vi_Tinh where Ten_Don_Vi_Tinh = @Ten_Don_Vi_Tinh)

	if(isnull(@Check_ID, 0) > 0)
	begin
		RAISERROR(N'Tên đơn vị tính đã tồn tại.', 11, 1)
		return
	end 

	declare @Auto_ID int
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_DM_Don_Vi_Tinh
	(
		Auto_ID,
		Ten_Don_Vi_Tinh,
		deleted,
		Created,
		Created_By,
		Last_Updated,
		Last_Updated_By
	)
	VALUES
	(
		@Auto_ID,
		@Ten_Don_Vi_Tinh,
		0,
		getdate(),
		@Last_Updated_By,
		getdate(),
		@Last_Updated_By
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F2001_sp_sel_List_DM_Don_Vi_Tinh]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[F2001_sp_sel_List_DM_Don_Vi_Tinh]
AS
BEGIN
	SELECT Auto_ID, Ten_Don_Vi_Tinh
	FROM view_DM_Don_Vi_Tinh
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[F2001_sp_upd_Don_Vi_Tinh]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[F2001_sp_upd_Don_Vi_Tinh]
	@Auto_ID int,
	@Ten_Don_Vi_Tinh nvarchar(200),
	@Last_Updated_By nvarchar(200)
AS
BEGIN
	SET NOCOUNT ON;

	declare @Check_ID int
	set @Check_ID = (select Auto_ID from view_DM_Don_Vi_Tinh where Ten_Don_Vi_Tinh = @Ten_Don_Vi_Tinh and Auto_ID <> @Auto_ID)

	if(isnull(@Check_ID, 0) > 0)
	begin
		RAISERROR(N'Tên đơn vị tính đã tồn tại.', 11, 1)
		return
	end 

	UPDATE tbl_DM_Don_Vi_Tinh SET
		Ten_Don_Vi_Tinh = @Ten_Don_Vi_Tinh,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F3002_sp_sel_Get_DM_Loai_San_Pham_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[F3002_sp_sel_Get_DM_Loai_San_Pham_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_DM_Loai_San_Pham with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[F3002_sp_sel_List_DM_Loai_San_Pham]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[F3002_sp_sel_List_DM_Loai_San_Pham]
	with recompile
AS
BEGIN
	SELECT * FROM view_DM_Loai_San_Pham with (nolock)
	ORDER BY Auto_ID DESC
END



GO
/****** Object:  StoredProcedure [dbo].[F4001_sp_del_XNK_Nhap_Kho_Chi_Tiet_By_Nhap_Kho_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[F4001_sp_del_XNK_Nhap_Kho_Chi_Tiet_By_Nhap_Kho_ID]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;
	update tbl_XNK_Nhap_Kho_Chi_Tiet set
		deleted=1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By
		WHERE
		Nhap_Kho_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[F4001_sp_del_XNK_Xuat_Kho_Chi_Tiet_By_Xuat_Kho_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[F4001_sp_del_XNK_Xuat_Kho_Chi_Tiet_By_Xuat_Kho_ID]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_XNK_Xuat_Kho_Chi_Tiet SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By
	WHERE
		Xuat_Kho_ID= @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[FCombo_sp_sel_List_Sys_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCombo_sp_sel_List_Sys_Chuc_Nang]
	with recompile
AS
BEGIN
	SELECT Auto_ID, Ma_Chuc_Nang, Ten_Chuc_Nang, Sort_Priority, Chuc_Nang_Parent_ID, Nhom_Chuc_Nang_ID,
		Func_URL, Image_URL, Is_View, Is_New, Is_Edit, Is_Delete, Is_Export
	FROM 
		view_Sys_Chuc_Nang with (nolock)
END
GO
/****** Object:  StoredProcedure [dbo].[FCombo_sp_sel_List_Sys_Column_Width]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCombo_sp_sel_List_Sys_Column_Width]
	with recompile
AS
BEGIN
	SELECT Auto_ID, Field_Name, Do_Rong, Format_Number
	FROM 
		view_Sys_Column_Width with (nolock)
	order by Field_Name ASC
END
GO
/****** Object:  StoredProcedure [dbo].[FCombo_sp_sel_List_Sys_Drill_Down]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCombo_sp_sel_List_Sys_Drill_Down]
	with recompile
AS
BEGIN
	SELECT Auto_ID, Field_Name, Link_URL, Parameter_Field, Func_ID
	FROM 
		view_Sys_Drill_Down with (nolock)
END
GO
/****** Object:  StoredProcedure [dbo].[FCombo_sp_sel_List_Sys_Filter_Date_Default]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCombo_sp_sel_List_Sys_Filter_Date_Default]
	with recompile
AS
BEGIN
	SELECT Auto_ID, Ma_Chuc_Nang, Duration_Days_From, Duration_Days_To
	FROM 
		view_Sys_Filter_Date_Default with (nolock)
END
GO
/****** Object:  StoredProcedure [dbo].[FCombo_sp_sel_List_Sys_Frozen_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCombo_sp_sel_List_Sys_Frozen_Column]
	with recompile
AS
BEGIN
	SELECT Auto_ID, Ma_Chuc_Nang, SL_Cot_Frozen
	FROM 
		view_Sys_Frozen_Column with (nolock)
END
GO
/****** Object:  StoredProcedure [dbo].[FCombo_sp_sel_List_Sys_Hien_An_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCombo_sp_sel_List_Sys_Hien_An_Column]
	with recompile
AS
BEGIN
	SELECT Auto_ID, Chu_Hang_ID, Field_Name, Option_ID, Ma_Chuc_Nang
	FROM 
		view_Sys_Hien_An_Column with (nolock)
END
GO
/****** Object:  StoredProcedure [dbo].[FCombo_sp_sel_List_Sys_Language]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCombo_sp_sel_List_Sys_Language]
	with recompile
AS
BEGIN
	SELECT Auto_ID, Field_Name, Lang_1, Lang_2, Lang_3, Lang_4, Lang_5, Type_ID 
	FROM 
		view_Sys_Language with (nolock)
END
GO
/****** Object:  StoredProcedure [dbo].[FCombo_sp_sel_List_Sys_Mau_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCombo_sp_sel_List_Sys_Mau_Column]
	with recompile
AS
BEGIN
	SELECT Auto_ID, Field_Name, Ma_So_Mau 
	FROM 
		view_Sys_Mau_Column with (nolock)
END
GO
/****** Object:  StoredProcedure [dbo].[FCombo_sp_sel_List_Sys_Nhom_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCombo_sp_sel_List_Sys_Nhom_Thanh_Vien]
	with recompile
AS
BEGIN
	SELECT Auto_ID, Ten_Nhom_Thanh_Vien
	FROM 
		view_Sys_Nhom_Thanh_Vien with (nolock)
END
GO
/****** Object:  StoredProcedure [dbo].[FCombo_sp_sel_List_Sys_Nhom_Thanh_Vien_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCombo_sp_sel_List_Sys_Nhom_Thanh_Vien_User]
	with recompile
AS
BEGIN
	SELECT Auto_ID, Nhom_Thanh_Vien_ID, Ma_Dang_Nhap
	FROM 
		view_Sys_Nhom_Thanh_Vien_User with (nolock)
END
GO
/****** Object:  StoredProcedure [dbo].[FCombo_sp_sel_List_Sys_Phan_Quyen_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCombo_sp_sel_List_Sys_Phan_Quyen_Chuc_Nang]
	with recompile
AS
BEGIN
	SELECT Auto_ID, Chuc_Nang_ID, Nhom_Thanh_Vien_ID, Is_Have_Add_Permission, Is_Have_Delete_Permission, Is_Have_Edit_Permission, 
		Is_Have_View_Permission, Is_Have_Export_Permission
	FROM 
		view_Sys_Phan_Quyen_Chuc_Nang with (nolock)
END
GO
/****** Object:  StoredProcedure [dbo].[FCombo_sp_sel_List_Sys_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCombo_sp_sel_List_Sys_Thanh_Vien]
	with recompile
AS
BEGIN
	SELECT Auto_ID, Ma_Dang_Nhap, Ho_Ten, Ten_Nhom_Thanh_Vien_Text, Email, Dien_Thoai, Hinh_Dai_Dien_URL, Trang_Thai_ID,
		Created
	FROM 
		view_Sys_Thanh_Vien with (nolock)
END
GO
/****** Object:  StoredProcedure [dbo].[FCombo_sp_sel_List_Sys_Token]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCombo_sp_sel_List_Sys_Token]
	with recompile
AS
BEGIN
	SELECT Auto_ID, Token_ID, Ma_Dang_Nhap
	FROM
		view_Sys_Token
END
GO
/****** Object:  StoredProcedure [dbo].[FCommon_sp_ins_Log_Import_Excel]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCommon_sp_ins_Log_Import_Excel]
	@Ma_Chuc_Nang nvarchar(50),
	@Ten_Chuc_Nang nvarchar(200),
	@Link_URL nvarchar(200),
	@Trang_Thai_ID int,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ten_Chuc_Nang = LTRIM(RTRIM(@Ten_Chuc_Nang))
	set @Link_URL = LTRIM(RTRIM(@Link_URL))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Log_Import_Excel
	(
		Auto_ID,
		Ma_Chuc_Nang,
		Ten_Chuc_Nang,
		Link_URL,
		Trang_Thai_ID,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ma_Chuc_Nang,
		@Ten_Chuc_Nang,
		@Link_URL,
		@Trang_Thai_ID,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[FCommon_sp_ins_Log_Nhat_Ky_Dang_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCommon_sp_ins_Log_Nhat_Ky_Dang_Nhap]
	@Ma_Dang_Nhap nvarchar(50),
	@IP nvarchar(50),
	@User_Agent nvarchar(500),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))
	set @IP = LTRIM(RTRIM(@IP))
	set @User_Agent = LTRIM(RTRIM(@User_Agent))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Log_Nhat_Ky_Dang_Nhap
	(
		Auto_ID,
		Ma_Dang_Nhap,
		IP,
		User_Agent,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ma_Dang_Nhap,
		@IP,
		@User_Agent,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[FCommon_sp_ins_Log_Nhat_Ky_Truy_Cap_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCommon_sp_ins_Log_Nhat_Ky_Truy_Cap_Chuc_Nang]
	@Ma_Dang_Nhap nvarchar(50),
	@Ma_Chuc_Nang nvarchar(50),
	@Ten_Chuc_Nang nvarchar(200),
	@Created_By nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))
	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ten_Chuc_Nang = LTRIM(RTRIM(@Ten_Chuc_Nang))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Log_Nhat_Ky_Truy_Cap_Chuc_Nang
	(
		Auto_ID,
		Ma_Dang_Nhap,
		Ma_Chuc_Nang,
		Ten_Chuc_Nang,
		deleted,
		Created,
		Created_By
	)
	VALUES
	(
		@Auto_ID,
		@Ma_Dang_Nhap,
		@Ma_Chuc_Nang,
		@Ten_Chuc_Nang,
		0,
		getdate(),
		@Created_By
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[FCommon_sp_ins_Log_Record_Action_History]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCommon_sp_ins_Log_Record_Action_History]
	@Ref_ID bigint,
	@Ten_Hanh_Dong nvarchar(30),
	@Ten_Moi_Truong nvarchar(30),
	@Ma_Chuc_Nang nvarchar(20),
	@Ten_Chuc_Nang nvarchar(200),
	@Noi_Dung_Action nvarchar(500),
	@Created_By nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ten_Hanh_Dong = LTRIM(RTRIM(@Ten_Hanh_Dong))
	set @Ten_Moi_Truong = LTRIM(RTRIM(@Ten_Moi_Truong))
	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ten_Chuc_Nang = LTRIM(RTRIM(@Ten_Chuc_Nang))
	set @Noi_Dung_Action = LTRIM(RTRIM(@Noi_Dung_Action))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Log_Record_Action_History
	(
		Auto_ID,
		Ref_ID,
		Ten_Hanh_Dong,
		Ten_Moi_Truong,
		Ma_Chuc_Nang,
		Ten_Chuc_Nang,
		Noi_Dung_Action,
		deleted,
		Created,
		Created_By
	)
	VALUES
	(
		@Auto_ID,
		@Ref_ID,
		@Ten_Hanh_Dong,
		@Ten_Moi_Truong,
		@Ma_Chuc_Nang,
		@Ten_Chuc_Nang,
		@Noi_Dung_Action,
		0,
		getdate(),
		@Created_By
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[FCommon_sp_ins_Sys_Token]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCommon_sp_ins_Sys_Token]
	@Token_ID nvarchar(50),
	@Ma_Dang_Nhap nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Token_ID = LTRIM(RTRIM(@Token_ID))
	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Token
	(
		Auto_ID,
		Token_ID,
		Ma_Dang_Nhap,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Token_ID,
		@Ma_Dang_Nhap,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[FCommon_sp_sel_Get_Sys_Help_Guide_By_Data]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCommon_sp_sel_Get_Sys_Help_Guide_By_Data]
	@Ma_Chuc_Nang nvarchar(50),
	@Khach_Hang_ID int,
	@Ngon_Ngu nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Auto_ID, Ma_Chuc_Nang, Noi_Dung
	from
		view_Sys_Help_Guide
	WHERE
		Ma_Chuc_Nang = @Ma_Chuc_Nang
		and Khach_Hang_ID = @Khach_Hang_ID
		and Ngon_Ngu = @Ngon_Ngu
END
GO
/****** Object:  StoredProcedure [dbo].[FCommon_sp_sel_List_Log_Record_Action_History]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCommon_sp_sel_List_Log_Record_Action_History]
	@Ref_ID int
	with recompile
AS
BEGIN
	SELECT Auto_ID, Ref_ID, Ma_Chuc_Nang, Ten_Hanh_Dong, Ten_Moi_Truong, Ten_Chuc_Nang, Noi_Dung_Action, Created, Created_By
	FROM 
		view_Log_Record_Action_History
	where
		Ref_ID = @Ref_ID
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[FCommon_sp_upd_Sys_Token]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FCommon_sp_upd_Sys_Token]
	@Auto_ID bigint,
	@Token_ID nvarchar(50),
	@Ma_Dang_Nhap nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Token_ID = LTRIM(RTRIM(@Token_ID))
	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))

	UPDATE tbl_Sys_Token SET
		Token_ID = @Token_ID,
		Ma_Dang_Nhap = @Ma_Dang_Nhap,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[FTotal_sp_upd_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FTotal_sp_upd_Thanh_Vien]
	@Ma_Dang_Nhap nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	declare @Ten_Nhom_Thanh_Vien_Text nvarchar(400) = dbo.fnList_Nhom_Thanh_Vien_By_Ma_Dang_Nhap(@Ma_Dang_Nhap)

	update tbl_Sys_Thanh_Vien set
		Ten_Nhom_Thanh_Vien_Text = @Ten_Nhom_Thanh_Vien_Text
	where
		Ma_Dang_Nhap = @Ma_Dang_Nhap
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_DM_Customer_Zone]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_del_DM_Customer_Zone]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_DM_Customer_Zone SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_del_DM_Don_Vi_Tinh]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_DM_Don_Vi_Tinh]
	@Auto_ID int,
	@Last_Updated_By nvarchar(200)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_DM_Don_Vi_Tinh SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_DM_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_DM_Kho]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_DM_Kho SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_del_DM_Khu_Vuc_Nhiet_Do]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_del_DM_Khu_Vuc_Nhiet_Do]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_DM_Khu_Vuc_Nhiet_Do SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_del_DM_Loai_San_Pham]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_del_DM_Loai_San_Pham]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_DM_Loai_San_Pham SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_del_DM_Nha_Cung_Cap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_del_DM_Nha_Cung_Cap]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_DM_Nha_Cung_Cap SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_del_DM_Phan_Quyen_Kho_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_DM_Phan_Quyen_Kho_User]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_DM_Phan_Quyen_Kho_User SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_del_DM_San_Pham]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_del_DM_San_Pham]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_DM_San_Pham SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_del_DM_Vi_Tri]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_del_DM_Vi_Tri]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_DM_Vi_Tri SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_del_Log_Import_Excel]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_Log_Import_Excel]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Log_Import_Excel SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_Log_Nhat_Ky_Dang_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_Log_Nhat_Ky_Dang_Nhap]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Log_Nhat_Ky_Dang_Nhap SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_Quan_Ly_Phieu_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_del_Quan_Ly_Phieu_Nhap]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Quan_Ly_Phieu_Nhap SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By
		
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_del_Sys_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_Sys_Chuc_Nang]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Chuc_Nang SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_Sys_Column_Width]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_Sys_Column_Width]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Column_Width SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_Sys_Drill_Down]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_Sys_Drill_Down]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Drill_Down SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_Sys_Filter_Date_Default]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_Sys_Filter_Date_Default]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Filter_Date_Default SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_Sys_Frozen_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_Sys_Frozen_Column]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Frozen_Column SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_Sys_Help_Guide]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_Sys_Help_Guide]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Help_Guide SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_Sys_Hien_An_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_Sys_Hien_An_Column]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Hien_An_Column SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_Sys_Language]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_Sys_Language]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Language SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_Sys_Mau_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_Sys_Mau_Column]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Mau_Column SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_Sys_Nhom_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_Sys_Nhom_Thanh_Vien]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Nhom_Thanh_Vien SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_Sys_Nhom_Thanh_Vien_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_Sys_Nhom_Thanh_Vien_User]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Nhom_Thanh_Vien_User SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_Sys_Phan_Quyen_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_Sys_Phan_Quyen_Chuc_Nang]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Phan_Quyen_Chuc_Nang SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_Sys_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_Sys_Thanh_Vien]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Thanh_Vien SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_Sys_Token]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_del_Sys_Token]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Token SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_XNK_Nhap_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_del_XNK_Nhap_Kho]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_XNK_Nhap_Kho SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_del_XNK_Nhap_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_del_XNK_Nhap_Kho_Chi_Tiet]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;
	update tbl_XNK_Nhap_Kho_Chi_Tiet set
		deleted=1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By
		WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_del_XNK_Quan_Ly_Phieu_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_del_XNK_Quan_Ly_Phieu_Nhap]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_XNK_Quan_Ly_Phieu_Nhap SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_del_XNK_Ton_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_del_XNK_Ton_Kho]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_XNK_Ton_Kho SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_del_XNK_Ton_Kho_A]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_del_XNK_Ton_Kho_A]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_XNK_Ton_Kho_A SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_del_XNK_Ton_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_del_XNK_Ton_Kho_Chi_Tiet]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_XNK_Ton_Kho_Chi_Tiet SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_del_XNK_Ton_Kho_CT]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_del_XNK_Ton_Kho_CT]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_XNK_Ton_Kho_CT SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_del_XNK_Xuat_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_del_XNK_Xuat_Kho]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_XNK_Xuat_Kho SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_del_XNK_Xuat_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_del_XNK_Xuat_Kho_Chi_Tiet]
	@Auto_ID bigint,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_XNK_Xuat_Kho_Chi_Tiet SET
		deleted = 1,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_ins_DM_Customer_Zone]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ins_DM_Customer_Zone]
	@Customer_Zone_Code nvarchar(50),
	@Customer_Zone_Name nvarchar(50),
	@Customer_Zone_Status int,
	@Notes nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Customer_Zone_Code = LTRIM(RTRIM(@Customer_Zone_Code))
	set @Customer_Zone_Name = LTRIM(RTRIM(@Customer_Zone_Name))
	set @Notes = LTRIM(RTRIM(@Notes))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_DM_Customer_Zone
	(
		Auto_ID,
		Customer_Zone_Code,
		Customer_Zone_Name,
		Customer_Zone_Status,
		Notes,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Customer_Zone_Code,
		@Customer_Zone_Name,
		@Customer_Zone_Status,
		@Notes,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_ins_DM_Don_Vi_Tinh]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_DM_Don_Vi_Tinh]
	@Ten_Don_Vi_Tinh nvarchar(200),
	@Last_Updated_By nvarchar(200)
AS
BEGIN
	SET NOCOUNT ON;

	set @Ten_Don_Vi_Tinh = LTRIM(RTRIM(@Ten_Don_Vi_Tinh))
	if (isnull(@Ten_Don_Vi_Tinh, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập tên.', 11, 1)
		return
	end

	declare @Check_ID_1 bigint = (select top 1 Auto_ID from view_DM_Don_Vi_Tinh with (nolock) where Ten_Don_Vi_Tinh = @Ten_Don_Vi_Tinh)
	if(isnull(@Check_ID_1, 0) > 0)
	begin
		RAISERROR(N' Tên đã tồn tại.', 11, 1)
		return
	end

	declare @Auto_ID int
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_DM_Don_Vi_Tinh
	(
		Auto_ID,
		Ten_Don_Vi_Tinh,
		deleted,
		Created,
		Created_By,
		Last_Updated,
		Last_Updated_By
	)
	VALUES
	(
		@Auto_ID,
		@Ten_Don_Vi_Tinh,
		0,
		getdate(),
		@Last_Updated_By,
		getdate(),
		@Last_Updated_By
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_DM_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_DM_Kho]
	@Ten_Kho nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	
	set @Ten_Kho = LTRIM(RTRIM(@Ten_Kho))
	if (isnull(@Ten_Kho, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập tên.', 11, 1)
		return
	end

	declare @Check_ten bigint = (select top 1 Auto_ID from view_DM_Kho with (nolock) where Ten_Kho = @Ten_Kho)
	if(isnull(@Check_ten, 0) > 0)
	begin
		RAISERROR(N' Tên đã tồn tại.', 11, 1)
		return
	end

	set @Ten_Kho = LTRIM(RTRIM(@Ten_Kho))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_DM_Kho
	(
		Auto_ID,
		Ten_Kho,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ten_Kho,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_DM_Khu_Vuc_Nhiet_Do]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ins_DM_Khu_Vuc_Nhiet_Do]
	@Ma_KVND nvarchar(200),
	@Ten_KVND nvarchar(200),
	@Tu_Nhiet_Do nvarchar(200),
	@Den_Nhiet_Do nvarchar(200),
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(200)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_KVND = LTRIM(RTRIM(@Ma_KVND))
	set @Ten_KVND = LTRIM(RTRIM(@Ten_KVND))
	set @Tu_Nhiet_Do = LTRIM(RTRIM(@Tu_Nhiet_Do))
	set @Den_Nhiet_Do = LTRIM(RTRIM(@Den_Nhiet_Do))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_DM_Khu_Vuc_Nhiet_Do
	(
		Auto_ID,
		Ma_KVND,
		Ten_KVND,
		Tu_Nhiet_Do,
		Den_Nhiet_Do,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ma_KVND,
		@Ten_KVND,
		@Tu_Nhiet_Do,
		@Den_Nhiet_Do,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_ins_DM_Loai_San_Pham]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ins_DM_Loai_San_Pham]
	@Ten_Loai_San_Pham nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ten_Loai_San_Pham = LTRIM(RTRIM(@Ten_Loai_San_Pham))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_DM_Loai_San_Pham
	(
		Auto_ID,
		Ten_Loai_San_Pham,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ten_Loai_San_Pham,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_ins_DM_Nha_Cung_Cap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_DM_Nha_Cung_Cap]
	@Ten_Nha_Cung_Cap nvarchar(200),
	@Dia_Chi nvarchar(200),
	@Dien_Thoai nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ten_Nha_Cung_Cap = LTRIM(RTRIM(@Ten_Nha_Cung_Cap))
	if (isnull(@Ten_Nha_Cung_Cap, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Tên Nhà Cung Cấp.', 11, 1)
		return
	end

	declare @Check_Ten bigint = (select top 1 Auto_ID from view_DM_Nha_Cung_Cap with (nolock) where Ten_Nha_Cung_Cap = @Ten_Nha_Cung_Cap)
	if(isnull(@Check_Ten, 0) > 0)
	begin
		RAISERROR(N'Tên Nhà Cung Cấp đã tồn tại.', 11, 1)
		return
	end

	set @Ten_Nha_Cung_Cap = LTRIM(RTRIM(@Ten_Nha_Cung_Cap))
	set @Dia_Chi = LTRIM(RTRIM(@Dia_Chi))
	set @Dien_Thoai = LTRIM(RTRIM(@Dien_Thoai))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_DM_Nha_Cung_Cap
	(
		Auto_ID,
		Ten_Nha_Cung_Cap,
		Dia_Chi,
		Dien_Thoai,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ten_Nha_Cung_Cap,
		@Dia_Chi,
		@Dien_Thoai,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_DM_Phan_Quyen_Kho_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_DM_Phan_Quyen_Kho_User]
	@Kho_ID int,
	@Ma_Dang_Nhap nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;
	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	set @Kho_ID = LTRIM(RTRIM(@Kho_ID))
	if (isnull(@Kho_ID, '') = '')
	begin
		RAISERROR(N'Vui lòng chọn tên Kho.', 11, 1)
		return
	end

	INSERT INTO tbl_DM_Phan_Quyen_Kho_User
	(
		Auto_ID,
		Kho_ID,
		Ma_Dang_Nhap,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Kho_ID,
		@Ma_Dang_Nhap,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
select * from tbl_DM_Phan_Quyen_Kho_User
select * from tbl_Sys_Thanh_Vien
select * from tbl_DM_Kho
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_DM_San_Pham]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ins_DM_San_Pham]
	@Ma_San_Pham nvarchar(200),
	@Loai_San_Pham nvarchar(200),
	@Ten_San_Pham nvarchar(200),
	@Don_Vi_Tinh nvarchar(200),
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_San_Pham = LTRIM(RTRIM(@Ma_San_Pham))
	if (isnull(@Ma_San_Pham, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Tên Mã Sản Phảm.', 11, 1)
		return
	end

	set @Loai_San_Pham = LTRIM(RTRIM(@Loai_San_Pham))
	if (isnull(@Loai_San_Pham, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Tên Loại Sản Phảm.', 11, 1)
		return
	end

	set @Ten_San_Pham = LTRIM(RTRIM(@Ten_San_Pham))
	if (isnull(@Ten_San_Pham, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Tên Sản Phảm.', 11, 1)
		return
	end

	set @Don_Vi_Tinh = LTRIM(RTRIM(@Don_Vi_Tinh))
	if (isnull(@Don_Vi_Tinh, '') = '')
	begin
		RAISERROR(N'Vui lòng nhập Tên Đơn Vị Tính.', 11, 1)
		return
	end

	declare @Check_Ten bigint = (select top 1 Auto_ID from view_DM_San_Pham with (nolock) where Ma_San_Pham = @Ma_San_Pham)
	if(isnull(@Check_Ten, 0) > 0)
	begin
		RAISERROR(N'Tên Mã Sản Phảm đã tồn tại.', 11, 1)
		return
	end

	set @Ma_San_Pham = LTRIM(RTRIM(@Ma_San_Pham))
	set @Loai_San_Pham = LTRIM(RTRIM(@Loai_San_Pham))
	set @Ten_San_Pham = LTRIM(RTRIM(@Ten_San_Pham))
	set @Don_Vi_Tinh = LTRIM(RTRIM(@Don_Vi_Tinh))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_DM_San_Pham
	(
		Auto_ID,
		Ma_San_Pham,
		Loai_San_Pham,
		Ten_San_Pham,
		Don_Vi_Tinh,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ma_San_Pham,
		@Loai_San_Pham,
		@Ten_San_Pham,
		@Don_Vi_Tinh,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_ins_DM_Vi_Tri]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ins_DM_Vi_Tri]
	@Ten_Vi_Tri nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ten_Vi_Tri = LTRIM(RTRIM(@Ten_Vi_Tri))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_DM_Vi_Tri
	(
		Auto_ID,
		Ten_Vi_Tri,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ten_Vi_Tri,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Log_Import_Excel]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Log_Import_Excel]
	@Ma_Chuc_Nang nvarchar(50),
	@Ten_Chuc_Nang nvarchar(200),
	@Link_URL nvarchar(200),
	@Trang_Thai_ID int,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ten_Chuc_Nang = LTRIM(RTRIM(@Ten_Chuc_Nang))
	set @Link_URL = LTRIM(RTRIM(@Link_URL))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Log_Import_Excel
	(
		Auto_ID,
		Ma_Chuc_Nang,
		Ten_Chuc_Nang,
		Link_URL,
		Trang_Thai_ID,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ma_Chuc_Nang,
		@Ten_Chuc_Nang,
		@Link_URL,
		@Trang_Thai_ID,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Log_Nhat_Ky_Dang_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Log_Nhat_Ky_Dang_Nhap]
	@Ma_Dang_Nhap nvarchar(50),
	@IP nvarchar(50),
	@User_Agent nvarchar(500),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))
	set @IP = LTRIM(RTRIM(@IP))
	set @User_Agent = LTRIM(RTRIM(@User_Agent))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Log_Nhat_Ky_Dang_Nhap
	(
		Auto_ID,
		Ma_Dang_Nhap,
		IP,
		User_Agent,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ma_Dang_Nhap,
		@IP,
		@User_Agent,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Log_Nhat_Ky_Truy_Cap_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Log_Nhat_Ky_Truy_Cap_Chuc_Nang]
	@Ma_Dang_Nhap nvarchar(50),
	@Ma_Chuc_Nang nvarchar(50),
	@Ten_Chuc_Nang nvarchar(200),
	@Created_By nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))
	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ten_Chuc_Nang = LTRIM(RTRIM(@Ten_Chuc_Nang))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Log_Nhat_Ky_Truy_Cap_Chuc_Nang
	(
		Auto_ID,
		Ma_Dang_Nhap,
		Ma_Chuc_Nang,
		Ten_Chuc_Nang,
		deleted,
		Created,
		Created_By
	)
	VALUES
	(
		@Auto_ID,
		@Ma_Dang_Nhap,
		@Ma_Chuc_Nang,
		@Ten_Chuc_Nang,
		0,
		getdate(),
		@Created_By
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Quan_Ly_Phieu_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ins_Quan_Ly_Phieu_Nhap]
	@So_Phieu_Nhap nvarchar(200),
	@Ngay_Nhap_Kho datetime,
	@Nha_Cung_Cap nvarchar(200),
	@Kho nvarchar(200),
	@Tong_So_Luong float,
	@Tong_Tri_Gia float,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(200)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @So_Phieu_Nhap = LTRIM(RTRIM(@So_Phieu_Nhap))
	set @Nha_Cung_Cap = LTRIM(RTRIM(@Nha_Cung_Cap))
	set @Kho = LTRIM(RTRIM(@Kho))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	set @Ngay_Nhap_Kho = dbo.fnConvert_Ngay_To_NULL(@Ngay_Nhap_Kho)
	set @Ngay_Nhap_Kho = dbo.fnConvert_To_Dau_Ngay(@Ngay_Nhap_Kho)

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Quan_Ly_Phieu_Nhap
	(
		Auto_ID,
		So_Phieu_Nhap,
		Ngay_Nhap_Kho,
		Nha_Cung_Cap,
		Kho,
		Tong_So_Luong,
		Tong_Tri_Gia,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		
		Last_Updated,
		Last_Updated_By
	
	)
	VALUES
	(
		@Auto_ID,
		@So_Phieu_Nhap,
		@Ngay_Nhap_Kho,
		@Nha_Cung_Cap,
		@Kho,
		@Tong_So_Luong,
		@Tong_Tri_Gia,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
	
		getdate(),
		@Last_Updated_By
		
	)

	SELECT @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Sys_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Sys_Chuc_Nang]
	@Ma_Chuc_Nang nvarchar(50),
	@Ten_Chuc_Nang nvarchar(200),
	@Sort_Priority int,
	@Chuc_Nang_Parent_ID bigint,
	@Nhom_Chuc_Nang_ID int,
	@Func_URL nvarchar(200),
	@Image_URL nvarchar(50),
	@Is_View bit,
	@Is_New bit,
	@Is_Edit bit,
	@Is_Delete bit,
	@Is_Export bit,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ten_Chuc_Nang = LTRIM(RTRIM(@Ten_Chuc_Nang))
	set @Func_URL = LTRIM(RTRIM(@Func_URL))
	set @Image_URL = LTRIM(RTRIM(@Image_URL))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Chuc_Nang
	(
		Auto_ID,
		Ma_Chuc_Nang,
		Ten_Chuc_Nang,
		Sort_Priority,
		Chuc_Nang_Parent_ID,
		Nhom_Chuc_Nang_ID,
		Func_URL,
		Image_URL,
		Is_View,
		Is_New,
		Is_Edit,
		Is_Delete,
		Is_Export,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ma_Chuc_Nang,
		@Ten_Chuc_Nang,
		@Sort_Priority,
		@Chuc_Nang_Parent_ID,
		@Nhom_Chuc_Nang_ID,
		@Func_URL,
		@Image_URL,
		@Is_View,
		@Is_New,
		@Is_Edit,
		@Is_Delete,
		@Is_Export,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Sys_Column_Width]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Sys_Column_Width]
	@Field_Name nvarchar(50),
	@Do_Rong int,
	@Format_Number nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Format_Number = LTRIM(RTRIM(@Format_Number))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Column_Width
	(
		Auto_ID,
		Field_Name,
		Do_Rong,
		Format_Number,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Field_Name,
		@Do_Rong,
		@Format_Number,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Sys_Drill_Down]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Sys_Drill_Down]
	@Field_Name nvarchar(50),
	@Link_URL nvarchar(200),
	@Parameter_Field nvarchar(50),
	@Func_ID nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Link_URL = LTRIM(RTRIM(@Link_URL))
	set @Parameter_Field = LTRIM(RTRIM(@Parameter_Field))
	set @Func_ID = LTRIM(RTRIM(@Func_ID))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Drill_Down
	(
		Auto_ID,
		Field_Name,
		Link_URL,
		Parameter_Field,
		Func_ID,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Field_Name,
		@Link_URL,
		@Parameter_Field,
		@Func_ID,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Sys_Filter_Date_Default]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Sys_Filter_Date_Default]
	@Ma_Chuc_Nang nvarchar(50),
	@Duration_Days_From float,
	@Duration_Days_To float,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Filter_Date_Default
	(
		Auto_ID,
		Ma_Chuc_Nang,
		Duration_Days_From,
		Duration_Days_To,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ma_Chuc_Nang,
		@Duration_Days_From,
		@Duration_Days_To,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Sys_Frozen_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Sys_Frozen_Column]
	@Ma_Chuc_Nang nvarchar(50),
	@SL_Cot_Frozen int,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Frozen_Column
	(
		Auto_ID,
		Ma_Chuc_Nang,
		SL_Cot_Frozen,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ma_Chuc_Nang,
		@SL_Cot_Frozen,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Sys_Help_Guide]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Sys_Help_Guide]
	@Khach_Hang_ID bigint,
	@Ma_Chuc_Nang nvarchar(50),
	@Ngon_Ngu nvarchar(50),
	@Noi_Dung ntext,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ngon_Ngu = LTRIM(RTRIM(@Ngon_Ngu))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Help_Guide
	(
		Auto_ID,
		Khach_Hang_ID,
		Ma_Chuc_Nang,
		Ngon_Ngu,
		Noi_Dung,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Khach_Hang_ID,
		@Ma_Chuc_Nang,
		@Ngon_Ngu,
		@Noi_Dung,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Sys_Hien_An_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Sys_Hien_An_Column]
	@Chu_Hang_ID bigint,
	@Field_Name nvarchar(50),
	@Option_ID int,
	@Ma_Chuc_Nang nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Hien_An_Column
	(
		Auto_ID,
		Chu_Hang_ID,
		Field_Name,
		Option_ID,
		Ma_Chuc_Nang,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Chu_Hang_ID,
		@Field_Name,
		@Option_ID,
		@Ma_Chuc_Nang,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Sys_Language]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Sys_Language]
	@Field_Name nvarchar(50),
	@Lang_1 nvarchar(200),
	@Lang_2 nvarchar(200),
	@Lang_3 nvarchar(200),
	@Lang_4 nvarchar(200),
	@Lang_5 nvarchar(200),
	@Type_ID int,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Lang_1 = LTRIM(RTRIM(@Lang_1))
	set @Lang_2 = LTRIM(RTRIM(@Lang_2))
	set @Lang_3 = LTRIM(RTRIM(@Lang_3))
	set @Lang_4 = LTRIM(RTRIM(@Lang_4))
	set @Lang_5 = LTRIM(RTRIM(@Lang_5))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Language
	(
		Auto_ID,
		Field_Name,
		Lang_1,
		Lang_2,
		Lang_3,
		Lang_4,
		Lang_5,
		Type_ID,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Field_Name,
		@Lang_1,
		@Lang_2,
		@Lang_3,
		@Lang_4,
		@Lang_5,
		@Type_ID,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Sys_Mau_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Sys_Mau_Column]
	@Field_Name nvarchar(50),
	@Ma_So_Mau nvarchar(50),
	@Ghi_Chu nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Ma_So_Mau = LTRIM(RTRIM(@Ma_So_Mau))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Mau_Column
	(
		Auto_ID,
		Field_Name,
		Ma_So_Mau,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Field_Name,
		@Ma_So_Mau,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Sys_Nhom_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Sys_Nhom_Thanh_Vien]
	@Ten_Nhom_Thanh_Vien nvarchar(200),
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;


	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Nhom_Thanh_Vien
	(
		Auto_ID,
		Ten_Nhom_Thanh_Vien,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ten_Nhom_Thanh_Vien,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Sys_Nhom_Thanh_Vien_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Sys_Nhom_Thanh_Vien_User]
	@Nhom_Thanh_Vien_ID bigint,
	@Ma_Dang_Nhap nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Nhom_Thanh_Vien_User
	(
		Auto_ID,
		Nhom_Thanh_Vien_ID,
		Ma_Dang_Nhap,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Nhom_Thanh_Vien_ID,
		@Ma_Dang_Nhap,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Sys_Phan_Quyen_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Sys_Phan_Quyen_Chuc_Nang]
	@Nhom_Thanh_Vien_ID bigint,
	@Chuc_Nang_ID bigint,
	@Is_Have_View_Permission bit,
	@Is_Have_Add_Permission bit,
	@Is_Have_Edit_Permission bit,
	@Is_Have_Delete_Permission bit,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Phan_Quyen_Chuc_Nang
	(
		Auto_ID,
		Nhom_Thanh_Vien_ID,
		Chuc_Nang_ID,
		Is_Have_View_Permission,
		Is_Have_Add_Permission,
		Is_Have_Edit_Permission,
		Is_Have_Delete_Permission,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Nhom_Thanh_Vien_ID,
		@Chuc_Nang_ID,
		@Is_Have_View_Permission,
		@Is_Have_Add_Permission,
		@Is_Have_Edit_Permission,
		@Is_Have_Delete_Permission,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Sys_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Sys_Thanh_Vien]
	@Ma_Dang_Nhap nvarchar(50),
	@Mat_Khau nvarchar(50),
	@Ho_Ten nvarchar(100),
	@Email nvarchar(250),
	@Dien_Thoai nvarchar(200),
	@Hinh_Dai_Dien_URL nvarchar(200),
	@Trang_Thai_ID int,
	@Ten_Nhom_Thanh_Vien_Text nvarchar(400),
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))
	set @Mat_Khau = LTRIM(RTRIM(@Mat_Khau))
	set @Ho_Ten = LTRIM(RTRIM(@Ho_Ten))
	set @Email = LTRIM(RTRIM(@Email))
	set @Dien_Thoai = LTRIM(RTRIM(@Dien_Thoai))
	set @Hinh_Dai_Dien_URL = LTRIM(RTRIM(@Hinh_Dai_Dien_URL))
	set @Ten_Nhom_Thanh_Vien_Text = LTRIM(RTRIM(@Ten_Nhom_Thanh_Vien_Text))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Thanh_Vien
	(
		Auto_ID,
		Ma_Dang_Nhap,
		Mat_Khau,
		Ho_Ten,
		Email,
		Dien_Thoai,
		Hinh_Dai_Dien_URL,
		Trang_Thai_ID,
		Ten_Nhom_Thanh_Vien_Text,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Ma_Dang_Nhap,
		@Mat_Khau,
		@Ho_Ten,
		@Email,
		@Dien_Thoai,
		@Hinh_Dai_Dien_URL,
		@Trang_Thai_ID,
		@Ten_Nhom_Thanh_Vien_Text,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_Sys_Token]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_Sys_Token]
	@Token_ID nvarchar(50),
	@Ma_Dang_Nhap nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Token_ID = LTRIM(RTRIM(@Token_ID))
	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_Sys_Token
	(
		Auto_ID,
		Token_ID,
		Ma_Dang_Nhap,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Token_ID,
		@Ma_Dang_Nhap,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_XNK_Nhap_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ins_XNK_Nhap_Kho]
	@So_Phieu_Nhap nvarchar(200),
	@Ngay_Nhap_Kho datetime,
	@Nha_Cung_Cap nvarchar(200),
	@Kho nvarchar(200),
	@Trang_Thai int,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;
	if(@So_Phieu_Nhap = '')
	begin
		Raiserror(N'Số phiếu nhập không được rỗng',11,1)
		return
	end

	--set @Nha_Cung_Cap = LTRIM(RTRIM(@Nha_Cung_Cap))
	--if (isnull(@Nha_Cung_Cap, '') = '')
	--begin
	--	RAISERROR(N'Vui lòng nhập Nhà Cung Cấp.', 11, 1)
	--	return
	--end

	--set @Kho = LTRIM(RTRIM(@Kho))
	--if (isnull(@Kho, '') = '')
	--begin
	--	RAISERROR(N'Vui lòng nhập Kho.', 11, 1)
	--	return
	--end


	declare @Check_Ten bigint = (select top 1 Auto_ID from view_XNK_Nhap_Kho with (nolock) where So_Phieu_Nhap = @So_Phieu_Nhap and Auto_ID != Auto_ID)
	if(isnull(@Check_Ten, 0) > 0)
	begin
		RAISERROR(N'Số Phiếu Nhập đã tồn tại.', 11, 1)
		return
	end

	set @So_Phieu_Nhap = LTRIM(RTRIM(@So_Phieu_Nhap))
	set @Nha_Cung_Cap = LTRIM(RTRIM(@Nha_Cung_Cap))
	set @Kho = LTRIM(RTRIM(@Kho))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	set @Ngay_Nhap_Kho = dbo.fnConvert_Ngay_To_NULL(@Ngay_Nhap_Kho)
	set @Ngay_Nhap_Kho = dbo.fnConvert_To_Dau_Ngay(@Ngay_Nhap_Kho)

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_XNK_Nhap_Kho
	(
		Auto_ID,
		So_Phieu_Nhap,
		Ngay_Nhap_Kho,
		Nha_Cung_Cap,
		Kho,
		Trang_Thai,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@So_Phieu_Nhap,
		getdate(),	
		@Nha_Cung_Cap,
		@Kho,
		@Trang_Thai,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_ins_XNK_Nhap_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_ins_XNK_Nhap_Kho_Chi_Tiet]
	@Nhap_Kho_ID int,
	@Ma_San_Pham nvarchar(200),
	@Ten_San_Pham nvarchar(200),
	@So_Luong float,
	@Don_Gia float,
	@Tri_Gia float,
	@Ngay_San_Xuat datetime,
	@Ngay_Het_Hang datetime,
	@So_LPN nvarchar(200),
	@Kien int, 
	@So_Luong_Chan int, 
	@So_Luong_Le int, 
	@Tong_So_Luong int,
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	set nocount on;

	set @Ma_San_Pham =LTRIM(RTRIM(@Ma_San_Pham))
	set @Ten_San_Pham = LTRIM(RTRIM(@Ten_San_Pham))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)
	
	Insert into tbl_XNK_Nhap_Kho_Chi_Tiet
	(
		Auto_ID,
		Nhap_Kho_ID,
		Ma_San_Pham,
		Ten_San_Pham,
		So_Luong,
		Don_Gia,
		Tri_Gia,
		Ngay_San_Xuat, 
		Ngay_Het_Hang, 
		So_LPN, 
		Kien, 
		So_Luong_Chan, 
		So_Luong_Le, 
		Tong_So_Luong,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	values
	(
		@Auto_ID,
		@Nhap_Kho_ID,
		@Ma_San_Pham,
		@Ten_San_Pham,
		@So_Luong,
		@Don_Gia,
		@Tri_Gia,
		@Ngay_San_Xuat, 
		@Ngay_Het_Hang, 
		@So_LPN, 
		@Kien, 
		@So_Luong_Chan, 
		@So_Luong_Le, 
		@Tong_So_Luong,
		0,
		GETDATE(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)
		
		select @Auto_ID
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ins_XNK_Quan_Ly_Phieu_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ins_XNK_Quan_Ly_Phieu_Nhap]
	@So_Phieu_Nhap nvarchar(200),
	@Ngay_Nhap_Kho datetime,
	@Nha_Cung_Cap nvarchar(200),
	@Kho nvarchar(200),
	@Tong_So_Luong int,
	@Tong_Tri_Gia int,
	@Trang_Thai int,
	@Trang_Thai_Putaway int,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @So_Phieu_Nhap = LTRIM(RTRIM(@So_Phieu_Nhap))
	set @Nha_Cung_Cap = LTRIM(RTRIM(@Nha_Cung_Cap))
	set @Kho = LTRIM(RTRIM(@Kho))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	set @Ngay_Nhap_Kho = dbo.fnConvert_Ngay_To_NULL(@Ngay_Nhap_Kho)
	set @Ngay_Nhap_Kho = dbo.fnConvert_To_Dau_Ngay(@Ngay_Nhap_Kho)

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_XNK_Quan_Ly_Phieu_Nhap
	(
		Auto_ID,
		So_Phieu_Nhap,
		Ngay_Nhap_Kho,
		Nha_Cung_Cap,
		Kho,
		Tong_So_Luong,
		Tong_Tri_Gia,
		Trang_Thai,
		Trang_Thai_Putaway,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@So_Phieu_Nhap,
		@Ngay_Nhap_Kho,
		@Nha_Cung_Cap,
		@Kho,
		@Tong_So_Luong,
		@Tong_Tri_Gia,
		@Trang_Thai,
		@Trang_Thai_Putaway,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_ins_XNK_Ton_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_ins_XNK_Ton_Kho]
	@So_Phieu_Nhap nvarchar(200),
	@Ngay_Nhap_Kho datetime,
	@Nha_Cung_Cap nvarchar(200),
	@Kho nvarchar(200),
	@Tong_So_Luong int,
	@Vi_Tri nvarchar(200),
	@Trang_Thai int,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @So_Phieu_Nhap = LTRIM(RTRIM(@So_Phieu_Nhap))
	set @Nha_Cung_Cap = LTRIM(RTRIM(@Nha_Cung_Cap))
	set @Kho = LTRIM(RTRIM(@Kho))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	set @Ngay_Nhap_Kho = dbo.fnConvert_Ngay_To_NULL(@Ngay_Nhap_Kho)
	set @Ngay_Nhap_Kho = dbo.fnConvert_To_Dau_Ngay(@Ngay_Nhap_Kho)

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_XNK_Ton_Kho
	(
		Auto_ID,
		So_Phieu_Nhap,
		Ngay_Nhap_Kho,
		Nha_Cung_Cap,
		Kho,
		Tong_So_Luong,
		Vi_Tri,
		Trang_Thai,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@So_Phieu_Nhap,
		getdate(),
		@Nha_Cung_Cap,
		@Kho,
		@Tong_So_Luong,
		@Vi_Tri,
		@Trang_Thai,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END


GO
/****** Object:  StoredProcedure [dbo].[sp_ins_XNK_Ton_Kho_A]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ins_XNK_Ton_Kho_A]
	@So_Phieu_Nhap nvarchar(200),
	@Ngay_Nhap_Kho datetime,
	@Nha_Cung_Cap nvarchar(200),
	@Kho nvarchar(200),
	@Trang_Thai int,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @So_Phieu_Nhap = LTRIM(RTRIM(@So_Phieu_Nhap))
	set @Nha_Cung_Cap = LTRIM(RTRIM(@Nha_Cung_Cap))
	set @Kho = LTRIM(RTRIM(@Kho))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	set @Ngay_Nhap_Kho = dbo.fnConvert_Ngay_To_NULL(@Ngay_Nhap_Kho)
	set @Ngay_Nhap_Kho = dbo.fnConvert_To_Dau_Ngay(@Ngay_Nhap_Kho)

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_XNK_Ton_Kho_A
	(
		Auto_ID,
		So_Phieu_Nhap,
		Ngay_Nhap_Kho,
		Nha_Cung_Cap,
		Kho,
		Trang_Thai,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@So_Phieu_Nhap,
		@Ngay_Nhap_Kho,
		@Nha_Cung_Cap,
		@Kho,
		@Trang_Thai,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_ins_XNK_Ton_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ins_XNK_Ton_Kho_Chi_Tiet]
	@Nhap_Kho_ID int,
	@Ma_San_Pham nvarchar(200),
	@Ten_San_Pham nvarchar(200),
	@So_Phieu nvarchar(200),
	@Ngay_Nhap_Kho datetime,
	@Vi_Tri nvarchar(200),
	@So_Luong float,
	@Don_Gia float,
	@Tri_Gia float,
	@Kien int,
	@So_Luong_Chan int,
	@So_Luong_Le int,
	@Tong_So_Luong int,
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_San_Pham = LTRIM(RTRIM(@Ma_San_Pham))
	set @Ten_San_Pham = LTRIM(RTRIM(@Ten_San_Pham))
	set @So_Phieu = LTRIM(RTRIM(@So_Phieu))
	set @Vi_Tri = LTRIM(RTRIM(@Vi_Tri))

	set @Ngay_Nhap_Kho = dbo.fnConvert_Ngay_To_NULL(@Ngay_Nhap_Kho)
	set @Ngay_Nhap_Kho = dbo.fnConvert_To_Dau_Ngay(@Ngay_Nhap_Kho)

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_XNK_Ton_Kho_Chi_Tiet
	(
		Auto_ID,
		Nhap_Kho_ID,
		Ma_San_Pham,
		Ten_San_Pham,
		So_Phieu,
		Ngay_Nhap_Kho,
		Vi_Tri,
		So_Luong,
		Don_Gia,
		Tri_Gia,
		Kien,
		So_Luong_Chan,
		So_Luong_Le,
		Tong_So_Luong,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Nhap_Kho_ID,
		@Ma_San_Pham,
		@Ten_San_Pham,
		@So_Phieu,
		getdate(),
		@Vi_Tri,
		@So_Luong,
		@Don_Gia,
		@Tri_Gia,
		@Kien,
		@So_Luong_Chan,
		@So_Luong_Le,
		@Tong_So_Luong,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_ins_XNK_Ton_Kho_CT]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ins_XNK_Ton_Kho_CT]
	@Nhap_Kho_ID int,
	@So_Phieu_Nhap nvarchar(200),
	@Ma_San_Pham nvarchar(200),
	@Ten_San_Pham nvarchar(200),
	@So_Luong float,
	@Don_Gia float,
	@Tri_Gia float,
	@Ngay_San_Xuat datetime,
	@Ngay_Het_Hang datetime,
	@So_LPN nvarchar(200),
	@Kien int,
	@So_Luong_Chan int,
	@So_Luong_Le int,
	@Tong_So_Luong int,
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @So_Phieu_Nhap = LTRIM(RTRIM(@So_Phieu_Nhap))
	set @Ma_San_Pham = LTRIM(RTRIM(@Ma_San_Pham))
	set @Ten_San_Pham = LTRIM(RTRIM(@Ten_San_Pham))
	set @So_LPN = LTRIM(RTRIM(@So_LPN))

	set @Ngay_San_Xuat = dbo.fnConvert_Ngay_To_NULL(@Ngay_San_Xuat)
	set @Ngay_San_Xuat = dbo.fnConvert_To_Dau_Ngay(@Ngay_San_Xuat)
	set @Ngay_Het_Hang = dbo.fnConvert_Ngay_To_NULL(@Ngay_Het_Hang)
	set @Ngay_Het_Hang = dbo.fnConvert_To_Dau_Ngay(@Ngay_Het_Hang)

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_XNK_Ton_Kho_CT
	(
		Auto_ID,
		Nhap_Kho_ID,
		So_Phieu_Nhap,
		Ma_San_Pham,
		Ten_San_Pham,
		So_Luong,
		Don_Gia,
		Tri_Gia,
		Ngay_San_Xuat,
		Ngay_Het_Hang,
		So_LPN,
		Kien,
		So_Luong_Chan,
		So_Luong_Le,
		Tong_So_Luong,
		deleted,
		Created,
		Created_By,
		Created_By_Function,
		Last_Updated,
		Last_Updated_By,
		Last_Updated_By_Function
	)
	VALUES
	(
		@Auto_ID,
		@Nhap_Kho_ID,
		@So_Phieu_Nhap,
		@Ma_San_Pham,
		@Ten_San_Pham,
		@So_Luong,
		@Don_Gia,
		@Tri_Gia,
		@Ngay_San_Xuat,
		@Ngay_Het_Hang,
		@So_LPN,
		@Kien,
		@So_Luong_Chan,
		@So_Luong_Le,
		@Tong_So_Luong,
		0,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function,
		getdate(),
		@Last_Updated_By,
		@Last_Updated_By_Function
	)

	SELECT @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_ins_XNK_Xuat_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ins_XNK_Xuat_Kho]
	@So_Phieu_Xuat_Kho nvarchar(200),
	@Ngay_Xuat_Kho datetime,
	@Kho nvarchar(200),
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(200)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

		declare @Check_Ten bigint = (select top 1 Auto_ID from view_XNK_Xuat_Kho with (nolock) where So_Phieu_Xuat_Kho = So_Phieu_Xuat_Kho and Auto_ID != Auto_ID)
	if(isnull(@Check_Ten, 0) > 0)
	begin
		RAISERROR(N'Số Phiếu Nhập đã tồn tại.', 11, 1)
		return
	end

	set @So_Phieu_Xuat_Kho = LTRIM(RTRIM(@So_Phieu_Xuat_Kho))
	set @Kho = LTRIM(RTRIM(@Kho))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	set @Ngay_Xuat_Kho = dbo.fnConvert_Ngay_To_NULL(@Ngay_Xuat_Kho)
	set @Ngay_Xuat_Kho = dbo.fnConvert_To_Dau_Ngay(@Ngay_Xuat_Kho)

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_XNK_Xuat_Kho
	(
		Auto_ID,
		So_Phieu_Xuat_Kho,
		Ngay_Xuat_Kho,
		Kho,
		Ghi_Chu,
		deleted,
		Created,
		Created_By,
		Last_Updated,
		Last_Updated_By
	)
	VALUES
	(
		@Auto_ID,
		@So_Phieu_Xuat_Kho,
		getdate(),
		@Kho,
		@Ghi_Chu,
		0,
		getdate(),
		@Last_Updated_By,
		getdate(),
		@Last_Updated_By
	)

	SELECT @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_ins_XNK_Xuat_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ins_XNK_Xuat_Kho_Chi_Tiet]
	@Xuat_Kho_ID int,
	@Ma_San_Pham nvarchar(200),
	@Ten_San_Pham nvarchar(200),
	@So_Luong float,
	@Don_Gia float,
	@Tri_Gia float,
	@Ngay_San_Xuat datetime,
	@Ngay_Het_Hang datetime,
	@So_LPN nvarchar(200),
	@Kien int, 
	@So_Luong_Chan int, 
	@So_Luong_Le int, 
	@Tong_So_Luong int,
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_San_Pham = LTRIM(RTRIM(@Ma_San_Pham))
	set @Ten_San_Pham = LTRIM(RTRIM(@Ten_San_Pham))

	declare @Auto_ID bigint
	set @Auto_ID = (next value for dbo.Seq_ID)

	INSERT INTO tbl_XNK_Xuat_Kho_Chi_Tiet
	(
		Auto_ID,
		Xuat_Kho_ID,
		Ma_San_Pham,
		Ten_San_Pham,
		So_Luong,
		Don_Gia,
		Tri_Gia,
		deleted,
		Created,
		Created_By,
		Last_Updated,
		Last_Updated_By

	)
	VALUES
	(
		@Auto_ID,
		@Xuat_Kho_ID,
		@Ma_San_Pham,
		@Ten_San_Pham,
		@So_Luong,
		@Don_Gia,
		@Tri_Gia,
		0,
		getdate(),
		@Last_Updated_By,
		getdate(),
		@Last_Updated_By

	)

	SELECT @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_DM_Customer_Zone_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_Get_DM_Customer_Zone_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_DM_Customer_Zone with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_DM_Don_Vi_Tinh_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_Get_DM_Don_Vi_Tinh_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_DM_Don_Vi_Tinh with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_DM_Kho_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_DM_Kho_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_DM_Kho with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END


GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_DM_Khu_Vuc_Nhiet_Do_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_Get_DM_Khu_Vuc_Nhiet_Do_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_DM_Khu_Vuc_Nhiet_Do with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_DM_Loai_San_Pham_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_Get_DM_Loai_San_Pham_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_DM_Loai_San_Pham with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_DM_Nha_Cung_Cap_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_DM_Nha_Cung_Cap_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_DM_Nha_Cung_Cap with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_DM_Phan_Quyen_Kho_User_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_DM_Phan_Quyen_Kho_User_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_DM_Phan_Quyen_Kho_User with (nolock)
	WHERE
		Kho_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_DM_San_Pham_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_Get_DM_San_Pham_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_DM_San_Pham with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_DM_Vi_Tri_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_Get_DM_Vi_Tri_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_DM_Vi_Tri with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Log_Import_Excel_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Log_Import_Excel_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Log_Import_Excel
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Log_Nhat_Ky_Dang_Nhap_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Log_Nhat_Ky_Dang_Nhap_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Log_Nhat_Ky_Dang_Nhap
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Log_Recort_Action_History_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Log_Recort_Action_History_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Log_Recort_Action_History
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Quan_Ly_Phieu_Nhap_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_Get_Quan_Ly_Phieu_Nhap_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Quan_Ly_Phieu_Nhap with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Sys_Chuc_Nang_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Sys_Chuc_Nang_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Sys_Chuc_Nang
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Sys_Column_Width_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Sys_Column_Width_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Sys_Column_Width
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Sys_Drill_Down_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Sys_Drill_Down_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Sys_Drill_Down
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Sys_Filter_Date_Default_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Sys_Filter_Date_Default_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Sys_Filter_Date_Default
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Sys_Frozen_Column_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Sys_Frozen_Column_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Sys_Frozen_Column with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Sys_Help_Guide_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Sys_Help_Guide_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Sys_Help_Guide with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Sys_Hien_An_Column_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Sys_Hien_An_Column_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Sys_Hien_An_Column
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Sys_Language_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Sys_Language_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Sys_Language
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Sys_Mau_Column_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Sys_Mau_Column_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Sys_Mau_Column
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Sys_Nhom_Thanh_Vien_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Sys_Nhom_Thanh_Vien_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Sys_Nhom_Thanh_Vien
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Sys_Nhom_Thanh_Vien_User_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Sys_Nhom_Thanh_Vien_User_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Sys_Nhom_Thanh_Vien_User
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Sys_Phan_Quyen_Chuc_Nang_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Sys_Phan_Quyen_Chuc_Nang_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Sys_Phan_Quyen_Chuc_Nang
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Sys_Thanh_Vien_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Sys_Thanh_Vien_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Sys_Thanh_Vien
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Sys_Thanh_Vien_By_Ma_Dang_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Sys_Thanh_Vien_By_Ma_Dang_Nhap]
	@Ma_Dang_Nhap nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Sys_Thanh_Vien
	WHERE
		Ma_Dang_Nhap = @Ma_Dang_Nhap
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_Sys_Token_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_Get_Sys_Token_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_Sys_Token
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_XNK_Nhap_Kho_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_Get_XNK_Nhap_Kho_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_XNK_Nhap_Kho with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_XNK_Nhap_Kho_Chi_Tiet_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create PROCEDURE [dbo].[sp_sel_Get_XNK_Nhap_Kho_Chi_Tiet_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_XNK_Nhap_Kho_Chi_Tiet with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_XNK_Nhap_Kho_Chi_Tiet_By_Nhap_Kho_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_sel_Get_XNK_Nhap_Kho_Chi_Tiet_By_Nhap_Kho_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_XNK_Nhap_Kho_Chi_Tiet with (nolock)
	WHERE
		Nhap_Kho_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_XNK_Quan_Ly_Phieu_Nhap_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_Get_XNK_Quan_Ly_Phieu_Nhap_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_XNK_Quan_Ly_Phieu_Nhap with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_XNK_Ton_Kho_A_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_Get_XNK_Ton_Kho_A_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_XNK_Ton_Kho_A with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_XNK_Ton_Kho_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_Get_XNK_Ton_Kho_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_XNK_Ton_Kho with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_XNK_Ton_Kho_Chi_Tiet_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_Get_XNK_Ton_Kho_Chi_Tiet_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_XNK_Ton_Kho_Chi_Tiet with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_XNK_Ton_Kho_CT_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_Get_XNK_Ton_Kho_CT_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_XNK_Ton_Kho_CT with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_XNK_Xuat_Kho_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_Get_XNK_Xuat_Kho_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_XNK_Xuat_Kho with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_XNK_Xuat_Kho_Chi_Tiet_By_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_Get_XNK_Xuat_Kho_Chi_Tiet_By_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_XNK_Xuat_Kho_Chi_Tiet with (nolock)
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_Get_XNK_Xuat_Kho_Chi_Tiet_By_Xuat_Kho_ID]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[sp_sel_Get_XNK_Xuat_Kho_Chi_Tiet_By_Xuat_Kho_ID]
	@Auto_ID bigint
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM view_XNK_Xuat_Kho_Chi_Tiet with (nolock)
	WHERE
		Xuat_Kho_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_DM_Customer_Zone]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_List_DM_Customer_Zone]
	with recompile
AS
BEGIN
	SELECT * FROM view_DM_Customer_Zone with (nolock)
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_DM_Don_Vi_Tinh]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_DM_Don_Vi_Tinh]
AS
BEGIN
	SELECT * FROM view_DM_Don_Vi_Tinh
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_DM_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_DM_Kho]
	with recompile
AS
BEGIN
	SELECT * FROM view_DM_Kho with (nolock)
	ORDER BY Auto_ID DESC
END

GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_DM_Khu_Vuc_Nhiet_Do]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_List_DM_Khu_Vuc_Nhiet_Do]
	with recompile
AS
BEGIN
	SELECT * FROM view_DM_Khu_Vuc_Nhiet_Do with (nolock)
	ORDER BY Auto_ID DESC
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_DM_Loai_San_Pham]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_List_DM_Loai_San_Pham]
	with recompile
AS
BEGIN
	SELECT * FROM view_DM_Loai_San_Pham with (nolock)
	ORDER BY Auto_ID DESC
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_DM_Nha_Cung_Cap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_DM_Nha_Cung_Cap]
	with recompile
AS
BEGIN
	SELECT * FROM view_DM_Nha_Cung_Cap with (nolock)
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_DM_Phan_Quyen_Kho_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_DM_Phan_Quyen_Kho_User]

	@Kho_ID bigInt
	with recompile
AS
BEGIN
	SELECT Auto_ID, Kho_ID, Ma_Dang_Nhap
	FROM view_DM_Phan_Quyen_Kho_User with (nolock)
	WHERE Kho_ID = @Kho_ID
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_DM_San_Pham]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_List_DM_San_Pham]
	with recompile
AS
BEGIN
	SELECT * FROM view_DM_San_Pham with (nolock)
	ORDER BY Auto_ID DESC
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_DM_Vi_Tri]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_List_DM_Vi_Tri]
	with recompile
AS
BEGIN
	SELECT * FROM view_DM_Vi_Tri with (nolock)
	ORDER BY Auto_ID DESC
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Log_Import_Excel]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Log_Import_Excel]
	with recompile
AS
BEGIN
	SELECT * FROM view_Log_Import_Excel
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Log_Nhat_Ky_Dang_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Log_Nhat_Ky_Dang_Nhap]
	with recompile
AS
BEGIN
	SELECT * FROM view_Log_Nhat_Ky_Dang_Nhap
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Log_Recort_Action_History]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Log_Recort_Action_History]
	with recompile
AS
BEGIN
	SELECT * FROM view_Log_Recort_Action_History
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Quan_Ly_Phieu_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_List_Quan_Ly_Phieu_Nhap]
	with recompile
AS
BEGIN
	SELECT * FROM view_Quan_Ly_Phieu_Nhap with (nolock)
	ORDER BY Auto_ID DESC
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Sys_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Sys_Chuc_Nang]
	with recompile
AS
BEGIN
	SELECT * FROM view_Sys_Chuc_Nang
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Sys_Column_Width]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Sys_Column_Width]
	with recompile
AS
BEGIN
	SELECT * FROM view_Sys_Column_Width
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Sys_Drill_Down]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Sys_Drill_Down]
	with recompile
AS
BEGIN
	SELECT * FROM view_Sys_Drill_Down
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Sys_Filter_Date_Default]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Sys_Filter_Date_Default]
	with recompile
AS
BEGIN
	SELECT * FROM view_Sys_Filter_Date_Default
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Sys_Frozen_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Sys_Frozen_Column]
	with recompile
AS
BEGIN
	SELECT * FROM view_Sys_Frozen_Column with (nolock)
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Sys_Help_Guide]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Sys_Help_Guide]
	with recompile
AS
BEGIN
	SELECT * FROM view_Sys_Help_Guide with (nolock)
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Sys_Hien_An_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Sys_Hien_An_Column]
	with recompile
AS
BEGIN
	SELECT * FROM view_Sys_Hien_An_Column
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Sys_Language]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Sys_Language]
	with recompile
AS
BEGIN
	SELECT * FROM view_Sys_Language
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Sys_Mau_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Sys_Mau_Column]
	with recompile
AS
BEGIN
	SELECT * FROM view_Sys_Mau_Column
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Sys_Nhom_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Sys_Nhom_Thanh_Vien]
	with recompile
AS
BEGIN
	SELECT * FROM view_Sys_Nhom_Thanh_Vien
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Sys_Nhom_Thanh_Vien_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Sys_Nhom_Thanh_Vien_User]
	with recompile
AS
BEGIN
	SELECT * FROM view_Sys_Nhom_Thanh_Vien_User
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Sys_Phan_Quyen_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Sys_Phan_Quyen_Chuc_Nang]
	with recompile
AS
BEGIN
	SELECT * FROM view_Sys_Phan_Quyen_Chuc_Nang
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Sys_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Sys_Thanh_Vien]
	with recompile
AS
BEGIN
	SELECT * FROM view_Sys_Thanh_Vien
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Sys_Token]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Sys_Token]
	with recompile
AS
BEGIN
	SELECT * FROM view_Sys_Token
	ORDER BY Auto_ID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sel_List_Thanh_Vien]
    @Kho_ID int
AS
BEGIN
 SELECT Ma_Dang_Nhap
FROM (
    SELECT Ma_Dang_Nhap FROM view_DM_Phan_Quyen_Kho_User WHERE Kho_ID = @Kho_ID
    UNION ALL/* lấy mã đăng nhập mà mã này được select từ hai view PHÂN	QUYỀN KHO và THÀNH VIÊN 
				select từ hai bảng và đếm nếu mã đăng nhập này xuất hiện 1 lần thì hiện select ra */
    SELECT Ma_Dang_Nhap FROM view_Sys_Thanh_Vien
) AS CombinedData
GROUP BY Ma_Dang_Nhap
HAVING COUNT(*) = 1;

END
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_XNK_Nhap_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_List_XNK_Nhap_Kho]
	with recompile
AS
BEGIN
	SELECT * FROM view_XNK_Nhap_Kho with (nolock)
	ORDER BY Auto_ID DESC
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_XNK_Nhap_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_sel_List_XNK_Nhap_Kho_Chi_Tiet]
	with recompile
as
begin
	select * from view_XNK_Nhap_Kho_Chi_Tiet with (nolock)
		ORDER BY Auto_ID DESC
end
GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_XNK_Quan_Ly_Phieu_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_List_XNK_Quan_Ly_Phieu_Nhap]
	with recompile
AS
BEGIN
	SELECT * FROM view_XNK_Quan_Ly_Phieu_Nhap with (nolock)
	ORDER BY Auto_ID DESC
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_XNK_Ton_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_List_XNK_Ton_Kho]
	with recompile
AS
BEGIN
	SELECT * FROM view_XNK_Ton_Kho with (nolock)
	ORDER BY Auto_ID DESC
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_XNK_Ton_Kho_A]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_List_XNK_Ton_Kho_A]
	with recompile
AS
BEGIN
	SELECT * FROM view_XNK_Ton_Kho_A with (nolock)
	ORDER BY Auto_ID DESC
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_XNK_Ton_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_List_XNK_Ton_Kho_Chi_Tiet]
	with recompile
AS
BEGIN
	SELECT * FROM view_XNK_Ton_Kho_Chi_Tiet with (nolock)
	ORDER BY Auto_ID DESC
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_XNK_Ton_Kho_CT]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_List_XNK_Ton_Kho_CT]
	with recompile
AS
BEGIN
	SELECT * FROM view_XNK_Ton_Kho_CT with (nolock)
	ORDER BY Auto_ID DESC
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_XNK_Xuat_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_List_XNK_Xuat_Kho]
	with recompile
AS
BEGIN
	SELECT * FROM view_XNK_Xuat_Kho with (nolock)
	ORDER BY Auto_ID DESC
END



GO
/****** Object:  StoredProcedure [dbo].[sp_sel_List_XNK_Xuat_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_sel_List_XNK_Xuat_Kho_Chi_Tiet]
	with recompile
AS
BEGIN
	SELECT * FROM view_XNK_Xuat_Kho_Chi_Tiet with (nolock)
	ORDER BY Auto_ID DESC
END



GO
/****** Object:  StoredProcedure [dbo].[sp_upd_DM_Customer_Zone]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_upd_DM_Customer_Zone]
	@Auto_ID bigint,
	@Customer_Zone_Code nvarchar(50),
	@Customer_Zone_Name nvarchar(50),
	@Customer_Zone_Status int,
	@Notes nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Customer_Zone_Code = LTRIM(RTRIM(@Customer_Zone_Code))
	set @Customer_Zone_Name = LTRIM(RTRIM(@Customer_Zone_Name))
	set @Notes = LTRIM(RTRIM(@Notes))

	UPDATE tbl_DM_Customer_Zone SET
		Customer_Zone_Code = @Customer_Zone_Code,
		Customer_Zone_Name = @Customer_Zone_Name,
		Customer_Zone_Status = @Customer_Zone_Status,
		Notes = @Notes,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_upd_DM_Don_Vi_Tinh]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_DM_Don_Vi_Tinh]
	@Auto_ID int,
	@Ten_Don_Vi_Tinh nvarchar(200),
	@Last_Updated_By nvarchar(200)
AS
BEGIN
	SET NOCOUNT ON;

	declare @Check_ID int
	set @Check_ID = (select Auto_ID from view_DM_Don_Vi_Tinh where Ten_Don_Vi_Tinh = @Ten_Don_Vi_Tinh and @Auto_ID <>Auto_ID)

	
	if (Len(@Ten_Don_Vi_Tinh)=0)
	begin
		RAISERROR(N'Vui lòng nhập tên.', 11, 1)
		return
	end

	if(isnull(@Check_ID, 0) > 0)
	begin
		RAISERROR(N'Tên đơn vị tính đã tồn tại.', 11, 1)
		return
	end 

	UPDATE tbl_DM_Don_Vi_Tinh SET
		Ten_Don_Vi_Tinh = @Ten_Don_Vi_Tinh,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By
	WHERE
		Auto_ID = @Auto_ID
END
select * from view_DM_Don_Vi_Tinh
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_DM_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_DM_Kho]
	@Auto_ID int,
	@Ten_Kho nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ten_Kho = LTRIM(RTRIM(@Ten_Kho))

	UPDATE tbl_DM_Kho SET
		Ten_Kho = @Ten_Kho,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END

GO
/****** Object:  StoredProcedure [dbo].[sp_upd_DM_Khu_Vuc_Nhiet_Do]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_upd_DM_Khu_Vuc_Nhiet_Do]
	@Auto_ID int,
	@Ma_KVND nvarchar(200),
	@Ten_KVND nvarchar(200),
	@Tu_Nhiet_Do nvarchar(200),
	@Den_Nhiet_Do nvarchar(200),
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(200)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_KVND = LTRIM(RTRIM(@Ma_KVND))
	set @Ten_KVND = LTRIM(RTRIM(@Ten_KVND))
	set @Tu_Nhiet_Do = LTRIM(RTRIM(@Tu_Nhiet_Do))
	set @Den_Nhiet_Do = LTRIM(RTRIM(@Den_Nhiet_Do))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	UPDATE tbl_DM_Khu_Vuc_Nhiet_Do SET
		Ma_KVND = @Ma_KVND,
		Ten_KVND = @Ten_KVND,
		Tu_Nhiet_Do = @Tu_Nhiet_Do,
		Den_Nhiet_Do = @Den_Nhiet_Do,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_upd_DM_Loai_San_Pham]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_upd_DM_Loai_San_Pham]
	@Auto_ID int,
	@Ten_Loai_San_Pham nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ten_Loai_San_Pham = LTRIM(RTRIM(@Ten_Loai_San_Pham))

	UPDATE tbl_DM_Loai_San_Pham SET
		Ten_Loai_San_Pham = @Ten_Loai_San_Pham,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_upd_DM_Nha_Cung_Cap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_upd_DM_Nha_Cung_Cap]
	@Auto_ID int,
	@Ten_Nha_Cung_Cap nvarchar(200),
	@Dia_Chi nvarchar(200),
	@Dien_Thoai nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ten_Nha_Cung_Cap = LTRIM(RTRIM(@Ten_Nha_Cung_Cap))
	set @Dia_Chi = LTRIM(RTRIM(@Dia_Chi))
	set @Dien_Thoai = LTRIM(RTRIM(@Dien_Thoai))

	UPDATE tbl_DM_Nha_Cung_Cap SET
		Ten_Nha_Cung_Cap = @Ten_Nha_Cung_Cap,
		Dia_Chi = @Dia_Chi,
		Dien_Thoai = @Dien_Thoai,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_DM_Phan_Quyen_Kho_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_DM_Phan_Quyen_Kho_User]
	@Auto_ID int,
	@Kho_ID int,
	@Ma_Dang_Nhap nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))

	UPDATE tbl_DM_Phan_Quyen_Kho_User SET
		Kho_ID = @Kho_ID,
		Ma_Dang_Nhap = @Ma_Dang_Nhap,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_upd_DM_San_Pham]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_upd_DM_San_Pham]
	@Auto_ID int,
	@Ma_San_Pham nvarchar(200),
	@Loai_San_Pham nvarchar(200),
	@Ten_San_Pham nvarchar(200),
	@Don_Vi_Tinh nvarchar(200),
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_San_Pham = LTRIM(RTRIM(@Ma_San_Pham))
	set @Loai_San_Pham = LTRIM(RTRIM(@Loai_San_Pham))
	set @Ten_San_Pham = LTRIM(RTRIM(@Ten_San_Pham))
	set @Don_Vi_Tinh = LTRIM(RTRIM(@Don_Vi_Tinh))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	UPDATE tbl_DM_San_Pham SET
		Ma_San_Pham = @Ma_San_Pham,
		Loai_San_Pham = @Loai_San_Pham,
		Ten_San_Pham = @Ten_San_Pham,
		Don_Vi_Tinh = @Don_Vi_Tinh,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_upd_DM_Vi_Tri]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_upd_DM_Vi_Tri]
	@Auto_ID int,
	@Ten_Vi_Tri nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ten_Vi_Tri = LTRIM(RTRIM(@Ten_Vi_Tri))

	UPDATE tbl_DM_Vi_Tri SET
		Ten_Vi_Tri = @Ten_Vi_Tri,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Log_Import_Excel]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_Log_Import_Excel]
	@Auto_ID bigint,
	@Ma_Chuc_Nang nvarchar(50),
	@Ten_Chuc_Nang nvarchar(200),
	@Link_URL nvarchar(200),
	@Trang_Thai_ID int,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ten_Chuc_Nang = LTRIM(RTRIM(@Ten_Chuc_Nang))
	set @Link_URL = LTRIM(RTRIM(@Link_URL))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	UPDATE tbl_Log_Import_Excel SET
		Ma_Chuc_Nang = @Ma_Chuc_Nang,
		Ten_Chuc_Nang = @Ten_Chuc_Nang,
		Link_URL = @Link_URL,
		Trang_Thai_ID = @Trang_Thai_ID,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Log_Nhat_Ky_Dang_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_Log_Nhat_Ky_Dang_Nhap]
	@Auto_ID bigint,
	@Ma_Dang_Nhap nvarchar(50),
	@IP nvarchar(50),
	@User_Agent nvarchar(500),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))
	set @IP = LTRIM(RTRIM(@IP))
	set @User_Agent = LTRIM(RTRIM(@User_Agent))

	UPDATE tbl_Log_Nhat_Ky_Dang_Nhap SET
		Ma_Dang_Nhap = @Ma_Dang_Nhap,
		IP = @IP,
		User_Agent = @User_Agent,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Quan_Ly_Phieu_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_upd_Quan_Ly_Phieu_Nhap]
	@Auto_ID int,
	@So_Phieu_Nhap nvarchar(200),
	@Ngay_Nhap_Kho datetime,
	@Nha_Cung_Cap nvarchar(200),
	@Kho nvarchar(200),
	@Tong_So_Luong float,
	@Tong_Tri_Gia float,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(200)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @So_Phieu_Nhap = LTRIM(RTRIM(@So_Phieu_Nhap))
	set @Nha_Cung_Cap = LTRIM(RTRIM(@Nha_Cung_Cap))
	set @Kho = LTRIM(RTRIM(@Kho))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	set @Ngay_Nhap_Kho = dbo.fnConvert_Ngay_To_NULL(@Ngay_Nhap_Kho)
	set @Ngay_Nhap_Kho = dbo.fnConvert_To_Dau_Ngay(@Ngay_Nhap_Kho)

	UPDATE tbl_Quan_Ly_Phieu_Nhap SET
		So_Phieu_Nhap = @So_Phieu_Nhap,
		Ngay_Nhap_Kho = @Ngay_Nhap_Kho,
		Nha_Cung_Cap = @Nha_Cung_Cap,
		Kho = @Kho,
		Tong_So_Luong = @Tong_So_Luong,
		Tong_Tri_Gia = @Tong_Tri_Gia,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By
		
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Sys_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_Sys_Chuc_Nang]
	@Auto_ID bigint,
	@Ma_Chuc_Nang nvarchar(50),
	@Ten_Chuc_Nang nvarchar(200),
	@Sort_Priority int,
	@Chuc_Nang_Parent_ID bigint,
	@Nhom_Chuc_Nang_ID int,
	@Func_URL nvarchar(200),
	@Image_URL nvarchar(50),
	@Is_View bit,
	@Is_New bit,
	@Is_Edit bit,
	@Is_Delete bit,
	@Is_Export bit,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ten_Chuc_Nang = LTRIM(RTRIM(@Ten_Chuc_Nang))
	set @Func_URL = LTRIM(RTRIM(@Func_URL))
	set @Image_URL = LTRIM(RTRIM(@Image_URL))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	UPDATE tbl_Sys_Chuc_Nang SET
		Ma_Chuc_Nang = @Ma_Chuc_Nang,
		Ten_Chuc_Nang = @Ten_Chuc_Nang,
		Sort_Priority = @Sort_Priority,
		Chuc_Nang_Parent_ID = @Chuc_Nang_Parent_ID,
		Nhom_Chuc_Nang_ID = @Nhom_Chuc_Nang_ID,
		Func_URL = @Func_URL,
		Image_URL = @Image_URL,
		Is_View = @Is_View,
		Is_New = @Is_New,
		Is_Edit = @Is_Edit,
		Is_Delete = @Is_Delete,
		Is_Export = @Is_Export,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Sys_Column_Width]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_Sys_Column_Width]
	@Auto_ID bigint,
	@Field_Name nvarchar(50),
	@Do_Rong int,
	@Format_Number nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Format_Number = LTRIM(RTRIM(@Format_Number))

	UPDATE tbl_Sys_Column_Width SET
		Field_Name = @Field_Name,
		Do_Rong = @Do_Rong,
		Format_Number = @Format_Number,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Sys_Drill_Down]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_Sys_Drill_Down]
	@Auto_ID bigint,
	@Field_Name nvarchar(50),
	@Link_URL nvarchar(200),
	@Parameter_Field nvarchar(50),
	@Func_ID nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Link_URL = LTRIM(RTRIM(@Link_URL))
	set @Parameter_Field = LTRIM(RTRIM(@Parameter_Field))
	set @Func_ID = LTRIM(RTRIM(@Func_ID))

	UPDATE tbl_Sys_Drill_Down SET
		Field_Name = @Field_Name,
		Link_URL = @Link_URL,
		Parameter_Field = @Parameter_Field,
		Func_ID = @Func_ID,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Sys_Filter_Date_Default]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_Sys_Filter_Date_Default]
	@Auto_ID bigint,
	@Ma_Chuc_Nang nvarchar(50),
	@Duration_Days_From float,
	@Duration_Days_To float,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	UPDATE tbl_Sys_Filter_Date_Default SET
		Ma_Chuc_Nang = @Ma_Chuc_Nang,
		Duration_Days_From = @Duration_Days_From,
		Duration_Days_To = @Duration_Days_To,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Sys_Frozen_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_Sys_Frozen_Column]
	@Auto_ID bigint,
	@Ma_Chuc_Nang nvarchar(50),
	@SL_Cot_Frozen int,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))

	UPDATE tbl_Sys_Frozen_Column SET
		Ma_Chuc_Nang = @Ma_Chuc_Nang,
		SL_Cot_Frozen = @SL_Cot_Frozen,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Sys_Help_Guide]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_Sys_Help_Guide]
	@Auto_ID bigint,
	@Khach_Hang_ID bigint,
	@Ma_Chuc_Nang nvarchar(50),
	@Ngon_Ngu nvarchar(50),
	@Noi_Dung ntext,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))
	set @Ngon_Ngu = LTRIM(RTRIM(@Ngon_Ngu))

	UPDATE tbl_Sys_Help_Guide SET
		Khach_Hang_ID = @Khach_Hang_ID,
		Ma_Chuc_Nang = @Ma_Chuc_Nang,
		Ngon_Ngu = @Ngon_Ngu,
		Noi_Dung = @Noi_Dung,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Sys_Hien_An_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_Sys_Hien_An_Column]
	@Auto_ID bigint,
	@Chu_Hang_ID bigint,
	@Field_Name nvarchar(50),
	@Option_ID int,
	@Ma_Chuc_Nang nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Ma_Chuc_Nang = LTRIM(RTRIM(@Ma_Chuc_Nang))

	UPDATE tbl_Sys_Hien_An_Column SET
		Chu_Hang_ID = @Chu_Hang_ID,
		Field_Name = @Field_Name,
		Option_ID = @Option_ID,
		Ma_Chuc_Nang = @Ma_Chuc_Nang,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Sys_Language]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_Sys_Language]
	@Auto_ID bigint,
	@Field_Name nvarchar(50),
	@Lang_1 nvarchar(200),
	@Lang_2 nvarchar(200),
	@Lang_3 nvarchar(200),
	@Lang_4 nvarchar(200),
	@Lang_5 nvarchar(200),
	@Type_ID int,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Lang_1 = LTRIM(RTRIM(@Lang_1))
	set @Lang_2 = LTRIM(RTRIM(@Lang_2))
	set @Lang_3 = LTRIM(RTRIM(@Lang_3))
	set @Lang_4 = LTRIM(RTRIM(@Lang_4))
	set @Lang_5 = LTRIM(RTRIM(@Lang_5))

	UPDATE tbl_Sys_Language SET
		Field_Name = @Field_Name,
		Lang_1 = @Lang_1,
		Lang_2 = @Lang_2,
		Lang_3 = @Lang_3,
		Lang_4 = @Lang_4,
		Lang_5 = @Lang_5,
		Type_ID = @Type_ID,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Sys_Mau_Column]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_Sys_Mau_Column]
	@Auto_ID bigint,
	@Field_Name nvarchar(50),
	@Ma_So_Mau nvarchar(50),
	@Ghi_Chu nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Field_Name = LTRIM(RTRIM(@Field_Name))
	set @Ma_So_Mau = LTRIM(RTRIM(@Ma_So_Mau))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	UPDATE tbl_Sys_Mau_Column SET
		Field_Name = @Field_Name,
		Ma_So_Mau = @Ma_So_Mau,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Sys_Nhom_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_Sys_Nhom_Thanh_Vien]
	@Auto_ID bigint,
	@Ten_Nhom_Thanh_Vien nvarchar(200),
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;


	UPDATE tbl_Sys_Nhom_Thanh_Vien SET
		Ten_Nhom_Thanh_Vien = @Ten_Nhom_Thanh_Vien,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Sys_Nhom_Thanh_Vien_User]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_Sys_Nhom_Thanh_Vien_User]
	@Auto_ID bigint,
	@Nhom_Thanh_Vien_ID bigint,
	@Ma_Dang_Nhap nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))

	UPDATE tbl_Sys_Nhom_Thanh_Vien_User SET
		Nhom_Thanh_Vien_ID = @Nhom_Thanh_Vien_ID,
		Ma_Dang_Nhap = @Ma_Dang_Nhap,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Sys_Phan_Quyen_Chuc_Nang]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_Sys_Phan_Quyen_Chuc_Nang]
	@Auto_ID bigint,
	@Nhom_Thanh_Vien_ID bigint,
	@Chuc_Nang_ID bigint,
	@Is_Have_View_Permission bit,
	@Is_Have_Add_Permission bit,
	@Is_Have_Edit_Permission bit,
	@Is_Have_Delete_Permission bit,
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tbl_Sys_Phan_Quyen_Chuc_Nang SET
		Nhom_Thanh_Vien_ID = @Nhom_Thanh_Vien_ID,
		Chuc_Nang_ID = @Chuc_Nang_ID,
		Is_Have_View_Permission = @Is_Have_View_Permission,
		Is_Have_Add_Permission = @Is_Have_Add_Permission,
		Is_Have_Edit_Permission = @Is_Have_Edit_Permission,
		Is_Have_Delete_Permission = @Is_Have_Delete_Permission,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Sys_Thanh_Vien]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_Sys_Thanh_Vien]
	@Auto_ID bigint,
	@Ma_Dang_Nhap nvarchar(50),
	@Mat_Khau nvarchar(50),
	@Ho_Ten nvarchar(100),
	@Email nvarchar(250),
	@Dien_Thoai nvarchar(200),
	@Hinh_Dai_Dien_URL nvarchar(200),
	@Trang_Thai_ID int,
	@Ten_Nhom_Thanh_Vien_Text nvarchar(400),
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))
	set @Mat_Khau = LTRIM(RTRIM(@Mat_Khau))
	set @Ho_Ten = LTRIM(RTRIM(@Ho_Ten))
	set @Email = LTRIM(RTRIM(@Email))
	set @Dien_Thoai = LTRIM(RTRIM(@Dien_Thoai))
	set @Hinh_Dai_Dien_URL = LTRIM(RTRIM(@Hinh_Dai_Dien_URL))
	set @Ten_Nhom_Thanh_Vien_Text = LTRIM(RTRIM(@Ten_Nhom_Thanh_Vien_Text))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	UPDATE tbl_Sys_Thanh_Vien SET
		Ma_Dang_Nhap = @Ma_Dang_Nhap,
		Mat_Khau = @Mat_Khau,
		Ho_Ten = @Ho_Ten,
		Email = @Email,
		Dien_Thoai = @Dien_Thoai,
		Hinh_Dai_Dien_URL = @Hinh_Dai_Dien_URL,
		Trang_Thai_ID = @Trang_Thai_ID,
		Ten_Nhom_Thanh_Vien_Text = @Ten_Nhom_Thanh_Vien_Text,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_Sys_Token]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_Sys_Token]
	@Auto_ID bigint,
	@Token_ID nvarchar(50),
	@Ma_Dang_Nhap nvarchar(50),
	@Last_Updated_By nvarchar(50),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Token_ID = LTRIM(RTRIM(@Token_ID))
	set @Ma_Dang_Nhap = LTRIM(RTRIM(@Ma_Dang_Nhap))

	UPDATE tbl_Sys_Token SET
		Token_ID = @Token_ID,
		Ma_Dang_Nhap = @Ma_Dang_Nhap,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_XNK_Nhap_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_XNK_Nhap_Kho]
	@Auto_ID int,
	@So_Phieu_Nhap nvarchar(200),
	@Ngay_Nhap_Kho datetime,
	@Nha_Cung_Cap nvarchar(200),
	@Kho nvarchar(200),
	@Trang_Thai int,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;
	set @So_Phieu_Nhap = LTRIM(RTRIM(@So_Phieu_Nhap))

	declare @Check_Ten_Phieu bigint = (select top 1 Auto_ID from view_XNK_Nhap_Kho with (nolock) where So_Phieu_Nhap = @So_Phieu_Nhap and Auto_ID != @Auto_ID)
	if(isnull(@Check_Ten_Phieu, 0) > 0)
	begin
		RAISERROR(N'Số Phiếu Nhập đã tồn tại.', 11, 1)
		return
	end


	set @So_Phieu_Nhap = LTRIM(RTRIM(@So_Phieu_Nhap))
	set @Nha_Cung_Cap = LTRIM(RTRIM(@Nha_Cung_Cap))
	set @Kho = LTRIM(RTRIM(@Kho))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	set @Ngay_Nhap_Kho = dbo.fnConvert_Ngay_To_NULL(@Ngay_Nhap_Kho)
	set @Ngay_Nhap_Kho = dbo.fnConvert_To_Dau_Ngay(@Ngay_Nhap_Kho)

	UPDATE tbl_XNK_Nhap_Kho SET
		So_Phieu_Nhap = @So_Phieu_Nhap,
		Ngay_Nhap_Kho = @Ngay_Nhap_Kho,
		Nha_Cung_Cap = @Nha_Cung_Cap,
		Kho = @Kho,
		Trang_Thai = @Trang_Thai,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_XNK_Nhap_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_upd_XNK_Nhap_Kho_Chi_Tiet]
	@Auto_ID int,
	@Nhap_Kho_ID int,
	@Ma_San_Pham nvarchar(200),
	@Ten_San_Pham nvarchar(200),
	@So_Luong float,
	@Don_Gia float,
	@Tri_Gia float,
	@Ngay_San_Xuat datetime,
	@Ngay_Het_Hang datetime,
	@So_LPN nvarchar(200),
	@Kien int, 
	@So_Luong_Chan int, 
	@So_Luong_Le int, 
	@Tong_So_Luong int,
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile

as
begin
	set nocount on;

		set @Ma_San_Pham = LTRIM(RTRIM(@Ma_San_Pham))
		set @Ten_San_Pham = LTRIM(RTRIM(@Ten_San_Pham))

		update tbl_XNK_Nhap_Kho_Chi_Tiet set
			Nhap_Kho_ID=@Nhap_Kho_ID,
			Ma_San_Pham= @Ma_San_Pham,
			Ten_San_Pham= @Ten_San_Pham,
			So_Luong= @So_Luong,
			Don_Gia= @Don_Gia,
			Tri_Gia= @Tri_Gia,
			Ngay_San_Xuat= @Ngay_San_Xuat,
			Ngay_Het_Hang= @Ngay_Het_Hang,
			So_LPN= @So_LPN,
			Kien= @Kien,
			So_Luong_Chan= @So_Luong_Chan,
			So_Luong_Le = @So_Luong_Le,
			Tong_So_Luong = @Tong_So_Luong,
			Last_Updated= @Last_Updated_By,
			Last_Updated_By =@Last_Updated_By,
			Last_Updated_By_Function = @Last_Updated_By_Function

			where 
				Auto_ID=@Auto_ID

end
			
GO
/****** Object:  StoredProcedure [dbo].[sp_upd_XNK_Quan_Ly_Phieu_Nhap]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_upd_XNK_Quan_Ly_Phieu_Nhap]
	@Auto_ID int,
	@So_Phieu_Nhap nvarchar(200),
	@Ngay_Nhap_Kho datetime,
	@Nha_Cung_Cap nvarchar(200),
	@Kho nvarchar(200),
	@Tong_So_Luong int,
	@Tong_Tri_Gia int,
	@Trang_Thai int,
	@Trang_Thai_Putaway int,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @So_Phieu_Nhap = LTRIM(RTRIM(@So_Phieu_Nhap))
	set @Nha_Cung_Cap = LTRIM(RTRIM(@Nha_Cung_Cap))
	set @Kho = LTRIM(RTRIM(@Kho))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	set @Ngay_Nhap_Kho = dbo.fnConvert_Ngay_To_NULL(@Ngay_Nhap_Kho)
	set @Ngay_Nhap_Kho = dbo.fnConvert_To_Dau_Ngay(@Ngay_Nhap_Kho)

	UPDATE tbl_XNK_Quan_Ly_Phieu_Nhap SET
		So_Phieu_Nhap = @So_Phieu_Nhap,
		Ngay_Nhap_Kho = @Ngay_Nhap_Kho,
		Nha_Cung_Cap = @Nha_Cung_Cap,
		Kho = @Kho,
		Tong_So_Luong = @Tong_So_Luong,
		Tong_Tri_Gia = @Tong_Tri_Gia,
		Trang_Thai = @Trang_Thai,
		Trang_Thai_Putaway = @Trang_Thai_Putaway,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_upd_XNK_Ton_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_upd_XNK_Ton_Kho]
	@Auto_ID int,
	@So_Phieu_Nhap nvarchar(200),
	@Ngay_Nhap_Kho datetime,
	@Nha_Cung_Cap nvarchar(200),
	@Kho nvarchar(200),
	@Tong_So_Luong int,
	@Vi_Tri nvarchar(200),
	@Trang_Thai int,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @So_Phieu_Nhap = LTRIM(RTRIM(@So_Phieu_Nhap))
	set @Nha_Cung_Cap = LTRIM(RTRIM(@Nha_Cung_Cap))
	set @Kho = LTRIM(RTRIM(@Kho))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	set @Ngay_Nhap_Kho = dbo.fnConvert_Ngay_To_NULL(@Ngay_Nhap_Kho)
	set @Ngay_Nhap_Kho = dbo.fnConvert_To_Dau_Ngay(@Ngay_Nhap_Kho)

	UPDATE tbl_XNK_Ton_Kho SET
		So_Phieu_Nhap = @So_Phieu_Nhap,
		Ngay_Nhap_Kho = @Ngay_Nhap_Kho,
		Nha_Cung_Cap = @Nha_Cung_Cap,
		Kho = @Kho,
		Tong_So_Luong = @Tong_So_Luong,
		Vi_Tri = @Vi_Tri,
		Trang_Thai = @Trang_Thai,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END


GO
/****** Object:  StoredProcedure [dbo].[sp_upd_XNK_Ton_Kho_A]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_upd_XNK_Ton_Kho_A]
	@Auto_ID int,
	@So_Phieu_Nhap nvarchar(200),
	@Ngay_Nhap_Kho datetime,
	@Nha_Cung_Cap nvarchar(200),
	@Kho nvarchar(200),
	@Trang_Thai int,
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @So_Phieu_Nhap = LTRIM(RTRIM(@So_Phieu_Nhap))
	set @Nha_Cung_Cap = LTRIM(RTRIM(@Nha_Cung_Cap))
	set @Kho = LTRIM(RTRIM(@Kho))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	set @Ngay_Nhap_Kho = dbo.fnConvert_Ngay_To_NULL(@Ngay_Nhap_Kho)
	set @Ngay_Nhap_Kho = dbo.fnConvert_To_Dau_Ngay(@Ngay_Nhap_Kho)

	UPDATE tbl_XNK_Ton_Kho_A SET
		So_Phieu_Nhap = @So_Phieu_Nhap,
		Ngay_Nhap_Kho = @Ngay_Nhap_Kho,
		Nha_Cung_Cap = @Nha_Cung_Cap,
		Kho = @Kho,
		Trang_Thai = @Trang_Thai,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_upd_XNK_Ton_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_upd_XNK_Ton_Kho_Chi_Tiet]
	@Auto_ID int,
	@Nhap_Kho_ID int,
	@Ma_San_Pham nvarchar(200),
	@Ten_San_Pham nvarchar(200),
	@So_Phieu nvarchar(200),
	@Ngay_Nhap_Kho datetime,
	@Vi_Tri nvarchar(200),
	@So_Luong float,
	@Don_Gia float,
	@Tri_Gia float,
	@Kien int,
	@So_Luong_Chan int,
	@So_Luong_Le int,
	@Tong_So_Luong int,
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_San_Pham = LTRIM(RTRIM(@Ma_San_Pham))
	set @Ten_San_Pham = LTRIM(RTRIM(@Ten_San_Pham))
	set @So_Phieu = LTRIM(RTRIM(@So_Phieu))
	set @Vi_Tri = LTRIM(RTRIM(@Vi_Tri))

	set @Ngay_Nhap_Kho = dbo.fnConvert_Ngay_To_NULL(@Ngay_Nhap_Kho)
	set @Ngay_Nhap_Kho = dbo.fnConvert_To_Dau_Ngay(@Ngay_Nhap_Kho)

	UPDATE tbl_XNK_Ton_Kho_Chi_Tiet SET
		Nhap_Kho_ID = @Nhap_Kho_ID,
		Ma_San_Pham = @Ma_San_Pham,
		Ten_San_Pham = @Ten_San_Pham,
		So_Phieu = @So_Phieu,
		Ngay_Nhap_Kho = @Ngay_Nhap_Kho,
		Vi_Tri = @Vi_Tri,
		So_Luong = @So_Luong,
		Don_Gia = @Don_Gia,
		Tri_Gia = @Tri_Gia,
		Kien = @Kien,
		So_Luong_Chan = @So_Luong_Chan,
		So_Luong_Le = @So_Luong_Le,
		Tong_So_Luong = @Tong_So_Luong,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_upd_XNK_Ton_Kho_CT]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_upd_XNK_Ton_Kho_CT]
	@Auto_ID int,
	@Nhap_Kho_ID int,
	@So_Phieu_Nhap nvarchar(200),
	@Ma_San_Pham nvarchar(200),
	@Ten_San_Pham nvarchar(200),
	@So_Luong float,
	@Don_Gia float,
	@Tri_Gia float,
	@Ngay_San_Xuat datetime,
	@Ngay_Het_Hang datetime,
	@So_LPN nvarchar(200),
	@Kien int,
	@So_Luong_Chan int,
	@So_Luong_Le int,
	@Tong_So_Luong int,
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @So_Phieu_Nhap = LTRIM(RTRIM(@So_Phieu_Nhap))
	set @Ma_San_Pham = LTRIM(RTRIM(@Ma_San_Pham))
	set @Ten_San_Pham = LTRIM(RTRIM(@Ten_San_Pham))
	set @So_LPN = LTRIM(RTRIM(@So_LPN))

	set @Ngay_San_Xuat = dbo.fnConvert_Ngay_To_NULL(@Ngay_San_Xuat)
	set @Ngay_San_Xuat = dbo.fnConvert_To_Dau_Ngay(@Ngay_San_Xuat)
	set @Ngay_Het_Hang = dbo.fnConvert_Ngay_To_NULL(@Ngay_Het_Hang)
	set @Ngay_Het_Hang = dbo.fnConvert_To_Dau_Ngay(@Ngay_Het_Hang)

	UPDATE tbl_XNK_Ton_Kho_CT SET
		Nhap_Kho_ID = @Nhap_Kho_ID,
		So_Phieu_Nhap = @So_Phieu_Nhap,
		Ma_San_Pham = @Ma_San_Pham,
		Ten_San_Pham = @Ten_San_Pham,
		So_Luong = @So_Luong,
		Don_Gia = @Don_Gia,
		Tri_Gia = @Tri_Gia,
		Ngay_San_Xuat = @Ngay_San_Xuat,
		Ngay_Het_Hang = @Ngay_Het_Hang,
		So_LPN = @So_LPN,
		Kien = @Kien,
		So_Luong_Chan = @So_Luong_Chan,
		So_Luong_Le = @So_Luong_Le,
		Tong_So_Luong = @Tong_So_Luong,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By,
		Last_Updated_By_Function = @Last_Updated_By_Function
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_upd_XNK_Xuat_Kho]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_upd_XNK_Xuat_Kho]
	@Auto_ID int,
	@So_Phieu_Xuat_Kho nvarchar(200),
	@Ngay_Xuat_Kho datetime,
	@Kho nvarchar(200),
	@Ghi_Chu nvarchar(200),
	@Last_Updated_By nvarchar(200)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @So_Phieu_Xuat_Kho = LTRIM(RTRIM(@So_Phieu_Xuat_Kho))
	set @Kho = LTRIM(RTRIM(@Kho))
	set @Ghi_Chu = LTRIM(RTRIM(@Ghi_Chu))

	set @Ngay_Xuat_Kho = dbo.fnConvert_Ngay_To_NULL(@Ngay_Xuat_Kho)
	set @Ngay_Xuat_Kho = dbo.fnConvert_To_Dau_Ngay(@Ngay_Xuat_Kho)

	UPDATE tbl_XNK_Xuat_Kho SET
		So_Phieu_Xuat_Kho = @So_Phieu_Xuat_Kho,
		Ngay_Xuat_Kho = @Ngay_Xuat_Kho,
		Kho = @Kho,
		Ghi_Chu = @Ghi_Chu,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By
	WHERE
		Auto_ID = @Auto_ID
END



GO
/****** Object:  StoredProcedure [dbo].[sp_upd_XNK_Xuat_Kho_Chi_Tiet]    Script Date: 01/24/2024 7:42:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_upd_XNK_Xuat_Kho_Chi_Tiet]
	@Auto_ID int,
	@Xuat_Kho_ID int,
	@Ma_San_Pham nvarchar(200),
	@Ten_San_Pham nvarchar(200),
	@So_Luong float,
	@Don_Gia float,
	@Tri_Gia float,
	@Ngay_San_Xuat datetime,
	@Ngay_Het_Hang datetime,
	@So_LPN nvarchar(200),
	@Kien int, 
	@So_Luong_Chan int, 
	@So_Luong_Le int, 
	@Tong_So_Luong int,
	@Last_Updated_By nvarchar(200),
	@Last_Updated_By_Function nvarchar(50)
	with recompile
AS
BEGIN
	SET NOCOUNT ON;

	set @Ma_San_Pham = LTRIM(RTRIM(@Ma_San_Pham))
	set @Ten_San_Pham = LTRIM(RTRIM(@Ten_San_Pham))

	UPDATE tbl_XNK_Xuat_Kho_Chi_Tiet SET
		Xuat_Kho_ID = @Xuat_Kho_ID,
		Ma_San_Pham = @Ma_San_Pham,
		Ten_San_Pham = @Ten_San_Pham,
		So_Luong = @So_Luong,
		Don_Gia = @Don_Gia,
		Tri_Gia = @Tri_Gia,
		Last_Updated = getdate(),
		Last_Updated_By = @Last_Updated_By
	WHERE
		Auto_ID = @Auto_ID
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_Log_Nhat_Ky_Truy_Cap_Chuc_Nang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_Log_Nhat_Ky_Truy_Cap_Chuc_Nang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 297
               Right = 258
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_Log_Record_Action_History'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_Log_Record_Action_History'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 306
               Right = 317
            End
            DisplayFlags = 280
            TopColumn = 10
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_Sys_Chuc_Nang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_Sys_Chuc_Nang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 301
               Right = 317
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 7
               Left = 365
               Bottom = 208
               Right = 646
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 7
               Left = 694
               Bottom = 170
               Right = 963
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_Sys_Nhom_Thanh_Vien_User'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_Sys_Nhom_Thanh_Vien_User'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 306
               Right = 320
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_Sys_Phan_Quyen_Chuc_Nang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_Sys_Phan_Quyen_Chuc_Nang'
GO
USE [master]
GO
ALTER DATABASE [TKS_Core_2023] SET  READ_WRITE 
GO
