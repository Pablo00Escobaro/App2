import 'package:app2/injectable.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'internal/app_config.dart';

//ATTENTION!!!
//Просьба билдить и чекать только на андроиде
//На ios'e не будут работать дип линки (Нету аккаунта девелопера)

void main() async {
  //inject getIt
  configureDependencies();

  //init firebase
  await initFirebaseServices();

  //catch deeplinks at terminated state
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
      
  runApp(MyApp(link: initialLink));
}


