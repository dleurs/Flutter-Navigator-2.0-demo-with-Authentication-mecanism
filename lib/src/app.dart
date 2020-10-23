import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:navigator_v2_flutter_with_auth/src/bloc/authentication/authentication_bloc.dart';
import 'package:navigator_v2_flutter_with_auth/src/navigation/my_route_information_parser.dart';
import 'package:navigator_v2_flutter_with_auth/src/navigation/my_router_delegate.dart';
import 'package:navigator_v2_flutter_with_auth/src/resource/login_repository.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  MyRouterDelegate _routerDelegate = MyRouterDelegate();
  MyRouteInformationParser _routeInformationParser = MyRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(LoginRepository()),
        child: MaterialApp.router(
          title: 'Books App',
          routerDelegate: _routerDelegate,
          routeInformationParser: _routeInformationParser,
        ));
  }
}
