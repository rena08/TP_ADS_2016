using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SignalRPruebaChat
{
    public class Mensaje
    {
        private string userName, mensajes, grupo;

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

        public string Mensajes
        {
            get
            {
                return mensajes;
            }

            set
            {
                mensajes = value;
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