import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/propiedad.dart';
import 'package:somosproperties/models/proyecto.dart';
import 'package:somosproperties/providers/propiedades_provides.dart';
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
  late String descripcion;
  late String banos;
  late String habitaciones;
  late String estacionamientos;
  late String mts2;
  late String sevendeoalquila;
  late String tipopropiedad;
  late String proyecto;
  late int precio;
  late String altura;
  late String? id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.propiedad?.uid;
    if (widget.propiedad != null) {
      Provider.of<PropiedadesProvider>(context, listen: false).prop =
          widget.propiedad!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Proyecto> proyectos =
        Provider.of<ProyectosProvider>(context).proyectos;
    final propiedadesProvider = Provider.of<PropiedadesProvider>(context);
    return Container(
      width: 380,
      height: 600,
      child: Column(
        children: [
          TextFormField(
            initialValue: widget.propiedad?.nombreProp ??
                propiedadesProvider.prop.nombreProp,
            onChanged: (value) => propiedadesProvider.prop.nombreProp = value,
            decoration: InputDecoration(label: Text('Nombre de la Propiedad')),
          ),
          TextFormField(
            initialValue: widget.propiedad?.direccion ??
                propiedadesProvider.prop.direccion,
            onChanged: (value) => propiedadesProvider.prop.direccion = value,
            decoration:
                InputDecoration(label: Text('Dirección de la Propiedad')),
          ),
          TextFormField(
            initialValue: widget.propiedad?.descripcion ??
                propiedadesProvider.prop.descripcion,
            onChanged: (value) => propiedadesProvider.prop.descripcion = value,
            maxLines: 3,
            decoration:
                InputDecoration(label: Text('Descripción de la Propiedad')),
          ),
          TextFormField(
            initialValue:
                widget.propiedad?.detalles ?? propiedadesProvider.prop.detalles,
            onChanged: (value) => propiedadesProvider.prop.detalles = value,
            maxLines: 3,
            decoration:
                InputDecoration(label: Text('Detalles de la Propiedad')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton(
                  value:
                      widget.propiedad?.banos ?? propiedadesProvider.prop.banos,
                  onChanged: (value) {
                    setState(() {
                      this.banos = value.toString();
                      propiedadesProvider.prop.banos = value.toString();
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Baños'),
                      value: '',
                    ),
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
                      value: '5+',
                    ),
                  ],
                ),
                DropdownButton(
                  value: widget.propiedad?.habitaciones ??
                      propiedadesProvider.prop.habitaciones,
                  onChanged: (value) => setState(() {
                    propiedadesProvider.prop.habitaciones = value.toString();
                    this.habitaciones = value.toString();
                  }),
                  items: [
                    DropdownMenuItem(
                      child: Text('Habs'),
                      value: '',
                    ),
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
                      value: '5+',
                    ),
                  ],
                ),
                DropdownButton(
                  value: widget.propiedad?.estacionamientos ??
                      propiedadesProvider.prop.estacionamientos,
                  onChanged: (value) => setState(() {
                    propiedadesProvider.prop.estacionamientos =
                        value.toString();
                    this.estacionamientos = value.toString();
                  }),
                  items: [
                    DropdownMenuItem(
                      child: Text('Estac.'),
                      value: '',
                    ),
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
                      value: '5+',
                    ),
                  ],
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
                    initialValue:
                        widget.propiedad?.mts2 ?? propiedadesProvider.prop.mts2,
                    onChanged: (value) => setState(() {
                      propiedadesProvider.prop.mts2 = value.toString();
                      this.mts2 = value.toString();
                    }),
                    decoration: InputDecoration(label: Text('Mts2')),
                  ),
                ),
                DropdownButton(
                  value: widget.propiedad?.sevendeoalquila ??
                      propiedadesProvider.prop.sevendeoalquila,
                  onChanged: (value) => setState(() {
                    propiedadesProvider.prop.sevendeoalquila = value.toString();
                    this.sevendeoalquila = value.toString();
                  }),
                  items: [
                    DropdownMenuItem(
                      child: Text('Venta'),
                      value: 'Venta',
                    ),
                    DropdownMenuItem(
                      child: Text('Alquiler'),
                      value: 'Alquiler',
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                DropdownButton(
                  value: widget.propiedad?.tipopropiedad ??
                      propiedadesProvider.prop.tipopropiedad,
                  onChanged: (value) => setState(() {
                    propiedadesProvider.prop.tipopropiedad = value.toString();
                    this.tipopropiedad = value.toString();
                  }),
                  items: [
                    DropdownMenuItem(
                      child: Text('Casa'),
                      value: 'Casa',
                    ),
                    DropdownMenuItem(
                      child: Text('Apartamento'),
                      value: 'Apartamento',
                    ),
                    DropdownMenuItem(
                      child: Text('Oficina'),
                      value: 'Oficina',
                    ),
                    DropdownMenuItem(
                      child: Text('Local'),
                      value: 'Local',
                    ),
                    DropdownMenuItem(
                      child: Text('Lote'),
                      value: 'Lote',
                    ),
                  ],
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
                  value: widget.propiedad?.proyecto.uid ??
                      propiedadesProvider.idProyPropNew,
                  onChanged: (value) => setState(() {
                        propiedadesProvider.idProyPropNew = value.toString();
                      }),
                  selectedItemBuilder: (context) {
                    return proyectos.map((proyecto) {
                      return Text(proyecto.nombre);
                    }).toList();
                  },
                  items: [
                    ...proyectos.map<DropdownMenuItem<String>>((proyecto) {
                      return DropdownMenuItem<String>(
                        value: proyecto.uid,
                        child: Text(proyecto.nombre),
                      );
                    }).toList(),
                  ]),
              Container(
                width: 80,
                child: TextFormField(
                  initialValue: widget.propiedad?.precio.toString() ??
                      propiedadesProvider.prop.precio.toString(),
                  onChanged: (value) => setState(() {
                    propiedadesProvider.prop.precio = int.parse(value);
                    this.precio = int.parse(value);
                  }),
                  maxLines: 1,
                  decoration: InputDecoration(label: Text('Precio')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration customInputDecoration() {
    return InputDecoration();
  }
}
