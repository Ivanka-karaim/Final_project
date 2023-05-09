import 'package:bloc/bloc.dart';
import 'package:final_project/bloc/profile/profile_event.dart';
import 'package:final_project/bloc/profile/profile_state.dart';


import '../../datasource/token_local_data_source.dart';

import '../../models/ticket.dart';
import '../../models/user.dart';
import '../../repository/authorization.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{

  final DataSource _tokenLocalDatasource = DatasourceImpl();
  final AuthorizationRepository _authorizationRepository = AuthorizationRepository();

  ProfileBloc():super(ProfileInitial()){
    on<GetUserEvent>(_getUser);
    on<GetUserTicketsEvent>(_getUserTickets);
    on<ChangeUserEvent>(_changeUser);
  }

  void _changeUser(ChangeUserEvent event, Emitter<ProfileState> emit) async{
    final accessToken = await _tokenLocalDatasource.getToken();
    if (accessToken == null) {
      emit(ProfileFailure(error:'Account error'));
    }else {
      final user = await _authorizationRepository.changeUser({"name":event.name}, accessToken);
      if (user["success"] == false){
        emit(ProfileFailure(error: user["data"]));
      }else{
        print(12);
        emit(ProfileInformation(user:User.fromJson(user["data"] as Map<String, dynamic>)));
      }
    }
  }

  void _getUser(GetUserEvent event, Emitter<ProfileState> emit) async{
    final accessToken = await _tokenLocalDatasource.getToken();
    if (accessToken == null) {
      emit(ProfileFailure(error:'Account error'));
    }else {
      final user = await _authorizationRepository.getUser(accessToken);
      if (user["success"] == false){
        emit(ProfileFailure(error: user["data"]));
      }else{
        emit(ProfileInformation(user:User.fromJson(user["data"] as Map<String, dynamic>)));
      }
    }
  }

  void _getUserTickets(GetUserTicketsEvent event, Emitter<ProfileState> emit) async{

    final accessToken = await _tokenLocalDatasource.getToken();
    if (accessToken == null) {
      emit(ProfileFailure(error:'Account error'));
    }else {
      final userTickets = await _authorizationRepository.getUserTickets(accessToken);
      if (userTickets["success"] == false){
        emit(ProfileFailure(error: userTickets["data"]));
      }else{

        List<Ticket> tickets = [];
        for (int i = 0; i < userTickets["data"].length; i++) {
          final ticket = Ticket.fromJson(userTickets["data"][i]);
          tickets.add(ticket);
        }
        List<Ticket> ticketsFilter = tickets.where((ticket) => ticket.date.isAfter(DateTime.now())).toList();
        ticketsFilter.sort((a, b)=>a.date.compareTo(b.date));
        emit(ProfileInformationTickets(tickets: ticketsFilter));

      }
    }
  }


}