<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sala.aspx.cs" Inherits="SignalRPruebaChat.Fomrularios.Sala" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sala de Chat</title>

    <!-- CDN de Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous" />

    <!-- CDN de Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous" />

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"> </script>
    <script src="Scripts/jquery-1.10.2.intellisense.js"></script>
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/jquery.signalR-2.2.0.js"></script>
    <script src="Scripts/jquery.signalR-2.2.0.min.js"></script>
    <script src="/signalr/hubs"></script>

    <script type="text/javascript">
        $(function () {
            // Declaro un proxy que hace referencia a el concentrador de mensajes. 
            var concentradorChat = $.connection.chatHub;


            metodosDelCliente(concentradorChat);

            $.connection.hub.start().done(function () {
                inicioChat(concentradorChat)
            });

        })


        function inicioChat(concentradorChat) {
            var nombre = getUrlVars()['nombre'];
            var password = getUrlVars()['password'];
            concentradorChat.server.conectar(nombre, password);
            var opt = document.createElement("option");
            document.getElementById("lsbUsuariosConectados").options.add(opt);
            opt.text = nombre;
            jQuery.ajax({
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{nombre:"' + nombre + '",password:"' + password + '"}',
                dataType: 'json',
                url: 'Sala.aspx/devolverIdUsuario',
                success: function (data) {
                    opt.value = data.d;
                }
            });
        }

        //Obtener valor de la variable del query string
        function getUrlVars() {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        }

        function metodosDelCliente(concentradorChat) {
            // Una vez atravezado el login lo conectamos a signal R
            concentradorChat.client.onConnected = function (id, userName, allUsers, messages) {
                // Agregamos usuarios 
                var listItems = [];
                if (allUsers.length > 1) {
                    for (i = 0; i < allUsers.length - 1; i++) {
                        listItems.push('<option value=' + allUsers[i].IdUsuario + '>' + allUsers[i].UserName + '</option>');
                    }

                    //Borrar duplicados en lista de usuarios conectados
                        var arraySinDuplicados = [];
                        $.each(listItems, function(i, elem){
                        if($.inArray(elem, arraySinDuplicados) === -1) arraySinDuplicados.push(elem);
                        });

                    $("#<%=lsbUsuariosConectados.ClientID%>").append(arraySinDuplicados.join(''));
                    //$("#<%=lsbUsuariosConectados.ClientID%>").append(listItems.join(''));
                   
                    //AddUser(chatHub, allUsers[i].ConnectionId, allUsers[i].UserName);
                }
            }

            // Cuando se agrega un usuario conectado se va a todas las paginas conectadas
            concentradorChat.client.onNewUserConnected = function (id, name, listaUsuarios) {
                var listItems = [];
                // Agregamos usuarios conectados
                listItems.push('<option value=' + listaUsuarios[listaUsuarios.length - 1].IdUsuario + '>' + name + '</option>');
                //alert(listaUsuarios[listaUsuarios.length - 1].IdUsuario);

                $("#<%=lsbUsuariosConectados.ClientID%>").append(listItems.join(''));
            }

            //Cuando el usuario envia un mensaje privado
            concentradorChat.client.sendPrivateMessage = function (windowId, fromUserName, message) {
                mensajePrivado(concentradorChat);
            }

            //Cuando el usuario recibe un nuevo mensaje
            concentradorChat.client.messageReceived = function (userName, message) {
                agregarMensaje(userName, message);
            }

        }

        function agregarMensaje(userName, message) {
            alert("Mensaje recibido: " + message + "de: " + userName);
            $("#txtMensajes").append(message);
            //var height = $('#txtMensajes')[0].scrollHeight;
            //$('#txtMensajes').scrollTop(height);
        }

        function mensajePrivado(concentradorChat) {

            $('#lsbUsuariosConectados').dblclick(function () {

                var idUsuarioAEnviar = $("#lsbUsuariosConectados").val();
                var nombreUsuarioAEnviar = $("#lsbUsuariosConectados option:selected").text();

                var nombreUsuario = getUrlVars()['nombre'];

                if (nombreUsuarioAEnviar != nombreUsuario) {
                    crearVentanaChat(concentradorChat, nombreUsuario, idUsuarioAEnviar, nombreUsuarioAEnviar)
                }

            });
        }

        function crearVentanaChat(concentradorChat, nombreUsuario, idUsuarioEnviar, nombreUsuarioEnviar) {

            document.getElementById('lblUsuarioDestino').innerHTML = nombreUsuarioEnviar;

            // Evento enviar mensaje
            $("#btnEnviarMensaje").click(function () {

                $textBox = $("#txtMensajeAEnviar");
                var msg = $textBox.val();
                if (msg.length > 0) {

                    concentradorChat.server.envioDeMensaje(idUsuarioEnviar, msg);

                    $textBox.val('');
                } else {
                    alert("Escribir mensaje a enviar");
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
                <div class="col-xs-3  col-xs-offset-1" style="float: left">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">Usuarios Conectados</h3>
                        </div>
                        <div class="panel-body">
                            <asp:ListBox ID="lsbUsuariosConectados" runat="server" CssClass="form-control"></asp:ListBox>
                        </div>
                    </div>
                </div>

                <div id="divChatIndividual" class="col-xs-8" style="float: right; top: 0px; left: 2px;">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">Chat individual con:&nbsp;&nbsp;<asp:Label ID="lblUsuarioDestino" CssClass="h4" runat="server" Text="[usuarioDestino]" Width="142px"></asp:Label>
                            </h3>
                        </div>
                        <div class="panel-body">
                            <asp:TextBox ID="txtMensajes" runat="server" Height="119px" Width="200px"></asp:TextBox>
                            <br />
                            <br />
                            <asp:TextBox ID="txtMensajeAEnviar" runat="server" Width="200px"></asp:TextBox>
                            &nbsp;<asp:Button ID="btnEnviarMensaje" CssClass="btn" runat="server" Text="Enviar" OnClientClick="return false;"/>
                            &nbsp;&nbsp;
                            <br />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
