class WareHouse {
  int? id;
  String? name;
  String? location;
  int? capacity;
  String? contact;

  WareHouse({this.id, this.name, this.location, this.capacity, this.contact});

  WareHouse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    capacity = json['capacity'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['capacity'] = this.capacity;
    data['contact'] = this.contact;
    return data;
  }
}
