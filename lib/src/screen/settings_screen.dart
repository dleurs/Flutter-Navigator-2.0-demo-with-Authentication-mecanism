import 'package:flutter/material.dart';
import 'package:navigator_v2_flutter_with_auth/src/navigation/app_state.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/base_screen.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/components/constant.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/components/dropdown_form_field.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/components/scroll_list_centered.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  static AppState get state => AppState(uri: Uri(path: '/settings'), name: 'Settings');

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseScreenState<SettingsScreen> {
  @override
  String get name => SettingsScreen.state.name;

  @override
  Widget buildSmallScreen(BuildContext context) {
    return ScrollListCentered(
      children: [
        SizedBox(height: Const.mediumPadding),
        Text(
          "Ok",
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: Const.mediumPadding),
        SizedBox(height: Const.mediumPadding),
      ],
    );
  }
}
