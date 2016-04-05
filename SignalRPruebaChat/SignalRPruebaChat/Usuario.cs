using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SignalRPruebaChat
{
    public class Usuario
    {
        private string userName, conexionID, grupo,password;

        public string ConexionID
        {
            get
            {
                return conexionID;
            }

            set
            {
                conexionID = value;
            }
        }

        public string Grupo
        {
            get
            {
                return grupo;
            }

            set
            {
                grupo = value;
            }
        }

        public string Password
        {
            get
            {
                return password;
            }

            set
            {
                password = value;
            }
        }

        public string UserName
        {
            get
            {
                return userName;
            }

            set
            {
                userName = value;
            }
        }
    }
}