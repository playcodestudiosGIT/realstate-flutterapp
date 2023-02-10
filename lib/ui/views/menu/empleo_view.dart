import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:somosproperties/constants.dart';
import 'package:somosproperties/providers/empleo_form_provider.dart';
import 'package:somosproperties/services/notification_service.dart';
import 'package:somosproperties/ui/buttons/custom_outlined_button.dart';
import 'package:somosproperties/ui/inputs/custom_inputs.dart';

import 'package:somosproperties/ui/labels/custom_labels.dart';
import 'package:somosproperties/ui/cards/white_card.dart';

class EmpleoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final empleoFormProvider = Provider.of<EmpleoFormProvider>(context);
    final isSending = Provider.of<EmpleoFormProvider>(context).isSending;
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
                      Text(
                        'EMPLEO',
                        style: CustomLabels.h1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Text(
                        'Te gustaría trabajar con nosotros?, envíanos tu hoja de vida y nuestro equipo se pondrá en contacto contigo.',
                        style: CustomLabels.h3ColorBlack87,
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Text(
                        'Asegúrate de llenar tus datos correctamente y adjuntar tu hoja de vida en formato PDF con peso menor a 4MB',
                        style: CustomLabels.h3ColorBlack87,
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Container(
                        child: Form(
                            key: empleoFormProvider.empleoKey,
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
                                          {empleoFormProvider.nombre = value},
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
                                      onChanged: (value) =>
                                          {empleoFormProvider.telfono = value},
                                      validator: (value) {
                                        if (value == null || value.isEmpty)
                                          return 'El nombre es obligatario';
                                        return null;
                                      },
                                      style: TextStyle(color: kPrimaryColor),
                                      decoration:
                                          CustomInputs.loginInputDecoration(
                                              hint:
                                                  'Ingrese su numero telefónico',
                                              label: 'Teléfono',
                                              icon: Icons.phone),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding,
                                    ),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (!EmailValidator.validate(
                                            value ?? ''))
                                          return 'Email no válido';

                                        return null;
                                      },
                                      onChanged: (value) =>
                                          {empleoFormProvider.correo = value},
                                      style: TextStyle(color: kPrimaryColor),
                                      decoration:
                                          CustomInputs.loginInputDecoration(
                                              hint: 'Ingrese su correo',
                                              label: 'Email',
                                              icon: Icons.email),
                                    ),
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(400, 65)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    kPrimaryColor)),
                                        onPressed: () async {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles(
                                            type: FileType.any,
                                          );

                                          if (result != null) {
                                            PlatformFile file =
                                                result.files.first;

                                            if (file.size > 4000000) {
                                              return NotificationService
                                                  .showSnackbarError(
                                                      msg:
                                                          'El tamaño maximo debe ser 4MB',
                                                      color: Colors.red);
                                            }

                                            if (file.extension != 'pdf')
                                              return NotificationService
                                                  .showSnackbarError(
                                                      msg:
                                                          'La extension debe ser PDF',
                                                      color: Colors.red);

                                            empleoFormProvider.fileName =
                                                file.name;
                                            empleoFormProvider.fileSize =
                                                file.size.toString();
                                            empleoFormProvider.file =
                                                file.bytes!;
                                            empleoFormProvider.notify();
                                          } else {
                                            // User canceled the picker
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, bottom: 8, right: 8),
                                          child: Row(
                                            children: [
                                              Icon(Icons.upload_file),
                                              SizedBox(
                                                width: kDefaultPadding / 2,
                                              ),
                                              Container(
                                                width: 240,
                                                child: Text(
                                                  (empleoFormProvider
                                                              .fileName !=
                                                          '')
                                                      ? empleoFormProvider
                                                          .fileName
                                                      : 'Adjuntar CV',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: (empleoFormProvider
                                                              .fileName !=
                                                          '')
                                                      ? CustomLabels
                                                          .h2ColorPrimary
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.green)
                                                      : CustomLabels
                                                          .h2ColorPrimary
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              if (empleoFormProvider.fileName !=
                                                  '')
                                                IconButton(
                                                    onPressed: () {
                                                      empleoFormProvider
                                                          .resetFileName();
                                                    },
                                                    icon: Icon(
                                                      Icons.clear,
                                                      color: Colors.red,
                                                    )),
                                            ],
                                          ),
                                        )),
                                    SizedBox(height: 20),
                                    Container(
                                        width: 115,
                                        child: ElevatedButton(
                                          child:
                                              (empleoFormProvider.isSending ==
                                                      SendingStatus.sending)
                                                  ? Text('ENVIANDO')
                                                  : Text('ENVIAR'),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      kSecondaryColor)),
                                          onPressed: () async {
                                            await empleoFormProvider
                                                .validateForm();
                                            empleoFormProvider
                                                .empleoKey.currentState!
                                                .reset();
                                            empleoFormProvider.fileName = '';
                                          },
                                        )),
                                    SizedBox(height: 20),
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
