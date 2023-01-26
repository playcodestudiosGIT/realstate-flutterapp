import 'package:seo_renderer/seo_renderer.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/providers/auth_provider.dart';
import 'package:somosproperties/providers/login_form_provider.dart';
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

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return ChangeNotifierProvider(
        create: (_) => LoginFormProvider(),
        child: Builder(builder: (context) {
          final loginFormProvider =
              Provider.of<LoginFormProvider>(context, listen: false);

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
                          maxHeight: 700,
                          minWidth: 370,
                          minHeight: 100),
                      child: Column(
                        children: [
                          Form(
                              autovalidateMode: AutovalidateMode.always,
                              key: loginFormProvider.formKey,
                              child: Container(
                                height: 700,
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
                                      TextRenderer(
                                          child: Text(
                                              'Ingresa con tus credenciales',
                                              style:
                                                  CustomLabels.h1ColorPrimary)),
                                      SizedBox(
                                        height: kDefaultPadding,
                                      ),
                                      TextFormField(
                                        onFieldSubmitted: (_) => onFormSubmit(
                                            loginFormProvider, authProvider),
                                        validator: (value) {
                                          if (!EmailValidator.validate(
                                              value ?? ''))
                                            return 'Email no válido';

                                          return null;
                                        },
                                        onChanged: (value) =>
                                            loginFormProvider.email = value,
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
                                        onFieldSubmitted: (_) => onFormSubmit(
                                            loginFormProvider, authProvider),
                                        onChanged: (value) =>
                                            loginFormProvider.password = value,
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
                                          icon: Icons.lock_outline_rounded,
                                        ),
                                      ),

                                      SizedBox(height: 20),

                                      // Container(
                                      //   width: 130,
                                      //   child: CustomOutlinedButton(
                                      //     icon: Icons.abc,
                                      //     color: kSecondaryColor,
                                      //     isFilled: true,
                                      //     onPressed: () => onFormSubmit(loginFormProvider, authProvider),
                                      //     text: ,
                                      //   ),
                                      // ),
                                      ElevatedButton(
                                          child: Text(
                                            'INGRESAR',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          onPressed: () => onFormSubmit(
                                              loginFormProvider, authProvider),
                                          style: ButtonStyle(
                                            side: MaterialStateProperty.all(
                                                BorderSide(
                                                    color: kSecondaryColor)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    kSecondaryColor),
                                          )),
                                      SizedBox(
                                        height: kDefaultPadding,
                                      ),
                                      LinkText(
                                          color: kSecondaryColor,
                                          text: 'Olvide mi contraseña',
                                          onPressed: () {}),
                                      SizedBox(
                                        height: kDefaultPadding,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('No tienes una cuenta?',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: kPrimaryColor)),
                                          LinkText(
                                            color: kSecondaryColor,
                                            text: 'Registrate',
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  Flurorouter.registerRoute);
                                            },
                                          ),
                                        ],
                                      )
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

  void onFormSubmit(
      LoginFormProvider loginFormProvider, AuthProvider authProvider) {
    final isValid = loginFormProvider.validateForm();
    if (isValid)
      authProvider.login(loginFormProvider.email, loginFormProvider.password);
  }
}
