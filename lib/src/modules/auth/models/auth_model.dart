class AuthModel {
  final String token;
  final String expiration;

  AuthModel({required this.token, required this.expiration});
  
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'] ?? '',
      expiration: json['expiration'] ?? '',
    );
  }
}