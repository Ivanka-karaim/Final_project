import 'package:bloc/bloc.dart';
import 'package:final_project/data/datasource/token_local_data_source.dart';
import 'package:final_project/data/repository/moveis_repository.dart';
import 'package:final_project/features/home/bloc/favourite/favourite_event.dart';
import 'package:final_project/features/home/bloc/favourite/favourite_state.dart';
import 'package:final_project/features/movies/models/movie.dart';


class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {

  final DataSource _datasource = DatasourceImpl();
  final MovieRepository _movieRepository  = MovieRepository();

  FavouriteBloc() :super(FavouriteInitial()) {
    on<AddFavouriteMovieEvent>(_addMovie);
    on<GetFavouriteMovieEvent>(_getMovies);
    on<DeleteMovieEvent>(_deleteMovie);
  }

  void _addMovie(AddFavouriteMovieEvent event, Emitter<FavouriteState> emit) async {

    await _datasource.addMovie(event.movie.id.toString());

  }

  void _deleteMovie(DeleteMovieEvent event, Emitter<FavouriteState> emit) async {

    await _datasource.deleteMovie(event.movie.id.toString());

  }

  void _getMovies(GetFavouriteMovieEvent event, Emitter<FavouriteState> emit) async {
    final accessToken = await _datasource.getToken();
    final response = await _datasource.getMovies();

    List<Movie> movies = [];
    if (response == null) {
      emit(FavouriteSuccessful(movies: movies));
    } else {
      final moviesRepo = await _movieRepository.getAllMovies(accessToken!);
      for (int i = 0; i < response.length; i++) {
        final obj = moviesRepo.where((element) => element.id==int.parse(response[i])).first;
        movies.add(obj);
      }
      emit(FavouriteSuccessful(movies: movies));

    }

  }
}