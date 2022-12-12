import 'package:app2/injectable.dart';
import 'package:app2/internal/options_bloc.dart/options_bloc.dart';
import 'package:app2/internal/time_bloc/time_bloc.dart';
import 'package:app2/internal/time_bloc/time_event.dart';
import 'package:app2/presentation/home_page.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  final PendingDynamicLinkData? link;
  const MyApp({super.key, required this.link});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App2',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<TimeBloc>(
            create: (_) => TimeBloc()..add(InitTime()),
          ),
          BlocProvider.value(value: getIt.get<OptionsBloc>())
        ],
        child: DefaultTabController(
          length: 2,
          initialIndex: link == null ? 0 : 1,
          child: HomePage(
            link: link,
          ),
        ),
      ),
    );
  }
}
