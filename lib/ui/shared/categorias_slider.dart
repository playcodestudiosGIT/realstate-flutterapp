import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/categories.dart';
import 'package:somosproperties/ui/cards/categories_card.dart';
import 'package:flutter/material.dart';

class CategoriasSlider extends StatelessWidget {
  final List<Categoria> categorias;
  const CategoriasSlider(
      {Key? key, required this.categorias})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categorias
                  .map<Widget>(
                    (item) => Padding(
                      padding: EdgeInsets.only(right: kDefaultPadding, top: 0),
                      child: CategoriesCard(
                        query: item.name!.toLowerCase(),
                        recommendation: item,
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
