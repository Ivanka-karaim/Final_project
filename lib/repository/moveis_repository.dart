import 'dart:convert';

import 'package:final_project/models/movie.dart';
import 'package:final_project/models/session.dart';
import 'package:http/http.dart' as http;

import '../data/constants.dart';
import 'authorization.dart';

class MovieRepository {
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

  Future<List<Movie>> getAllMoviesDateSearch(String accessToken, String date,
      String search) async {
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


  Future<dynamic> getSessionsMovieDate(String accessToken, String date,
      int movieId) async {
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


  Future<Session> getSession(String accessToken, int id) async {
    final response = await http.get(
      Uri.parse('$URL_API/api/movies/sessions/$id'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    return Session.fromJson(jsonDecode(response.body)["data"]);
  }

  Future<bool> bookSeatsForMovie(String accessToken, int sessionId,
      List<int> seats) async {
    final response = await http.post(Uri.parse('$URL_API/api/movies/book'),

        headers: {
          "Authorization": ' Bearer $accessToken'
        },
        body: {
          "seats": seats.toString(),
          "sessionId": sessionId.toString()
        }
    );

    return jsonDecode(response.body)["success"];
  }

  Future<bool> buySeats(String accessToken, int sessionId, String email,
      String cardNumber, String expirationDate, String cvv,
      List<int> seats) async {
    final response = await http.post(Uri.parse('$URL_API/api/movies/buy'),

        headers: {
          "Authorization": ' Bearer $accessToken'
        },
        body: {
          "seats": seats.toString(),
          "sessionId": sessionId.toString(),
          "email": email,
          "cardNumber": cardNumber,
          "expirationDate": expirationDate,
          "cvv": cvv
        }
    );

    return jsonDecode(response.body)["success"];
  }


}


Future<void> main() async {
  MovieRepository movieRepository = MovieRepository();
  AuthorizationRepository auth = AuthorizationRepository();
  // String response = await auth.authorization("+380667236485");
  // print(response);

  final movies = await movieRepository.getAllMoviesDate(
      "543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb", '2023-05-09');
  // print(movies["data"].length);
  // await movieRepository.getAllMovies("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb");
  List<Session> sessions = await movieRepository.getSessionsMovieDate("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb", '2023-05-09', movies["data"][0]["id"]);
  print(sessions);
  // Session session = await movieRepository.getSession("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb", sessions[0].id);
  //
  // print(session);

  final tickets = await auth.getUserTickets("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb");
  // print(tickets);
  // print(["1","2"].toString());
  final book = await movieRepository.bookSeatsForMovie("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb", 10, [1,2]);
  // print(book);
  final buy = await movieRepository.buySeats("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb", 10, "svyrop@gmail.com", "1111111111111111", "12/24", "123", [1,2]);
  // print(buy);
  final tickets1 = await auth.getUserTickets("543|5Yt76GTj0u1ZBi6prqmQLPRHSfs8Yx6DuLaUtEsb");
  // print(tickets1);


}


