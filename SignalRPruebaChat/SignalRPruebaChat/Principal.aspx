<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Principal.aspx.cs" Inherits="SignalRPruebaChat.Principal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/jquery-1.10.2.intellisense.js"></script>
    <script src="Scripts/jquery.signalR-2.2.0.js"></script>
    <script src="Scripts/jquery.signalR-2.2.0.min.js"></script>
    <script src="signalr/hubs" type="text/javascript"></script>

    <!-- CDN de Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

    <title></title>
    <script type="text/javascript">
        $(function () {
            // Declaro un proxy que hace referencia a el concentrador de mensajes. 
            var concentradorChat = $.connection.chatHub;
            //
            //metodosDelCliente(concentradorChat);
            $.connection.hub.start().done(function () {
                inicioChat(concentradorChat)
            });
        });

        //Ingreso de un usuario a la sala de chat
        function inicioChat(concentradorChat) {
            $("#btnLogin").click(function () {
                //Declaro una variable nombre, con el nombre del usuario
                var nombre = $("#txtNombreUsuario").val();
                //Declaro una variable password, con el password del usuario
                var password = $("#txtPassword").val();
                //Verifico que no sea vacio
                if (nombre.length > 0 && password.length > 0) {
                    //Si no es vacio me conecto al signalR
                    jQuery.ajax({
                        type: 'POST',
                        contentType: 'application/json; charset=utf-8',
                        data: '{nombre:"' + nombre + '",password:"' + password + '"}',
                        dataType: 'json',
                        url: 'Principal.aspx/llamador',
                        success: function (data) {
                            if (data.d == 1) {
                                concentradorChat.server.conectar(nombre, password);
                                window.location = ("Sala.aspx?nombre=" + $("#txtNombreUsuario").val());
                            } else {
                                alert("Usuario no registrado");
                            }
                        }
                    });
                }
                else {
                    alert("Ingresa tu nombre");
                }
            });
        }

        function pasarVariables(pagina, nombres) {
            pagina += "?";
            nomVec = nombres.split(",");
            for (i = 0; i < nomVec.length; i++)
                pagina += nomVec[i] + "=" + escape(eval(nomVec[i])) + "&";
            pagina = pagina.substring(0, pagina.length - 1);
            location.href = pagina;
        }

        function metodosDelCliente(concentradorChat) {
            // Una vez atravezado el login lo conectamos a signal R
            concentradorChat.client.onConnected = function (id, userName, allUsers, messages) {

                //setScreen(true);

                //$('#hdId').val(id);
                //$('#hdUserName').val(userName);
                //$('#spanUser').html(userName);

                // Agregamos usuarios a la otra pagina

                for (i = 0; i < allUsers.length; i++) {

                    AddUser(chatHub, allUsers[i].ConnectionId, allUsers[i].UserName);
                }

                // Add Existing Messages
                for (i = 0; i < messages.length; i++) {

                    AddMessage(messages[i].UserName, messages[i].Message);
                }


            }

            // On New User Connected
            chatHub.client.onNewUserConnected = function (id, name) {
                AddUser(chatHub, id, name);
            }


            // On User Disconnected
            chatHub.client.onUserDisconnected = function (id, userName) {

                $('#' + id).remove();

                var ctrId = 'private_' + id;
                $('#' + ctrId).remove();


                var disc = $('<div class="disconnect">"' + userName + '" logged off.</div>');

                $(disc).hide();
                $('#divusers').prepend(disc);
                $(disc).fadeIn(200).delay(2000).fadeOut(200);

            }

            chatHub.client.messageReceived = function (userName, message) {

                AddMessage(userName, message);
            }


            chatHub.client.sendPrivateMessage = function (windowId, fromUserName, message) {

                var ctrId = 'private_' + windowId;


                if ($('#' + ctrId).length == 0) {

                    createPrivateChatWindow(chatHub, windowId, ctrId, fromUserName);

                }

                $('#' + ctrId).find('#divMessage').append('<div class="message"><span class="userName">' + fromUserName + '</span>: ' + message + '</div>');

                // set scrollbar
                var height = $('#' + ctrId).find('#divMessage')[0].scrollHeight;
                $('#' + ctrId).find('#divMessage').scrollTop(height);

            }

        }

        function agregarUsuario(concentradorChat, id, nombre) {

        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <div class="col-xs-3 col-xs-offset-4">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title text-center text-primary">Inicio de Sesión</h3>
                </div>
                <div class="panel-body">
                    <asp:Label ID="lblNombreUsuario" runat="server" Text="Nombre usuario:"></asp:Label>
                    <input id="txtNombreUsuario" type="text" class="form-control" />
                    <br />
                    <asp:Label ID="lblPassword" runat="server" Text="Contraseña: "></asp:Label>
                    <input id="txtPassword" type="password" class="form-control" />
                    <br />
                    <div class="col-xs-offset-4">
                        <input id="btnLogin" type="button" value="Iniciar Sesión" class="btn-primary" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
