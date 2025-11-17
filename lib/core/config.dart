import 'package:flutter_riverpod/flutter_riverpod.dart';

class Config {
  final String baseUrl;

  const Config({
    required this.baseUrl,
  });
}

final configProvider = Provider<Config>((ref) {
  return const Config(
    baseUrl: 'https://jsonplaceholder.typicode.com',
  );
});

