import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/proyecto.dart';
import 'package:somosproperties/providers/proyectos_provider.dart';

class ProyEditDialog extends StatefulWidget {
  final Proyecto? proyecto;
  const ProyEditDialog({Key? key, this.proyecto}) : super(key: key);

  @override
  State<ProyEditDialog> createState() => _ProyEditDialogState();
}

class _ProyEditDialogState extends State<ProyEditDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.proyecto?.uid != null) {
      Provider.of<ProyectosProvider>(context, listen: false).proy =
          widget.proyecto!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final proyectosProvider = Provider.of<ProyectosProvider>(context);
    return Container(
      width: 380,
      height: 600,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.proyecto?.nombre ?? '',
              decoration: customInputDecoration(label: 'Nombre del proyecto'),
              onChanged: (value) => proyectosProvider.proy.nombre = value,
            ),
            TextFormField(
              initialValue: widget.proyecto?.direccion ?? '',
              decoration:
                  customInputDecoration(label: 'Dirección del proyecto'),
              onChanged: (value) => proyectosProvider.proy.direccion = value,
            ),
            TextFormField(
              initialValue: widget.proyecto?.ciudadPais ?? '',
              decoration: customInputDecoration(label: 'Ciudad / País'),
              onChanged: (value) => proyectosProvider.proy.ciudadPais = value,
            ),
            TextFormField(
              initialValue: widget.proyecto?.descripcion ?? '',
              maxLines: 3,
              decoration: customInputDecoration(label: 'Descripción'),
              onChanged: (value) => proyectosProvider.proy.descripcion = value,
            ),
            TextFormField(
              initialValue: widget.proyecto?.amenidades ?? '',
              maxLines: 3,
              decoration: customInputDecoration(label: 'Amenidades'),
              onChanged: (value) => proyectosProvider.proy.amenidades = value,
            ),
            TextFormField(
              initialValue: widget.proyecto?.video ?? '',
              maxLines: 3,
              decoration: customInputDecoration(label: 'Video'),
              onChanged: (value) => proyectosProvider.proy.video = value,
            ),
            TextFormField(
              initialValue: widget.proyecto?.brochure ?? '',
              maxLines: 3,
              decoration: customInputDecoration(label: 'Brochure'),
              onChanged: (value) => proyectosProvider.proy.brochure = value,
            ),
            SizedBox(
              height: kDefaultPadding * 2,
            ),
            Text('Ubicación'),
            SizedBox(
              height: kDefaultPadding,
            ),
            Wrap(
              children: [
                Container(
                  width: 160,
                  child: TextFormField(
                    initialValue: widget.proyecto?.lat ?? '',
                    decoration: customInputDecoration(label: 'Latitud'),
                    onChanged: (value) =>
                        proyectosProvider.proy.ciudadPais = value,
                  ),
                ),
                SizedBox(
                  width: kDefaultPadding,
                ),
                Container(
                  width: 160,
                  child: TextFormField(
                    initialValue: widget.proyecto?.lon ?? '',
                    decoration: customInputDecoration(label: 'Logintud'),
                    onChanged: (value) =>
                        proyectosProvider.proy.ciudadPais = value,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: kDefaultPadding * 2,
            ),
            Text('Amenidades'),
            SizedBox(
              height: kDefaultPadding,
            ),
            // SWITCHBUTTON

            Wrap(
              runSpacing: kDefaultPadding / 2,
              spacing: kDefaultPadding / 2,
              children: [
                ToggleButtons(
                    selectedColor: Colors.white,
                    fillColor: kPrimaryColor,
                    direction: Axis.vertical,
                    onPressed: (index) => setState(() {
                          proyectosProvider.proy.estac =
                              !proyectosProvider.proy.estac;
                        }),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: Text('Estacionamientos'),
                      ),
                    ],
                    isSelected: [
                      proyectosProvider.proy.estac
                    ]),
                ToggleButtons(
                    selectedColor: Colors.white,
                    fillColor: kPrimaryColor,
                    direction: Axis.vertical,
                    onPressed: (index) => setState(() {
                          proyectosProvider.proy.roomParty =
                              !proyectosProvider.proy.roomParty;
                        }),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: Text('Salón de fiestas'),
                      ),
                    ],
                    isSelected: [
                      proyectosProvider.proy.roomParty
                    ]),
                ToggleButtons(
                    selectedColor: Colors.white,
                    fillColor: kPrimaryColor,
                    direction: Axis.vertical,
                    onPressed: (index) => setState(() {
                          proyectosProvider.proy.gym =
                              !proyectosProvider.proy.gym;
                        }),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: Text('Gimnasio'),
                      ),
                    ],
                    isSelected: [
                      proyectosProvider.proy.gym
                    ]),
                ToggleButtons(
                    selectedColor: Colors.white,
                    fillColor: kPrimaryColor,
                    direction: Axis.vertical,
                    onPressed: (index) => setState(() {
                          proyectosProvider.proy.roomPlay =
                              !proyectosProvider.proy.roomPlay;
                        }),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: Text('Salón de juegos'),
                      ),
                    ],
                    isSelected: [
                      proyectosProvider.proy.roomPlay
                    ]),
                ToggleButtons(
                    selectedColor: Colors.white,
                    fillColor: kPrimaryColor,
                    direction: Axis.vertical,
                    onPressed: (index) => setState(() {
                          proyectosProvider.proy.parque =
                              !proyectosProvider.proy.parque;
                        }),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: Text('Parque'),
                      ),
                    ],
                    isSelected: [
                      proyectosProvider.proy.parque
                    ]),
                ToggleButtons(
                    selectedColor: Colors.white,
                    fillColor: kPrimaryColor,
                    direction: Axis.vertical,
                    onPressed: (index) => setState(() {
                          proyectosProvider.proy.tenis =
                              !proyectosProvider.proy.tenis;
                        }),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: Text('Cancha de tennis'),
                      ),
                    ],
                    isSelected: [
                      proyectosProvider.proy.tenis
                    ]),
                ToggleButtons(
                    selectedColor: Colors.white,
                    fillColor: kPrimaryColor,
                    direction: Axis.vertical,
                    onPressed: (index) => setState(() {
                          proyectosProvider.proy.squash =
                              !proyectosProvider.proy.squash;
                        }),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: Text('Cancha de squash'),
                      ),
                    ],
                    isSelected: [
                      proyectosProvider.proy.squash
                    ]),
                ToggleButtons(
                    selectedColor: Colors.white,
                    fillColor: kPrimaryColor,
                    direction: Axis.vertical,
                    onPressed: (index) => setState(() {
                          proyectosProvider.proy.raquetball =
                              !proyectosProvider.proy.raquetball;
                        }),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: Text('Cancha de Raquetball'),
                      ),
                    ],
                    isSelected: [
                      proyectosProvider.proy.raquetball
                    ]),
                ToggleButtons(
                    selectedColor: Colors.white,
                    fillColor: kPrimaryColor,
                    direction: Axis.vertical,
                    onPressed: (index) => setState(() {
                          proyectosProvider.proy.futbol =
                              !proyectosProvider.proy.futbol;
                        }),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: Text('Cancha de futbol'),
                      ),
                    ],
                    isSelected: [
                      proyectosProvider.proy.futbol
                    ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration customInputDecoration({required String label}) {
  return InputDecoration(label: Text(label));
}
