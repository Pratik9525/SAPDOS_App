class Patient {
  final String name;
  final int age;
  final String description;
  // final String image;

  Patient({
    required this.name,
    required this.age,
    required this.description,
    // required this.image
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      name: json['name'],
      age: json['age'],
      description: json['description'],
      // image: json['image'],
    );
  }
}

// // lib/models/patient.dart
// class Patient {
//   final String name;
//   final int age;
//   final String description;
//   final String image;

//   Patient({
//     required this.name,
//     required this.age,
//     required this.description,
//     required this.image,
//   });

//   factory Patient.fromJson(Map<String, dynamic> json) {
//     return Patient(
//       name: json['name'],
//       age: json['age'],
//       description: json['description'],
//       image: json['image'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'age': age,
//       'description': description,
//       'image': image,
//     };
//   }
// }
