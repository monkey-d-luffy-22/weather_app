import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}
class WeatherData {
  final String cityName;
  final double temperature;
  final int humidity;
  final double windSpeed;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String apiKey = "c0283118dcfbcece9f0a2585baf69038"; // Replace with your OpenWeatherMap API key
  String city = "bangalore"; // Replace with your desired city name
  WeatherData? weatherData;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";
    final response = await http.get(Uri.parse(url));
    print("status ");
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        weatherData = WeatherData(
          cityName: data['name'],
          temperature: data['main']['temp'],
          humidity: data['main']['humidity'],
          windSpeed: data['wind']['speed'],
        );
      });
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: Center(
          child: weatherData == null
              ? CircularProgressIndicator()
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'City: ${weatherData!.cityName}',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Temperature: ${weatherData!.temperature}°C',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Humidity: ${weatherData!.humidity}%',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Wind Speed: ${weatherData!.windSpeed} km/h',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// void main() => runApp(MyApp());
//
// class WeatherData {
//   final String cityName;
//   final double temperature;
//   final int humidity;
//   final double windSpeed;
//
//   WeatherData({
//     required this.cityName,
//     required this.temperature,
//     required this.humidity,
//     required this.windSpeed,
//   });
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Weather App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: WeatherScreen(),
//     );
//   }
// }
//
// class WeatherScreen extends StatefulWidget {
//   @override
//   _WeatherScreenState createState() => _WeatherScreenState();
// }
//
// class _WeatherScreenState extends State<WeatherScreen> {
//   WeatherData? weatherData;
//   String _city = '';
//   String _temperature = '';
//   String _humidity = '';
//   String _windSpeed = '';
//   // String _description = '';
//   // String _iconCode = '';
//
//   Future<void> fetchWeatherData(String cityName) async {
//     final apiKey = "c0283118dcfbcece9f0a2585baf69038";
//     final url =
//         "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric";
//     final response = await http.get(Uri.parse(url));
//     final data = jsonDecode(response.body);
//     print("status ");
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       weatherData = json.decode(response.body);
//       setState(() {
//         weatherData = WeatherData(
//           cityName: data['name'],
//           temperature: data['main']['temp'],
//           humidity: data['main']['humidity'],
//           windSpeed: data['wind']['speed'],
//         );
//         // _city: weatherData['name'];
//         // _temperature: weatherData['main']['temp'];
//         // _humidity: weatherData['main']['humidity'];
//         // _windSpeed: weatherData['wind']['speed'];
//         // _city = weatherData['name'];
//         // _temperature = weatherData['main']['temp'].toString();
//         // _description = weatherData['weather'][0]['description'];
//         // _iconCode = weatherData['weather'][0]['icon'];
//       });
//     } else {
//       print("Data fetch error");
//       // setState(() {
//       //   _city = 'Error';
//       //   _temperature = '';
//       //   _description = 'Failed to fetch weather data';
//       //   _iconCode = '';
//       // });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather App'),
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: 20),
//           Text(
//             _city,
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 10),
//           Text(
//             _temperature + '°C',
//             style: TextStyle(fontSize: 48),
//           ),
//           SizedBox(height: 10),
//           Text(
//             _humidity,
//             style: TextStyle(fontSize: 18),
//           ),
//           SizedBox(height: 10),
//           Text(
//             _windSpeed,
//             style: TextStyle(fontSize: 18),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () async {
//               final cityName = await Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => CitySelectionScreen()),
//               );
//               if (cityName != null) {
//                 fetchWeatherData(cityName);
//               }
//             },
//             child: Text('Change City'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CitySelectionScreen extends StatefulWidget {
//   @override
//   State<CitySelectionScreen> createState() => _CitySelectionScreenState();
// }
//
// class _CitySelectionScreenState extends State<CitySelectionScreen> {
//   final TextEditingController _cityController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select City'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: _cityController,
//               decoration: InputDecoration(
//                 labelText: 'Enter City Name',
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 final cityName = _cityController.text;
//                 Navigator.pop(context, cityName);
//               },
//               child: Text('Get Weather'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
