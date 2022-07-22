import 'package:floward_task/generated/l10n.dart';
import 'package:floward_task/providers/connectivity_provider.dart';
import 'package:floward_task/providers/language_provider.dart';
import 'package:floward_task/utils/app_colors.dart';
import 'package:floward_task/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late LanguageProvider _languageProvider;
  late ConnectivityProvider _connectivityProvider;

  @override
  void didChangeDependencies() async {
    _languageProvider = Provider.of<LanguageProvider>(context);
    _connectivityProvider = Provider.of<ConnectivityProvider>(context);
    _languageProvider.init();
    await _connectivityProvider.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _languageProvider.locale.languageCode == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: _languageProvider.locale,
        theme: ThemeData(
            textTheme: GoogleFonts.cairoTextTheme(),
            primarySwatch: AppColors.primarySwatch),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        initialRoute: AppRoutes.homeRoute,
        routes: AppRoutes.routes,
        builder: EasyLoading.init(),
      ),
    );
  }
}
