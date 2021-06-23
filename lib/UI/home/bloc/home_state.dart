import 'package:movies/model/film_models.dart';

abstract class HomeState {}

class Initial implements HomeState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class Loading implements HomeState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class FilmLoaded implements HomeState {
  final List<Film> datas;

  const FilmLoaded(this.datas);

  @override
  List<Object> get props => [datas];

  @override
  bool get stringify => true;
}
