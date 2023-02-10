import 'package:somosproperties/constants.dart';
import 'package:somosproperties/providers/auth_provider.dart';
import 'package:somosproperties/providers/login_form_provider.dart';
import 'package:somosproperties/providers/register_form_provider.dart';
import 'package:somosproperties/services/notification_service.dart';
import 'package:somosproperties/ui/cards/white_card.dart';
import 'package:somosproperties/ui/labels/custom_labels.dart';
import 'package:somosproperties/ui/shared/links_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:somosproperties/router/router.dart';

import 'package:somosproperties/ui/inputs/custom_inputs.dart';
import 'package:somosproperties/ui/buttons/custom_outlined_button.dart';
import 'package:somosproperties/ui/buttons/link_text.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LoginFormProvider(),
        child: Builder(builder: (context) {
          final registerFormProvider =
              Provider.of<RegisterFormProvider>(context, listen: false);

          return Container(
            color: kBgColor,
            margin: EdgeInsets.only(top: kDefaultPadding),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: 370,
                          maxHeight: 756,
                          minWidth: 370,
                          minHeight: 100),
                      child: Column(
                        children: [
                          Form(
                              autovalidateMode: AutovalidateMode.always,
                              key: registerFormProvider.formKey,
                              child: Container(
                                height: 756,
                                child: WhiteCard(
                                  isDrag: false,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(
                                            kDefaultPadding),
                                        color: kPrimaryColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              kDefaultPadding),
                                          child: Image(
                                              image: NetworkImage(
                                                  'https://res.cloudinary.com/dnejayiiq/image/upload/v1672446892/logo_hnizxp.png')),
                                        ),
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: kDefaultPadding,
                                      ),
                                      Text('Crea una nueva cuenta',
                                          style: CustomLabels.h1ColorPrimary),
                                      SizedBox(
                                        height: kDefaultPadding,
                                      ),

                                      // Email
                                      TextFormField(
                                        onChanged: (value) =>
                                            registerFormProvider.name = value,
                                        validator: (value) {
                                          if (value == null || value.isEmpty)
                                            return 'El nombre es obligatario';
                                          return null;
                                        },
                                        style: TextStyle(color: kPrimaryColor),
                                        decoration:
                                            CustomInputs.loginInputDecoration(
                                                hint: 'Ingrese su nombre',
                                                label: 'Nombre',
                                                icon: Icons
                                                    .supervised_user_circle_sharp),
                                      ),

                                      SizedBox(height: 20),

                                      // Email
                                      TextFormField(
                                        onChanged: (value) =>
                                            registerFormProvider.email = value,
                                        validator: (value) {
                                          if (!EmailValidator.validate(
                                              value ?? ''))
                                            return 'Email no válido';
                                          return null;
                                        },
                                        style: TextStyle(color: kPrimaryColor),
                                        decoration:
                                            CustomInputs.loginInputDecoration(
                                                hint: 'Ingrese su correo',
                                                label: 'Email',
                                                icon: Icons.email_outlined),
                                      ),

                                      SizedBox(height: 20),

                                      // Password
                                      TextFormField(
                                        onChanged: (value) =>
                                            registerFormProvider.password =
                                                value,
                                        validator: (value) {
                                          if (value == null || value.isEmpty)
                                            return 'Ingrese su contraseña';
                                          if (value.length < 6)
                                            return 'La contraseña debe de ser de 6 caracteres';

                                          return null; // Válido
                                        },
                                        obscureText: true,
                                        style: TextStyle(color: kPrimaryColor),
                                        decoration:
                                            CustomInputs.loginInputDecoration(
                                                hint: '*********',
                                                label: 'Contraseña',
                                                icon:
                                                    Icons.lock_outline_rounded),
                                      ),

                                      SizedBox(height: 20),
                                      Container(
                                        width: 146,
                                        child: CustomOutlinedButton(
                                          isFilled: true,
                                          color: kSecondaryColor,
                                          icon: Icons.abc,
                                          onPressed: () {
                                            final validForm =
                                                registerFormProvider
                                                    .formKey.currentState!
                                                    .validate();
                                            if (!validForm) {
                                              NotificationService
                                                  .showSnackbarError(
                                                      msg:
                                                          'Formulario no valido',
                                                      color: Colors.red);
                                            }
                                            final authProvider =
                                                Provider.of<AuthProvider>(
                                                    context,
                                                    listen: false);
                                            authProvider.register(
                                                registerFormProvider.name,
                                                registerFormProvider.email,
                                                registerFormProvider.password);
                                          },
                                          text: 'Registrar',
                                        ),
                                      ),

                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Text('Ya tienes una cuenta?',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: kPrimaryColor)),
                                          LinkText(
                                            color: kSecondaryColor,
                                            text: 'Ir al login',
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  Flurorouter.loginRoute);
                                            },
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: kDefaultPadding),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    LinksBar()
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
