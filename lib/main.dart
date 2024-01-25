import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppLanguageProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLanguageProvider>(
      builder: (context, model, child) {
        return MaterialApp(
          locale: model.locale,
          title: 'Multi Lingual App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const MyHomePage(title: 'Multi Lingual App Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)?.title ?? 'TRANSLATION NOT AVAILABLE'),
        actions: [
          DropdownButton<Locale>(
            value: Provider.of<AppLanguageProvider>(context).locale,
            items: AppLocalizations.supportedLocales.map((locale) {
              return DropdownMenuItem<Locale>(
                value: locale,
                child: Text(locale.languageCode),
              );
            }).toList(),
            onChanged: (newLocale) {
              setState(() {
                Provider.of<AppLanguageProvider>(context, listen: false)
                    .setLocale(newLocale!.languageCode);
              });
              // Update your app's locale here
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)?.text1 ?? 'TRANSLATION NOT AVAILABLE',

              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(AppLocalizations.of(context)?.text2 ?? 'TRANSLATION NOT AVAILABLE',
              style: TextStyle(
              fontSize: 21,
            ),),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class AppLanguageProvider extends ChangeNotifier {
  Locale _locale = Locale('en');

  Locale get locale => _locale;

  void setLocale(String languageCode) {
    _locale = Locale(languageCode) ;
    notifyListeners();
  }
}
