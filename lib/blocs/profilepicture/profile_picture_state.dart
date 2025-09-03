abstract class ProfilePictureState {}

class ProfileInitial extends ProfilePictureState {}

class ProfileLoading extends ProfilePictureState {}

class ProfileLoaded extends ProfilePictureState {
  final String imageUrl;
  ProfileLoaded({required this.imageUrl});
}

class ProfileError extends ProfilePictureState {
  final String message;
  ProfileError({required this.message});
}
