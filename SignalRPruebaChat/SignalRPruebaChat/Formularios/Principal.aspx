<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Principal.aspx.cs" Inherits="SignalRPruebaChat.Principal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <!--Título de pestaña-->
    <title>Chat - Inicio de Sesión</title>

    <!--Latest compiled and minified JavaScript-->
    <script src="../jQuery/core/jquery-1.10.2.min.js"></script>
    <script src="../jQuery/plugins/jquery.signalR-2.2.0.min.js"></script>
    <script src="/signalr/hubs"></script>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous" />

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous" />

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

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
                    <!--Confirmar y registrar usuario-->
                    <div class="col-xs-offset-4">
                        <asp:Button ID="btnLogin" runat="server" Text="Iniciar Sesión" CssClass="btn-primary" OnClick="btnLogin_Click" />
                        <br />
                        <br />
                        <asp:Button ID="btnRegisrarUsuario" runat="server" Text="Registrarse" CssClass="btn-primary" OnClick="btnRegisrarUsuario_Click" Width="125px"/>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
