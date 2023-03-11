import 'package:codelab/application/screens/home/components/future_forcast_listitem.dart';
import 'package:codelab/application/screens/home/components/hourly_weather_listitem.dart';
import 'package:codelab/application/screens/home/components/todays_weather.dart';
import 'package:codelab/models/weather_model.dart';
import 'package:codelab/service/api_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiService apiService = ApiService();
  final _textFieldController = TextEditingController();
  String searchText = "auto:ip";

  _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter a city'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "City"),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_textFieldController.text.isEmpty) {
                    return;
                  }
                  Navigator.pop(context, _textFieldController.text);
                },
                child: const Text('Okay'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF282c34),
        title: const Text('Weather App', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              _textFieldController.clear();
              searchText = await _showTextInputDialog(context);
              setState(() {
                searchText = searchText;
              });
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                searchText = "auto:ip";
              });
            },
            icon: const Icon(
              Icons.gps_fixed,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF282c34),
      body: SafeArea(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModel? weathermodel = snapshot.data;
              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    TodaysWeather(weatherModel: weathermodel),
                    const SizedBox(height: 10),
                    const Text(
                      'Weather by Hours',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Hour? hour = weathermodel
                              ?.forecast?.forecastday?[0].hour?[index];

                          return HourlyWeatherListItem(
                            hour: hour,
                          );
                        },
                        itemCount: weathermodel
                            ?.forecast?.forecastday?[0].hour?.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Weather next 7 days',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Forecastday? forecastday =
                              weathermodel?.forecast?.forecastday?[index];
                          return FutureForcastListItem(
                            forecastday: forecastday,
                          );
                        },
                        itemCount: weathermodel?.forecast?.forecastday?.length,
                      ),
                    )
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            return const Center(child: CircularProgressIndicator());
          },
          future: apiService.getWeatherData(searchText),
        ),
      ),
    );
  }
}
