import 'package:bloc/bloc.dart';

import '../../datasource/token_local_data_source.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../repository/authorization.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  late final String phoneNumber;

  final TokenLocalDatasourceImpl _tokenLocalDatasource = TokenLocalDatasourceImpl();

  AuthBloc():super(AuthInitial()){
    on<SaveUserEvent>(_saveUser);
    on<CheckUserEvent>(_userCheck);

  }

  void _saveUser(SaveUserEvent event, Emitter<AuthState> emit) async{
    await _tokenLocalDatasource.saveToken(event.accessToken as String );
    emit(AuthSuccessful());
  }


  void _userCheck(CheckUserEvent event, Emitter<AuthState> emit) async{
    await _tokenLocalDatasource.getToken();
    emit(AuthSuccessful());

  }
}