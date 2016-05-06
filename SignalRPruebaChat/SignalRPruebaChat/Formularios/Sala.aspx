<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sala.aspx.cs" Inherits="SignalRPruebaChat.Fomrularios.Sala" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <!--Título de pestaña-->
    <title>Sala de Chat</title>

    <!-- Latest compiled and minified JavaScript -->
    <script src="../jQuery/core/jquery-1.10.2.min.js"></script>
    <script src="../jQuery/plugins/jquery.signalR-2.2.0.min.js"></script>
    <script src="/signalr/hubs"></script>
    <script src="../jQuery/funcionalidades/signalRClienteJavaScript.js"></script>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous" />

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous" />

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

</head>
<body>
    <!--Sala de chat-->
    <form id="frmSala" runat="server">
        <br />
        <div class="container">
            <div class="row">
                <div class="col-xs-3  col-xs-offset-1" style="float: left; top: 0px; left: 0px;">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <!--Título-->
                            <h3 class="panel-title">BIENVENIDO Sr/a:&nbsp;<asp:Label ID="lblUsuarioReg" runat="server" Text="[usuarioRegistrado]"></asp:Label>
                            </h3>
                            <p class="panel-title">&nbsp;</p>
                            <h3 class="panel-title">Usuarios Conectados</h3>
                        </div>
                        <div class="panel-body">
                            <!--Usuarios conectados-->
                            <asp:ListBox ID="lsbUsuariosConectados" runat="server" CssClass="form-control" Height="180px" Width="232px"></asp:ListBox>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3 col-xs-offset-1"  style="float: right; top: 0px; left: -22px; margin-right: 378px; height: 283px;">
                    <!--Chat individual-->
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">Chat individual: &nbsp;&nbsp;<asp:Label ID="lblUsuarioDestino" runat="server" Text="[usuarAEnviar]"></asp:Label>
                            </h3>
                        </div>
                        <!--Envío de mensajes-->
                        <div class="panel-body">
                            <asp:TextBox ID="txtMensajes" runat="server" Height="119px" Width="235px" TextMode="MultiLine" ReadOnly="True"></asp:TextBox>
                            <br />
                            <br />
                            <asp:TextBox ID="txtMensajeAEnviar" placeholder="Escribe un mensaje aquí" runat="server" Width="147px"></asp:TextBox>
                            &nbsp;&nbsp;&nbsp;<asp:Button ID="btnEnviarMensaje" CssClass="btn-primary" runat="server" Text="Enviar" OnClientClick="return false;"/>
                            &nbsp;&nbsp;&nbsp;
                            <br />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Campos auxiliares-->
        <input id="txtNombreUsuario" type="hidden" runat="server" />
        <input id="txtPassword" type="hidden" runat="server" />
    </form>
</body>
</html>
