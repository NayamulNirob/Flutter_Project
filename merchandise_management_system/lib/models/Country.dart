class Country {
  final int id;
  final String name;
  final String? bussiness;
  final String? progress;
  final String? status;
  final double sale;

  Country({
    required this.id,
    required this.name,
    this.bussiness,
    this.progress,
    this.status,
    required this.sale,
  });

  // Convert the Country to a JSON map for serialization
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'bussiness': bussiness,
    'progress': progress,
    'status': status,
    'sale': sale,
  };

  // Create a Country from a JSON map
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      bussiness: json['bussiness'],
      progress: json['progress'],
      status: json['status'],
      sale: json['sale'],
    );
  }
}
