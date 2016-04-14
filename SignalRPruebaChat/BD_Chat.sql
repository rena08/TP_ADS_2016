USE [master]
GO
/****** Object:  Database [Chat]    Script Date: 04/14/2016 10:50:55 ******/
CREATE DATABASE [Chat] ON  PRIMARY 
( NAME = N'Chat', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\Chat.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Chat_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\Chat_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Chat] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Chat].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Chat] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [Chat] SET ANSI_NULLS OFF
GO
ALTER DATABASE [Chat] SET ANSI_PADDING OFF
GO
ALTER DATABASE [Chat] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [Chat] SET ARITHABORT OFF
GO
ALTER DATABASE [Chat] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [Chat] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [Chat] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [Chat] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [Chat] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [Chat] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [Chat] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [Chat] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [Chat] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [Chat] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [Chat] SET  DISABLE_BROKER
GO
ALTER DATABASE [Chat] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [Chat] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [Chat] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [Chat] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [Chat] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [Chat] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [Chat] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [Chat] SET  READ_WRITE
GO
ALTER DATABASE [Chat] SET RECOVERY SIMPLE
GO
ALTER DATABASE [Chat] SET  MULTI_USER
GO
ALTER DATABASE [Chat] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [Chat] SET DB_CHAINING OFF
GO
USE [Chat]
GO
/****** Object:  Table [dbo].[mensaje]    Script Date: 04/14/2016 10:50:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[mensaje](
	[idMensaje] [int] IDENTITY(1,1) NOT NULL,
	[detalleMensaje] [varchar](8000) NULL,
	[hora] [datetime] NULL,
	[entregado] [bit] NULL,
	[esPrivado] [bit] NULL,
	[esGrupal] [bit] NULL,
	[esGeneral] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idMensaje] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 04/14/2016 10:50:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[usuario](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NULL,
	[pass] [varbinary](2000) NULL,
	[logueado] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[usuario] ON
INSERT [dbo].[usuario] ([idUsuario], [nombre], [pass], [logueado]) VALUES (3, N'Rena', 0x202CB962AC59075B964B07152D234B70, 0)
INSERT [dbo].[usuario] ([idUsuario], [nombre], [pass], [logueado]) VALUES (4, N'Mati', 0x202CB962AC59075B964B07152D234B70, 0)
INSERT [dbo].[usuario] ([idUsuario], [nombre], [pass], [logueado]) VALUES (5, N'Pedro', 0x202CB962AC59075B964B07152D234B70, 0)
INSERT [dbo].[usuario] ([idUsuario], [nombre], [pass], [logueado]) VALUES (6, N'Juan', 0x202CB962AC59075B964B07152D234B70, 0)
INSERT [dbo].[usuario] ([idUsuario], [nombre], [pass], [logueado]) VALUES (7, N'Agu', 0x202CB962AC59075B964B07152D234B70, 0)
INSERT [dbo].[usuario] ([idUsuario], [nombre], [pass], [logueado]) VALUES (8, N'Santi', 0x202CB962AC59075B964B07152D234B70, 0)
INSERT [dbo].[usuario] ([idUsuario], [nombre], [pass], [logueado]) VALUES (9, N'Rena', 0x0100E21C1F03D26DDCB806CD6F89740C4765AB7A0F27AC9940C5, 0)
INSERT [dbo].[usuario] ([idUsuario], [nombre], [pass], [logueado]) VALUES (10, N'Juan', 0x01003AFDE0F222B02BB05D642511DCDC39D546603CA5B3A56425, 0)
INSERT [dbo].[usuario] ([idUsuario], [nombre], [pass], [logueado]) VALUES (11, N'Agu', 0x0100AA4719EB15B4C156E89DD252E71839F4D6B9713D1BD520F5, 0)
INSERT [dbo].[usuario] ([idUsuario], [nombre], [pass], [logueado]) VALUES (12, N'Mati', 0x0100FE22E1579838F9F34D1E4CDE8E9100190820B2D43E9E5680, 0)
INSERT [dbo].[usuario] ([idUsuario], [nombre], [pass], [logueado]) VALUES (13, N'Pedro', 0x0100666E5D8D123E2D7A68FD9789739FB08B999A94FD75549598, 0)
INSERT [dbo].[usuario] ([idUsuario], [nombre], [pass], [logueado]) VALUES (14, N'Santi', 0x0100E63AE540C933D918A4FB3E98F25133F37032BD58F31549FC, 0)
SET IDENTITY_INSERT [dbo].[usuario] OFF
/****** Object:  Table [dbo].[mesaje_x_usuario]    Script Date: 04/14/2016 10:50:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mesaje_x_usuario](
	[idUsuario] [int] NULL,
	[idMensaje] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_idMensaje]    Script Date: 04/14/2016 10:50:56 ******/
ALTER TABLE [dbo].[mesaje_x_usuario]  WITH CHECK ADD  CONSTRAINT [FK_idMensaje] FOREIGN KEY([idMensaje])
REFERENCES [dbo].[mensaje] ([idMensaje])
GO
ALTER TABLE [dbo].[mesaje_x_usuario] CHECK CONSTRAINT [FK_idMensaje]
GO
/****** Object:  ForeignKey [FK_idUsuario]    Script Date: 04/14/2016 10:50:56 ******/
ALTER TABLE [dbo].[mesaje_x_usuario]  WITH CHECK ADD  CONSTRAINT [FK_idUsuario] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[mesaje_x_usuario] CHECK CONSTRAINT [FK_idUsuario]
GO
