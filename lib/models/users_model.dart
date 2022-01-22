import 'dart:convert';

class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? uid;
  final DateTime? createdAt;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.uid,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'uid': uid,
      // 'created_at': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      uid: map['uid'],
      // createdAt: map['created_at'] != null
      //     ? DateTime.tryParse(map['created_at'])
      //     : null,
    );
  }
}
