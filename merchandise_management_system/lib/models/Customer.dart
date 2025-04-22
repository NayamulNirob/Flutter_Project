class Customer {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? contactPerson;
  String? organigation;
  CountryObj? countryObj;

  Customer(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.contactPerson,
        this.organigation,
        this.countryObj
      });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    createdAt = json['createdAt'] != null
        ? DateTime.parse(json['createdAt']) // Parse string to DateTime
        : null;
    updatedAt = json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt']) // Parse string to DateTime
        : null;
    contactPerson = json['contactPerson'];
    organigation = json['organigation'];
    countryObj = json['countryObj'] != null
        ? CountryObj.fromJson(json['countryObj'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['contactPerson'] = contactPerson;
    data['organigation'] = organigation;
    if (countryObj != null) {
      data['countryObj'] = countryObj!.toJson();
    }
    return data;
  }
}

class CountryObj {
  int? id;
  String? name;
  String? bussiness;
  String? progress;
  String? status;
  int? sale;

  CountryObj(
      {this.id,
        this.name,
        this.bussiness,
        this.progress,
        this.status,
        this.sale});

  CountryObj.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bussiness = json['bussiness'];
    progress = json['progress'];
    status = json['status'];
    sale = json['sale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['bussiness'] = bussiness;
    data['progress'] = progress;
    data['status'] = status;
    data['sale'] = sale;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CountryObj && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

}