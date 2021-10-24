import '../../helper/localStorageData.dart';
import '../../core/service/Firestore_user.dart';
import '../../model/userModel.dart';
import '../../views/subViews/authView/forgetPasswordView.dart';
import '../../views/subViews/authView/signInView.dart';
import '../../views/subViews/authView/signUpView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthViewModel extends GetxController {
  int currentIndex = 0;
  List<Widget> authViews = [
    SignInView(),
    SignUpView(),
    ForgetPasswordView(),
  ];
  String userName, email, password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final LocalStorageData _localStorageData = Get.find();
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;
  List<UserModel> _users = [];
  List<UserModel> get users => _users;
  Rxn<User> _user = Rxn<User>();
  String get user => _user.value?.email;
  @override
  void onInit() {
    _user.bindStream(_auth.authStateChanges());
    getUsers();
    super.onInit();
  }

  getAuthIndex(val) {
    currentIndex = val;
    update();
  }

  bool isNotCustomer(String loginEmail) {
    return _users.firstWhere((element) => element.email == loginEmail).role!='Customer';
  }

  Future<void> getUsers() async {
    FireStoreUser().getUsersFromFireStore().then((usersData) {
      usersData.forEach((element) {
        Map data = element.data();
        var index = _users.indexWhere((element) => element.id == data['id']);
        if (index >= 0) {
          _users.removeAt(index);
          _users.add(UserModel.fromJson(data));
        } else {
          _users.add(UserModel.fromJson(data));
        }
      });
      update();
    });
  }

  setUser(UserModel user) {
    _localStorageData.setUserData(user);
  }

  signUp() async {
    _loading.value = true;
    update();
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .onError((error, stackTrace) {
      _loading.value = false;
      update();
      return handleAuthErrors(error.toString());
    }).then((user) async {
      _loading.value = false;
      if (user != null) {
        UserModel userModel = UserModel(
            id: user.user.uid,
            userName: userName,
            email: email,
            role: 'Manger',
            isOnline: true);
        await FireStoreUser().addUserToFireStore(userModel);
        setUser(userModel);
      }
      update();
    });
  }

  signIn() async {
    _loading.value = true;
    update();
    if (isNotCustomer(email)) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .onError((error, stackTrace) {
        _loading.value = false;
        update();
        return handleAuthErrors(error.toString());
      }).then((user) {
        _loading.value = false;
        if (user != null) {
          FireStoreUser().updateOnlineState(user.user.uid, true);
          UserModel userData =
              _users.firstWhere((element) => element.id == user.user.uid);
          setUser(userData);
        }
        update();
      });
    } else {
      _loading.value = false;
      update();
      handleAuthErrors('Customers are not allowed to enter !');
    }
  }

  forgetPassword() async {
    try {
      _loading.value = true;
      update();
      await _auth.sendPasswordResetEmail(email: email).then((_) {
        _loading.value = false;
        update();
        Get.snackbar(
          'Congratulations',
          'Check you email !',
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      });
    } catch (e) {
      _loading.value = false;
      update();
      handleAuthErrors(e);
    }
  }

  handleAuthErrors(String error) {
    Get.snackbar(
      'AuthError',
      error,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 5),
    );
  }

  clearAuthData() {
    userName = email = password = null;
    update();
  }

  logout() {
    _localStorageData.deleteUserData();
    _auth.signOut();
    currentIndex = 0;
    clearAuthData();
    update();
  }
}
