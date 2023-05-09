import 'package:bloc/bloc.dart';


import '../../datasource/token_local_data_source.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../repository/authorization.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  late final String phoneNumber;

  final DataSource _tokenLocalDatasource = DatasourceImpl();

  AuthBloc():super(AuthInitial()){
    on<SaveUserEvent>(_saveUser);
    on<CheckUserEvent>(_userCheck);
    on<RemoveUserEvent>(_removeUser);
  }

  void _saveUser(SaveUserEvent event, Emitter<AuthState> emit) async{
    print("save");
    await _tokenLocalDatasource.saveToken(event.accessToken as String);
    emit(AuthSuccessful());
  }


  void _userCheck(CheckUserEvent event, Emitter<AuthState> emit) async{
    print("check");
    await _tokenLocalDatasource.getToken();
    emit(AuthSuccessful());

  }

  void _removeUser(RemoveUserEvent event, Emitter<AuthState> emit) async{
    print("remove");
    await _tokenLocalDatasource.deleteToken();
    emit(AuthFailure());
  }
}