class Config {
  final String baseUrl;

  const Config({
    required this.baseUrl,
  });
}

class ConfigService {
  static const Config instance = Config(
    baseUrl: 'https://jsonplaceholder.typicode.com',
  );
}

