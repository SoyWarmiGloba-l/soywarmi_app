import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soywarmi_app/presentation/bloc/chat_conversations/create_chat_conversations_cubit.dart';
import 'package:soywarmi_app/presentation/bloc/chat_conversations/create_chat_conversations_state.dart';
import 'package:soywarmi_app/presentation/bloc/user/get_users_cubit.dart';
import 'package:soywarmi_app/presentation/bloc/user/get_users_state.dart';

import '../../core/inyection_container.dart';
import '../../domain/entity/user_entity.dart';
import 'chat_page.dart';

class Person {
  String name;
  bool isSelected;

  Person(this.name, this.isSelected);
}

class SearchPeopleToGroup extends StatefulWidget {
  @override
  _SearchPeopleToGroupState createState() => _SearchPeopleToGroupState();
}

class _SearchPeopleToGroupState extends State<SearchPeopleToGroup> {


  List filteredPeople = [];
  TextEditingController searchController = TextEditingController();
  TextEditingController groupNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final users = sl<GetUsersCubit>().state.users;
    if(users!=null){
      filteredPeople = users.map((e) => {
        "id":e.id,
        "email":e.email,
        "isSelected":false
      }).toList();

    }
    searchController.addListener(() {
      _filterPeople();
    });
  }
  List<UserEntity>? usersAux=[];
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
                  bloc:sl<GetUsersCubit>()..getUsers() ,
                  builder: (context,state){
                    if(state is GetUsersLoaded){
                      usersAux=sl<GetUsersCubit>().state.users;
                      return ListView.builder(
                            itemCount: filteredPeople.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(filteredPeople[index]["email"]),
                                trailing: Checkbox(
                                  value: filteredPeople[index]["isSelected"],
                                  onChanged: (value) {
                                    setState(() {
                                      filteredPeople[index]["isSelected"] = value!;
                                    });
                                  },
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
              BlocConsumer<CreateChatConversationCubit, CreateChatConversationsState>(
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
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatPage(state.id,groupNameController.text)),
                    );
                  }

                },
                builder: (context,state){
                  return ElevatedButton(
                    onPressed: () {
                      _showCreateGroupDialog();
                    },
                    child: const Text('Crear Grupo'),
                  );
                }
              ),
            ],
          ),
        ),
      )
    );
  }

  void _filterPeople() {
    setState(() {
      List<UserEntity>? users = usersAux;
      if(users!=null){
        users= users.where((person) =>
            person.email.toLowerCase().contains(searchController.text.toLowerCase()))
            .toList();
        filteredPeople = users.map((e) => {
          "id":e.id,
          "email":e.email,
          "isSelected":false
        }).toList();

      }

    });
  }

  void _showCreateGroupDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Crear Grupo'),
          content: TextField(
            controller: groupNameController,
            decoration: const InputDecoration(labelText: 'Nombre del Grupo'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _createGroup();
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _createGroup() {
    List<String> idUsers =[];
    String groupName = groupNameController.text;
    for (var person in filteredPeople) {
      if(person["isSelected"]){
        idUsers.add(person["id"].toString());
      }
    }
    sl<CreateChatConversationCubit>().createChatConversation(
      name: groupName,
      users: idUsers
    );

  }
}
