class Config {
  // Base URL for API endpoints
  static const String baseUrl =
      'http://192.168.31.86:81/api'; // For Android Emulator
  // static const String baseUrl = 'http://localhost:8000/api'; // For iOS Simulator

  // API Endpoints
  static const String login = '/login';
  static const String register = '/register';
  static const String logout = '/logout';
  static const String products = '/products';
  static const String categories = '/categories';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
}
