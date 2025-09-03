import 'dart:io';

abstract class ProfilePictureEvent {}

class UploadProfilePictureEvent extends ProfilePictureEvent {
  final String uid;
  final File? imageFile;

  UploadProfilePictureEvent({required this.uid,  this.imageFile});
}

class LoadProfilePictureEvent extends ProfilePictureEvent {
  final String uid;
  LoadProfilePictureEvent({required this.uid});
}
