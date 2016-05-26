using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace ServiceDataBase
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select Service1.svc or Service1.svc.cs at the Solution Explorer and start debugging.
    public class Service1 : IService1
    {
        #region Atributos
        //Declaramos las variables comando y conexion
        private SqlCommand comando = new SqlCommand();
        private SqlConnection conexion = new SqlConnection();
        private string connection_string = ConfigurationManager.ConnectionStrings["Chat2"].ConnectionString;
        private SqlTransaction transaccion;
        //Clave maestra que protege las claves privadas de los certificados
        private string masterKey = "jli,gr4526+";
        private string nombreCertificado = "CertificadoAES256";
        private string nombreClaveSimetrica = "ClaveSimetricaAES256";
        //Para generar el GUID de la clave 
        private string identityValue = "Artin–Zorn";
        //Para generar la clave actual
        private string keySource = "hsgh45w6.p{|";
        #endregion

        #region Conexión BD
        //Conectarme a la base de datos
        public void Conectar()
        {
            conexion.ConnectionString = connection_string;
            comando.Connection = conexion;
            conexion.Open();
        }

        //Desconectarme de la base de datos
        public void Desconectar()
        {
            conexion.Close();
            conexion.Dispose();
        }
        #endregion

        #region Autenticación de usuario
        //Autenticar a un usuario que desea ingresar al chat        
        public int usuarioCorrecto(string nombre, string password)
        {
            Desconectar();
            Conectar();
            int resultado = 0;
            string query = "SELECT 1 FROM usuario WHERE nombre=@nombre AND " +
                "(HASHBYTES('SHA2_512', @password) = (SELECT pass FROM usuario WHERE nombre=@nombre))"; 
            comando = new SqlCommand(query, conexion);
            comando.Parameters.Clear();
            comando.Parameters.AddWithValue("@nombre", nombre);
            comando.Parameters.AddWithValue("@password", password);
            SqlDataReader dr = comando.ExecuteReader();
            if (dr.Read())
            {
                resultado = 1;
            }
            return resultado;
        }
        #endregion

        #region Retorno de datos
        //Recuperar id de un usuario
        public int devolverIdUsuario(string nombre, string password)
        {
            Desconectar();
            Conectar();
            int resultado = 0;
            string query = "SELECT idUsuario FROM usuario WHERE nombre=@nombre AND " +
                "(HASHBYTES('SHA2_512', @password) = (SELECT pass FROM usuario WHERE nombre=@nombre))";
            comando = new SqlCommand(query, conexion);
            comando.Parameters.Clear();
            comando.Parameters.AddWithValue("@nombre", nombre);
            comando.Parameters.AddWithValue("@password", password);
            SqlDataReader dr = comando.ExecuteReader();
            if (dr.Read())
            {
                resultado = dr.GetInt32(0);
            }
            return resultado;
        }
        #endregion

        #region Comparación de datos
        //Corroborar si un nombre de usuario existe en la base de datos
        public bool compararNombre(string nombreUsuario)
        {
            Desconectar();
            Conectar();
            string query = "SELECT 1 FROM usuario WHERE nombre=@nombreUsuario";
            comando = new SqlCommand(query, conexion);
            comando.Parameters.Clear();
            comando.Parameters.AddWithValue("@nombreUsuario", nombreUsuario);
            SqlDataReader dr = comando.ExecuteReader();
            if (dr.Read())
            {
                return true;
            }
            return false;
        }
        #endregion

        #region Alta de usuarios
        //Insertar un nuevo usuario en la base de datos
        public bool insertarUsuario(string nombreUsuario, string password)
        {
            Desconectar();
            Conectar();
            string query = "INSERT INTO usuario (nombre, pass, logueado) values (@nombreUsuario, HASHBYTES ('SHA2_512', @password), 0)";
            comando = new SqlCommand(query, conexion);
            comando.Parameters.Clear();
            comando.Parameters.AddWithValue("@nombreUsuario", nombreUsuario);
            comando.Parameters.AddWithValue("@password", password);
            int resultado = comando.ExecuteNonQuery();
            if (resultado == 1)
            {
                return true;
            }
            return false;
        }
        #endregion

        #region Insertar mensaje
        public void insertarMensaje(int idUsuarioOrigen, int idUsuarioDestino, string mensaje)
        {
            Desconectar();
            Conectar();
            abrirClaveSimetrica();
            transaccion = conexion.BeginTransaction();
            comando.Transaction=transaccion;
            try
            {
                string query = "INSERT INTO mensaje(hora,entregado,esPrivado,esGrupal,esGeneral,detalleMensaje) values " +
                               "(getdate(), null, null, null, null,(EncryptByKey(Key_GUID('ClaveSimetricaAES256'), @Mensaje)));" +
                               "Select @@identity";
                comando = new SqlCommand(query, conexion,transaccion);
                comando.Parameters.Clear();
                comando.Parameters.AddWithValue("@Mensaje", mensaje);
                int idMensaje = Convert.ToInt32(comando.ExecuteScalar());

                string query2 = "INSERT INTO mesaje_x_usuario(idUsuario,idMensaje) values (@idUsuarioOrigen, @idMensaje)";
                comando = new SqlCommand(query2, conexion,transaccion);
                comando.Parameters.Clear();
                comando.Parameters.AddWithValue("@idUsuarioOrigen", idUsuarioOrigen);
                comando.Parameters.AddWithValue("@idMensaje", idMensaje);
                comando.ExecuteNonQuery();

                string query3 = "INSERT INTO mesaje_x_usuario(idUsuario,idMensaje) values (@idUsuarioDestino, @idMensaje)";
                comando = new SqlCommand(query3, conexion,transaccion);
                comando.Parameters.Clear();
                comando.Parameters.AddWithValue("@idUsuarioDestino", idUsuarioDestino);
                comando.Parameters.AddWithValue("@idMensaje", idMensaje);
                comando.ExecuteNonQuery();

                transaccion.Commit();

            }
            catch (Exception e)
            {
                transaccion.Rollback();
                throw e;
            }
            finally {
                Desconectar();
            }
        }
        #endregion

        #region
        //Abrir la clave simétrica para cifrar los datos
        private bool abrirClaveSimetrica()
        {
            Desconectar();
            Conectar();
            string query = "OPEN SYMMETRIC KEY ClaveSimetricaAES256 " +
                "DECRYPTION BY CERTIFICATE CertificadoAES256";
            comando = new SqlCommand(query, conexion);
            int resultado = comando.ExecuteNonQuery();
            if (resultado == 1)
            {
                return true;
            }
            return false;
        }
        #endregion

    }
}
