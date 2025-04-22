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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['location'] = location;
    data['capacity'] = capacity;
    data['contact'] = contact;
    return data;
  }
}
