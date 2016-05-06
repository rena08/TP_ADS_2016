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