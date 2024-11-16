class User {
  final int id;
  final String userName;
  final String userId;
  final String userPw;
  final String userEmail;
  final String userPhoneNumber;
  final DateTime createdAt;

  User({
    required this.id,
    required this.userName,
    required this.userId,
    required this.userPw,
    required this.userEmail,
    required this.userPhoneNumber,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['user_name'],
      userId: json['user_id'],
      userPw: json['user_pw'],
      userEmail: json['user_email'],
      userPhoneNumber: json['user_phone_number'],
      createdAt: DateTime.parse(json['created_at']).add(Duration(hours: 9)),
    );
  }
}
