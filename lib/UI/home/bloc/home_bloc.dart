import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/UI/home/bloc/home_event.dart';
import 'package:movies/UI/home/bloc/home_state.dart';
import 'package:movies/model/film_models.dart';
import 'package:movies/repositories/film_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FilmRepository filmRepository;
  HomeBloc(this.filmRepository) : super(Initial());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetAll) {
      yield* _getFilms();
      List<Film> data = await filmRepository.getFilm();
      yield FilmLoaded(data);
    }
  }

  Stream<HomeState> _getFilms() async* {
    try {
      yield Loading();
    } catch (e) {
      print(e);
    }
  }
}
