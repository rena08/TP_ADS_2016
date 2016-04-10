using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.SignalR;
using System.Web.Services;
using TSHAK;

namespace SignalRPruebaChat.Fomrularios
{
    public partial class Sala : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                byte[] b = new byte[] { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 8 };
                string querystring = Request.QueryString["data"]; 
                TSHAK.Components.SecureQueryString queryStringDesencriptar = new TSHAK.Components.SecureQueryString(b,querystring);
                try
                {
                    string nombre = queryStringDesencriptar["nombre"];
                    string password = queryStringDesencriptar["password"];
                    txtNombreUsuario.Value = nombre;
                    txtPassword.Value = password;
                }
                catch (SystemException ex)
                {
                    throw ex;
                }
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