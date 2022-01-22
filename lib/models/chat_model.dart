import 'dart:convert';

class ChatModel {
  final String? name;
  final String? msg;
  final String? uid;
  final DateTime? sent;
  ChatModel({
    this.name,
    this.msg,
    this.uid,
    this.sent,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'msg': msg,
      'uid': uid,
      'sent': sent?.millisecondsSinceEpoch,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      name: map['name'] ?? null,
      msg: map['msg'] ?? null,
      uid: map['uid'] ?? null,
      sent: map['sent'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['sent'])
          : null,
    );
  }
}
