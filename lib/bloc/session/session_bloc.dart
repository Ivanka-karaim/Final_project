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

class SessionBloc extends Bloc<SessionEvent,SessionState>{

  final TokenLocalDatasource _tokenLocalDatasource = TokenLocalDatasourceImpl();
  final MovieRepository _movieRepository = MovieRepository();
  // List<Seat> seats = [];

  SessionBloc():super(SessionInitial()){
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

  void _bookSeats(BookSeatsEvent event, Emitter<SessionState> emit) async{
    final accessToken = await _tokenLocalDatasource.getToken();
    if (accessToken == null) {
      emit(SessionFailure());
    }else {
      List<int> seats = [];
      for(int i=0;i<event.seats.length; i++){
        seats.add(event.seats[i].id);
      }
      final book = await _movieRepository.bookSeatsForMovie(accessToken, event.session.id, seats);
      if (book["success"] == false){
        print(false);
        print(1111);
        print(book);
        emit(SessionFailure());
      }else{
        print(true);
        emit(SessionBook());
      }
    }
  }

  void _buySeats(BuySeatsEvent event, Emitter<SessionState> emit) async{
    print("buy");
    final accessToken = await _tokenLocalDatasource.getToken();
    if (accessToken == null) {
      emit(SessionFailure());
    }else {
      List<int> seats = [];
      for(int i=0;i<event.seats.length; i++){
        seats.add(event.seats[i].id);
      }

        final buy = await _movieRepository.buySeats(
            accessToken,
            event.sessionId,
            event.email,
            event.cardNumber,
            event.expirationDate,
            event.cvv,
            seats);
      print(buy);

      if (buy["success"] == false){
        emit(SessionFailure());
      }else{
        createPdf();
        emit(BuySuccessful());
      }
      }
    }



  void _getSession(GetSessionEvent event, Emitter<SessionState> emit) async{
    final accessToken = await _tokenLocalDatasource.getToken();
    if (accessToken == null) {
      emit(SessionFailure());
    }else {
      final sessionResponse = await _movieRepository.getSession(accessToken, event.sessionId);


      if (sessionResponse["success"] == false){
        print(false);
        emit(SessionFailure());
      }else{
        final session = Session.fromJson(sessionResponse["data"]);
        emit(SessionObject(session: session));
      }
    }
  }




}

