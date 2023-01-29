import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/propiedad.dart';
import 'package:somosproperties/models/proyecto.dart';
import 'package:somosproperties/providers/proyectos_provider.dart';
import 'package:somosproperties/ui/inputs/custom_inputs.dart';
import 'package:somosproperties/ui/labels/custom_labels.dart';

class PropEditDialog extends StatefulWidget {
  final Propiedad? propiedad;
  const PropEditDialog({Key? key, this.propiedad}) : super(key: key);

  @override
  State<PropEditDialog> createState() => _PropEditDialogState();
}

class _PropEditDialogState extends State<PropEditDialog> {
  late String nombreProp;
  late String direccion;
  late String detalles;
  late String sevendeoalquila;
  late String tipopropiedad;
  late String mts2;
  late String proyecto;
  late String descripcion;
  late String img;
  late String habitaciones;
  late int precio;
  late String banos;
  late String altura;
  late String estacionamientos;
  late List galeria;
  late String? id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nombreProp = widget.propiedad?.nombreProp ?? ''; //
    direccion = widget.propiedad?.direccion ?? ''; //
    detalles = widget.propiedad?.detalles ?? ''; //
    sevendeoalquila = widget.propiedad?.sevendeoalquila ?? 'Venta'; //
    tipopropiedad = widget.propiedad?.tipopropiedad ?? ''; //
    mts2 = widget.propiedad?.mts2 ?? ''; //
    proyecto = widget.propiedad?.proyecto.nombre ?? ''; //
    descripcion = widget.propiedad?.descripcion ?? ''; //
    img = widget.propiedad?.img ??
        'https://res.cloudinary.com/dnejayiiq/image/upload/v1674159080/noavatar_oesi6a.png';
    habitaciones = widget.propiedad?.habitaciones ?? ''; //
    precio = widget.propiedad?.precio ?? 0; //
    banos = widget.propiedad?.banos ?? ''; //
    altura = widget.propiedad?.altura ?? '';
    estacionamientos = widget.propiedad?.estacionamientos ?? ''; //
    galeria = widget.propiedad?.galeria ?? [];
    id = widget.propiedad?.uid;
  }

  @override
  Widget build(BuildContext context) {
    final List<Proyecto> proyectos =
        Provider.of<ProyectosProvider>(context).proyectos;
    return Container(
      width: 380,
      height: 600,
      child: Column(
        children: [
          TextFormField(
            decoration: customInputDecoration(label: 'Nombre de Propiedad'),
          ),
          TextFormField(
            decoration: customInputDecoration(label: 'Dirección de Propiedad'),
          ),
          TextFormField(
            maxLines: 3,
            decoration: customInputDecoration(label: 'Detalles de Propiedad'),
          ),
          TextFormField(
            maxLines: 3,
            decoration:
                customInputDecoration(label: 'Descripción de Propiedad'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton(
                  // isExpanded: true,
                  value: '1',
                  items: [
                    DropdownMenuItem(
                      child: Text('1 Baño'),
                      value: '1',
                    ),
                    DropdownMenuItem(
                      child: Text('2 Baños'),
                      value: '2',
                    ),
                    DropdownMenuItem(
                      child: Text('3 Baños'),
                      value: '3',
                    ),
                    DropdownMenuItem(
                      child: Text('4 Baños'),
                      value: '4',
                    ),
                    DropdownMenuItem(
                      child: Text('5+ Baños'),
                      value: '5',
                    ),
                  ],
                  onChanged: (value) {},
                ),
                DropdownButton(
                  // isExpanded: true,
                  value: '1',
                  items: [
                    DropdownMenuItem(
                      child: Text('1 Hab'),
                      value: '1',
                    ),
                    DropdownMenuItem(
                      child: Text('2 Habs'),
                      value: '2',
                    ),
                    DropdownMenuItem(
                      child: Text('3 Habs'),
                      value: '3',
                    ),
                    DropdownMenuItem(
                      child: Text('4 Habs'),
                      value: '4',
                    ),
                    DropdownMenuItem(
                      child: Text('5+ Habs'),
                      value: '5',
                    ),
                  ],
                  onChanged: (value) {},
                ),
                DropdownButton(
                  // isExpanded: true,
                  value: '1',
                  items: [
                    DropdownMenuItem(
                      child: Text('1 Estac.'),
                      value: '1',
                    ),
                    DropdownMenuItem(
                      child: Text('2 Estac.'),
                      value: '2',
                    ),
                    DropdownMenuItem(
                      child: Text('3 Estac.'),
                      value: '3',
                    ),
                    DropdownMenuItem(
                      child: Text('4 Estac.'),
                      value: '4',
                    ),
                    DropdownMenuItem(
                      child: Text('5+ Estac.'),
                      value: '5',
                    ),
                  ],
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 80,
                  child: TextFormField(
                    decoration: customInputDecoration(label: 'Mts2'),
                  ),
                ),
                DropdownButton(
                  // isExpanded: true,
                  value: '1',
                  items: [
                    DropdownMenuItem(
                      child: Text('Venta'),
                      value: '1',
                    ),
                    DropdownMenuItem(
                      child: Text('Alquiler'),
                      value: '2',
                    ),
                  ],
                  onChanged: (value) {},
                ),
                SizedBox(
                  width: 10,
                ),
                DropdownButton(
                  // isExpanded: true,
                  value: '1',
                  items: [
                    DropdownMenuItem(
                      child: Text('Casa'),
                      value: '1',
                    ),
                    DropdownMenuItem(
                      child: Text('Apartamento'),
                      value: '2',
                    ),
                    DropdownMenuItem(
                      child: Text('Oficina'),
                      value: '3',
                    ),
                    DropdownMenuItem(
                      child: Text('Local'),
                      value: '4',
                    ),
                    DropdownMenuItem(
                      child: Text('Lote'),
                      value: '5',
                    ),
                  ],
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton(
                // isExpanded: true,
                value: proyectos[0].uid,
                onChanged: (value) => setState(() {}),
                selectedItemBuilder: (context) {
                  return proyectos.map((proyecto) {
                    return Text(proyecto.nombre);
                  }).toList();
                },
                items: proyectos.map<DropdownMenuItem<String>>((proyecto) {
                  return DropdownMenuItem<String>(
                    value: proyecto.uid,
                    child: Text(proyecto.nombre),
                  );
                }).toList(),
              ),
              Container(
                width: 80,
                child: TextFormField(
                  maxLines: 1,
                  decoration: customInputDecoration(label: 'Precio'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration customInputDecoration({required String label}) {
    return InputDecoration(label: Text(label));
  }
}
