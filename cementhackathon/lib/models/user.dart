class User {
  String name;
  String? phone;
  String email;
  String password;
  String role; // 'ADMIN' or 'USER'
  String? otpCode;
  DateTime? codeExpires;
  bool isVerified;

  User({
    required this.name,
    this.phone,
    required this.email,
    required this.password,
    this.role = 'USER', // Default role as USER
    this.otpCode,
    this.codeExpires,
    this.isVerified = false,
  });

  // Method to convert JSON to User instance
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      role: json['role'] ?? 'USER',
      otpCode: json['otpCode'],
      codeExpires: json['codeExpires'] != null
          ? DateTime.parse(json['codeExpires'])
          : null,
      isVerified: json['isVerified'] ?? false,
    );
  }

  // Method to convert User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'role': role,
      'otpCode': otpCode,
      'codeExpires': codeExpires?.toIso8601String(),
      'isVerified': isVerified,
    };
  }
}
