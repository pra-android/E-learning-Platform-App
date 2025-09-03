import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:e_learning_platform/blocs/admin/admin_event.dart';
import 'package:e_learning_platform/blocs/admin/admin_state.dart';
import 'package:e_learning_platform/services/send_notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitialState()) {
    on<SubmitCourseEvent>((event, emit) async {
      emit(AdminLoading());
      try {
        String? imageUrl;
        if (event.imageFile != null) {
          imageUrl = await _uploadToCloudinary(
            event.imageFile!,
            "images",
            "image",
          );
        }

        String? videoUrl;
        if (event.videoFile != null) {
          videoUrl = await _uploadToCloudinary(
            event.videoFile!,
            "videos",
            "video",
          );
        }
        List<String> pdfUrls = [];
        if (event.pdfFile != null && event.pdfFile!.isNotEmpty) {
          for (var pdf in event.pdfFile!) {
            final url = await _uploadToCloudinary(pdf, "pdfs", "raw");
            if (url != null) pdfUrls.add(url);
          }
        }

        DocumentReference docRef = FirebaseFirestore.instance
            .collection("courses")
            .doc();
        await docRef.set({
          "courseId": docRef.id,
          "title": event.title,
          "category": event.category,
          "description": event.description,
          "price": event.price,
          "priceType": event.priceType,
          "imageUrl": imageUrl,
          "videoUrl": videoUrl,
          "ratings": [],
          "comments": [],
          "pdfs": pdfUrls,
          "createdAt": DateTime.now(),
        });
        print("✅ Course saved with ID: ${docRef.id}");
        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection("users")
            .where("role", isEqualTo: "user")
            .get();

        for (var user in userSnapshot.docs) {
          String? token = user['userToken'];
          debugPrint("We are checking token $token");
          if (token!.isNotEmpty) {
            await SendNotificationServices().sendNotificationsThroughAPi(
              token: token,
              title: "New Course added ${event.title}",
              body: event.description,
            );
            //save notifications
            await FirebaseFirestore.instance
                .collection("notifications")
                .doc()
                .set({
                  "title": "New Course added ${event.title}",
                  "body": event.description,
                  "userId": user.id,
                  "courseId": docRef.id,
                  "createdAt": DateTime.now(),
                  "isRead": false,
                });
          }
        }

        emit(AdminSuccess());
      } catch (e) {
        emit(AdminFailure(e.toString()));
        debugPrint("catching is ${e.toString()}");
      }
    });
  }

  Future<String?> _uploadToCloudinary(
    File file,
    String folder,
    String resourceType,
  ) async {
    const String cloudName = "dvqlshrm4";
    const String uploadPresetKey = "e-learning";
    final String url =
        "https://api.cloudinary.com/v1_1/$cloudName/$resourceType/upload";
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path),
        "upload_preset": uploadPresetKey,
        "folder": folder,
      });
      var response = await Dio().post(
        url,
        data: formData,
        options: Options(
          receiveTimeout: Duration(minutes: 5),
          sendTimeout: Duration(minutes: 5),
        ),
      );
      if (response.statusCode == 200) {
        print("Response data is ${response.data}");
        return response.data["secure_url"];
      } else {
        throw Exception("Failed to upload: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Dio Error: Status Code ${e.response!.statusCode}");
        print("Dio Error: Response Body ${e.response!.data}");
      }
      throw Exception("Cloudinary Upload Error: $e");
    } catch (e) {
      throw Exception("Cloudinary Upload Error: $e");
    }
  }
}
