import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seo_renderer/seo_renderer.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/providers/contacto_form_provider.dart';
import 'package:somosproperties/ui/inputs/custom_inputs.dart';

import 'package:somosproperties/ui/labels/custom_labels.dart';
import 'package:somosproperties/ui/cards/white_card.dart';

class ContactoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contactoFormProvider = Provider.of<ContactoFormProvider>(context);
    final isSending = Provider.of<ContactoFormProvider>(context).isSending;

    return Container(
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Column(
            children: [
              WhiteCard(
                isDrag: false,
                child: Container(
                  margin: EdgeInsets.all(kDefaultPadding),
                  alignment: Alignment.center,
                  constraints: BoxConstraints(
                      maxWidth: 400,
                      minWidth: 350,
                      maxHeight: 200,
                      minHeight: 200),
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(0)),
                  child: Center(
                      child: Image(
                    image: NetworkImage(
                        'https://res.cloudinary.com/dnejayiiq/image/upload/v1672446892/logo_hnizxp.png'),
                  )),
                ),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              WhiteCard(
                isDrag: false,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(kDefaultPadding),
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextRenderer(
                        style: TextRendererStyle.header1,
                        child: Text(
                          'CONTACTANOS',
                          style: CustomLabels.h1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Text(
                        'Envienos sus comentarios, nuestro equipo se pondrá en contacto con usted.',
                        style: CustomLabels.h3ColorBlack87,
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Container(
                        child: Form(
                            key: contactoFormProvider.contactoKey,
                            child: Container(
                              child: WhiteCard(
                                isDrag: false,
                                child: Column(
                                  children: [
                                    Divider(),
                                    SizedBox(
                                      height: kDefaultPadding,
                                    ),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      onChanged: (value) =>
                                          {contactoFormProvider.nombre = value},
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
                                    SizedBox(
                                      height: kDefaultPadding,
                                    ),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      onFieldSubmitted: (_) => {},
                                      validator: (value) {
                                        if (!EmailValidator.validate(
                                            value ?? ''))
                                          return 'Email no válido';

                                        return null;
                                      },
                                      onChanged: (value) =>
                                          {contactoFormProvider.correo = value},
                                      style: TextStyle(color: kPrimaryColor),
                                      decoration:
                                          CustomInputs.loginInputDecoration(
                                              hint: 'Ingrese su correo',
                                              label: 'Email',
                                              icon: Icons.email),
                                    ),
                                    SizedBox(height: 20),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      maxLines: 5,
                                      style: TextStyle(color: kPrimaryColor),
                                      decoration:
                                          CustomInputs.loginInputDecoration(
                                              hint: 'Mensaje',
                                              label: 'Escriba sus comentarios',
                                              icon: Icons.message),
                                      onChanged: (value) {
                                        contactoFormProvider.mensaje = value;
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                        width: 115,
                                        child: ElevatedButton(
                                          child:
                                              (contactoFormProvider.isSending ==
                                                      SendingStatus.sending)
                                                  ? Text('ENVIANDO')
                                                  : Text('ENVIAR'),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      kSecondaryColor)),
                                          onPressed: () async {
                                            await contactoFormProvider
                                                .validateForm();
                                          },
                                        )),
                                    SizedBox(height: 10),
                                    if (isSending == SendingStatus.sending)
                                      Center(
                                        child: Container(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: kPrimaryColor,
                                            )),
                                      ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
