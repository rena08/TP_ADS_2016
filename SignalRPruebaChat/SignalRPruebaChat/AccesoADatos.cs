using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

namespace SignalRPruebaChat
{
    public class AccesoADatos
    {
        //Declaramos las variables comando y conexion
        private SqlCommand comando = new SqlCommand();
        private SqlConnection conexion = new SqlConnection();
        private string connection_string = ConfigurationManager.ConnectionStrings["Chat"].ConnectionString;

        // Método que me permite conectarme a la base de datos
        public void Conectar()
        {
            conexion.ConnectionString = connection_string;
            comando.Connection = conexion;
            conexion.Open();
        }

        // Método que me permite desconectarme de la base de datos
        public void Desconectar()
        {
            conexion.Close();
            conexion.Dispose();
        }


        // Método que me permite autenticar a un usuario que desea ingresar al chat
        // ARREGLAR ACAAAAAA!
        public int usuarioCorrecto(string nombre, string password)
        {
            Desconectar();
            Conectar();
            int resultado = 0;
            string query = "SELECT 1 FROM usuario WHERE nombre='" + nombre + "' AND PWDCOMPARE( " + password + ", password)= 1";
            comando.Parameters.Clear();
            comando.Parameters.AddWithValue("@nombre", nombre);
            comando = new SqlCommand(query, conexion);
            SqlDataReader dr = comando.ExecuteReader();
            if (dr.Read())
            {
                resultado = 1;
            }
            return resultado;
        }

        public int devolverIdUsuario(string nombre, string password)
        {

            Desconectar();
            Conectar();
            int resultado = 0;
            string query = "SELECT idUsuario FROM usuario WHERE nombre='" + nombre + "' AND PWDCOMPARE( " + password + ", password)= 1";
            comando.Parameters.Clear();
            comando.Parameters.AddWithValue("@nombre", nombre);
            comando = new SqlCommand(query, conexion);
            SqlDataReader dr = comando.ExecuteReader();
            if (dr.Read())
            {
                resultado = dr.GetInt32(0);
            }
            return resultado;
        }
    }
}