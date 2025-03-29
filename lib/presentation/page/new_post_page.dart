import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:soywarmi_app/core/language/locales.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/remote/http_headers_global.dart';
import '../widget/custom_alerts.dart';
import 'main_page.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final _storage = const FlutterSecureStorage();
  final _endPoint = dotenv.env['API_ENDPOINT'];
  final _formPostKey=GlobalKey<FormState>();
  bool isPostRegistering=false;
  registrarPost() async {

    final userToken = await _storage.read(key: 'USER_TOKEN');
    await CustomAlerts.showConfirmationDialog(myWidgetKey.currentContext!).then((isConfirmed) async {
      if(isConfirmed){
        setState(() {
          isPostRegistering=true;
        });
        int isAnonymous=(_value=="Anonimo")?1:0;
        var body=jsonEncode({
          'title':_controllerTitle.text,
          'content':_controllerDescription.text,
          "anonymous":isAnonymous
        });
        List<Map<String, String>>imagesRoutes=[];
        for(int i=0;i<_images.length;i++){
          if(_images[i]!=null){
            imagesRoutes.add({
              "name":"photo${i+1}",
              "path":_images[i]!.path
            });
          }
        }
        await HttpHeadersGlobal.headerPostHttpWithTokenMultipart(userToken!, '$_endPoint/api/v1/post_publication',body,imagesRoutes).then((res){
          if(res.statusCode==200){
            CustomAlerts.showSuccessDialog(context, "Registro correcto", "Publicacion registrada con exito!!!");
          }else{
            CustomAlerts.showSuccessDialog(context, "Registro correcto", "Publicacion registrada con exito!!!");
          }
          setState(() {
            isPostRegistering=false;
          });
        });
      }
    });

  }

  List<File?> _images = [];
  final GlobalKey<_NewPostPageState> myWidgetKey = GlobalKey();
  String? _value = 'Anonimo';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: myWidgetKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage(selectedIndex: 3)));
            },
            icon: Icon(Icons.cancel, color: Theme.of(context).primaryColor),
          ),
          actions: [
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: NbSecondSecondaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      if (_formPostKey.currentState!.validate()) {
                        registrarPost();
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Error ingrese los campos')),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(LocaleData.publicar.getString(context),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                          )),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: (!isPostRegistering)?Column(children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 8, bottom: 8, right: 8),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(NbImageEmpty),
                ),
              ),
              DropdownButton<String>(
                iconSize: 42,
                value: _value,
                dropdownColor: Colors.white,
                items:  [
                  DropdownMenuItem<String>(
                    value: 'Anonimo',
                    child: Text(LocaleData.anonimo.getString(context)),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Publico',
                    child: Text(LocaleData.publico.getString(context)),
                  ),
                ],
                icon: Icon(Icons.arrow_drop_down,
                    color: Theme.of(context).primaryColor),
                underline: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _value = value;
                  });
                },
                hint: const Text('Anonimo'),
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 60, right: 10),
              child: Form(
                key: _formPostKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _controllerTitle,
                      decoration: InputDecoration(
                        hintText: LocaleData.cualEsTuPregunta.getString(context),
                        hintStyle: TextStyle(
                          color: Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                      maxLength: 100,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Ingrese un titulo";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _controllerDescription,
                      decoration: InputDecoration(
                        hintText: LocaleData.descripcion.getString(context),
                        hintStyle: TextStyle(
                          color: Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                        border: InputBorder.none,
                      ),
                      maxLength: 800,
                      validator: (value){
                        if(value!.isEmpty){
                          return "La descripcion no puede estar vacia";
                        }
                        return null;
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _images.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 200,
                              height: 300,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image:
                                            FileImage(_images[index]!, scale: 3),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: CircleAvatar(
                                      child: IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () {
                                          setState(() {
                                            _images.removeAt(index);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: NbSecondSecondaryColor.withOpacity(0.1),
              border: const Border(
                  top: BorderSide(color: NbSecondSecondaryColor, width: 1.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    if (_images.length >= 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                              'No puedes agregar mas de 3 imagenes por post'),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                      );

                      return;
                    }
                    ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then((value) {
                      setState(() {
                        _images.add(File(value!.path));
                      });
                    });
                  },
                  icon: CircleAvatar(
                    backgroundColor: NBSecondPrimaryColor.withOpacity(0.1) ,
                    child: Icon(
                      Icons.image,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ]):const Center(child: CircularProgressIndicator())
    );
  }
}
