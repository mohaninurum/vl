import 'favorite_bloc.dart';

abstract class FavoriteEvent {}

class ChangeCategory extends FavoriteEvent {
  final FavoriteCategory? category;

  ChangeCategory({this.category});
}

class LoadFavorites extends FavoriteEvent {
  final userID;
  final token;
  final context;
  LoadFavorites({required this.userID, this.token, this.context});
}
