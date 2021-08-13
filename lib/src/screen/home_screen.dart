import 'package:flutter/material.dart';
import 'package:navigator_v2_flutter_with_auth/src/navigation/app_state.dart';
import 'package:navigator_v2_flutter_with_auth/src/navigation/my_router_delegate.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/base_screen.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/components/constant.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/components/scroll_list_centered.dart';

class HomeScreen extends StatelessWidget {
  static AppState get state => AppState(uri: Uri(path: '/'), name: 'Home');

  @override
  Widget build(BuildContext context) {
    return HomeScreenProvided();
  }
}

class HomeScreenProvided extends StatefulWidget {
  @override
  _HomeScreenProvidedState createState() => _HomeScreenProvidedState();
}

class _HomeScreenProvidedState extends BaseScreenState<HomeScreenProvided> {
  @override
  String get name => HomeScreen.state.name;

  @override
  Widget buildSmallScreen(BuildContext context) {
    return ScrollListCentered(children: [
      SizedBox(height: Const.largePadding),
      Text(
        "S.of(context).welcome_message",
        style: Theme.of(context).textTheme.headline4,
      ),
      SizedBox(height: Const.largePadding),
      //Image.asset('assets/images/flutter.png'),
      SizedBox(height: Const.largePadding),
      ElevatedButton(
        onPressed: () {
          (Router.of(context).routerDelegate as MyRouterDelegate).toSettingsScreen();
        },
        child: Text(
          "S.of(context).settings_button",
        ),
      ),
    ]);
  }
}
