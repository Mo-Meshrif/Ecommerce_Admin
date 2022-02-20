class UserModel {
  String? id, userName, email, pic, role;
  bool? isOnline;
  UserModel({
    this.id,
    this.userName,
    this.email,
    this.pic,
    this.role,
    this.isOnline,
  });
  UserModel.fromJson(bool fromLocal,String uid,Map<String, dynamic> map) {
    if (map.isEmpty) {
      return;
    }
    id = fromLocal?map['id']:uid;
    userName = map['userName'];
    email = map['email'];
    pic = map['pic'];
    role = map['role'];
    isOnline = map['isOnline'];
  }

  toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'pic': pic,
      'role': role,
      'isOnline': isOnline,
    };
  }
}
