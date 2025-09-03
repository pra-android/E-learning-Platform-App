import 'dart:io';
import 'package:dio/dio.dart';
import 'package:e_learning_platform/blocs/profilepicture/profile_picture_event.dart';
import 'package:e_learning_platform/blocs/profilepicture/profile_picture_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePictureBloc
    extends Bloc<ProfilePictureEvent, ProfilePictureState> {
  final FirebaseFirestore firestore;

  ProfilePictureBloc({required this.firestore}) : super(ProfileInitial()) {
    on<UploadProfilePictureEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        String? profileImageUrl;
        if (event.imageFile != null) {
          profileImageUrl = await _uploadToCloudinary(
            event.imageFile!,
            "profileImage",
            "image",
          );
          await firestore.collection('users').doc(event.uid).update({
            "profileImage": profileImageUrl,
          });
          emit(ProfileLoaded(imageUrl: profileImageUrl!));
        } else {}
      } catch (e) {
        debugPrint(e.toString());
        emit(ProfileError(message: e.toString()));
      }
    });
    on<LoadProfilePictureEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final doc = await firestore.collection("users").doc(event.uid).get();
        final imageUrl =
            doc.data()?["profileImage"] ??
            "https://imgs.search.brave.com/WnXt5GP1v6rK2JKBalDtyk9dFOxABNjFoQphbFOtEFs/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS12ZWN0/b3IvbWFuLXdpdGgt/c2hpcnQtdGhhdC1z/YXlzLWhlLWlzLWNo/YXJhY3Rlcl8xMjMw/NDU3LTMzNzEyLmpw/Zz9zZW10PWFpc19o/eWJyaWQmdz03NDAm/cT04MA";
        emit(ProfileLoaded(imageUrl: imageUrl));
      } catch (e) {
        emit(ProfileError(message: e.toString()));
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
