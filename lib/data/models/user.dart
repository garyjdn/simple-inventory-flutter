class User {
  String id;
  String name;
  String email;
  String role;

  User({
    this.id,
    this.name,
    this.email,
    this.role,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      role: map['role']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'role': this.role,
    };
  }
}