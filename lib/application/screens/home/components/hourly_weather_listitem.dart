import 'package:codelab/models/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyWeatherListItem extends StatelessWidget {
  const HourlyWeatherListItem({super.key, this.hour});

  final Hour? hour;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            '${hour?.tempC?.round().toString() ?? ""}°C',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Image.network(
            'https:${hour?.condition?.icon ?? ""}',
            width: 50,
            height: 50,
          ),
          const SizedBox(height: 15),
          Text(
              DateFormat.j()
                  .format(DateTime.parse(hour?.time.toString() ?? "")),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))
        ],
      ),
    );
  }
}
