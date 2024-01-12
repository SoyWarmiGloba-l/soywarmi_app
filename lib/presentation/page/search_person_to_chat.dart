import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/inyection_container.dart';
import '../../domain/entity/user_entity.dart';
import '../bloc/chat_conversations/create_chat_conversations_cubit.dart';
import '../bloc/chat_conversations/create_chat_conversations_state.dart';
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
  List<UserEntity>? usersAux=[];

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
  String emailPersonSelected="";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Personas'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width > 600
              ? 600
              : MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  labelText: 'Buscar Persona',
                ),
              ),
              Expanded(
                child: BlocBuilder<GetUsersCubit, GetUsersState>(
                  bloc: sl<GetUsersCubit>()..getUsers(),
                  builder: (context,state){
                    if(state is GetUsersLoaded){
                      usersAux=sl<GetUsersCubit>().state.users;
                      return ListView.builder(
                        itemCount: filteredPeople.length,
                        itemBuilder: (context, index) {
                          return BlocConsumer<CreateChatConversationCubit, CreateChatConversationsState>(
                              bloc: sl<CreateChatConversationCubit>(),
                              listener: (context,state){
                              if (state is CreateChatConversationsFailed) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(state.message),
                                    backgroundColor: Theme.of(context).colorScheme.error,
                                  ),
                                );
                              }
                              if (state is CreateChatConversationsSuccess) {
                                if(filteredPeople[index].email==emailPersonSelected){
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ChatPage(state.id,emailPersonSelected)),
                                  );
                                }
                              }
                            },
                            builder: (context,state){
                              return ListTile(
                                title: Text(filteredPeople[index].email),
                                onTap: () {
                                  emailPersonSelected=filteredPeople[index].email;
                                  sl<CreateChatConversationCubit>().createChatConversation(
                                      name: filteredPeople[index].email,
                                      users: [
                                        filteredPeople[index].id.toString()
                                      ]
                                  );
                                },
                              );
                            }
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

  void _filterPeople() {
    setState(() {
      final users = usersAux;
      if(users!=null){
        filteredPeople = users
            .where((person) =>
            person.email.toLowerCase().contains(searchController.text.toLowerCase()))
            .toList();
      }
    });
  }
}