import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soywarmi_app/core/inyection_container.dart';
import 'package:soywarmi_app/domain/entity/medical_center_entity.dart';
import 'package:soywarmi_app/presentation/bloc/medical_centers/get_medical_centers_cubit.dart';
import 'package:soywarmi_app/presentation/bloc/medical_centers/get_medical_centers_state.dart';
import 'package:soywarmi_app/presentation/page/medical_center_info.dart';

import 'package:soywarmi_app/utilities/nb_colors.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

LatLng camaraPosition = LatLng(-17.419869, -66.129660);

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final default_position = const LatLng(-17.419869, -66.129660);

  BitmapDescriptor? iconMarkerImage;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLocationPermission();
  }

  void _showCityModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                height: constraints.maxHeight,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Cambia de ciudad',
                              style: TextStyle(
                                fontSize: 18,
                                color: NBSecondPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: generateCountryButtons(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  List<Widget> generateCountryButtons() {
    List<Widget> buttons = [];
    final List<Map<String, dynamic>> ciudades = [
      {"nombre": "La paz", "latitud": -16.5, "longitud": -68.15},
      {"nombre": "Oruro", "latitud": -17.9833, "longitud": -67.1500},
      {"nombre": "Potosi", "latitud": -19.5667, "longitud": -65.7500},
      {"nombre": "Cochabamba", "latitud": -17.3895, "longitud": -66.1568},
      {"nombre": "Chuquisaca", "latitud": -19.0428, "longitud": -65.2594},
      {"nombre": "Tarija", "latitud": -21.5355, "longitud": -64.7296},
      {"nombre": "Santa Cruz", "latitud": -17.8146, "longitud": -63.1561},
      {"nombre": "Beni", "latitud": -14.8245, "longitud": -64.8992},
      {"nombre": "Pando", "latitud": -10.9419, "longitud": -66.9980}
    ];
    for (var data in ciudades) {
      buttons.add(const Divider(
        thickness: 1,
      ));
      buttons.add(
          countryButton(data["latitud"], data["longitud"], data["nombre"]));
    }
    return buttons;
  }

  Widget countryButton(double lat, double long, String name) {
    return TextButton(
      onPressed: () {
        setState(() {
          camaraPosition = new LatLng(lat, long);
          Navigator.pop(context);
        });
      },
      child: Text(name),
    );
  }

  Future<void> _checkLocationPermission() async {
    if (await Permission.location.isGranted) {
      _getCurrentLocation();
    } else {
      await Permission.location.request();
      if (await Permission.location.isGranted) {
        _getCurrentLocation();
      } else {
        print('Permiso de ubicación denegado');
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print(position.latitude);
      print(position.longitude);
      setState(() {
        camaraPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('Error al obtener la ubicación: $e');
    }
  }

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/hospital_icon.png')
        .then((value) => iconMarkerImage = value);
    super.initState();
  }

  List<Map<String, dynamic>> cities = [
    {
      'name': 'La Paz',
      'selected': false,
      'coordinates': const LatLng(-16.5032, -68.1286)
    },
    {
      'name': 'Sucre',
      'selected': false,
      'coordinates': const LatLng(-19.0196, -65.2619)
    },
    {
      'name': 'Cochabamba',
      'selected': false,
      'coordinates': const LatLng(-17.3895, -66.1568)
    },
    {
      'name': 'Santa Cruz de la Sierra',
      'selected': false,
      'coordinates': const LatLng(-17.7833, -63.1667)
    },
    {
      'name': 'Oruro',
      'selected': false,
      'coordinates': const LatLng(-17.9833, -67.1500)
    },
    {
      'name': 'Tarija',
      'selected': false,
      'coordinates': const LatLng(-21.5355, -64.7296)
    },
    {
      'name': 'Potosí',
      'selected': false,
      'coordinates': const LatLng(-19.5836, -65.7531)
    },
    {
      'name': 'Trinidad',
      'selected': false,
      'coordinates': const LatLng(-14.8333, -64.9000)
    },
    {
      'name': 'Cobija',
      'selected': false,
      'coordinates': const LatLng(-11.0333, -68.7333)
    },
    // Puedes agregar más ciudades o localidades si es necesario
  ];

  void _showModalNearestHospitalsl(
      BuildContext context, List<MedicalCenterEntity> medicalCenters) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                height: constraints.maxHeight,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Hospitales mas cercanos',
                              style: TextStyle(
                                fontSize: 18,
                                color: NBSecondPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                          itemCount: medicalCenters.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final medicalCenter = medicalCenters[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MedicalCenterInfo(
                                            medicalCenter: medicalCenter)));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                decoration: BoxDecoration(
                                    color: NbSecondSecondaryColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  leading: Image.asset(
                                      'assets/images/hospital_icon.png'),
                                  title: Text(
                                    medicalCenter.name,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  subtitle: Text(
                                    medicalCenter.description,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.5)),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showCityModal(
    BuildContext context,
  ) {
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
                        'Cambia de ciudad',
                        style: TextStyle(
                          fontSize: 18,
                          color: NBSecondPrimaryColor,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: cities.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CheckboxListTile(
                          activeColor: NBSecondPrimaryColor,
                          title: Text(cities[index]['name']),
                          value: cities[index]['selected'],
                          onChanged: (bool? value) {
                            setState(() {
                              cities.forEach((city) {
                                city['selected'] = false;
                              });
                              cities[index]['selected'] = value;

                              // Cambiar la posición del mapa al seleccionar una ciudad
                              if (value == true) {
                                mapController.animateCamera(
                                    CameraUpdate.newLatLng(
                                        cities[index]['coordinates']));
                              }
                            });
                            Navigator.pop(context);
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
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<GetMedicalCentersCubit, GetMedicalCentersState>(
      bloc: sl<GetMedicalCentersCubit>()..getMedicalCenters(),
      builder: (context, state) {
        if (state is GetMedicalCentersLoaded) {
          final medicalCenters = state.medicalCenters;
          final markers = medicalCenters.map((e) {
            final LatLng position = LatLng(e.latitude, e.longitude);
            return Marker(
              markerId: MarkerId(e.id.toString()),
              position: position,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MedicalCenterInfo(medicalCenter: e)));
              },
              infoWindow: InfoWindow(
                title: e.name,
              ),
            );
          }).toSet();
          return Stack(
            children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                markers: markers,
                initialCameraPosition: CameraPosition(
                  target: camaraPosition,
                  zoom: 15.0,
                ),
              ),
              Positioned(
                left: 0,
                right: width * 0.6,
                bottom: 60,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          NBSecondPrimaryColor),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      _showCityModal(context);
                      final res = FaqsRemoteDataSourceImplementation();
                      final data = res.getFaqs();
                    },
                    child: const Text(
                      'Cambiar ciudad',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: width * 0.6,
                bottom: 10,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          NBSecondPrimaryColor),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      _showModalNearestHospitalsl(context, medicalCenters);
                    },
                    child: const Text(
                      'Mostrar mas cercanos',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              )
            ],
          );
        }

        if (state is GetMedicalCentersError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    'No se pudo cargar los centros medicos, intente nuevamente'),
                IconButton(
                  onPressed: () {
                    sl<GetMedicalCentersCubit>().getMedicalCenters();
                  },
                  icon: Icon(Icons.refresh,
                      color: Theme.of(context).primaryColor),
                )
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

void _showModalNearestHospitalsl(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              height: constraints.maxHeight,
              child: Center(
                child: Column(
                  children: [
                    const Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Hospitales mas cercanos',
                          style: TextStyle(
                            fontSize: 18,
                            color: NBSecondPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          color: NbSecondSecondaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        leading: Image.asset('assets/images/hospital_icon.png'),
                        title: Text(
                          'Hospital 1',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        subtitle: Text(
                          'Av Heroinas ',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
