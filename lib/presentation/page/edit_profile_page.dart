
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soywarmi_app/presentation/widget/custom_button.dart';
import 'package:soywarmi_app/presentation/widget/custom_date_picker.dart';
import 'package:soywarmi_app/presentation/widget/custom_text_field.dart';
import 'package:soywarmi_app/presentation/widget/custom_text_litle.dart';
import 'package:soywarmi_app/presentation/widget/gender_card.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import '../../data/remote/http_headers_global.dart';
import '../widget/custom_alerts.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? imageProfile;
  TextEditingController name=TextEditingController();
  TextEditingController lastname=TextEditingController();
  TextEditingController motherLastname=TextEditingController();
  TextEditingController phone=TextEditingController();
  DateTime selectedDate=DateTime.now();
  String gender="Masculino";
  bool editedImage=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtainMyAccount();
  }
  final storage = const FlutterSecureStorage();
  final _endPoint = dotenv.env['API_ENDPOINT'];
  Map<dynamic,dynamic> myAccount={
    "name":""
  };
  Future<void> obtainMyAccount() async {
    final myAccountJson = await storage.read(key: 'my_account');
    if (myAccountJson != null) {
      setState(() {
        print("OBTAIN MY ACCOUNT-----------------------------------------------------------");
        myAccount=jsonDecode(myAccountJson);
        name.text=myAccount["name"];
        lastname.text=myAccount["lastname"];
        motherLastname.text=myAccount["mother_lastname"];
        phone.text=myAccount["phone"].toString();
        selectedDate=DateFormat('yyyy-MM-dd').parse(myAccount["birthday"]);
        gender=myAccount["gender"];
      });
    }
  }
  final GlobalKey<_EditProfilePageState> myWidgetKey = GlobalKey();
  Widget build(BuildContext context) {
    return Scaffold(
      key: myWidgetKey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            )),
        title: Text(
          'Edicion de perfil',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Container(
                        width: 50,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: (!editedImage)?DecorationImage(
                            image: myAccount["photo"] == '' || myAccount["photo"]==null || !myAccount.containsKey("photo")
                                ? const NetworkImage('https://drive.google.com/file/d/12V8D0w45iG9NdaQxBPyssK2MQv7qpZ4M')
                                : NetworkImage('$_endPoint${myAccount['photo']}') as ImageProvider,
                            fit: BoxFit.cover,
                          ):DecorationImage(image: FileImage(imageProfile!)),
                        ),
                        child: const Text(""),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.white,
                        onPressed: () {
                          _pickImageFromGallery();
                        },
                      ),
                    ),

                  ],
                ),
                const CustomTextTitle(
                  label: '¿Como te llamas?',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(label: 'Nombre',controller: name),
                CustomTextField(label: 'Apellido',controller: lastname,),
                CustomTextField(label: 'Apellido materno',controller: motherLastname,),
                CustomTextField(label: 'Telefono',controller: phone,),
                const CustomTextTitle(label: '¿Cuando naciste?'),
                const SizedBox(
                  height: 10,
                ),
                CustomDatePicker(selectedDate: selectedDate,),
                const CustomTextTitle(
                  label: '¿Con que genero te edentificas?',
                ),
                 Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      GestureDetector(
                        onTap: (){setState(() {
                          gender='Masculino';
                        });},
                        child: GenderCard(
                          selected: (gender=='Masculino')?true:false,
                          label: 'Masculino',
                        ),
                      ),
                      GestureDetector(
                        onTap: (){setState(() {
                          gender='Femenino';
                        });},
                        child: GenderCard(
                          selected: (gender=='Femenino')?true:false,
                          label: 'Femenino',
                        ),
                      ),
                      GestureDetector(
                        onTap: (){setState(() {
                          gender='No binario';
                        });},
                        child: GenderCard(
                          selected: (gender=='No binario')?true:false,
                          label: 'No binario',
                        ),
                      ),
                      GestureDetector(
                        onTap: (){setState(() {
                          gender='Prefiero no decirlo';
                        });},
                        child: GenderCard(
                          selected: (gender=='Prefiero no decirlo')?true:false,
                          label: 'Prefiero no decirlo',
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ))),
            Container(
              decoration: BoxDecoration(
                color: NbSecondSecondaryColor.withOpacity(0.1),
                border: const Border(
                    top: BorderSide(color: NbSecondSecondaryColor, width: 1.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: CustomButton(
                  label: 'Guardar cambios',
                  onPressed: () {
                    updateProfileData();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _pickImageFromGallery() async {
    print("pick image");
    final imagePicker = ImagePicker();
    final pickedImage = imagePicker.pickImage(source: ImageSource.gallery).then((pickedImage) => {
      setState(() {
        editedImage=true;
        imageProfile = File(pickedImage!.path);
      })
    });
  }
  final _storage = const FlutterSecureStorage();

  Future<void> updateProfileData() async {
    final id=myAccount['id'];
    final userToken = await _storage.read(key: 'USER_TOKEN');
    await CustomAlerts.showConfirmationDialog(myWidgetKey.currentContext!).then((isConfirmed) async {
      if(isConfirmed){
        var body=jsonEncode({
          "name":name.text,
          "lastname":lastname.text,
          "mother_lastname":motherLastname.text,
          "birthday":selectedDate.toString(),
          "gender":gender,
          "phone":phone.text
        });
        List<Map<String, String>>imagesRoutes=[];
        if(imageProfile!=null)imagesRoutes.add({"name":"photo1", "path":imageProfile!.path});
        await HttpHeadersGlobal.headerPostHttpWithTokenMultipart(userToken!, '$_endPoint/api/v1/update_user/$id',body,imagesRoutes).then((res) async {
          if(res.statusCode==200){
            final req = await HttpHeadersGlobal.headerGetHttpWithToken(
                userToken, '$_endPoint/api/v1/get_my_account');
            await storage.write(key: "my_account", value: jsonEncode(jsonDecode(req.body)["data"]));
            CustomAlerts.showSuccessDialog(context, "Actualizacion correcto", "Datos actualizados con exito!!!");
            Navigator.pop(context);
            Navigator.pushNamed(context, '/home');
          }else{
            CustomAlerts.showSuccessDialog(context, "Actualizacion erronea", "No se pudo completar la actualizacion!!!");
          }
        });
      }
    });

  }
}
