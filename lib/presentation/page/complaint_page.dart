import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soywarmi_app/presentation/widget/custom_button.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final TextEditingController _controller = TextEditingController();

  final String _recipientEmail = 'soywarmiglobal.edu@gmail.com';

  Future<void> _sendEmail(String subject, String body) async {
    final Email email = Email(
        body: body,
        subject: subject,
        recipients: ['soywarmiglobal.edu@gmail.com'],
        cc: [''],
        bcc: [''],
        isHTML: false);

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      //snackbar
      print(error);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al enviar el correo $error'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  List<Map<String, dynamic>> types = [
    {
      'name': 'Abuso sexual',
      'selected': false,
    },
    {
      'name': 'Violencia familiar',
      'selected': false,
    },
    {
      'name': 'Violencia de género',
      'selected': false,
    },
    {
      'name': 'Violencia psicológica',
      'selected': false,
    },
    {
      'name': 'Violencia física',
      'selected': false,
    },
    {
      'name': 'Violencia sexual',
      'selected': false,
    },
    {
      'name': 'Acoso laboral',
      'selected': false,
    },
  ];

  Map<String, dynamic>? _selectedType;

  void _showTypeComplaint() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Selecciona el tipo de denuncia',
                        style: TextStyle(
                          fontSize: 18,
                          color: NBSecondPrimaryColor,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: types.length,
                      itemBuilder: (BuildContext context, int index) {
                        final type = types[index];
                        return CheckboxListTile(
                          activeColor: NBSecondPrimaryColor,
                          title: Text(type['name']),
                          value: type['selected'],
                          onChanged: (bool? value) {
                            setState(() {
                              types.forEach((city) {
                                city['selected'] = false;
                              });
                              types[index]['selected'] = value;

                              if (value == true) {
                                _selectedType = type;
                              } else {
                                _selectedType = null;
                              }
                            });

                            Navigator.pop(context);
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    _selectedType = types[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'Realizar Denuncia',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*const Text(
                        'Tipo de denuncia',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          _showTypeComplaint();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [
                              Text(
                                _selectedType != null
                                    ? _selectedType!['name']
                                    : 'Selecciona el tipo de denuncia',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_drop_down)
                            ]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Realizar Denuncia',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                            ),
                          ),
                          filled: true,
                          fillColor:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          hintText: 'Escribe tu denuncia',
                          hintStyle: TextStyle(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                          ),
                          border: InputBorder.none,
                        ),
                        maxLines: 10,
                        maxLength: 100,
                      ),*/
                      const Text(
                        'Comunicate con nosotros',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                            backgroundColor: NbSecondSecondaryColor,
                            child: Icon(
                              FontAwesomeIcons.instagram,
                              color: Theme.of(context).primaryColor,
                            )),
                        title: const Text('FACEBOOK'),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryColor,
                        ),
                        onTap: () {
                          final Uri facebookLaunchUri = Uri(
                            scheme: 'https',
                            host: 'www.facebook.com',
                            path: 'soywarmi',
                          );

                          if (facebookLaunchUri != null) {
                            launchUrl(facebookLaunchUri);
                          }
                        },
                      ),
                      ListTile(
                        leading: CircleAvatar(
                            backgroundColor: NbSecondSecondaryColor,
                            child: Icon(
                              Icons.email,
                              color: Theme.of(context).primaryColor,
                            )),
                        title: const Text('CORREO ELECTRONICO'),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryColor,
                        ),
                        onTap: () {
                          final Uri _emailLaunchUri = Uri.parse("mailto:soywarmiglobal.edu@gmail.com?subject=Denuncia&body=Hola quiero hacer una denuncia, necesito ayuda");

                          if (_emailLaunchUri != null) {
                            launchUrl(_emailLaunchUri);
                          }
                        },
                      ),
                      ListTile(
                        leading: CircleAvatar(
                            backgroundColor: NbSecondSecondaryColor,
                            child: Icon(
                              FontAwesomeIcons.phone,
                              color: Theme.of(context).primaryColor,
                            )),
                        title: const Text('LLAMANOS'),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryColor,
                        ),
                        onTap: () {
                          final Uri phoneLaunchUri = Uri(
                            scheme: 'tel',
                            path: '73309063',
                          );

                          if (phoneLaunchUri != null) {
                            launchUrl(phoneLaunchUri);
                          }
                        },
                      ),
                      ListTile(
                        leading: CircleAvatar(
                            backgroundColor: NbSecondSecondaryColor,
                            child: Icon(
                              FontAwesomeIcons.whatsapp,
                              color: Theme.of(context).primaryColor,
                            )),
                        title: const Text('WHATSAPP'),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryColor,
                        ),
                        onTap: () {
                          final Uri phoneLaunchUri = Uri.parse('https://api.whatsapp.com/send/?phone=59173309063&text=Hola quiero hacer una denuncia, necesito ayuda');

                          if (phoneLaunchUri != null) {
                            launchUrl(phoneLaunchUri);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              /*CustomButton(
                  label: 'Enviar denuncia',
                  onPressed: () {
                    _sendEmail(
                      'Denuncia de ${_selectedType!['name']}',
                      _controller.text,
                    );
                  })*/
            ],
          ),
        ));
  }
}
