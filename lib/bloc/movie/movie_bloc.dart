import 'package:bloc/bloc.dart';
import 'package:final_project/bloc/movie/movie_event.dart';
import 'package:final_project/bloc/movie/movie_state.dart';

import '../../datasource/token_local_data_source.dart';
import '../../models/movie.dart';
import '../../repository/moveis_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState>{

  final TokenLocalDatasource _tokenLocalDatasource = TokenLocalDatasourceImpl();
  final MovieRepository _movieRepository = MovieRepository();

  MovieBloc():super(MovieInitial()){
    on<GetMoviesEvent>(_getMovies);

  }

  void _getMovies(GetMoviesEvent event, Emitter<MovieState> emit) async {
    final accessToken = await _tokenLocalDatasource.getToken();
    if (accessToken == null) {
      emit(MovieFailure());
    } else {
      String date = '${event.date.year}-${event.date.month}-${event.date.day}';
      final moviesBody = await _movieRepository.getAllMoviesDate(
          accessToken, date);
      if (moviesBody["success"] == false) {
        emit(MovieFailure());
      } else {
        List<Movie> movies = [];
        for (int i = 0; i < moviesBody["data"].length; i++) {
          movies.add(Movie.fromJson(moviesBody["data"][i]));
        }

        emit(MovieSuccessful(movies: movies));
        print(state);
      }
    }
  }


}