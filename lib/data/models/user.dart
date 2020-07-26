class User {
  String id;
  String name;
  String role;

  User({
    this.id,
    this.name,
    this.role,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      role: map['role']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'role': this.role,
    };
  }
}