class UserModel {
  String id, userName, email, pic;
  bool isAdmin, isOnline;
  UserModel({
    this.id,
    this.userName,
    this.email,
    this.pic,
    this.isAdmin,
    this.isOnline,
  });
  UserModel.fromJson(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return;
    }
    id = map['id'];
    userName = map['userName'];
    email = map['email'];
    pic = map['pic'];
    isAdmin = map['isAdmin'];
    isOnline = map['isOnline'];
  }

  toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'pic': pic,
      'isAdmin': isAdmin,
      'isOnline': isOnline,
    };
  }
}
