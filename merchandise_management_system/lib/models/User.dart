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
  bool? active;
  bool? enabled;
  String? username;
  bool? lock;
  List<Authorities>? authorities;
  bool? credentialsNonExpired;
  bool? accountNonExpired;
  bool? accountNonLocked;

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
        this.active,
        this.enabled,
        this.username,
        this.lock,
        this.authorities,
        this.credentialsNonExpired,
        this.accountNonExpired,
        this.accountNonLocked});

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
    active = json['active'];
    enabled = json['enabled'];
    username = json['username'];
    lock = json['lock'];
    if (json['authorities'] != null) {
      authorities = <Authorities>[];
      json['authorities'].forEach((v) {
        authorities!.add(new Authorities.fromJson(v));
      });
    }
    credentialsNonExpired = json['credentialsNonExpired'];
    accountNonExpired = json['accountNonExpired'];
    accountNonLocked = json['accountNonLocked'];
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
    data['active'] = this.active;
    data['enabled'] = this.enabled;
    data['username'] = this.username;
    data['lock'] = this.lock;
    if (this.authorities != null) {
      data['authorities'] = this.authorities!.map((v) => v.toJson()).toList();
    }
    data['credentialsNonExpired'] = this.credentialsNonExpired;
    data['accountNonExpired'] = this.accountNonExpired;
    data['accountNonLocked'] = this.accountNonLocked;
    return data;
  }
}

class Authorities {
  String? authority;

  Authorities({this.authority});

  Authorities.fromJson(Map<String, dynamic> json) {
    authority = json['authority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authority'] = this.authority;
    return data;
  }
}

