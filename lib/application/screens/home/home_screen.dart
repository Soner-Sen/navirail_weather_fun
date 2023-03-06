import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimary);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            color: theme.colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Random cool App :)',
                style: style,
              ),
            ),
          )
        ],
      ),
    );
  }
}
