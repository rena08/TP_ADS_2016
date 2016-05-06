using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace ServiceDataBase
{
    
    [ServiceContract]
    public interface IService1
    {

        [OperationContract]
        void Conectar();
        [OperationContract]
        void Desconectar();
        [OperationContract]
        int usuarioCorrecto(string nombre, string password);
        [OperationContract]
        int devolverIdUsuario(string nombre, string password);
        [OperationContract]
        bool compararNombre(string nombreUsuario);
        [OperationContract]
        bool insertarUsuario(string nombreUsuario, string password);
        [OperationContract]
        void insertarMensaje(int idUsuarioOrigen, int idUsuarioDestino,string mensaje);

    }
}
