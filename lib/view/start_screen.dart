import 'package:contadorwear/view/api_http.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';
import 'utils.dart';

class DateTimeWidget extends StatefulWidget {
  const DateTimeWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DateTimeWidgetState createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  String _currentDate = '';
  String _currentTime = '';
  String _currentMinute = '';
  String _currentSecond = '';

  @override
  void initState() {
    super.initState();
    _updateDateTime();
  }

  void _updateDateTime() {
    setState(() {
      _currentDate = DateFormat('dd MMM, yyyy').format(DateTime.now());
      _currentTime = DateFormat('HH').format(DateTime.now());
      _currentMinute = DateFormat('mm').format(DateTime.now());
      _currentSecond = DateFormat('ss').format(DateTime.now());
    });

    // Actualizar la fecha y hora cada segundo
    Future.delayed(const Duration(seconds: 1), _updateDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherModel?>(
      future: Weather().getWeather('queretaro'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator while fetching weather data
        } else if (snapshot.hasData) {
          WeatherModel? weather = snapshot.data;

          return Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/ponyo_azul.jpg'),
                  fit: BoxFit.cover,
                  alignment: FractionalOffset(1.0, 0.75),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    weather?.cityName ?? 'Conectando...',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Color(0xFFB2EBF2),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      '${weather?.temp} °',
                      style: const TextStyle(
                        fontSize: 10, // Tamaño de fuente
                        fontWeight: FontWeight.bold, // Grosor de la fuente
                        letterSpacing: 0.5,
                        color: Color(0xFFB2EBF2), // Color del texto
                      ),
                    ),
                    const SizedBox(width: 3),
                    Image.asset(
                        weather!.temp! > 18
                            ? 'assets/sun.png'
                            : 'assets/cold.png',
                        width: 50,
                        height: 50),
                    const SizedBox(width: 3),
                    const Icon(
                      Icons.opacity,
                      size: 13,
                      color: Colors.white,
                    ),
                    Text(
                      '${weather.humidity} %',
                      style: const TextStyle(
                        fontSize: 10, // Tamaño de fuente
                        fontWeight: FontWeight.bold, // Grosor de la fuente
                        letterSpacing: 0.5,
                        color: Color(0xFFB2EBF2), // Color del texto
                      ),
                    ),
                  ]),
                  const SizedBox(height: 5),
                  Text(
                    _currentDate.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14, // Tamaño de fuente
                      fontWeight: FontWeight.bold, // Grosor de la fuente
                      letterSpacing: 0.5,
                      color: Color(0xFFB2EBF2), // Color del texto
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      _currentTime,
                      style: const TextStyle(
                        fontSize: 63, // Tamaño de fuente
                        fontWeight: FontWeight.bold, // Grosor de la fuente
                        letterSpacing: 10, // Espaciado entre caracteres
                        color: Colors.white, // Color del texto
                        fontFamily:
                            'Digital', // Fuente personalizada (opcional)
                      ),
                    ),
                    const SizedBox(width: 3),
                    Column(children: [
                      Text(
                        _currentMinute,
                        style: const TextStyle(
                          fontSize: 30, // Tamaño de fuente
                          fontWeight: FontWeight.bold, // Grosor de la fuente
                          letterSpacing: 5, // Espaciado entre caracteres
                          color: Colors.white, // Color del texto
                          fontFamily:
                              'Digital', // Fuente personalizada (opcional)
                        ),
                      ),
                      Text(
                        _currentSecond,
                        style: const TextStyle(
                          fontSize: 20, // Tamaño de fuente
                          letterSpacing: 10, // Espaciado entre caracteres
                          color: Colors.white, // Color del texto
                          fontFamily:
                              'Digital', // Fuente personalizada (opcional)
                        ),
                      ),
                    ]
                    )
                  ]
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Text(
              'Error en encontrar clima'); // Display an error message if there's an error
        } else {
          return const Text(
              'API no valida'); // Display a message when there's no data
        }
      },
    );
  }
}
