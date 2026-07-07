import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  final TextEditingController _villeController = TextEditingController();
  bool _loading = false;
  String? _error;
  List<Map<String, dynamic>> _forecasts = [];

  Future<void> _rechercherVille() async {
    final ville = _villeController.text.trim();
    if (ville.isEmpty) {
      setState(() => _error = 'Veuillez saisir une ville');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
      _forecasts = [];
    });

    try {
      final geoUrl = Uri.parse(
          'https://geocoding-api.open-meteo.com/v1/search?name=${Uri.encodeComponent(ville)}&count=1&language=fr&format=json');
      final geoResponse = await http.get(geoUrl);
      final geoJson = jsonDecode(geoResponse.body);
      final results = geoJson['results'] as List<dynamic>?;

      if (results == null || results.isEmpty) {
        setState(() {
          _error = 'Ville introuvable';
          _loading = false;
        });
        return;
      }

      final lat = results[0]['latitude'];
      final lon = results[0]['longitude'];

      final forecastUrl = Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon'
          '&daily=temperature_2m_max,temperature_2m_min'
          '&hourly=relative_humidity_2m,surface_pressure'
          '&timezone=auto&forecast_days=5');
      final forecastResponse = await http.get(forecastUrl);
      final forecastJson = jsonDecode(forecastResponse.body);

      final dailyTime = forecastJson['daily']['time'] as List<dynamic>;
      final tempMax = forecastJson['daily']['temperature_2m_max'] as List<dynamic>;
      final tempMin = forecastJson['daily']['temperature_2m_min'] as List<dynamic>;

      final hourlyTime = forecastJson['hourly']['time'] as List<dynamic>;
      final humidity = forecastJson['hourly']['relative_humidity_2m'] as List<dynamic>;
      final pressure = forecastJson['hourly']['surface_pressure'] as List<dynamic>;

      final forecasts = <Map<String, dynamic>>[];
      for (var i = 0; i < dailyTime.length; i++) {
        final day = dailyTime[i];
        final hourIndex = hourlyTime.indexOf('${day}T12:00');

        forecasts.add({
          'date': day,
          'tempMax': tempMax[i],
          'tempMin': tempMin[i],
          'humidite': hourIndex >= 0 ? humidity[hourIndex] : null,
          'pression': hourIndex >= 0 ? pressure[hourIndex] : null,
        });
      }

      setState(() {
        _forecasts = forecasts;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erreur de connexion';
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _villeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _villeController,
                  decoration: const InputDecoration(labelText: 'Ville'),
                  onSubmitted: (_) => _rechercherVille(),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _loading ? null : _rechercherVille,
                child: const Text('Rechercher'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_loading) const CircularProgressIndicator(),
          if (_error != null)
            Text(_error!, style: const TextStyle(color: Colors.red)),
          Expanded(
            child: ListView.builder(
              itemCount: _forecasts.length,
              itemBuilder: (context, index) {
                final item = _forecasts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['date'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text('Min: ${item['tempMin']}°C   Max: ${item['tempMax']}°C'),
                        Text('Pression: ${item['pression']} hPa'),
                        Text('Humidité: ${item['humidite']}%'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
