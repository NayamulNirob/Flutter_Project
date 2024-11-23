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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['cell'] = this.cell;
    data['address'] = this.address;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['image'] = this.image;
    data['role'] = this.role;
    data['username'] = this.username;
    return data;
  }
}
