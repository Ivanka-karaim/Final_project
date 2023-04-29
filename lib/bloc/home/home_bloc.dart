
import 'package:bloc/bloc.dart';
import 'package:final_project/bloc/home/home_event.dart';
import 'package:final_project/bloc/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc():super(const HomeInitial()){
    on<ChangeEvent>(_changeEvent);
  }

  void _changeEvent(ChangeEvent event, Emitter<HomeState> emit) async {
    emit(HomeResultState(event.cIndex));
  }


}