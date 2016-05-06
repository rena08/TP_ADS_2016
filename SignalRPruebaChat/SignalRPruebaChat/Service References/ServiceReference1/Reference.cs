﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SignalRPruebaChat.ServiceReference1 {
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="ServiceReference1.IService1")]
    public interface IService1 {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/Conectar", ReplyAction="http://tempuri.org/IService1/ConectarResponse")]
        void Conectar();
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/Conectar", ReplyAction="http://tempuri.org/IService1/ConectarResponse")]
        System.Threading.Tasks.Task ConectarAsync();
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/Desconectar", ReplyAction="http://tempuri.org/IService1/DesconectarResponse")]
        void Desconectar();
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/Desconectar", ReplyAction="http://tempuri.org/IService1/DesconectarResponse")]
        System.Threading.Tasks.Task DesconectarAsync();
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/usuarioCorrecto", ReplyAction="http://tempuri.org/IService1/usuarioCorrectoResponse")]
        int usuarioCorrecto(string nombre, string password);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/usuarioCorrecto", ReplyAction="http://tempuri.org/IService1/usuarioCorrectoResponse")]
        System.Threading.Tasks.Task<int> usuarioCorrectoAsync(string nombre, string password);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/devolverIdUsuario", ReplyAction="http://tempuri.org/IService1/devolverIdUsuarioResponse")]
        int devolverIdUsuario(string nombre, string password);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/devolverIdUsuario", ReplyAction="http://tempuri.org/IService1/devolverIdUsuarioResponse")]
        System.Threading.Tasks.Task<int> devolverIdUsuarioAsync(string nombre, string password);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/compararNombre", ReplyAction="http://tempuri.org/IService1/compararNombreResponse")]
        bool compararNombre(string nombreUsuario);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/compararNombre", ReplyAction="http://tempuri.org/IService1/compararNombreResponse")]
        System.Threading.Tasks.Task<bool> compararNombreAsync(string nombreUsuario);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/insertarUsuario", ReplyAction="http://tempuri.org/IService1/insertarUsuarioResponse")]
        bool insertarUsuario(string nombreUsuario, string password);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/insertarUsuario", ReplyAction="http://tempuri.org/IService1/insertarUsuarioResponse")]
        System.Threading.Tasks.Task<bool> insertarUsuarioAsync(string nombreUsuario, string password);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/insertarMensaje", ReplyAction="http://tempuri.org/IService1/insertarMensajeResponse")]
        void insertarMensaje(int idUsuarioOrigen, int idUsuarioDestino, string mensaje);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/insertarMensaje", ReplyAction="http://tempuri.org/IService1/insertarMensajeResponse")]
        System.Threading.Tasks.Task insertarMensajeAsync(int idUsuarioOrigen, int idUsuarioDestino, string mensaje);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IService1Channel : SignalRPruebaChat.ServiceReference1.IService1, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class Service1Client : System.ServiceModel.ClientBase<SignalRPruebaChat.ServiceReference1.IService1>, SignalRPruebaChat.ServiceReference1.IService1 {
        
        public Service1Client() {
        }
        
        public Service1Client(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public Service1Client(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public Service1Client(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public Service1Client(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public void Conectar() {
            base.Channel.Conectar();
        }
        
        public System.Threading.Tasks.Task ConectarAsync() {
            return base.Channel.ConectarAsync();
        }
        
        public void Desconectar() {
            base.Channel.Desconectar();
        }
        
        public System.Threading.Tasks.Task DesconectarAsync() {
            return base.Channel.DesconectarAsync();
        }
        
        public int usuarioCorrecto(string nombre, string password) {
            return base.Channel.usuarioCorrecto(nombre, password);
        }
        
        public System.Threading.Tasks.Task<int> usuarioCorrectoAsync(string nombre, string password) {
            return base.Channel.usuarioCorrectoAsync(nombre, password);
        }
        
        public int devolverIdUsuario(string nombre, string password) {
            return base.Channel.devolverIdUsuario(nombre, password);
        }
        
        public System.Threading.Tasks.Task<int> devolverIdUsuarioAsync(string nombre, string password) {
            return base.Channel.devolverIdUsuarioAsync(nombre, password);
        }
        
        public bool compararNombre(string nombreUsuario) {
            return base.Channel.compararNombre(nombreUsuario);
        }
        
        public System.Threading.Tasks.Task<bool> compararNombreAsync(string nombreUsuario) {
            return base.Channel.compararNombreAsync(nombreUsuario);
        }
        
        public bool insertarUsuario(string nombreUsuario, string password) {
            return base.Channel.insertarUsuario(nombreUsuario, password);
        }
        
        public System.Threading.Tasks.Task<bool> insertarUsuarioAsync(string nombreUsuario, string password) {
            return base.Channel.insertarUsuarioAsync(nombreUsuario, password);
        }
        
        public void insertarMensaje(int idUsuarioOrigen, int idUsuarioDestino, string mensaje) {
            base.Channel.insertarMensaje(idUsuarioOrigen, idUsuarioDestino, mensaje);
        }
        
        public System.Threading.Tasks.Task insertarMensajeAsync(int idUsuarioOrigen, int idUsuarioDestino, string mensaje) {
            return base.Channel.insertarMensajeAsync(idUsuarioOrigen, idUsuarioDestino, mensaje);
        }
    }
}
