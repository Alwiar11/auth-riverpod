import 'package:auth/firebase_auth.dart';
import 'package:auth/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  UserCredential? _userCredential;
  Map<String, dynamic> _userData = {};
  FirebaseAuthClass fauth = FirebaseAuthClass();
  FirestoreService fstore = FirestoreService();

  bool get isLoading => _isLoading;
  UserCredential? get userCredential => _userCredential;
  // Map<String, dynamic> get userData => _userData;

  Future<UserCredential> loginUserWithFirebase(
      String email, String password) async {
    setLoader(false);
    try {
      _userCredential = await fauth.loginUserWithFirebase(email, password);

      return _userCredential!;
    } catch (e) {
      print(e);
      setLoader(false);
      return Future.error(e);
    }
  }

  Future<UserCredential> signupWithEmailAndPassword(
      String email, String password, String name) async {
    var isSuccess = false;
    setLoader(true);
    _userCredential = await fauth.signupUserWithFirebase(email, password);

    final data = {
      'email': email,
      'password': password,
      'uid': _userCredential!.user!.uid,
      'createdAt': Timestamp.now().toString(),
      'name': name,
    };

    String uid = _userCredential!.user!.uid;

    isSuccess = await addUserToDatabase(data, 'users', uid);
    setLoader(false);
    if (isSuccess) {
      return _userCredential!;
    } else {
      throw Exception('Error to Sign Up');
    }
  }

  Future<bool> addUserToDatabase(
      Map<String, dynamic> data, String coll, String doc) async {
    // var value = false;
    try {
      await fstore.addDataToFirestore(data, coll, doc);
      // value = true;
    } catch (e) {
      print(e);
      // value = false;
    }
    return true;
  }

  Future<Map<String, dynamic>> getDataUser(String coll, String doc) async {
    setLoader(false);
    try {
      _userData = await fstore.getUserData(coll, doc);

      return _userData;
    } catch (e) {
      print(e);
      setLoader(false);
      return Future.error(e);
    }
  }

  void logoutUser() {
    fauth.signOutUser();
  }

  setLoader(bool loader) {
    _isLoading = loader;
    notifyListeners();
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthProvider());
