import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:soywarmi_app/core/inyection_container.dart';
import 'package:soywarmi_app/domain/entity/member_entity.dart';
import 'package:soywarmi_app/presentation/bloc/team/get_teams_cubit.dart';
import 'package:soywarmi_app/presentation/bloc/team/get_teams_state.dart';
import 'package:soywarmi_app/presentation/page/member_info_page.dart';
import 'package:soywarmi_app/presentation/widget/custom_text_field.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({Key? key}) : super(key: key);

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  final TextEditingController _searchController = TextEditingController();

  List<MemberEntity> _filteredTeams = []; // Lista filtrada de equipos
  final _endPoint = dotenv.env['API_ENDPOINT'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NBColorWhite,
        elevation: 0,
        title: const Text(
          'Todos los miembros',
          style: TextStyle(color: NBPrimaryColor),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Buscar.....',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) {
                  _filterTeams();
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<GetTeamsCubit, GetTeamsState>(
                bloc: sl<GetTeamsCubit>()..getTeams(),
                builder: (context, state) {
                  if (state is GetTeamsLoaded) {
                    final teams = state.members;

                    return GridView.builder(
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (MediaQuery.of(context).size.width>800)?2:0.8,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _filteredTeams.isNotEmpty
                          ? _filteredTeams.length
                          : teams.length,
                      itemBuilder: (context, index) {
                        final team = _filteredTeams.isNotEmpty
                            ? _filteredTeams[index]
                            : teams[index];
                        return Container(
                          height: 200,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: NbSecondSecondaryColor,
                          ),
                          width: MediaQuery.of(context).size.width * 0.45,
                          margin: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MemberInfoPage(
                                    member: team,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  backgroundImage:NetworkImage((team.photo=='')?'$_endPoint/storage/default_image.png':'$_endPoint${team.photo}'),
                                ),
                                const SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    team.name,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          height: 1.5,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Voluntaria',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  if (state is GetTeamsError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            'No se pudo cargar los miembros, intente de nuevo'),
                        IconButton(
                          onPressed: () {
                            sl<GetTeamsCubit>().getTeams();
                          },
                          icon: Icon(Icons.refresh,
                              color: Theme.of(context).primaryColor),
                        )
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _filterTeams() {
    final searchQuery = _searchController.text.toLowerCase();
    setState(() {
      _filteredTeams = [];

      final teams = sl<GetTeamsCubit>().state.members;

      _filteredTeams.addAll(teams!.where((team) {
        return team.name.toLowerCase().contains(searchQuery);
      }));
    });
  }
}
