﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sala.aspx.cs" Inherits="SignalRPruebaChat.Fomrularios.Sala" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sala de Chat</title>

    <!--CDN de Bootstrap-->
    <link rel="stylesheet" href="Bootstrap/bootstrap.min.css"/>

    <!--CDN de Bootstrap-->
    <link rel="stylesheet" href="Bootstrap/bootstrap-theme.min.css" />

    <!-- Latest compiled and minified JavaScript -->
    <script src="Bootstrap/bootstrap.min.js"></script>
    <script src="Scripts/jquery-1.10.2.intellisense.js"></script>
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/jquery.signalR-2.2.0.js"></script>
    <script src="Scripts/jquery.signalR-2.2.0.min.js"></script>
    <script src="/signalr/hubs"></script>

    <script type="text/javascript">

        $(function () {

            document.getElementById("lblUsuarioReg").innerHTML = txtNombreUsuario.value;

            // Declaro un proxy que hace referencia a el concentrador de mensajes. 
            var concentradorChat = $.connection.chatHub;
            metodosDelCliente(concentradorChat);

            $.connection.hub.start().done(function () {
                inicioChat(concentradorChat)
            });

        })

        function inicioChat(concentradorChat) {

            var nombre = txtNombreUsuario.value;
            var password = txtPassword.value;
            concentradorChat.server.conectar(nombre, password);
            
            //var opt = document.createElement("option");
            //document.getElementById("lsbUsuariosConectados").options.add(opt);
            //opt.text = nombre;
            //jQuery.ajax({
            //    type: 'POST',
            //    contentType: 'application/json; charset=utf-8',
            //    data: '{nombre:"' + nombre + '",password:"' + password + '"}',
            //    dataType: 'json',
            //    url: 'Sala.aspx/devolverIdUsuario',
            //    success: function (data) {
            //        opt.value = data.d;
            //    }
            //});
        }

        function metodosDelCliente(concentradorChat) {
            // Una vez atravezado el login lo conectamos a signal R
            concentradorChat.client.onConnected = function (id, userName, allUsers, messages) {
                // Agregamos usuarios 
                var listItems = [];
                var nombreUsuario = txtNombreUsuario.value;
                
                for (i = 0; i < allUsers.length; i++) {
                        listItems.push('<option value=' + allUsers[i].ConexionID + '>' + allUsers[i].UserName + '</option>');
                        mensajePrivado(concentradorChat, allUsers[i].ConexionID, allUsers[i].UserName);
                }

                $("#<%=lsbUsuariosConectados.ClientID%>").append(listItems.join(''));

                //Agregar todos los mensajes
                //for (var i = 0; i < messages.length; i++) {
                //    agregarMensaje(messages[i].UserName, messages[i].Message);
                //}
            }

            
            // Cuando se agrega un usuario conectado se va a todas las paginas conectadas
            concentradorChat.client.onNewUserConnected = function (id, name, listaUsuarios)
            {
                var listItems = [];
                var nombreUsuario = txtNombreUsuario.value;
                listItems.push('<option value=' + id + '>' + name + '</option>');
                
                if (nombreUsuario != name) {
                mensajePrivado(concentradorChat, id, name);
                }

                //Agrega usuario conectado al list box
                $("#<%=lsbUsuariosConectados.ClientID%>").append(listItems.join(''));

            }

            // Cuando un usuario se desconecta
            concentradorChat.client.onUserDisconnected = function (id, userName) {

            }

            //Envio de mensajes entre usuarios
            concentradorChat.client.sendPrivateMessage = function (idUsuarioOrigen, fromUserName, message) {

               
               $('#txtMensajes').append(fromUserName + ": " + message + "\n");

                //Filtro para que solo se cambie el nombre si no es el mismo usuario
                var nombreUsuario = txtNombreUsuario.value;
                if (fromUserName != nombreUsuario) {
                    document.getElementById('lblUsuarioDestino').innerHTML = fromUserName;
                }
            }

        }

        function mensajePrivado(concentradorChat, id, name) {

            $('#lsbUsuariosConectados').dblclick(function () {

                var idUsuarioAEnviar = $("#lsbUsuariosConectados option:selected").val();
                var nombreUsuarioAEnviar = $("#lsbUsuariosConectados option:selected").text();
                var usuarioLogueado = txtNombreUsuario.value;

                if (nombreUsuarioAEnviar != usuarioLogueado && id == idUsuarioAEnviar) {
                    document.getElementById('lblUsuarioDestino').innerHTML = nombreUsuarioAEnviar;

                    $("#btnEnviarMensaje").click(function () {
                        var msg = $("#txtMensajeAEnviar").val();
                        var idUsuarioAEnviar = $("#lsbUsuariosConectados option:selected").val();
                        if (idUsuarioAEnviar == id) {
                            if (msg.length > 0) {
                                concentradorChat.server.envioDeMensaje(idUsuarioAEnviar, msg);
                                $("#txtMensajeAEnviar").val("");
                            }
                        }
                    });
                }
            });
        }
        

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <br />
        <div class="container">
            <div class="row">
                <div class="col-xs-3  col-xs-offset-1" style="float: left; top: 0px; left: 0px;">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">BIENVENIDO Sr/a:&nbsp;<asp:Label ID="lblUsuarioReg" runat="server" Text="[usuarioRegistrado]"></asp:Label>
                            </h3>
                            <p class="panel-title">&nbsp;</p>
                            <h3 class="panel-title">Usuarios Conectados</h3>
                        </div>
                        <div class="panel-body">
                            <asp:ListBox ID="lsbUsuariosConectados" runat="server" CssClass="form-control" Height="180px" Width="232px"></asp:ListBox>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3 col-xs-offset-1"  style="float: right; top: 0px; left: -22px; margin-right: 378px; height: 283px;">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">Chat individual: &nbsp;&nbsp;<asp:Label ID="lblUsuarioDestino" runat="server" Text="[usuarAEnviar]"></asp:Label>
                            </h3>
                        </div>
                        <div class="panel-body">
                            <asp:TextBox ID="txtMensajes" runat="server" Height="119px" Width="235px" TextMode="MultiLine"></asp:TextBox>
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
        <input id="txtNombreUsuario" type="hidden" runat="server" />
        <input id="txtPassword" type="hidden" runat="server" />
    </form>
</body>
</html>
