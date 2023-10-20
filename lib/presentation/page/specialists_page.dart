import 'package:flutter/material.dart';
import 'package:soywarmi_app/presentation/widget/custom_text_field.dart';
import 'package:soywarmi_app/presentation/widget/doctor_card.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';

class SpecialistsPage extends StatefulWidget {
  const SpecialistsPage({super.key});

  @override
  State<SpecialistsPage> createState() => _SpecialistsPageState();
}

class _SpecialistsPageState extends State<SpecialistsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomTextField(
            label: 'Buscar.....',
            icon: Icons.search,
          ),
        ),
        DoctorCard(
          name: 'Juan Sebastian',
          specialty: 'Urologo',
          onPressed: () {},
          image: NbImageEmpty,
        ),
        DoctorCard(
          name: 'Juan Sebastian',
          specialty: 'Urologo',
          onPressed: () {},
          image: NbImageEmpty,
        ),
        DoctorCard(
          name: 'Juan Sebastian',
          specialty: 'Urologo',
          onPressed: () {},
          image: NbImageEmpty,
        ),
      ],
    );
  }
}
