import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:soywarmi_app/core/inyection_container.dart' as sl;
import 'package:soywarmi_app/core/language/locales.dart';
import 'package:soywarmi_app/firebase_options.dart';
import 'package:soywarmi_app/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:soywarmi_app/presentation/page/about_us_page.dart';
import 'package:soywarmi_app/presentation/page/activities_page.dart';
import 'package:soywarmi_app/presentation/page/complaint_page.dart';
import 'package:soywarmi_app/presentation/page/edit_profile_page.dart';
import 'package:soywarmi_app/presentation/page/frequent_asked_questions_page.dart';
import 'package:soywarmi_app/presentation/page/main_page.dart';
import 'package:soywarmi_app/presentation/page/login_page.dart';
import 'package:soywarmi_app/presentation/page/members_page.dart';
import 'package:soywarmi_app/presentation/page/new_post_page.dart';
import 'package:soywarmi_app/presentation/page/news_page.dart';
import 'package:soywarmi_app/presentation/page/notifications_page.dart';
import 'package:soywarmi_app/presentation/page/password_reset_page.dart';
import 'package:soywarmi_app/presentation/page/profile_user_page.dart';
import 'package:soywarmi_app/presentation/page/register_page.dart';
import 'package:soywarmi_app/utilities/app_theme_data.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:soywarmi_app/utilities/nb_images.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/config/.env');
  await sl.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  /*runApp(
    DevicePreview(
      enabled: true,
      tools: [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => MyApp(),
    ),
  );*/
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final localization = FlutterLocalization.instance;

  @override
  void initState() {
    configureLocalization();
    super.initState();
  }

  void configureLocalization() {
    localization.init(mapLocales: LOCALES, initLanguageCode: "es");
    localization.onTranslatedLanguage = onTranslatedLanguage;
  }

  void onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
        ),
      ],
      child: MaterialApp(
        //useInheritedMediaQuery: true,
        //locale: DevicePreview.locale(context),
        //builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.theme,
        localizationsDelegates: localization.localizationsDelegates,
        supportedLocales: localization.supportedLocales,
        locale: const Locale('es', 'ES'),
        initialRoute: '/',
        routes: {
          '/': (context) => AnimatedSplashScreen(
                duration: 1500,
                splash: NBWarmiLogo,
                splashIconSize: 100,
                splashTransition: SplashTransition.slideTransition,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                nextScreen: const FirstPage(),
              ),
          '/register': (context) => const RegisterPage(),
          '/forgot_password': (context) => const PasswordResetPage(),
          '/home': (context) => const MainPage(),
          '/profile': (context) => const ProfileUserPage(),
          '/edit_profile': (context) => const EditProfilePage(),
          '/new_post': (context) => const NewPostPage(),
          '/notifications': (context) => const NotificationsPage(),
          '/about_us': (context) => const AboutUsPage(),
          '/frequent_questions': (context) =>
              const FrequentAskedQuestionsPage(),
          '/members': (context) => const MembersPage(),
          '/news': (context) => const NewsPage(),
          '/activity': (context) => const ActivitiesPage(),
          '/complaint': (context) => const ComplaintPage(),
        },
      ),
    );
  }
}
class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>  {
  _FirstPageState();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        print("Cambio de estado"+state.toString());
        if (state is Authenticated) {
          return const MainPage();
        }
        if (state is Unauthenticated) {
          return const LoginPage();
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
