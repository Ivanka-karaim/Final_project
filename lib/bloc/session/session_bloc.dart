import 'package:bloc/bloc.dart';
import 'package:final_project/bloc/session/session_event.dart';
import 'package:final_project/bloc/session/session_state.dart';

import '../../datasource/token_local_data_source.dart';
import '../../repository/authorization.dart';
import '../../repository/moveis_repository.dart';

class SessionBloc extends Bloc<SessionEvent,SessionState>{

  final TokenLocalDatasource _tokenLocalDatasource = TokenLocalDatasourceImpl();
  final MovieRepository _movieRepository = MovieRepository();

  SessionBloc():super(SessionInitial()){
    on<BookSeatsEvent>(_bookSeats);
  }

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
        emit(SessionFailure());
      }else{
        print(true);
        emit(SessionBook());
      }
    }
  }




}