import 'package:flutter/material.dart';

abstract class FavouritesEvent {}

class ToggleFavorite extends FavouritesEvent {
  final Map<String, dynamic> course;
  final BuildContext context;
  ToggleFavorite(this.course, this.context);
}

class LoadFavoriteStatus extends FavouritesEvent {
  final String courseId;
  LoadFavoriteStatus(this.courseId);
}

class LoadAllFavorites extends FavouritesEvent {}
