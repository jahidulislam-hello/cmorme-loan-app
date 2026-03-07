import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static final TokenService _instance = TokenService._internal();
  factory TokenService() => _instance;
  TokenService._internal();

  SharedPreferences? _prefs;

  static const String _accessTokenKey = 'access_token';

  /// Must be called once in main() after WidgetsFlutterBinding.ensureInitialized()
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  SharedPreferences get _safePrefs {
    assert(_prefs != null, 'TokenService.init() must be called before use.');
    return _prefs!;
  }

  Future<void> saveToken(String token) async {
    await _safePrefs.setString(_accessTokenKey, token);
  }

  String? getToken() {
    return _safePrefs.getString(_accessTokenKey);
  }

  Future<void> deleteToken() async {
    await _safePrefs.remove(_accessTokenKey);
  }

  bool hasToken() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }
}
