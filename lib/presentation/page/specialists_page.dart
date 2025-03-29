import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:soywarmi_app/core/inyection_container.dart';
import 'package:soywarmi_app/domain/entity/doctor_entity.dart';
import 'package:soywarmi_app/presentation/bloc/doctor/get_doctor_cubit.dart';
import 'package:soywarmi_app/presentation/bloc/doctor/get_doctor_state.dart';
import 'package:soywarmi_app/presentation/page/doctor_info_page.dart';
import 'package:soywarmi_app/presentation/widget/custom_text_field.dart';
import 'package:soywarmi_app/presentation/widget/doctor_card.dart';

import '../../core/language/locales.dart';

class SpecialistsPage extends StatefulWidget {
  const SpecialistsPage({Key? key}) : super(key: key);

  @override
  State<SpecialistsPage> createState() => _SpecialistsPageState();
}

class _SpecialistsPageState extends State<SpecialistsPage> {
  final TextEditingController _searchController = TextEditingController();

  List<DoctorEntity> _filteredDoctors = []; 

  @override
  void initState() {
    super.initState();
    _filteredDoctors = []; 
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 2),
          child: CustomTextField(
            controller: _searchController,
            label: LocaleData.buscarDoctor.getString(context),
            colored: true,
            onChanged: (_) {
              setState(() {
                _filterDoctors(); 
              });
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<GetDoctorCubit, GetDoctorsState>(
            bloc: sl<GetDoctorCubit>()..getDoctor(),
            builder: (context, state) {
              if (state is GetDoctorsLoaded) {
                final doctors = state.doctors;

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final doctor = _filteredDoctors.isNotEmpty
                        ? _filteredDoctors[index]
                        : doctors[index];
                    return DoctorCard(
                      doctor: doctor,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorInfoPage(
                              doctor: doctor,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  itemCount: _filteredDoctors.isNotEmpty
                      ? _filteredDoctors.length
                      : doctors.length,
                );
              }
              if (state is GetDoctorsError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No se pudo cargar los doctores, intente de nuevo'),
                    IconButton(
                      onPressed: () {
                        sl<GetDoctorCubit>().getDoctor();
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
        ),
      ],
    );
  }

  void _filterDoctors() {
    final searchQuery = _searchController.text.toLowerCase();
    setState(() {
      _filteredDoctors = [];

      final doctors = sl<GetDoctorCubit>().state.doctors;

      _filteredDoctors.addAll(doctors!.where((doctor) {
        return doctor.name.toLowerCase().contains(searchQuery);
      }));
    });
  }
}
