import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soywarmi_app/core/inyection_container.dart';
import 'package:soywarmi_app/presentation/bloc/faqs/get_faqs_cubit.dart';
import 'package:soywarmi_app/presentation/bloc/faqs/get_faqs_state.dart';
import 'package:soywarmi_app/utilities/nb_colors.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';

class FrequentAskedQuestionsPage extends StatefulWidget {
  const FrequentAskedQuestionsPage({super.key});

  @override
  State<FrequentAskedQuestionsPage> createState() =>
      _FrequentAskedQuestionsPageState();
}

class _FrequentAskedQuestionsPageState
    extends State<FrequentAskedQuestionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          '',
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
        margin: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Image.asset(Images.logo, height: 50, width: 150),
            const Center(
              child: Text(
                '¿Tienes preguntas?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<GetFaqsCubit, GetFaqsState>(
                bloc: sl<GetFaqsCubit>()..getFaqs(),
                builder: (context, state) {
                  if (state is GetFaqsLoaded) {
                    final faqs = state.faqs;
                    return ListView.builder(
                      itemCount: faqs.length,
                      itemBuilder: (context, index) {
                        final faq = faqs[index];

                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: const BoxDecoration(
                            color: NbSecondSecondaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: ExpansionTile(
                            iconColor: Colors.black,
                            collapsedIconColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                faq.question,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  faq.answer,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  if (state is GetFaqsError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Error al cargar las preguntas frecuentes'),
                        IconButton(
                          onPressed: () {
                            sl<GetFaqsCubit>().getFaqs();
                          },
                          icon: Icon(Icons.refresh,
                              color: Theme.of(context).primaryColor),
                        )
                      ],
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
