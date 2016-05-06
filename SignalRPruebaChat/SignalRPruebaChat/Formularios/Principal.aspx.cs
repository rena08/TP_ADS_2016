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

        #region Inicio de sesión
        //Iniciar sesión
        protected void btnLogin_Click(object sender, EventArgs e)
        {            
            if (txtNombreUsuario.Value != "" && txtPassword.Value != "")
            {
                ServiceReference1.Service1Client objServiceClientobjService = new ServiceReference1.Service1Client();
                int res = objServiceClientobjService.usuarioCorrecto(txtNombreUsuario.Value, txtPassword.Value);
                if (res == 1)
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
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Los datos ingresados son incorrectos')", true);
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Ingrese usuario y contraseña')", true);
            }            
        }
        #endregion

        #region Alta de usuario
        //Redirección al registro de usuario
        protected void btnRegisrarUsuario_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarUsuario.aspx");
        }
        #endregion
    }
}