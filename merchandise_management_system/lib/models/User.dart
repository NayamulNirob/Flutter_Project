class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? cell;
  String? address;
  String? dob;
  String? gender;
  String? image;
  String? role;
  String? username;

  User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.cell,
      this.address,
      this.dob,
      this.gender,
      this.image,
      this.role,
      this.username,
    });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    cell = json['cell'];
    address = json['address'];
    dob = json['dob'];
    gender = json['gender'];
    image = json['image'];
    role = json['role'];
    username = json['username'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['cell'] = cell;
    data['address'] = address;
    data['dob'] = dob;
    data['gender'] = gender;
    data['image'] = image;
    data['role'] = role;
    data['username'] = username;
    return data;
  }
}
