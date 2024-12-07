class Login {
  String token;
  String refreshToken;

  Login({
    required this.token,
    required this.refreshToken,
  });

  // Method to convert JSON to Login instance
  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }

  // Method to convert Login instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refreshToken': refreshToken,
    };
  }
}
