import 'package:shared_preferences/shared_preferences.dart';

class User {
  String? username;
  String? name;
  String? thumbnail;

  User({
    this.name,
    this.username,
    this.thumbnail,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      username: json['username'] ,
      name: json['name'] ,
      thumbnail: json['thumbnail'] ,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username ,
      'name': name ,
      'thumbnail': thumbnail ,
    };
  }
}

class TokenData {
  String accessToken;
  String refreshToken;

  TokenData({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenData.fromJson(Map<String, dynamic> json) {
    return TokenData(
      accessToken: json['access'],
      refreshToken: json['refresh'],
    );
  }
}

class TokenManager {
  static late SharedPreferences _prefs;
  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void saveTokens(TokenData tokens) {
    _prefs.setString(_accessTokenKey, tokens.accessToken);
    _prefs.setString(_refreshTokenKey, tokens.refreshToken);
  }

  static TokenData? getTokens() {
    final accessToken = _prefs.getString(_accessTokenKey);
    final refreshToken = _prefs.getString(_refreshTokenKey);

    if (accessToken != null && refreshToken != null) {
      return TokenData(accessToken: accessToken, refreshToken: refreshToken);
    } else {
      return null;
    }
  }

  static bool isLoggedIn() {
    // Check if tokens are available or not
    final tokens = TokenManager.getTokens();
    return tokens != null &&
        tokens.accessToken.isNotEmpty &&
        tokens.refreshToken.isNotEmpty;
  }

  static void clearTokens() {
    _prefs.remove(_accessTokenKey);
    _prefs.remove(_refreshTokenKey);
  }
}
