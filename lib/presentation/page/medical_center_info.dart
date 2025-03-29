import 'package:flutter/material.dart';
import 'package:soywarmi_app/domain/entity/medical_center_entity.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MedicalCenterInfo extends StatefulWidget {
  const MedicalCenterInfo({super.key, required this.medicalCenter});

  final MedicalCenterEntity medicalCenter;

  @override
  State<MedicalCenterInfo> createState() => _MedicalCenterInfoState();
}

class _MedicalCenterInfoState extends State<MedicalCenterInfo> {
  @override
  Widget build(BuildContext context) {

    final formatTime = DateFormat('HH:mm');
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
                radius: 60,
                backgroundColor: Colors.white,
                child: Image.asset('assets/images/hospital_icon.png',
                    width: 90, height: 90),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.medicalCenter.name,
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
                    onPressed: () {},
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
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: Column(children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sobre el centro medico',
                          style: TextStyle(fontSize: 18),
                        )),
                    const SizedBox(height: 10),
                    Text(
                      widget.medicalCenter.description,
                      style: const TextStyle(fontSize: 15),
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: NbSecondSecondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.medicalCenter.phones,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Horario de atencion',
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
                                '${formatTime.format(DateTime.parse(widget.medicalCenter.openingDate))}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'a',
                            style: TextStyle(fontSize: 15),
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
                                '${formatTime.format(DateTime.parse(widget.medicalCenter.closingDate))}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Servicios',
                          style: TextStyle(fontSize: 18),
                        )),
                    widget.medicalCenter.medicalServices.isEmpty
                        ? const Text('No hay servicios')
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                widget.medicalCenter.medicalServices.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
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
                                          widget.medicalCenter
                                              .medicalServices[index],
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              );
                            },
                          ),
                  ]),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
