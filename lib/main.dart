import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_manager/theme_manager.dart';
import 'providers/city_provider.dart';
import 'providers/type_of_HDYKATC_provider.dart';
import 'providers/user_provider.dart';
import 'widgets/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CityProvider()),
        ChangeNotifierProvider(create: (context) => TypeOfHDYKATCProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path:
            'lib/assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('ar'),
        startLocale: const Locale('ar'),
        child: UNDP(),
      ),
    ),
  );
}

class UNDP extends StatefulWidget {
  const UNDP({super.key});

  @override
  State<UNDP> createState() => _UNDPState();
}

class _UNDPState extends State<UNDP> {
  @override
  Widget build(BuildContext context) {
    return ThemeManager(
      defaultBrightnessPreference: BrightnessPreference.system,
      data: (Brightness brightness) =>
          // brightness == Brightness.light
          //     ? ThemeData(
          //         primarySwatch: Colors.blue,
          //         accentColor: Colors.lightBlue,
          //         brightness: Brightness.light,
          //       )
          //     :
          ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.lightBlue, // accentColor
        brightness: brightness,
      ),
      themedWidgetBuilder: (BuildContext context, ThemeData theme) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: theme,
          home: Home(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
