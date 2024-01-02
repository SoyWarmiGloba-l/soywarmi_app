import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/inyection_container.dart';
import '../../domain/entity/user_entity.dart';
import '../bloc/chat_conversations/create_chat_conversations_cubit.dart';
import '../bloc/chat_conversations/create_chat_conversations_state.dart';
import '../bloc/team/get_teams_cubit.dart';
import '../bloc/user/get_users_cubit.dart';
import '../bloc/user/get_users_state.dart';
import 'chat_page.dart';


class SearchPersonToChat extends StatefulWidget {
  @override
  _SearchPersonToChatState createState() => _SearchPersonToChatState();
}

class _SearchPersonToChatState extends State<SearchPersonToChat> {

  List<UserEntity> filteredPeople = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final users = sl<GetUsersCubit>().state.users;
    if(users!=null){
      filteredPeople = users;
    }
    searchController.addListener(() {
      _filterPeople();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Personas'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width > 600
              ? 600
              : MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Buscar Persona',
                ),
              ),
              Expanded(
                child: BlocBuilder<GetUsersCubit, GetUsersState>(
                  bloc: sl<GetUsersCubit>()..getUsers(),
                  builder: (context,state){
                    if(state is GetUsersLoaded){
                      return ListView.builder(
                        itemCount: filteredPeople.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: BlocConsumer<CreateChatConversationCubit, CreateChatConversationsState>(
                              listener: (context,state){
                                if (state is CreateChatConversationsFailed) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.message),
                                      backgroundColor: Theme.of(context).colorScheme.error,
                                    ),
                                  );
                                }
                                print("STATE----------------------------------------------------------------------------------------");
                                print(state);
                                if (state is CreateChatConversationsSuccess) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ChatPage(state.id,filteredPeople[index].email)),
                                  );
                                  /*context
                          .read<AuthenticationBloc>()
                          .add(const AuthenticationStatusChanged(true));*/
                                }

                              },
                              builder: (context,state){
                                return ListTile(
                                  title: Text(filteredPeople[index].email),
                                  onTap: () {
                                    _showPersonName(context, filteredPeople[index].id);
                                  },
                                );
                              }
                            ),
                          );
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPersonName(BuildContext context, String personName) {
    // Puedes hacer cualquier acción aquí, por ejemplo, imprimir el nombre en la consola
    print('Nombre de la persona: $personName');
  }

  void _filterPeople() {
    setState(() {
      final users = sl<GetUsersCubit>().state.users;
      if(users!=null){
        filteredPeople = users
            .where((person) =>
            person.email.toLowerCase().contains(searchController.text.toLowerCase()))
            .toList();
      }
    });
  }
}