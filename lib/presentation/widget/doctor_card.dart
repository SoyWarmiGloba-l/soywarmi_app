import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:soywarmi_app/domain/entity/doctor_entity.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';

class DoctorCard extends StatelessWidget {
  final _endPoint = dotenv.env['API_ENDPOINT'];

  final DoctorEntity doctor;
  final VoidCallback onPressed;
  DoctorCard(
      {super.key,
      required this.doctor,
      required this.onPressed,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: NbSecondSecondaryColor.withOpacity(0.5), width: 1.0)),
        ),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage((doctor.photo=='')?'$_endPoint/storage/default_image.png':'$_endPoint${doctor.photo}'),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${doctor.name}',
                maxLines: 1,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines:1,
                doctor.specialty,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
