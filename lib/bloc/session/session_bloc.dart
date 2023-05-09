import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:final_project/bloc/session/session_event.dart';
import 'package:final_project/bloc/session/session_state.dart';

import '../../datasource/token_local_data_source.dart';
import '../../models/seat.dart';
import '../../models/session.dart';
import '../../repository/authorization.dart';
import '../../repository/moveis_repository.dart';
import '../../widgets/movies/session/pdf.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final TokenLocalDatasource _tokenLocalDatasource = TokenLocalDatasourceImpl();
  final MovieRepository _movieRepository = MovieRepository();

  // List<Seat> seats = [];

  SessionBloc() : super(SessionInitial()) {
    on<BookSeatsEvent>(_bookSeats);
    on<GetSessionEvent>(_getSession);
    on<BuySeatsEvent>(_buySeats);
    // on<AddToListSeatsEvent>(_addSeat);
  }

  // void _addSeat(AddToListSeatsEvent event, Emitter<SessionState> emit) async {
  //   seats.add(event.seat);
  //   print(seats);
  //   emit(SeatsSuccessful());
  // }

  void _bookSeats(BookSeatsEvent event, Emitter<SessionState> emit) async {
    final accessToken = await _tokenLocalDatasource.getToken();
    if (accessToken == null) {
      emit(SessionFailure(error: 'Account error'));
    } else {
      List<int> seats = [];
      for (int i = 0; i < event.seats.length; i++) {
        seats.add(event.seats[i].id);
      }
      final book = await _movieRepository.bookSeatsForMovie(
          accessToken, event.session.id, seats);
      if (book["success"] == false) {
        emit(SessionFailure(error: book["data"]));
      } else {
        emit(SessionBook());
      }
    }
  }

  void _buySeats(BuySeatsEvent event, Emitter<SessionState> emit) async {
    final accessToken = await _tokenLocalDatasource.getToken();
    if (accessToken == null) {
      emit(SessionFailure(error: "Account error"));
    } else {
      RegExp reg = RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$');
      final bool emailValid = reg.hasMatch(event.email);

      print(1);
      print(emailValid);

      RegExp regCard = RegExp(r'^\d{4}(-?\d{4}){3}$');
      final bool cardValid = regCard.hasMatch(event.cardNumber);

      print(2);
      print(cardValid);

      RegExp regDate = RegExp(r'^\d{2}/\d{2}$');
      final bool dateValid = regDate.hasMatch(event.expirationDate);

      print(3);
      print(dateValid);

      RegExp regCvv = RegExp(r'^\d{3}$');
      final bool cvvValid = regCvv.hasMatch(event.cvv);

      print(4);
      print(cvvValid);

      if (reg.hasMatch(event.email) == false) {
        emit(BuyError(error: 'Неправильно введена пошта'));
      } else if (regCard.hasMatch(event.cardNumber) == false) {
        emit(BuyError(error: 'Неправильно введено номер карти'));
      } else if (regDate.hasMatch(event.expirationDate) == false) {
        emit(BuyError(error: 'Неправильно введено дату'));
      } else if (regCvv.hasMatch(event.cvv) == false) {
        emit(BuyError(error: 'Неправильно введено cvv'));
      } else {
        List<int> seats = [];
        for (int i = 0; i < event.seats.length; i++) {
          seats.add(event.seats[i].id);
        }

        final buy = await _movieRepository.buySeats(
            accessToken,
            event.sessionId,
            event.email,
            event.cardNumber.replaceAll('-', ''),
            event.expirationDate,
            event.cvv,
            seats);

        if (buy["success"] == false) {
          emit(SessionFailure(error: buy["data"]));
        } else {
          emit(BuySuccessful());
        }
      }
    }
  }

  void _getSession(GetSessionEvent event, Emitter<SessionState> emit) async {
    final accessToken = await _tokenLocalDatasource.getToken();
    if (accessToken == null) {
      emit(SessionFailure(error: "Account error"));
    } else {
      final sessionResponse =
          await _movieRepository.getSession(accessToken, event.sessionId);

      if (sessionResponse["success"] == false) {
        print(false);
        emit(SessionFailure(error: sessionResponse["data"]));
      } else {
        final session = Session.fromJson(sessionResponse["data"]);
        emit(SessionObject(session: session));
      }
    }
  }
}
