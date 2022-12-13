GO
CREATE TABLE [dbo].[HangXuat](
 [MaHD] [nchar](10) NOT NULL,
 [MaVT] [nchar](10) NOT NULL,
 [DonGia] [money] NULL,
 [SLBan] [tinyint] NULL,
 CONSTRAINT [PK_HangXuat] PRIMARY KEY CLUSTERED 
(
 [MaHD] ASC,
 [MaVT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HDBan]    Script Date: 13/12/2022 2:12:27 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HDBan](
 [MaHD] [nchar](10) NOT NULL,
 [NgayXuat] [smalldatetime] NULL,
 [HoTenKhach] [nchar](40) NULL,
 CONSTRAINT [PK_HDBan] PRIMARY KEY CLUSTERED 
(
 [MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VatTu]    Script Date: 13/12/2022 2:12:27 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VatTu](
 [TenVT] [nchar](10) NULL,
 [MaVT] [nchar](10) NOT NULL,
 [DVTinh] [nchar](10) NULL,
 [SLCon] [smallint] NULL,
 CONSTRAINT [PK_VatTu] PRIMARY KEY CLUSTERED 
(
 [MaVT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[HangXuat] ([MaHD], [MaVT], [DonGia], [SLBan]) VALUES (N'm01       ', N'1a        ', 500.0000, 1)
INSERT [dbo].[HangXuat] ([MaHD], [MaVT], [DonGia], [SLBan]) VALUES (N'm02       ', N'1b        ', 60000000.0000, 1)
INSERT [dbo].[HangXuat] ([MaHD], [MaVT], [DonGia], [SLBan]) VALUES (N'm03       ', N'1a        ', 500.0000, 1)
INSERT [dbo].[HangXuat] ([MaHD], [MaVT], [DonGia], [SLBan]) VALUES (N'm04       ', N'1b        ', 6000000.0000, 1)
GO
INSERT [dbo].[HDBan] ([MaHD], [NgayXuat], [HoTenKhach]) VALUES (N'm01       ', CAST(N'2018-03-23T00:00:00' AS SmallDateTime), N'Nguyễn Đức Phát                            ')
INSERT [dbo].[HDBan] ([MaHD], [NgayXuat], [HoTenKhach]) VALUES (N'm02       ', CAST(N'2022-11-15T00:00:00' AS SmallDateTime), N'nguyễn Thị Thu Hồng                            ')
GO
INSERT [dbo].[VatTu] ([TenVT], [MaVT], [DVTinh], [SLCon]) VALUES (N'gà 300 MT  ', N'1a        ', N'con       ', 569)
INSERT [dbo].[VatTu] ([TenVT], [MaVT], [DVTinh], [SLCon]) VALUES (N'gà 250 LG ', N'1b        ', N'con       ', 352)

go
select top 1 MaHD, sum(DonGia) 
as TongTien 
from HangXuat 
group by MaHD, DonGia 
order by DonGia desc
go
 
 select * from HangXuat

