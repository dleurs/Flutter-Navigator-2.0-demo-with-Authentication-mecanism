import 'package:flutter/material.dart';

class ScrollListCentered extends StatelessWidget {
  final List<Widget> children;
  const ScrollListCentered({required this.children, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Column(children: children)],
      ),
    );
  }
}
