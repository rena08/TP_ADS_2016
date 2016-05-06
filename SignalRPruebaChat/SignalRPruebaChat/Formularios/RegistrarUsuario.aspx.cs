using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SignalRPruebaChat
{
    public partial class RegistrarUsuario : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region Alta usuario
        //Registrar un nuevo usuario  
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            ServiceReference1.Service1Client objServiceClientobjService = new ServiceReference1.Service1Client();
            bool existe = objServiceClientobjService.compararNombre(txtNombreUsuario.Value);
            if (existe == false)
            {
                bool insert = objServiceClientobjService.insertarUsuario(txtNombreUsuario.Value, txtPassword.Value);
                if (insert == true)
                {
                    TSHAK.Components.SecureQueryString querystring;
                    byte[] b = new byte[] { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5, 8 };
                    querystring = new TSHAK.Components.SecureQueryString(b);
                    querystring["nombre"] = txtNombreUsuario.Value;
                    querystring["password"] = txtPassword.Value;
                    Response.Redirect("Sala.aspx?data=" + HttpUtility.UrlEncode(querystring.ToString()));
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error, no se pudo registrar el usuario')", true);
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error, usuario existente. Ingrese otro nombre de usuario')", true);
            }     
        }
        #endregion
    }
}