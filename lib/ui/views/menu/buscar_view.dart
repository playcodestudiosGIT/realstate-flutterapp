import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/propiedad.dart';
import 'package:somosproperties/providers/busqueda_provider.dart';
import 'package:somosproperties/providers/propiedades_provides.dart';
import 'package:somosproperties/providers/proyectos_provider.dart';
import 'package:somosproperties/ui/cards/propiedad_card.dart';
import 'package:somosproperties/ui/labels/custom_labels.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class BuscarView extends StatefulWidget {
  const BuscarView({Key? key}) : super(key: key);
  @override
  State<BuscarView> createState() => _BuscarViewState();
}

class _BuscarViewState extends State<BuscarView> {
  @override
  void initState() {
    Provider.of<PropiedadesProvider>(context, listen: false).getPropiedades();
    Provider.of<ProyectosProvider>(context, listen: false).getProyectos();
    Provider.of<BusquedasProvider>(context, listen: false).getSearchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final busquedasProvider = Provider.of<BusquedasProvider>(context);
    final List<Propiedad> lista = busquedasProvider.lista;
    final size = MediaQuery.of(context).size;
    final destrct = lista.map((e) {
      return PropiedadCard(
        propiedad: e,
      );
    }).toList();

    return Container(
        child: Scaffold(
      body: Stack(children: [
        ListView(
          physics: ClampingScrollPhysics(),
          children: [
            SizedBox(height: 80),
            if (busquedasProvider.isOpen)
              SizedBox(
                height: kDefaultPadding * 3,
              ),
            if (size.width <= 492)
              SizedBox(
                height: kDefaultPadding,
              ),
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding * 2),
              child: Text(
                'Busqueda por: "${busquedasProvider.query}"',
                style: (size.width < 450)
                    ? CustomLabels.h2ColorPrimary
                    : CustomLabels.h1,
              ),
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            Container(
              child: Wrap(
                  alignment: WrapAlignment.center,
                  children: (destrct.length == 0)
                      ? [
                          Text(
                            'No hay resultados',
                            style: CustomLabels.h2ColorPrimary,
                          )
                        ]
                      : [...destrct]),
            ),
          ],
        ),
        Positioned(child: SearchFilterBar()),
      ]),
    ));
  }
}

class SearchFilterBar extends StatefulWidget {
  @override
  State<SearchFilterBar> createState() => _SearchFilterBarState();
}

