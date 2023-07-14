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
        if (snapshot.hasData) {
          WeatherModel? weather = snapshot.data;

          // ignore: unused_local_variable
          var temp = weather!.temp !- 273;
          var tempF = temp.toStringAsFixed(0);

          return Scaffold(
              backgroundColor: const Color.fromARGB(255, 23, 77, 139),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      weather.cityName ?? 'Conectando...',
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: Color(0xFFB2EBF2),
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      temp > 18
                          ? const Icon(
                              Icons.sunny,
                              size: 9,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.severe_cold,
                              size: 9,
                              color: Colors.white,
                            ),
                      Text(
                        '$tempF °',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Color(0xFFB2EBF2),
                        ),
                      ),
                      const SizedBox(width: 3),
                      const Icon(
                        Icons.opacity,
                        size: 9,
                        color: Colors.white,
                      ),
                      Text(
                        '${weather.humidity} %',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Color(0xFFB2EBF2),
                        ),
                      ),
                    ]),
		                const SizedBox(height: 5),
                    Text(
                      _currentDate.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12, // Tamaño de fuente
                        fontWeight: FontWeight.bold, // Grosor de la fuente
                        letterSpacing: 0.5,
                        color: Colors.white, // Color del texto
                      ),
                    ),
                     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      _currentTime,
                      style: const TextStyle(
                        fontSize: 49,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 10,
                        color: Colors.white,
                        fontFamily: 'Digital',
                      ),
                    ),
                    const SizedBox(width: 3),
                    Column(children: [
                      Text(
                        _currentMinute,
                        style: const TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5,
                          color: Colors.white,
                          fontFamily: 'Digital',
                        ),
                      ),
                      Text(
                        _currentSecond,
                        style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: 10,
                          color: Colors.white,
                          fontFamily: 'Digital',
                        ),
                      ),
                    ])
                  ]),
		                const SizedBox(height: 5),
                    Image.asset('assets/images/ponyo_water.png',
                        fit: BoxFit
                            .fill, // Ajusta la imagen al tamaño disponible
                        width: 185,
                        height: 90)
                  ],
                ),
              ));
    
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
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
