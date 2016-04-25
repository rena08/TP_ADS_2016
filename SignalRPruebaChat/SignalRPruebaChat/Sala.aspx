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

            document.getElementById("lblUsuarioReg").innerHTML = txtNombreUsuario.value;

            // Declaro un proxy que hace referencia a el concentrador de mensajes. 
            var concentradorChat = $.connection.chatHub;
            metodosDelCliente(concentradorChat);

            $.connection.hub.start().done(function () {
                inicioChat(concentradorChat)
            });

        })


        function inicioChat(concentradorChat) {
            //var nombre = getUrlVars()['nombre'];
            //var password = getUrlVars()['password'];
            var nombre = txtNombreUsuario.value;
            var password = txtPassword.value;
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


        //Doble click en el list box
        //$(function dobleClickLsb() {
        //    var x;
        //    x = $("#lsbUsuariosConectados");
        //    x.dblclick($(x.options.select()).bind("dblclick", function () {
        //        alert($(this).select().text());
        //        //var name = $("[#lsbUsuariosConectados] option:selected")
        //        //alert(var options = $("");)
        //    }));
            
        //});

        //$(function () {
        //    $("#lsbUsuariosConectados").bind("dblclick", function () {
        //        alert($(this).select.text());
        //    });
        //});


        //Obtener valor de la variable del query string
        //function getUrlVars() {
        //    var vars = [], hash;
        //    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
        //    for (var i = 0; i < hashes.length; i++) {
        //        hash = hashes[i].split('=');
        //        vars.push(hash[0]);
        //        vars[hash[0]] = hash[1];
        //    }
        //    return vars;
        //}

        function metodosDelCliente(concentradorChat) {
            // Una vez atravezado el login lo conectamos a signal R
            concentradorChat.client.onConnected = function (id, userName, allUsers, messages) {
                // Agregamos usuarios 
                var listItems = [];
                var nombreUsuario = txtNombreUsuario.value;
                

                if (allUsers.length > 1) {
                    for (i = 0; i < allUsers.length - 1; i++) {
                        if (nombreUsuario != allUsers[i].UserName) {
                            listItems.push('<option value=' + allUsers[i].IdUsuario + '>' + allUsers[i].UserName + '</option>');
                        }
                        //alert utilizado para verificar que los id's se han cargado correctamente
                        //alert('User name= ' + allUsers[i].UserName + ' , id=' + allUsers[i].IdUsuario );
                        var nombreUsuario = txtNombreUsuario.value;
                        if (nombreUsuario != allUsers[i].UserName) {
                            mensajePrivado(concentradorChat);
                        }
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

                //Agregar todos los mensajes
                for (var i = 0; i < messages.length; i++) {
                    agregarMensaje(messages[i].UserName, messages[i].Message);
                }
            }

            
            // Cuando se agrega un usuario conectado se va a todas las paginas conectadas
            concentradorChat.client.onNewUserConnected = function (id, name, listaUsuarios)
            {
                var listItems = [];
                var sel = document.getElementById("lsbUsuariosConectados");
                var flagExiste = false;

                //Habilita envio de mensaje privado a usuario recien conectado
                var nombreUsuario = txtNombreUsuario.value;
                if (nombreUsuario != name) {
                    mensajePrivado(concentradorChat);
                }

                // Agregamos usuarios conectados
                for (var i = 0; i < sel.length; i++) {
                    //  Aca haces referencia al "option" actual
                    var opt = sel[i];
                    if (name == opt.text) {
                        flagExiste = true;


                    }
                }

                if (flagExiste == false) {
                    listItems.push('<option value=' + listaUsuarios[listaUsuarios.length - 1].IdUsuario + '>' + name + '</option>');
                }

                //Agrega usuario conectado al list box
                $("#<%=lsbUsuariosConectados.ClientID%>").append(listItems.join(''));

            }


            concentradorChat.client.sendPrivateMessage = function (idUsuarioOrigen, fromUserName, message) {

                

                var cont = 0;
                alert("idUsuarioOrigen: " + idUsuarioOrigen);
                alert("Contador: " + cont);
                cont = cont + 1;

                $('#txtMensajes').append(message + "\n");

                //Filtro para que solo se cambie el nombre si no es el mismo usuario
                var nombreUsuario = txtNombreUsuario.value;
                if (fromUserName != nombreUsuario) {
                    document.getElementById('lblUsuarioDestino').innerHTML = fromUserName;
                }

            }

        }


        function mensajePrivado(concentradorChat) {
            $('#lsbUsuariosConectados').dblclick(function () {

                var idUsuarioAEnviar = $("#lsbUsuariosConectados").val();
                var nombreUsuarioAEnviar = $("#lsbUsuariosConectados option:selected").text();
                var nombreUsuario = txtNombreUsuario.value;
                
                if (nombreUsuarioAEnviar != nombreUsuario) {

                    document.getElementById('lblUsuarioDestino').innerHTML = nombreUsuarioAEnviar;

                    enviarMensajePrivado(concentradorChat,idUsuarioAEnviar);
                }
            });
        }

        function enviarMensajePrivado(concentradorChat,idUsuarioAEnviar) {
            // Evento enviar mensaje
            $("#btnEnviarMensaje").click(function () {
                var msg = $("#txtMensajeAEnviar").val();
                if (msg.length > 0) {
                    concentradorChat.server.envioDeMensaje(idUsuarioAEnviar, msg);
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
                            <h3 class="panel-title">BIENVENIDO Sr/a:&nbsp;<asp:Label ID="lblUsuarioReg" runat="server" Text="[usuarioRegistrado]"></asp:Label>
                            </h3>
                            <p class="panel-title">&nbsp;</p>
                            <h3 class="panel-title">Usuarios Conectados</h3>
                        </div>
                        <div class="panel-body">
                            <asp:ListBox ID="lsbUsuariosConectados" runat="server" CssClass="form-control"></asp:ListBox>
                        </div>
                    </div>
                </div>
                <div class="col-xs-3 col-xs-offset-1"  style="float: right; top: 0px; left: 0px; margin-right: 378px;">
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
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="btnEnviarMensaje" CssClass="btn-primary" runat="server" Text="Enviar" OnClientClick="return false;"/>
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
