import 'package:flutter/material.dart';
import 'package:soywarmi_app/domain/entity/doctor_entity.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorInfoPage extends StatefulWidget {
  final DoctorEntity doctor;
  const DoctorInfoPage({required this.doctor, super.key});

  @override
  State<DoctorInfoPage> createState() => _DoctorInfoPageState();
}

class _DoctorInfoPageState extends State<DoctorInfoPage> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    // final  url = Uri.parse('tel:$phoneNumber') ;

    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // } else {
    //   throw 'No se pudo iniciar la llamada: $url';
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: NbSecondSecondaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: NbSecondSecondaryColor),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(widget.doctor.photo),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.doctor.name,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 20,
                  child: IconButton(
                    icon: const Icon(Icons.phone),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(
                    icon: const Icon(
                      Icons.message,
                    ),
                    onPressed: () {
                      _makePhoneCall(widget.doctor.phone.toString());
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: Column(children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sobre el medico',
                        style: TextStyle(fontSize: 18),
                      )),
                  const SizedBox(height: 10),
                  const Text(
                    'Un médico es un profesional que practica la medicina y que intenta mantener y recuperar la salud mediante el estudio, el diagnóstico y el tratamiento de la enfermedad',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Especialidades',
                        style: TextStyle(fontSize: 18),
                      )),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: NbSecondSecondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.doctor.specialty,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ubicacion',
                        style: TextStyle(fontSize: 18),
                      )),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: NbSecondSecondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Cochabamba',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Contacto',
                        style: TextStyle(fontSize: 18),
                      )),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: NbSecondSecondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.doctor.phone.toString().isEmpty
                                  ? 'Sin telefono'
                                  : widget.doctor.phone.toString(),
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: NbSecondSecondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.doctor.email,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Genero',
                        style: TextStyle(fontSize: 18),
                      )),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: NbSecondSecondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.doctor.gender,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
