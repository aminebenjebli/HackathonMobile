class Cementery {
  final String id;
  final String name;
  final String code;

  Cementery({required this.id, required this.name, required this.code});

  factory Cementery.fromJson(Map<String, dynamic> json) {
    return Cementery(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
    };
  }
}
