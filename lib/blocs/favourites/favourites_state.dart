abstract class FavouritesState {}

class FavouriteInitial extends FavouritesState {}

class FavouriteLoading extends FavouritesState {}

class FavoriteLoaded extends FavouritesState {
  final bool isFavorite;
  FavoriteLoaded(this.isFavorite);
}

class AllFavoritesLoaded extends FavouritesState {
  final List<Map<String, dynamic>> favourites;
  AllFavoritesLoaded(this.favourites);
}
