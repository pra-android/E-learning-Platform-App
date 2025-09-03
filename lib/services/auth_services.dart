import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_platform/repositories/auth_repositories.dart';
import 'package:e_learning_platform/services/notification_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AuthServices implements AuthRepositories {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  //signup
  Future<void> signup(
    String fullname,
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      debugPrint("email is $email and password is $password");
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(fullname);
      await userCredential.user!.reload();
      NotificationServices notificationServices = NotificationServices();
      String userDeviceToken = await notificationServices.getDeviceToken();

      await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'uid': userCredential.user!.uid,
            'fullname': fullname,
            'email': email,
            'createdAt': Timestamp.now(),
            "userToken": userDeviceToken,
            'role': 'user',
            "profileImage": null,
          });
    } on FirebaseAuthException catch (e) {
      String errorMsg = 'Something went wrong.';
      if (e.code == 'email-already-in-use') {
        errorMsg = 'The email is already registered.';
      } else if (e.code == 'weak-password') {
        errorMsg = 'The password is too weak.';
      }

      throw Exception(errorMsg);
    }
  }

  //login
  @override
  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = FirebaseAuth.instance.currentUser!.uid;
      NotificationServices notificationServices = NotificationServices();
      String token = await notificationServices.getDeviceToken();
      await firebaseFirestore.collection("users").doc(uid).update({
        "userToken": token,
      });
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
        await firebaseFirestore.collection("users").doc(uid).update({
          "userToken": newToken,
        });
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  //forgot password
  @override
  Future<void> forgotPassword(String email, context) async {
    if (email.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter your email")));
      return;
    } else {
      try {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,

            content: Text(
              "Password reset email sent to $email",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      } on FirebaseAuthException catch (e) {
        String msg = 'Something went wrong';
        if (e.code == 'user-not-found') {
          msg = 'No user found with this email';
        }
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      }
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
