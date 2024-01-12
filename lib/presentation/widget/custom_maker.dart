
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/entity/medical_center_entity.dart';
import '../page/medical_center_info.dart';

class CustomMakerMedicalCenter {

  final MedicalCenterEntity medicalCenterEntity;
  CustomMakerMedicalCenter(this.medicalCenterEntity);

  @override
  Future<Marker> getMaker(context) async {
    const iconMedicalCenter='assets/icons/icon_medical_center.png';
    const sizeIcon=50;

    return Marker(
      markerId: MarkerId(medicalCenterEntity.id.toString()),
      position: LatLng(medicalCenterEntity.latitude, medicalCenterEntity.longitude),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MedicalCenterInfo(medicalCenter: medicalCenterEntity)));
      },
      //icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12.0, 12.0)),iconMedicalCenter),
      icon: BitmapDescriptor.fromBytes( await getBytesFromAsset(iconMedicalCenter, sizeIcon)),
      infoWindow: InfoWindow(
        title: medicalCenterEntity.name,
      ),
    );
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec =
    await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}