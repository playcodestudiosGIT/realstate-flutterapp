import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/categories.dart';
import 'package:somosproperties/router/router.dart';
import 'package:somosproperties/services/navigation_service.dart';
import 'package:somosproperties/ui/buttons/custom_outlined_button.dart';
import 'package:flutter/material.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({
    Key? key,
    required this.recommendation,
    required this.query,
  }) : super(key: key);
  final Categoria recommendation;
  final String query;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          
        },
        child: CustomOutlinedButton(
          icon: Icons.abc,
          onPressed: () {
            NavigationService.navigateTo('${Flurorouter.buscarRoute}/$query');
          },
          text: recommendation.name!,
          color: kPrimaryColor,
          isFilled: false,
        ));
  }
}
