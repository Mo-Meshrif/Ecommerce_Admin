import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String id, from, message;
  List to;
  Timestamp createdAt;
  bool seen;
  NotificationModel({
    this.from,
    this.to,
    this.message,
    this.createdAt,
    this.seen,
  });
  NotificationModel.fromJson(String notifyId, Map<String, dynamic> map) {
    if (map == null) {
      return;
    }
    id = notifyId;
    from = map['from'];
    to = map['to'];
    message = map['message'];
    createdAt = map['createdAt'];
    seen = map['seen'];
  }
  toJson() {
    return {
      'from': from,
      'to': to,
      'message': message,
      'createdAt': createdAt,
      'seen': seen,
    };
  }
}
