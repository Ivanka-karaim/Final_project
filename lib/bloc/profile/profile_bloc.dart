import 'package:bloc/bloc.dart';
import 'package:final_project/bloc/profile/profile_event.dart';
import 'package:final_project/bloc/profile/profile_state.dart';


import '../../datasource/token_local_data_source.dart';

import '../../models/ticket.dart';
import '../../models/user.dart';
import '../../repository/authorization.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{

  final TokenLocalDatasource _tokenLocalDatasource = TokenLocalDatasourceImpl();
  final AuthorizationRepository _authorizationRepository = AuthorizationRepository();

  ProfileBloc():super(ProfileInitial()){
    on<GetUserEvent>(_getUser);
    on<GetUserTicketsEvent>(_getUserTickets);
  }

  void _getUser(GetUserEvent event, Emitter<ProfileState> emit) async{
    final accessToken = await _tokenLocalDatasource.getToken();
    if (accessToken == null) {
      emit(ProfileFailure());
    }else {
      final user = await _authorizationRepository.getUser(accessToken);
      if (user["success"] == false){
        emit(ProfileFailure());
      }else{
        emit(ProfileInformation(user:User.fromJson(user["data"] as Map<String, dynamic>)));
      }
    }
  }

  void _getUserTickets(GetUserTicketsEvent event, Emitter<ProfileState> emit) async{

    final accessToken = await _tokenLocalDatasource.getToken();
    if (accessToken == null) {
      emit(ProfileFailure());
    }else {
      final userTickets = await _authorizationRepository.getUserTickets(accessToken);
      if (userTickets["success"] == false){
        emit(ProfileFailure());
      }else{

        List<Ticket> tickets = [];
        for (int i = 0; i < userTickets["data"].length; i++) {
          final ticket = Ticket.fromJson(userTickets["data"][i]);
          tickets.add(ticket);
        }
        print(tickets.length);
        List<Ticket> ticketsFilter = tickets.where((ticket) => ticket.date.isAfter(DateTime.now())).toList();
        print(ticketsFilter.length);
        ticketsFilter.sort((a, b)=>a.date.compareTo(b.date));
        print(ticketsFilter.length);
        emit(ProfileInformationTickets(tickets: ticketsFilter));
        print(state);
      }
    }
  }


}