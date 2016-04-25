<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Principal.aspx.cs" Inherits="SignalRPruebaChat.Principal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <!--Título de pestaña-->
    <title>Chat - Inicio de Sesión</title>


    <!--CDN de Bootstrap-->
    <link rel="stylesheet" href="Bootstrap/bootstrap.min.css"/>

    <!--CDN de Bootstrap-->
    <link rel="stylesheet" href="Bootstrap/bootstrap-theme.min.css" />


    <!--Latest compiled and minified JavaScript-->
    <script src="Bootstrap/bootstrap.min.js"></script>
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/jquery-1.10.2.intellisense.js"></script>
    <script src="Scripts/jquery.signalR-2.2.0.js"></script>
    <script src="Scripts/jquery.signalR-2.2.0.min.js"></script>
    <script src="signalr/hubs" type="text/javascript"></script>

    <script type="text/javascript">
    </script>

</head>
<body>
    <!--Formulario de inicio de sesión-->
    <form id="frmInicioSesion" runat="server">
        <br />
        <div class="col-xs-3 col-xs-offset-4">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <!--Título-->
                    <h3 class="panel-title text-center text-primary">Inicio de Sesión</h3>
                </div>
                <div class="panel-body">
                    <!--Nombre Usuario-->
                    <asp:Label ID="lblNombreUsuario" runat="server" Text="Nombre usuario:"></asp:Label>
                    <input id="txtNombreUsuario" type="text" runat="server" class="form-control" />
                    <br />
                    <!--Contraseña-->
                    <asp:Label ID="lblPassword" runat="server" Text="Contraseña: "></asp:Label>
                    <input id="txtPassword" type="password" runat="server" class="form-control" /><br />
                    <div class="col-xs-offset-4">
                        <asp:Button ID="btnLogin" runat="server" Text="Iniciar Sesión" CssClass="btn-primary" OnClick="btnLogin_Click" />
                        &nbsp;
                        <asp:Button ID="btnRegisrarUsuario" runat="server" Text="Registrarse" CssClass="btn-primary" OnClick="btnRegisrarUsuario_Click"/>
                    &nbsp;<br />
                    </div>
                    <br />
                        
                    <!--Confirmar y registrar usuario-->
                </div>
            </div>
        </div>
    </form>
</body>
</html>
