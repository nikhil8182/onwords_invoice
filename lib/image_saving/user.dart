class User {
  final String imagePath;

  const User({
    required this.imagePath,
  });

  User copy({
    String? imagePath,
  }) =>
      User(
        imagePath: imagePath ?? this.imagePath,
      );

  static User fromJson(Map<String, dynamic> json) => User(
    imagePath: json['imagePath'],
  );

  Map<String, dynamic> toJson() => {
    'imagePath': imagePath,

  };
}