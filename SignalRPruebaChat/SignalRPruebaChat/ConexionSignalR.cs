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

        static AccesoADatos acceso = new AccesoADatos();
        static List<Usuario> listaUsuarios = new List<Usuario>();
        static List<Mensaje> listaMensajes = new List<Mensaje>();

        #endregion

        #region Métodos


        public void conectar(string nombreUsuario, string password)
        {
            if ((listaUsuarios.Count(x => x.ConexionID == Context.ConnectionId) == 0))
            {
                //Agrego un usuario a la lista deconectados
                Usuario usuario = new Usuario();
                usuario.ConexionID = Context.ConnectionId;
                usuario.UserName = nombreUsuario;
                usuario.Password = password;
                listaUsuarios.Add(usuario);

                //Se define que el usuario que entro se conectó
                Clients.Caller.onConnected(Context.ConnectionId, nombreUsuario, listaUsuarios, listaMensajes);
                
                // Envio a todos los usuario que me conecté pero no ami!
                Clients.AllExcept(Context.ConnectionId).onNewUserConnected(Context.ConnectionId, nombreUsuario);

            }
        }

        public void envioDeMensaje(string usuarioDestino, string mensaje)
        {
            string usuarioOrigen = Context.ConnectionId;

            Usuario destino = listaUsuarios.FirstOrDefault(x => x.ConexionID == usuarioDestino);
            Usuario origen = listaUsuarios.FirstOrDefault(x => x.ConexionID == usuarioOrigen);

            if (origen != null && destino != null)
            {
                // Envio de mensaje al destino
                Clients.Client(usuarioDestino).sendPrivateMessage(usuarioOrigen, origen.UserName,mensaje);

                // send to caller user
                Clients.Caller.sendPrivateMessage(usuarioDestino, origen.UserName, mensaje);
            }

        }

        #endregion

    }
}