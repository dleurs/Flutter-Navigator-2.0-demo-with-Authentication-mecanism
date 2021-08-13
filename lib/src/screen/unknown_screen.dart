import 'package:flutter/material.dart';
import 'package:navigator_v2_flutter_with_auth/src/navigation/app_state.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/base_screen.dart';

class UnknownScreen extends StatefulWidget {
  static AppState get state => AppState(uri: Uri(path: '/unknown'), name: 'Unknown');

  @override
  _UnknownScreenState createState() => _UnknownScreenState();
}

class _UnknownScreenState extends BaseScreenState<UnknownScreen> {
  String get name => UnknownScreen.state.name;

  @override
  Widget buildLargeScreen(BuildContext context) {
    return Center(
      child: Text(
        "S.of(context).page_not_found",
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  @override
  Widget buildSmallScreen(BuildContext context) {
    return buildLargeScreen(context);
  }
}
