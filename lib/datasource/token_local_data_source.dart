
import 'package:shared_preferences/shared_preferences.dart';

abstract class DataSource {
  Future<bool> saveToken(String jwt);
  Future<bool> deleteToken();
  Future<String?> getToken();
  Future<void> addMovies(List<String> fvt);
  Future<bool> addMovie(String fvt);
  Future<bool> deleteMovie(String fvt);
  Future<List<String>?> getMovies();
  // Future init();

}
// class Singleton {
//   static final Singleton _singleton = Singleton._internal();
//
//   factory Singleton() {
//     return _singleton;
//   }
//
//   Singleton._internal();
// }
class  DatasourceImpl extends DataSource {
  static final DatasourceImpl _singleton = DatasourceImpl._internal();

  DatasourceImpl._internal();


  factory DatasourceImpl(){
    return _singleton;
  }

  late final Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();


  @override
  Future<bool> saveToken(String jwt) async {
    sharedPreferences.then((value) => value.setString("Authorization", jwt));
    return true;
  }

  @override
  Future<String?> getToken() async {
    final jwt = sharedPreferences.then((value) => value.getString("Authorization"));
    // final jwt = sharedPreferences.getString("Authorization");
    return jwt;
  }

  @override
  Future<bool> deleteToken() async {
    sharedPreferences.then((value) => value.remove("Authorization"));
    return true;
  }

  @override
  Future<void> addMovies(List<String> fvt) async {
    sharedPreferences.then((value) => value.setStringList("Favourite_movie", fvt));
  }

  @override
  Future<bool> deleteMovie(String fvt) async {
    List<String> movies = await sharedPreferences.then((value) => value.getStringList("Favourite_movie"))??[];
    movies.remove(fvt);
    sharedPreferences.then((value) => value.setStringList("Favourite_movie", movies));
    return true;
  }

  @override
  Future<bool> addMovie(String fvt) async {
    List<String> movies = await sharedPreferences.then((value) => value.getStringList("Favourite_movie"))??[];
    movies.add(fvt);
    sharedPreferences.then((value) => value.setStringList("Favourite_movie", movies));
    return true;
  }

  @override
  Future<List<String>?> getMovies() async {
    return sharedPreferences.then((value) => value.getStringList("Favourite_movie"));
  }




}