import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FcmServices {
  static void firebaseInit() async {
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint(message.notification!.title);
    });
  }
}
