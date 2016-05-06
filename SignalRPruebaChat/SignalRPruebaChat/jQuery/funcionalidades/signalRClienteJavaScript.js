$(function () {
    // Declaro un proxy que hace referencia a el concentrador de mensajes. 
    var concentradorChat = $.connection.chatHub;
    metodosDelCliente(concentradorChat);
    $.connection.hub.start().done(function () {
        inicioChat(concentradorChat)
    });
})

function inicioChat(concentradorChat) {
    var nombre = $("#txtNombreUsuario").val();
    var password = $("#txtPassword").val();
    concentradorChat.server.conectar(nombre, password);
    $("#lblUsuarioReg").html(nombre);
    $("#lblUsuarioDestino").html("");
}

function metodosDelCliente(concentradorChat) {

    //Una vez atravezado el login lo conectamos a signalR
    concentradorChat.client.onConnected = function (id, userName, allUsers, messages) {
        //Agregamos usuarios 
        var listItems = [];
        var nombreUsuario = $("#txtNombreUsuario").val();
        for (i = 0; i < allUsers.length; i++) {
            if (nombreUsuario != allUsers[i].UserName) {
                listItems.push('<option value=' + allUsers[i].ConexionID + '>' + allUsers[i].UserName + '</option>');
                mensajePrivado(concentradorChat, allUsers[i].ConexionID, allUsers[i].UserName);
            }            
        }
        $('[id$="lsbUsuariosConectados"]').append(listItems.join(''));
    }

    //onNewUserConnected
    //Cuando se agrega un usuario conectado se va a todas las paginas conectadas
    concentradorChat.client.onNewUserConnected = function (id, name, listaUsuarios) {
        var listItems = [];
        var nombreUsuario = $("#txtNombreUsuario").val();
        listItems.push('<option value=' + id + '>' + name + '</option>');
        if (nombreUsuario != name) {
            mensajePrivado(concentradorChat, id, name);
        }
        //Agrega usuario conectado al list box
        $('[id$="lsbUsuariosConectados"]').append(listItems.join(''));
    }

    //onUserDisconnected
    // Cuando un usuario se desconecta
    concentradorChat.client.onUserDisconnected = function (id, userName) {

    }

    //sendPrivateMessage
    //Envio de mensajes entre usuarios
    concentradorChat.client.sendPrivateMessage = function (idUsuarioOrigen, fromUserName, message) {
        $('#txtMensajes').append(fromUserName + ": " + message + "\n");
        //Filtro para que solo se cambie el nombre si no es el mismo usuario
        var nombreUsuario = $("#txtNombreUsuario").val();
        if (fromUserName != nombreUsuario) {
            $("#lblUsuarioDestino").html(fromUserName);
        }
    }

}

function mensajePrivado(concentradorChat, id, name) {
    $('#lsbUsuariosConectados').dblclick(function () {
        var idUsuarioAEnviar = $("#lsbUsuariosConectados option:selected").val();
        var nombreUsuarioAEnviar = $("#lsbUsuariosConectados option:selected").text();
        var usuarioLogueado = $("#txtNombreUsuario").val();
        if (nombreUsuarioAEnviar != usuarioLogueado && id == idUsuarioAEnviar) {
            $("#lblUsuarioDestino").html(nombreUsuarioAEnviar);
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