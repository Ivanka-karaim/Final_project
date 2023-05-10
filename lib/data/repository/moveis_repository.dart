import 'dart:convert';

import 'package:final_project/features/movies/models/movie.dart';

import 'package:http/http.dart' as http;

import '../constants.dart';

import 'package:dio/dio.dart';

final dio = Dio();

class MovieRepository {
  Future<dynamic> getAllMoviesDate(String accessToken, String date) async {
    final response = await http.get(
      Uri.parse('$URL_API/api/movies?date=$date'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': 'uk',
      },
    );

    return jsonDecode(response.body);
  }

  Future<dynamic> getMovieId(String accessToken, int id) async {
    final response = await http.get(
      Uri.parse('$URL_API/api/movies?$id'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': 'uk',
      },
    );

    return jsonDecode(response.body);
  }

  Future<List<Movie>> getAllMoviesDateSearch(
      String accessToken, String date, String search) async {
    final response = await http.get(
      Uri.parse('$URL_API/api/movies?date=$date&query=$search'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': 'uk',
      },
    );
    final moviesApi = jsonDecode(response.body)["data"];
    List<Movie> movies = [];
    for (int i = 0; i < moviesApi.length; i++) {
      movies.add(Movie.fromJson(moviesApi[i]));
    }
    return movies;
  }

  Future<List<Movie>> getAllMovies(String accessToken) async {
    final response = await http.get(
      Uri.parse('$URL_API/api/movies'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': 'uk',
      },
    );
    final moviesApi = jsonDecode(response.body)["data"];
    List<Movie> movies = [];
    for (int i = 0; i < moviesApi.length; i++) {
      movies.add(Movie.fromJson(moviesApi[i]));
    }
    return movies;
  }

  Future<dynamic> getSessionsMovieDate(
      String accessToken, String date, int movieId) async {
    final response = await http.get(
      Uri.parse('$URL_API/api/movies/sessions?movieId=$movieId&date=$date'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': 'uk',
      },
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> getSession(String accessToken, int id) async {
    dio.options.headers["Authorization"] = ' Bearer $accessToken';
    dio.options.headers["Accept-Language"] = 'uk';
    final response = await dio.get(
      '$URL_API/api/movies/sessions/$id',
    );
    return response.data;
  }

  Future<dynamic> bookSeatsForMovie(
      String accessToken, int sessionId, List<int> seats) async {
    dio.options.headers["Authorization"] = ' Bearer $accessToken';
    dio.options.headers["Accept-Language"] = 'uk';
    Map<String, dynamic> map = {
      "sessionId": sessionId,
      "seats": seats,
    };
    final response = await dio.post(
      '$URL_API/api/movies/book',
      data: map,
    );
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
    dio.options.headers["Authorization"] = ' Bearer $accessToken';
    dio.options.headers["Accept-Language"] = 'uk';
    Map<String, dynamic> map = {
      "seats": seats,
      "sessionId": sessionId,
      "email": email,
      "cardNumber": cardNumber,
      "expirationDate": expirationDate,
      "cvv": cvv
    };

    final response =
        await dio.post('$URL_API/api/movies/buy', data: map, options: Options(
      validateStatus: (statusCode) {
        if (statusCode == null) {
          return false;
        }
        if (statusCode == 422) {
          // your http status code
          return true;
        } else {
          return statusCode >= 200 && statusCode < 300;
        }
      },
    ));
    return response.data;
  }
}
