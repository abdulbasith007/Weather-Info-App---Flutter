import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _cityController = TextEditingController();
  String _cityName = '';
  String _temperature = '';
  String _weatherCondition = '';
  List<Map<String, String>> _sevenDayForecast = [];

  void _fetchWeather() {
    if (_cityController.text.isEmpty) return;
    setState(() {
      _cityName = _cityController.text;
      _temperature = '${_generateRandomTemperature()}°C';
      _weatherCondition = _getRandomWeatherCondition();
    });
  }

  void _fetchSevenDayForecast() {
    setState(() {
      _sevenDayForecast = List.generate(7, (index) {
        int temp = _generateRandomTemperature();
        return {
          'day': 'Day ${index + 1}',
          'temperature': '${temp}°C',
          'condition': _getRandomWeatherCondition(),
        };
      });
    });
  }

  int _generateRandomTemperature() {
    Random random = Random();
    return 15 + random.nextInt(16);
  }

  String _getRandomWeatherCondition() {
    List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];
    Random random = Random();
    return conditions[random.nextInt(conditions.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: const Text('Fetch Weather'),
            ),
            const SizedBox(height: 20),
            Text(
              'City: $_cityName',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Temperature: $_temperature',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Condition: $_weatherCondition',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchSevenDayForecast,
              child: const Text('7-Day Forecast'),
            ),
            const SizedBox(height: 20),
            _sevenDayForecast.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _sevenDayForecast.length,
                      itemBuilder: (context, index) {
                        final forecast = _sevenDayForecast[index];
                        return ListTile(
                          title: Text(forecast['day']!),
                          subtitle: Text(
                              'Temp: ${forecast['temperature']}, Condition: ${forecast['condition']}'),
                        );
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
