using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using SignalRPruebaChat;
using System.Web.Services;
using System.Web.Script.Services;

namespace SignalRPruebaChat
{
    [HubName("chatHub")]
    public class ConexionSignalR : Hub
    {
        #region Atributos
        ServiceReference1.Service1Client objServiceClientobjService = new ServiceReference1.Service1Client();
        public static List<Usuario> listaUsuarios = new List<Usuario>();
        public static List<Mensaje> listaMensajes = new List<Mensaje>();
        #endregion

        #region Conexión de usuario
        public void conectar(string nombreUsuario, string password)
        {
            if ((listaUsuarios.Count(x => x.ConexionID == Context.ConnectionId) == 0))
            {
                //Agrego un usuario a la lista deconectados
                Usuario usuario = new Usuario();
                usuario.ConexionID = Context.ConnectionId;
                usuario.UserName = nombreUsuario;
                usuario.Password = password;
                usuario.IdUsuario = objServiceClientobjService.devolverIdUsuario(nombreUsuario, password);
                listaUsuarios.Add(usuario);

                //Se define que el usuario que entro se conectó
                Clients.Caller.onConnected(Context.ConnectionId, nombreUsuario, listaUsuarios, listaMensajes);

                // Envio a todos los usuario que me conecté pero no a mi
                Clients.AllExcept(Context.ConnectionId).onNewUserConnected(Context.ConnectionId, nombreUsuario, listaUsuarios);

            }
        }
        #endregion

        #region Enviar mensaje
        public void envioDeMensaje(string usuarioDestino, string mensaje)
        {
            string usuarioOrigen = Context.ConnectionId;
            Usuario destino = listaUsuarios.FirstOrDefault(x => x.ConexionID == usuarioDestino);
            Usuario origen = listaUsuarios.FirstOrDefault(x => x.ConexionID == usuarioOrigen);
            int idUsuarioDestino = 0;
            int idUsuarioOrigen = 0;
            foreach (Usuario usuario in listaUsuarios)
            {
                if (usuarioDestino == usuario.ConexionID)
                {
                    idUsuarioDestino = usuario.IdUsuario;
                }
                if (usuarioOrigen == usuario.ConexionID)
                {
                    idUsuarioOrigen = usuario.IdUsuario;
                }
            }
            if (origen != null && destino != null)
            {
                //Envío de mensaje al destino
                Clients.Client(usuarioDestino).sendPrivateMessage(usuarioOrigen, origen.UserName, mensaje);
                //Usuario origen
                Clients.Caller.sendPrivateMessage(usuarioDestino, origen.UserName, mensaje);
                //Inserción del mensaje en BD
                objServiceClientobjService.insertarMensaje(idUsuarioOrigen, idUsuarioDestino, mensaje);
            }
        }
        #endregion

    }
}
