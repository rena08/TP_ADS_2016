using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.SignalR;
using System.Web.Services;

namespace SignalRPruebaChat.Fomrularios
{
    public partial class Sala : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }

        [WebMethod]
        public static int devolverIdUsuario(string nombre, string password)
        {
            AccesoADatos acceso = new AccesoADatos();
            return acceso.devolverIdUsuario(nombre, password);
        }


        [WebMethod]
        public static List<Usuario> traerDatosUsuario()
        {
            int i = ConexionSignalR.listaUsuarios.Count;
            return ConexionSignalR.listaUsuarios;
        }

 
    }
}