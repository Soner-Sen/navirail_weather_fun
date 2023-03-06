import 'package:codelab/application/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class Rail extends StatefulWidget {
  const Rail({Key? key}) : super(key: key);

  @override
  State<Rail> createState() => _RailState();
}

class _RailState extends State<Rail> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const HomeScreen();
        break;
      case 1:
        page = const Placeholder();
        break;
      default:
        throw UnimplementedError('no Widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth > 1200,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.sunny),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.map),
                    label: Text('Second'),
                  ),
                ],
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
                selectedIndex: selectedIndex,
              ),
            ),
            Expanded(
                child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ))
          ],
        ),
      );
    });
  }
}
