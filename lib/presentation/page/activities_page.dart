import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:soywarmi_app/core/inyection_container.dart';
import 'package:soywarmi_app/presentation/bloc/activity/get_activity_cubit.dart';
import 'package:soywarmi_app/presentation/bloc/activity/get_activity_state.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  final _endPoint = dotenv.env['API_ENDPOINT'];

  @override
  Widget build(BuildContext context) {

    final formatTime = DateFormat('dd-MM-yyyy hh:mm');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NBColorWhite,
        elevation: 0,
        title: const Text('Actividades SoyWarmi',
            style: TextStyle(color: NBPrimaryColor)),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: BlocBuilder<GetActivityCubit, GetActivityState>(
        bloc: sl<GetActivityCubit>()..getActivity(),
        builder: (context, state) {
          if (state is GetActivityError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Theme.of(context).primaryColor,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'No se pudo cargar las actividades',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ],
              ),
            );
          }

          if (state is GetActivityLoaded) {
            final activity = state.activity;

            return ListView.builder(
                itemCount: activity.length,
                itemBuilder: (context, index) {
                  final images = [
                  ];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CarouselSlider(
                                    options: CarouselOptions(
                                      height: 200.0,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      pauseAutoPlayOnTouch: true,
                                      aspectRatio: 2.0,
                                    ),
                                    items: activity[index].images.isEmpty
                                        ? images.map((item) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                      //border˝

                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.network(
                                                      item,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }).toList()
                                        : activity[index].images.map((item) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5.0),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.amber,
                                                  ),
                                                  child: Image.network(
                                                    '$_endPoint${item["url"]}',
                                                    fit: BoxFit.fill,
                                                  ),
                                                );
                                              },
                                            );
                                          }).toList()),
                                const SizedBox(height: 10),
                                Text(
                                  activity[index].name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Fecha de inicio: ${formatTime.format(DateTime.parse(activity[index].createdAt.toString()))}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Fecha de finalizacion: ${formatTime.format(DateTime.parse(activity[index].endDate))} ',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Descripción: ${activity[index].description}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                    spacing: 8,
                                    children: activity[index]
                                        .area
                                        .map((e) => Container(
                                              margin: const EdgeInsets.only(
                                                  right: 8, bottom: 8),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                e,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: NBColorWhite,
                                                ),
                                              ),
                                            ))
                                        .toList()),
                              ])),
                    ),
                  );
                });
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
