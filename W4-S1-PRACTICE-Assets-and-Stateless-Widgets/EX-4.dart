import 'package:flutter/material.dart';

enum WeatherCondition {
  sunny(Icons.wb_sunny, Colors.yellow),
  rainy(Icons.water_drop, Colors.blue),
  cloudy(Icons.cloud, Colors.blueGrey),
  snowy(Icons.ac_unit, Colors.white),
  windy(Icons.air, Colors.white),
  thunderstorm(Icons.flash_on, Colors.blueGrey);

  final IconData icon;
  final Color color;

  const WeatherCondition(this.icon, this.color);
}

void main() => runApp(MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Weather Forecast',
                style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.pink[300],
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                WeatherForecast(
                    weatherCondition: WeatherCondition.sunny,
                    temperature: Temperature(min: 20, max: 35),
                    dayOfWeek: 'Mon'),
                const SizedBox(width: 5),
                WeatherForecast(
                    weatherCondition: WeatherCondition.rainy,
                    temperature: Temperature(min: 15, max: 25),
                    dayOfWeek: 'Tue'),
                const SizedBox(width: 5),
                WeatherForecast(
                    weatherCondition: WeatherCondition.cloudy,
                    temperature: Temperature(min: 18, max: 28),
                    dayOfWeek: 'Wed'),
                const SizedBox(width: 5),
                WeatherForecast(
                    weatherCondition: WeatherCondition.snowy,
                    temperature: Temperature(min: 10, max: 13),
                    dayOfWeek: 'Thu'),
                const SizedBox(width: 5),
                WeatherForecast(
                    weatherCondition: WeatherCondition.windy,
                    temperature: Temperature(min: 14, max: 20),
                    dayOfWeek: 'Fri'),
                const SizedBox(width: 5),
                WeatherForecast(
                    weatherCondition: WeatherCondition.thunderstorm,
                    temperature: Temperature(min: 18, max: 30),
                    dayOfWeek: 'Sat'),
                const SizedBox(width: 5),
                WeatherForecast(
                    weatherCondition: WeatherCondition.sunny,
                    temperature: Temperature(min: 20, max: 30),
                    dayOfWeek: 'Sun'),
              ]),
            ]),
          )),
    ));

class Temperature {
  final double min;
  final double max;

  Temperature({required this.min, required this.max});
}

class WeatherForecast extends StatelessWidget {
  final WeatherCondition weatherCondition;
  final Temperature temperature;
  final String dayOfWeek;

  const WeatherForecast({
    super.key,
    required this.weatherCondition,
    required this.temperature,
    required this.dayOfWeek,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.pink[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              Text(dayOfWeek, style: const TextStyle(fontSize: 13)),
              const SizedBox(height: 10),
              Icon(weatherCondition.icon,
                  size: 25, color: weatherCondition.color),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '${temperature.max.toString()}°',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${temperature.min.toString()}°',
                    style: TextStyle(fontSize: 13, color: Colors.blueGrey),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
