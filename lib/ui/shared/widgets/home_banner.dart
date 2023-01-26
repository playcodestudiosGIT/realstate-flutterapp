import 'package:somosproperties/constants.dart';
import 'package:somosproperties/router/router.dart';
import 'package:somosproperties/services/navigation_service.dart';
import 'package:somosproperties/ui/buttons/custom_outlined_button.dart';
import 'package:somosproperties/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  final String image;
  final String text;
  final String textButton;
  final double corner;
  const HomeBanner(
      {Key? key,
      required this.image,
      required this.text,
      required this.textButton,
      required this.corner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: kPrimaryColor,
          ),
          Container(
            decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.modulate,
              color: Colors.black.withOpacity(0.1),
              image: DecorationImage( fit: BoxFit.fitHeight, image: NetworkImage(image), opacity: 0.9
              )
            
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (text != '')
                Text(
                  text,
                  textAlign: TextAlign.center,
                    style: CustomLabels.h1.copyWith( color: Colors.white, fontSize: (size.width < 700)? 18 : 30)),

                  SizedBox(height: kDefaultPadding),
                  if (text != '')
                  Container(
                      width: (size.width < 700) ? 100 : 120,
                      child: CustomOutlinedButton(
                        text: 'Buscar',
                        onPressed: () {
                          NavigationService.navigateTo(
                              '${Flurorouter.buscarRoute}/');
                        },
                        icon: (size.width < 700) ? Icons.abc : Icons.search,
                        color: kSecondaryColor,
                        isFilled: true,
                      ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
