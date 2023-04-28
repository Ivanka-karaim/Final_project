import 'package:bloc/bloc.dart';

import '../../datasource/token_local_data_source.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';
import '../../repository/authorization.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState>{
  late final String phoneNumber;
  final AuthorizationRepository _authorizationRepository;
  final TokenLocalDatasourceImpl _tokenLocalDatasource;

  SignInBloc(this._authorizationRepository, this._tokenLocalDatasource):super(SignInInitial()){
    on<PhoneNumberEvent>(_phoneNumberCheck);
    on<AuthorizationEvent>(_passwordCheck);

  }

  void _phoneNumberCheck(PhoneNumberEvent event, Emitter<SignInState> emit) async{
    final result = await _authorizationRepository.authorization(event.phoneNumber);
    if (result["success"] == false) {
      emit(SignInPhoneNumberError());
    }else {
      phoneNumber = event.phoneNumber!;
      emit(SignInPhoneNumberSuccessful());
    }
  }


  void _passwordCheck(AuthorizationEvent event, Emitter<SignInState> emit) async{
    final result = await _authorizationRepository.otpAuthorization(phoneNumber, event.password);
    if (result["success"] == false){
      emit(SignInPasswordError());
    }else{
      final accessToken = result["data"]["accessToken"];
      _tokenLocalDatasource.saveToken(accessToken);
      emit(SignInSuccessful());
    }

  }
}