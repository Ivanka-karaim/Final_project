import 'dart:convert';

import 'package:final_project/models/movie.dart';
import 'package:final_project/models/session.dart';
import 'package:http/http.dart' as http;

import '../data/constants.dart';
import 'authorization.dart';
import 'package:dio/dio.dart';

final dio = Dio();


class MovieRepository {

  MovieRepository(){


  }
  Future<dynamic> getAllMoviesDate(String accessToken, String date) async {
    final response = await http.get(
      Uri.parse('$URL_API/api/movies?date=$date'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    // print(response.body);

    // print(jsonDecode(response.body)["data"].length);
    // print(movies);
    return jsonDecode(response.body);
  }

  Future<List<Movie>> getAllMoviesDateSearch(
      String accessToken, String date, String search) async {
    final response = await http.get(
      Uri.parse('$URL_API/api/movies?date=$date&query=$search'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    // print(response.body);
    final moviesApi = jsonDecode(response.body)["data"];
    List<Movie> movies = [];
    for (int i = 0; i < moviesApi.length; i++) {
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
    for (int i = 0; i < moviesApi.length; i++) {
      movies.add(Movie.fromJson(moviesApi[i]));
    }
    print(jsonDecode(response.body)["data"].length);
    // print(movies);
    return movies;
  }

  Future<dynamic> getSessionsMovieDate(
      String accessToken, String date, int movieId) async {
    final response = await http.get(
      Uri.parse('$URL_API/api/movies/sessions?movieId=$movieId&date=$date'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    // print(response.body);
    // final sessionsApi = jsonDecode(response.body)["data"];
    // print(sessionsApi);
    // List<Session> sessions = [];
    // for (int i = 0; i < sessionsApi.length; i++) {
    //   sessions.add(Session.fromJson(sessionsApi[i]));
    // }
    // print(jsonDecode(response.body)["data"].length);
    // print(sessions);
    // return sessions;
    return jsonDecode(response.body);
  }

  Future<dynamic> getSession(String accessToken, int id) async {
    print("getSession");
    dio.options.headers["Authorization"] = ' Bearer $accessToken';
    final response = await dio.get(
      '$URL_API/api/movies/sessions/$id',
    );
    print(response.data);

    return response.data;
  }

  Future<dynamic> bookSeatsForMovie(
      String accessToken, int sessionId, List<int> seats) async {

    Map<String, dynamic> map = {
      "sessionId": sessionId,
      "seats": seats,

    };
    print(map);
    // final json = jsonEncode(map);
    // print(json);
    final response = await dio.post('$URL_API/api/movies/book',
      data:map,
    );
    print(response);

    return response.data;
  }

  Future<dynamic> buySeats(
      String accessToken,
      int sessionId,
      String email,
      String cardNumber,
      String expirationDate,
      String cvv,
      List<int> seats) async {
    // print(seats);
    dio.options.headers["Authorization"] = ' Bearer $accessToken';
    Map<String, dynamic> map = {

        "seats": seats,
        "sessionId": sessionId,
        "email": email,
        "cardNumber": cardNumber,
        "expirationDate": expirationDate,
        "cvv": cvv

    };

      final response =
      await dio.post('$URL_API/api/movies/buy', data: map,
        options: Options(
          validateStatus: (statusCode){
            if(statusCode == null){
              return false;
            }
            if(statusCode == 422){ // your http status code
              return true;
            }else{
              return statusCode >= 200 && statusCode < 300;
            }
          },
        ));
      return response.data;



  }
}

Future<void> main() async {
  MovieRepository movieRepository = MovieRepository();
  AuthorizationRepository auth = AuthorizationRepository();
  // String response = await auth.authorization("+380667236485");
  // print(response);

  // final movies = await movieRepository.getAllMoviesDate(
  //     "543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb", '2023-05-09');
  // print(movies["data"].length);
  // await movieRepository.getAllMovies("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb");
  // List<Session> sessions = await movieRepository.getSessionsMovieDate("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb", '2023-05-09', movies["data"][0]["id"])["data"];
  // print(sessions);
  // Session session = await movieRepository.getSession("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb", sessions[0].id);
  //
  // print(session);

  // final tickets = await auth.getUserTickets("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb");
  // print(tickets);
  // print(["1","2"].toString());
  final book = await movieRepository.bookSeatsForMovie(
      "543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb", 148, [298]);
  print(book);
  final session = await movieRepository.getSession("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb",148);
  print(session);
  final buy = await movieRepository.buySeats("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb", 148, "svyrop@gmail.com", "1111111111111111", "12/24", "123", [298]);
  print(buy);
  final session1 = await movieRepository.getSession("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb",148);
  print(session1);

  // final tickets1 = await auth.getUserTickets("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb");
  // print(tickets1);
}
