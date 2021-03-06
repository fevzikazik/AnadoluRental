USE [master]
GO
/****** Object:  Database [dbAnadoluRental]    Script Date: 12.05.2019 19:36:59 ******/
CREATE DATABASE [dbAnadoluRental]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbAnadoluRental', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\dbAnadoluRental.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'dbAnadoluRental_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\dbAnadoluRental_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [dbAnadoluRental] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbAnadoluRental].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbAnadoluRental] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbAnadoluRental] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbAnadoluRental] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET  DISABLE_BROKER 
GO
ALTER DATABASE [dbAnadoluRental] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbAnadoluRental] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [dbAnadoluRental] SET  MULTI_USER 
GO
ALTER DATABASE [dbAnadoluRental] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbAnadoluRental] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbAnadoluRental] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbAnadoluRental] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [dbAnadoluRental] SET DELAYED_DURABILITY = DISABLED 
GO
USE [dbAnadoluRental]
GO
/****** Object:  Table [dbo].[Arac]    Script Date: 12.05.2019 19:36:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Arac](
	[aracID] [int] IDENTITY(1,1) NOT NULL,
	[aracMarka] [varchar](50) NULL,
	[aracModel] [varchar](50) NULL,
	[gerekenEhliyetYasi] [int] NULL,
	[minYasSiniri] [int] NULL,
	[gunlukSinirKM] [int] NULL,
	[aracKM] [int] NULL,
	[airBagSayisi] [int] NULL,
	[bagacHacmi] [int] NULL,
	[koltukSayisi] [int] NULL,
	[gunlukKiralikFiyati] [int] NULL,
	[aitOlduguSirketID] [int] NOT NULL,
 CONSTRAINT [PK_Arac] PRIMARY KEY CLUSTERED 
(
	[aracID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kiralik]    Script Date: 12.05.2019 19:37:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kiralik](
	[kiraID] [int] IDENTITY(1,1) NOT NULL,
	[kiralananAracID] [int] NULL,
	[kiraTarihi] [date] NULL,
	[verilisKM] [int] NULL,
	[kiraBitisKM] [int] NULL,
	[kiraAlinanUcret] [int] NULL,
	[kiralayanKulID] [int] NOT NULL,
 CONSTRAINT [PK_Kiralik] PRIMARY KEY CLUSTERED 
(
	[kiraID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kullanici]    Script Date: 12.05.2019 19:37:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kullanici](
	[kullaniciID] [int] IDENTITY(1,1) NOT NULL,
	[kullAdi] [nvarchar](100) NULL,
	[kullSifre] [nvarchar](100) NULL,
	[kullRolID] [int] NULL,
	[kullSirketID] [int] NULL,
	[Ad] [nvarchar](100) NULL,
	[Soyad] [nvarchar](100) NULL,
	[TelNo] [nvarchar](100) NULL,
	[Adres] [nvarchar](100) NULL,
 CONSTRAINT [PK_Kullanici] PRIMARY KEY CLUSTERED 
(
	[kullaniciID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 12.05.2019 19:37:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol](
	[rolID] [int] IDENTITY(1,1) NOT NULL,
	[rolAdi] [nvarchar](100) NULL,
 CONSTRAINT [PK_Rol] PRIMARY KEY CLUSTERED 
(
	[rolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sirket]    Script Date: 12.05.2019 19:37:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sirket](
	[sirketID] [int] IDENTITY(1,1) NOT NULL,
	[sirketAdi] [nvarchar](150) NULL,
	[sirketSehir] [nvarchar](150) NULL,
	[sirketAdres] [nvarchar](150) NULL,
	[sirketAracSayisi] [int] NULL,
	[sirketPuani] [int] NULL,
 CONSTRAINT [PK_Sirket] PRIMARY KEY CLUSTERED 
(
	[sirketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Arac] ON 

INSERT [dbo].[Arac] ([aracID], [aracMarka], [aracModel], [gerekenEhliyetYasi], [minYasSiniri], [gunlukSinirKM], [aracKM], [airBagSayisi], [bagacHacmi], [koltukSayisi], [gunlukKiralikFiyati], [aitOlduguSirketID]) VALUES (1, N'OPEL', N'CORSA', 1, 20, 100, 100000, 6, 10, 5, 101, 1)
INSERT [dbo].[Arac] ([aracID], [aracMarka], [aracModel], [gerekenEhliyetYasi], [minYasSiniri], [gunlukSinirKM], [aracKM], [airBagSayisi], [bagacHacmi], [koltukSayisi], [gunlukKiralikFiyati], [aitOlduguSirketID]) VALUES (2, N'FİAT', N'LINEA', 0, 18, 50, 50000, 2, 5, 5, 50, 1)
INSERT [dbo].[Arac] ([aracID], [aracMarka], [aracModel], [gerekenEhliyetYasi], [minYasSiniri], [gunlukSinirKM], [aracKM], [airBagSayisi], [bagacHacmi], [koltukSayisi], [gunlukKiralikFiyati], [aitOlduguSirketID]) VALUES (3, N'RENAULT', N'CLİO', 0, 18, 150, 15000, 3, 15, 6, 80, 2)
INSERT [dbo].[Arac] ([aracID], [aracMarka], [aracModel], [gerekenEhliyetYasi], [minYasSiniri], [gunlukSinirKM], [aracKM], [airBagSayisi], [bagacHacmi], [koltukSayisi], [gunlukKiralikFiyati], [aitOlduguSirketID]) VALUES (4, N'FORD', N'CONNECT', 2, 20, 200, 80000, 2, 30, 6, 120, 2)
INSERT [dbo].[Arac] ([aracID], [aracMarka], [aracModel], [gerekenEhliyetYasi], [minYasSiniri], [gunlukSinirKM], [aracKM], [airBagSayisi], [bagacHacmi], [koltukSayisi], [gunlukKiralikFiyati], [aitOlduguSirketID]) VALUES (5, N'HONDA', N'CIVIC', 5, 25, 120, 10000, 9, 20, 5, 150, 1)
INSERT [dbo].[Arac] ([aracID], [aracMarka], [aracModel], [gerekenEhliyetYasi], [minYasSiniri], [gunlukSinirKM], [aracKM], [airBagSayisi], [bagacHacmi], [koltukSayisi], [gunlukKiralikFiyati], [aitOlduguSirketID]) VALUES (10, N'FİAT', N'LİNEA V2', 3, 25, 100, 150002, 50, 20, 50, 251, 4)
SET IDENTITY_INSERT [dbo].[Arac] OFF
SET IDENTITY_INSERT [dbo].[Kiralik] ON 

INSERT [dbo].[Kiralik] ([kiraID], [kiralananAracID], [kiraTarihi], [verilisKM], [kiraBitisKM], [kiraAlinanUcret], [kiralayanKulID]) VALUES (11, 1, CAST(N'2019-05-02' AS Date), 100000, 150000, 100, 24)
INSERT [dbo].[Kiralik] ([kiraID], [kiralananAracID], [kiraTarihi], [verilisKM], [kiraBitisKM], [kiraAlinanUcret], [kiralayanKulID]) VALUES (14, 2, CAST(N'2019-05-08' AS Date), 100000, 200000, 150, 25)
INSERT [dbo].[Kiralik] ([kiraID], [kiralananAracID], [kiraTarihi], [verilisKM], [kiraBitisKM], [kiraAlinanUcret], [kiralayanKulID]) VALUES (15, 3, CAST(N'2019-05-02' AS Date), 10000, 11000, 180, 26)
INSERT [dbo].[Kiralik] ([kiraID], [kiralananAracID], [kiraTarihi], [verilisKM], [kiraBitisKM], [kiraAlinanUcret], [kiralayanKulID]) VALUES (16, 4, CAST(N'2019-05-01' AS Date), 150, 1001, 201, 27)
SET IDENTITY_INSERT [dbo].[Kiralik] OFF
SET IDENTITY_INSERT [dbo].[Kullanici] ON 

INSERT [dbo].[Kullanici] ([kullaniciID], [kullAdi], [kullSifre], [kullRolID], [kullSirketID], [Ad], [Soyad], [TelNo], [Adres]) VALUES (24, N'fevzi', N'fevzis', 1, 0, N'Feyzi', N'KAZIK', N'05555555555', N'İzmit')
INSERT [dbo].[Kullanici] ([kullaniciID], [kullAdi], [kullSifre], [kullRolID], [kullSirketID], [Ad], [Soyad], [TelNo], [Adres]) VALUES (25, N'halil', N'halils', 2, 2, N'Halil', N'ALAN', N'05555555556', N'Manisa')
INSERT [dbo].[Kullanici] ([kullaniciID], [kullAdi], [kullSifre], [kullRolID], [kullSirketID], [Ad], [Soyad], [TelNo], [Adres]) VALUES (26, N'yahya', N'yahyas', 3, 4, N'Yahya', N'Öztürk', N'05555555557', N'Kayseri')
INSERT [dbo].[Kullanici] ([kullaniciID], [kullAdi], [kullSifre], [kullRolID], [kullSirketID], [Ad], [Soyad], [TelNo], [Adres]) VALUES (27, N'yeni', N'yenis', 4, 2, N'YeniAd', N'YeniSoyad', N'05555555558', N'İst')
INSERT [dbo].[Kullanici] ([kullaniciID], [kullAdi], [kullSifre], [kullRolID], [kullSirketID], [Ad], [Soyad], [TelNo], [Adres]) VALUES (36, N'mus1', N'mussoyad1', 4, 2, N'Mus1', N'MusSoyad1', N'05555555559', N'MusAdres1')
INSERT [dbo].[Kullanici] ([kullaniciID], [kullAdi], [kullSifre], [kullRolID], [kullSirketID], [Ad], [Soyad], [TelNo], [Adres]) VALUES (37, N'mus2', N'mussoyad2', 4, 4, N'Mus2', N'MusSoyad2', N'05555555550', N'MusAdres2')
SET IDENTITY_INSERT [dbo].[Kullanici] OFF
SET IDENTITY_INSERT [dbo].[Rol] ON 

INSERT [dbo].[Rol] ([rolID], [rolAdi]) VALUES (1, N'Admin')
INSERT [dbo].[Rol] ([rolID], [rolAdi]) VALUES (2, N'Yönetici')
INSERT [dbo].[Rol] ([rolID], [rolAdi]) VALUES (3, N'Çalışan')
INSERT [dbo].[Rol] ([rolID], [rolAdi]) VALUES (4, N'Müşteri')
SET IDENTITY_INSERT [dbo].[Rol] OFF
SET IDENTITY_INSERT [dbo].[Sirket] ON 

INSERT [dbo].[Sirket] ([sirketID], [sirketAdi], [sirketSehir], [sirketAdres], [sirketAracSayisi], [sirketPuani]) VALUES (1, N'A HOLDİNG', N'İSTANBUL', N'MERKEZ', 4, 100)
INSERT [dbo].[Sirket] ([sirketID], [sirketAdi], [sirketSehir], [sirketAdres], [sirketAracSayisi], [sirketPuani]) VALUES (2, N'B HOLDİNG', N'MANİSA', N'MERKEZ', 5, 150)
INSERT [dbo].[Sirket] ([sirketID], [sirketAdi], [sirketSehir], [sirketAdres], [sirketAracSayisi], [sirketPuani]) VALUES (4, N'C HOLDİNG', N'İZMİR', N'MERKEZ', 1, 231)
INSERT [dbo].[Sirket] ([sirketID], [sirketAdi], [sirketSehir], [sirketAdres], [sirketAracSayisi], [sirketPuani]) VALUES (11, N'D HOLDİNG', N'BURSA', N'MERKEZ', 20, 41)
SET IDENTITY_INSERT [dbo].[Sirket] OFF
ALTER TABLE [dbo].[Kullanici] ADD  CONSTRAINT [DF_Kullanici_kullSirketID]  DEFAULT ((0)) FOR [kullSirketID]
GO
ALTER TABLE [dbo].[Arac]  WITH CHECK ADD  CONSTRAINT [FK_Arac_Sirket] FOREIGN KEY([aitOlduguSirketID])
REFERENCES [dbo].[Sirket] ([sirketID])
GO
ALTER TABLE [dbo].[Arac] CHECK CONSTRAINT [FK_Arac_Sirket]
GO
ALTER TABLE [dbo].[Kiralik]  WITH CHECK ADD  CONSTRAINT [FK_Kiralik_Arac] FOREIGN KEY([kiralananAracID])
REFERENCES [dbo].[Arac] ([aracID])
GO
ALTER TABLE [dbo].[Kiralik] CHECK CONSTRAINT [FK_Kiralik_Arac]
GO
ALTER TABLE [dbo].[Kiralik]  WITH CHECK ADD  CONSTRAINT [FK_Kiralik_Kullanici] FOREIGN KEY([kiralayanKulID])
REFERENCES [dbo].[Kullanici] ([kullaniciID])
GO
ALTER TABLE [dbo].[Kiralik] CHECK CONSTRAINT [FK_Kiralik_Kullanici]
GO
ALTER TABLE [dbo].[Kullanici]  WITH CHECK ADD  CONSTRAINT [FK_Kullanici_Rol] FOREIGN KEY([kullRolID])
REFERENCES [dbo].[Rol] ([rolID])
GO
ALTER TABLE [dbo].[Kullanici] CHECK CONSTRAINT [FK_Kullanici_Rol]
GO
USE [master]
GO
ALTER DATABASE [dbAnadoluRental] SET  READ_WRITE 
GO
