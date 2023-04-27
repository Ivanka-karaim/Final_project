import 'dart:convert';

import 'package:final_project/models/movie.dart';
import 'package:final_project/models/session.dart';
import 'package:http/http.dart' as http;

import '../data/constants.dart';
import 'authorization.dart';

class MovieRepository {
  Future<List<Movie>> getAllMoviesDate(String accessToken, String date) async{
    final response = await http.get(
          Uri.parse('$URL_API/api/movies?date=$date'),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        );
        // print(response.body);
        final moviesApi = jsonDecode(response.body)["data"];
        List<Movie> movies = [];
        for (int i=0; i<moviesApi.length; i++){
          movies.add(Movie.fromJson(moviesApi[i]));
        }
        print(jsonDecode(response.body)["data"].length);
        // print(movies);
        return movies;
  }
  Future<List<Movie>> getAllMoviesDateSearch(String accessToken, String date, String search) async{
    final response = await http.get(
      Uri.parse('$URL_API/api/movies?date=$date&query=$search'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    // print(response.body);
    final moviesApi = jsonDecode(response.body)["data"];
    List<Movie> movies = [];
    for (int i=0; i<moviesApi.length; i++){
      movies.add(Movie.fromJson(moviesApi[i]));
    }
    print(jsonDecode(response.body)["data"].length);
    // print(movies);
    return movies;
  }

  Future<List<Movie>> getAllMovies(String accessToken) async {
    final response = await http.get(
      Uri.parse('$URL_API/api/movies'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    // print(response.body);
    final moviesApi = jsonDecode(response.body)["data"];
    List<Movie> movies = [];
    for (int i=0; i<moviesApi.length; i++){
      movies.add(Movie.fromJson(moviesApi[i]));
    }
    print(jsonDecode(response.body)["data"].length);
    // print(movies);
    return movies;
  }



  Future<List<Session>> getSessionsMovieDate(String accessToken, String date, int movieId) async{
    final response = await http.get(
      Uri.parse('$URL_API/api/movies/sessions?movieId=$movieId&date=$date'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    print(response.body);
    final sessionsApi = jsonDecode(response.body)["data"];
    print(sessionsApi);
    List<Session> sessions = [];
    for (int i=0; i<sessionsApi.length; i++){
     sessions.add(Session.fromJson(sessionsApi[i]));
    }
    print(jsonDecode(response.body)["data"].length);
    print(sessions);
    return sessions;


  }


  Future<Session> getSession(String accessToken, int id) async {
    final response = await http.get(
      Uri.parse('$URL_API/api/movies/sessions/$id'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    return Session.fromJson(jsonDecode(response.body)["data"]);
  }
}


Future<void> main() async {
  MovieRepository movieRepository = MovieRepository();
  AuthorizationRepository auth = AuthorizationRepository();
  // String response = await auth.authorization("+380667236485");
  // print(response);

  final movies = await movieRepository.getAllMoviesDate("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb", '2023-04-27');
  print(movies);
  await movieRepository.getAllMovies("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb");
  List<Session> sessions = await movieRepository.getSessionsMovieDate("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb", '2023-04-27', movies[0].id);
  print(sessions);
  Session session = await movieRepository.getSession("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb", sessions[0].id);

  print(session);

}
// GET /api/movies/sessions?movieId={movieId}&date={date}
// Authorization: Bearer {access_token}
//
//
// GET /api/movies/sessions/{id}
// Authorization: Bearer {access_token}


