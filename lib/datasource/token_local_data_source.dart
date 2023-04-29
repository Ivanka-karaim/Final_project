
import 'package:shared_preferences/shared_preferences.dart';

abstract class TokenLocalDatasource {
  Future<bool> saveToken(String jwt);
  Future<bool> deleteToken();
  Future<String?> getToken();
  // Future init();

}
class Singleton {
  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();
}
class  TokenLocalDatasourceImpl extends TokenLocalDatasource {
  static final TokenLocalDatasourceImpl _singleton = TokenLocalDatasourceImpl._internal();

  TokenLocalDatasourceImpl._internal();


  factory TokenLocalDatasourceImpl(){
    return _singleton;
  }

  late final Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();

  // @override
  // Future init() async {
  //   print(1111);
  //   if (sharedPreferences == null ) {
  //     sharedPreferences = await SharedPreferences.getInstance();
  //     print(222);
  //   }
  // }

  @override
  Future<bool> saveToken(String jwt) async {

    // await sharedPreferences.setString("Authorization", jwt);
    sharedPreferences.then((value) => value.setString("Authorization", jwt));
    // f.then((v)=>print(v));
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


}