class _SearchFilterBarState extends State<SearchFilterBar> {
  late String value;
  @override
  void initState() {
    value = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final busquedasProvider = Provider.of<BusquedasProvider>(context);
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(color: kPrimaryColor, boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 10)
          ]),
          height: 50,
          child: Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.2),
                    ),
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextFormField(
                        initialValue: value,
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) async {
                          busquedasProvider.setQuery(value);
                          busquedasProvider.searchProp();
                        },
                        decoration: InputDecoration(
                          hintText: 'Buscar palabra',
                          hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontWeight: FontWeight.w300),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          labelStyle: TextStyle(color: Colors.white),
                          icon: Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 8),
                            child: Icon(
                              Icons.search,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                    )),
                if (size.width > 380)
                  IconButton(
                      onPressed: () {
                        busquedasProvider.setAll();
                        busquedasProvider.searchProp();
                      },
                      icon: Icon(
                        Icons.restore,
                        color: Colors.white,
                      )),
                Spacer(),
                IconButton(
                    onPressed: () {
                      busquedasProvider.setIsOpen();
                    },
                    icon: Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: kDefaultPadding,
                )
              ],
            ),
          ),
        ),
        if (busquedasProvider.isOpen)
          Column(
            children: [
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: kPrimaryColor, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2), blurRadius: 10)
                  ]),
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Wrap(
                    spacing: 0,
                    runSpacing: -15,
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      Container(
                        child: DropdownButton(
                            dropdownColor: kPrimaryColor,
                            value: busquedasProvider.comer,
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.house_siding,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            underline: Container(color: Colors.transparent),
                            iconEnabledColor: kSecondaryColor,
                            items: [
                              DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    (size.width < 380) ? '' : 'Alquilar?',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                value: '',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  'Comprar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: 'venta',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  'Alquilar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: 'alquiler',
                              )
                            ],
                            onChanged: (value) {
                              busquedasProvider.setComer(value.toString());
                              busquedasProvider.searchProp();
                            }),
                      ),
                      Container(
                        child: DropdownButton(
                            dropdownColor: kPrimaryColor,
                            value: busquedasProvider.tipo,
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(Icons.business_outlined,
                                  color: Colors.white, size: 20),
                            ),
                            underline: Container(color: Colors.transparent),
                            iconEnabledColor: kSecondaryColor,
                            items: [
                              DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    (size.width < 380) ? '' : 'Tipo',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                value: '',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  'Casa',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: 'casa',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  'Apto.',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: 'apartamento',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  'Oficina',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: 'oficina',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  'Local',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: 'local',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  'Lote',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: 'lote',
                              ),
                            ],
                            onChanged: (value) {
                              busquedasProvider.setTipo(value.toString());
                              busquedasProvider.searchProp();
                            }),
                      ),
                      Container(
                        child: DropdownButton(
                            dropdownColor: kPrimaryColor,
                            value: busquedasProvider.hab,
                            icon: Icon(Icons.bed_rounded,
                                color: Colors.white, size: 20),
                            underline: Container(color: Colors.transparent),
                            iconEnabledColor: kSecondaryColor,
                            items: [
                              DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    (size.width < 380) ? '' : 'Hab',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                value: '',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '1 Hab',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '1',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '2 Hab',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '2',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '3 Hab',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '3',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '4 Hab',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '4',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '5+ Hab',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '5+',
                              ),
                            ],
                            onChanged: (value) {
                              busquedasProvider.setHab(value.toString());
                              busquedasProvider.searchProp();
                            }),
                      ),
                      Container(
                        child: DropdownButton(
                            dropdownColor: kPrimaryColor,
                            value: busquedasProvider.banos,
                            icon: Icon(Icons.bathtub_outlined,
                                color: Colors.white, size: 20),
                            underline: Container(color: Colors.transparent),
                            iconEnabledColor: kSecondaryColor,
                            items: [
                              DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    (size.width < 380) ? '' : 'Baños',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                value: '',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '1 Baño',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '1',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '2 Baños',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '2',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '3 Baños',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '3',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '4 Baños',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '4',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '5+ Baños',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '5+',
                              ),
                            ],
                            onChanged: (value) {
                              busquedasProvider.setBanos(value.toString());
                              busquedasProvider.searchProp();
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: kDefaultPadding),
                        child: DropdownButton(
                            dropdownColor: kPrimaryColor,
                            value: busquedasProvider.precio,
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(Icons.attach_money_outlined,
                                  color: Colors.white, size: 20),
                            ),
                            underline: Container(color: Colors.transparent),
                            iconEnabledColor: kSecondaryColor,
                            items: [
                              DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    (size.width < 380) ? '' : 'Precio',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                value: '5000000',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '< 50k',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '50000',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '< 100 k',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '100000',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '< 150 k',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '150000',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '< 200 k',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '200000',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '< 300 k',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '300000',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '< 400 k',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '400000',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '400 k +',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '4000000',
                              ),
                            ],
                            onChanged: (value) {
                              busquedasProvider.setPrecio(value.toString());
                              busquedasProvider.searchProp();
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: kDefaultPadding),
                        child: DropdownButton(
                            dropdownColor: kPrimaryColor,
                            value: busquedasProvider.mts2,
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                FontAwesomeIcons.ruler,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            underline: Container(color: Colors.transparent),
                            iconEnabledColor: kSecondaryColor,
                            items: [
                              DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    (size.width < 380) ? '' : 'Mts2',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                value: '5000',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '< 50 mts2',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '50',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '< 100 mts2',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '100',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '< 150 mts2',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '150',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '< 200 mts2',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '200',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '< 300 mts2',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '300',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '< 400 mts2',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '400',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  '+400 mts2',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                value: '4000',
                              ),
                            ],
                            onChanged: (value) {
                              busquedasProvider.setMts2(value.toString());
                              busquedasProvider.searchProp();
                            }),
                      ),
                    ],
                  )),
            ],
          )
      ],
    );
  }
}
