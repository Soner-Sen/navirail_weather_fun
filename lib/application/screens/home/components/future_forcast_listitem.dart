import 'package:flutter/material.dart';
import 'package:codelab/models/weather_model.dart';
import 'package:intl/intl.dart';

class FutureForcastListItem extends StatelessWidget {
  const FutureForcastListItem({super.key, this.forecastday});

  final Forecastday? forecastday;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              DateFormat.EEEE()
                  .format(DateTime.parse(forecastday?.date.toString() ?? "")),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Image.network(
              'https:${forecastday?.day?.condition?.icon ?? ""}',
            ),
          ),
          Expanded(
            child: Text(
              forecastday?.day?.condition?.text ?? "",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '${forecastday?.day?.maxtempC?.round().toString() ?? ""}°C | ${forecastday?.day?.mintempC?.round().toString() ?? ""}°C',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
