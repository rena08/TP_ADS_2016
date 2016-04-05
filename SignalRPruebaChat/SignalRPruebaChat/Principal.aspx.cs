using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SignalRPruebaChat
{
    
    public partial class Principal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static int llamador(string nombre, string password)
        {
            AccesoADatos acceso = new AccesoADatos();
            int res = acceso.usuarioCorrecto(nombre, password);
            return res;
        }

    }
}