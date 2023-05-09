import 'package:bloc/bloc.dart';

import '../../datasource/token_local_data_source.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';
import '../../repository/authorization.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState>{
  late final String phoneNumber;
  final AuthorizationRepository _authorizationRepository;
  final DatasourceImpl _tokenLocalDatasource;

  SignInBloc(this._authorizationRepository, this._tokenLocalDatasource):super(SignInInitial()){
    on<PhoneNumberEvent>(_phoneNumberCheck);
    on<AuthorizationEvent>(_passwordCheck);

  }

  void _phoneNumberCheck(PhoneNumberEvent event, Emitter<SignInState> emit) async{
    RegExp reg = RegExp(r'^\+380\d{9}$');
    bool phoneNumberValid = reg.hasMatch(event.phoneNumber.toString());
    if (phoneNumberValid == false){
      emit(SignInError(error:'Неправильно введено номер телефону'));
    }else {
      final result = await _authorizationRepository.authorization(
          event.phoneNumber);
      if (result["success"] == false) {
        emit(SignInPhoneNumberError());
      } else {
        phoneNumber = event.phoneNumber!;
        emit(SignInPhoneNumberSuccessful());
      }
    }
  }


  void _passwordCheck(AuthorizationEvent event, Emitter<SignInState> emit) async {
    RegExp reg = RegExp(r'^\d{4}$');
    bool otpValid = reg.hasMatch(event.password.toString());
    if (otpValid == false) {
      emit(SignInError(error: 'Неправильно введено otp'));
    } else {
      final result = await _authorizationRepository.otpAuthorization(
          phoneNumber, event.password);
      if (result["success"] == false) {
        emit(SignInPasswordError());
      } else {
        final accessToken = result["data"]["accessToken"];
        _tokenLocalDatasource.saveToken(accessToken);
        emit(SignInSuccessful());
      }
    }
  }
}