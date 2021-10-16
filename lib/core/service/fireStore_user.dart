import '../../model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FireStoreUser {
  final collectionRef = FirebaseFirestore.instance.collection('Users');
  
  Future<void> addUserToFireStore(UserModel user) async {
    return await collectionRef.doc(user.id).set(user.toJson());
  }

  Future<List<QueryDocumentSnapshot>> getUsersFromFireStore() async {
    var val = await collectionRef.get();
    return val.docs;
  }


  Future<void> updateOnlineState(uid, bool isOnline) async {
    return await collectionRef.doc(uid).update({
      'isOnline': isOnline,
    });
  }
}