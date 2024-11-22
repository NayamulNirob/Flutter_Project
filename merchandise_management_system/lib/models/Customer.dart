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
        ? new CountryObj.fromJson(json['countryObj'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['createdAt'] = this.createdAt?.toIso8601String();
    data['updatedAt'] = this.updatedAt?.toIso8601String();
    data['contactPerson'] = this.contactPerson;
    data['organigation'] = this.organigation;
    if (this.countryObj != null) {
      data['countryObj'] = this.countryObj!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['bussiness'] = this.bussiness;
    data['progress'] = this.progress;
    data['status'] = this.status;
    data['sale'] = this.sale;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CountryObj && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

}