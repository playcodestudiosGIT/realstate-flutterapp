import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';

import 'package:somosproperties/providers/sidemenu_provider.dart';

import 'package:somosproperties/ui/views/system/no_page_found_view.dart';

class NoPageFoundHandlers {

  static Handler noPageFound = Handler(
    handlerFunc: ( context, params ) {

      Provider.of<SideMenuProvider>(context!, listen: false).setCurrentPageUrl('/404');

      return NoPageFoundView();
    }
  );


}

