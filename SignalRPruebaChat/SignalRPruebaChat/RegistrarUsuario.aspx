<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrarUsuario.aspx.cs" Inherits="SignalRPruebaChat.RegistrarUsuario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <!--Título de pestaña-->
    <title>Registrar Usuario</title>

    <!--CDN de Bootstrap-->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous" />

    <!--CDN de Bootstrap-->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous" />

    <!--Latest compiled and minified JavaScript-->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"> </script>
    <script src="Scripts/jquery-1.10.2.intellisense.js"></script>
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/jquery.validate.min.js"></script>
    <script src="Scripts/strength.min.js"></script>
    <script src="Scripts/jquery.tooltipster.min.js"></script>
    <script src="Scripts/jquery.signalR-2.2.0.js"></script>
    <script src="Scripts/jquery.signalR-2.2.0.min.js"></script>
    <script src="/signalr/hubs"></script>

    <!--CSS-->
    <!--Se modificaron valores y clases de strength.css para ajustar el idioma y la dimensión del medidor de robustez-->
    <link href="CSS/strength.css" rel="stylesheet" />
    <link href="CSS/tooltipster.css" rel="stylesheet" />
    <link href="CSS/tooltipster-shadow.css" rel="stylesheet" />

    <script type="text/javascript">
                
        $().ready(function () {

            //Validación de los campos necesarios para realizar el alta del usuario utilizando el plugin jquery.validate.min.js
            $("#frmRegistrarUsuario").validate({
                rules: {
                    txtNombreUsuario: "required",
                    txtPassword: {
                        required: true,
                        minlength: 2
                    },
                    txtConfirmarPassword: {
                        required: true,
                        minlength: 2,
                        equalTo: "#txtPassword"
                    }               
                },
                messages: {
                    txtNombreUsuario: "Ingrese un nombre de usuario",
                    txtPassword: {
                        required: "Ingrese una contraseña",
                        minlength: "La contraseña debe tener más de 2 caracteres"
                    },
                    txtConfirmarPassword: {
                        required: "Ingrese una contraseña",
                        minlength: "La contraseña debe tener más de 2 caracteres",
                        equalTo: "Las contraseñas deben coincidir"
                    }
                }
            })

            //Validación de la robustez de la contraseña utilizando el plugin strength.min.js
            $("#txtPassword").strength({
                strengthClass: 'strength',
                strengthMeterClass: 'strength_meter',
                strengthButtonClass: 'button_strength',
                strengthButtonText: 'Mostrar contraseña',
                strengthButtonTextToggle: 'Ocultar contraseña'
            })

            //Tooltip de características necesarias para la password
            $("#imgInfoPassword").tooltipster({
                theme: 'tooltipster-shadow'
            })
            
        });
        
    </script>
</head>
<body>
    <!--Formulario de registro de usuario-->
    <form id="frmRegistrarUsuario" runat="server">
        <br />
        <div class="col-xs-3 col-xs-offset-4">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <!--Título-->
                    <h3 class="panel-title text-center text-primary">Registrar Usuario</h3>
                </div>
                <div class="panel-body">
                    <!--Nombre Usuario-->
                    <asp:Label ID="lblNombreUsuario" runat="server" Text="Nombre usuario:"></asp:Label>
                    <input id="txtNombreUsuario" type="text" runat="server" class="form-control" />
                    <br />
                    <br />
                    <!--Contraseña-->
                    <asp:Label ID="lblPassword" runat="server" Text="Contraseña: "></asp:Label>
                    <img id="imgInfoPassword" src="img/icon_interrogation.png" cssclass="tooltip" runat="server" 
                        title="Se recomiendan 8 caracterés, 1 minúscula, 1 mayúscula y 1 número, como mínimo" /> 
                    <input id="txtPassword" type="password" runat="server" class="form-control" />
                    <br />
                    <br />
                    <!--Confirmar contraseña-->
                    <asp:Label ID="lblConfirmarPassword" runat="server" Text="Confirmar contraseña: "></asp:Label>
                    <input id="txtConfirmarPassword" type="password" runat="server" class="form-control" />
                    <br />
                    <br />
                    <!--Confirmar-->
                    <div class="col-xs-offset-4">
                        <asp:Button ID="btnLogin" runat="server" Text="Confirmar" CssClass="btn-primary" OnClick="btnLogin_Click" />                        
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
