// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:e_learning_platform/blocs/favourites/favourites_event.dart';
import 'package:e_learning_platform/blocs/favourites/favourites_state.dart';
import 'package:e_learning_platform/db/favourites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavoritesBloc() : super(FavouriteInitial()) {
    on<ToggleFavorite>((event, emit) async {
      final isFav = await FavouritesDb.instance.isFavorite(
        event.course["courseId"],
      );
      if (isFav) {
        await FavouritesDb.instance.removeFavourites(event.course["courseId"]);
        ScaffoldMessenger.of(event.context).showSnackBar(
          SnackBar(
            content: Text("Succesfully removed course from  favourites"),
          ),
        );
        emit(FavoriteLoaded(false));
      } else {
        await FavouritesDb.instance.addFavourites(event.course);

        ScaffoldMessenger.of(event.context).showSnackBar(
          SnackBar(content: Text("Succesfully added to favourites")),
        );
        emit(FavoriteLoaded(true));
      }
    });
    on<LoadFavoriteStatus>(_onLoadFavoriteStatus);
    on<LoadAllFavorites>((event, emit) async {
      final favs = await FavouritesDb.instance.getAllFavorites();
      emit(AllFavoritesLoaded(favs));
    });
  }

  FutureOr<void> _onLoadFavoriteStatus(
    LoadFavoriteStatus event,
    Emitter<FavouritesState> emit,
  ) async {
    final isFav = await FavouritesDb.instance.isFavorite(event.courseId);
    emit(FavoriteLoaded(isFav));
  }
}
