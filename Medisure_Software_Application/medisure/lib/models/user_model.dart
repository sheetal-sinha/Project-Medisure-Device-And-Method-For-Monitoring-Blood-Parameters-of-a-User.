class User {
  final String email;
  final String name;
  final String gender;
  final String ailments;
  final int age;
  final String photoUrl;

  User({
    required this.email,
    required this.name,
    required this.gender,
    required this.ailments,
    required this.age,
    required this.photoUrl,
  });

  factory User.fromFirestore(Map<String, dynamic> data) {
    return User(
      name: data['name'],
      gender: data['gender'],
      ailments: data['ailments'],
      age: int.parse(data['age']),
      email: '',
      photoUrl: data['photoUrl']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
      'gender': gender,
      'ailments': ailments,
      'age': age,
    };
  }
}
