import 'dart:async';
import 'package:app2/internal/options_bloc.dart/options_bloc.dart';
import 'package:app2/internal/options_bloc.dart/options_event.dart';
import 'package:app2/presentation/option_list_tab.dart';
import 'package:app2/presentation/time_tab.dart';
import 'package:app2/presentation/widgets/tab_tile.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../internal/time_bloc/time_bloc.dart';
import '../internal/time_bloc/time_event.dart';

class HomePage extends StatefulWidget {
  final PendingDynamicLinkData? link;
  const HomePage({super.key, required this.link});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _handleDeepLink();
    Timer.periodic(const Duration(seconds: 1),
        (_) => context.read<TimeBloc>().add(InitTime()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 10,
        bottom: const TabBar(
          tabs: [
            TabTile(title: 'Current Time'),
            TabTile(title: 'List details')
          ],
        ),
      ),
      body: const TabBarView(children: [
        TimeTab(),
        OptionListTab(),
      ]),
    );
  }

  void _handleDeepLink() {
    if (widget.link != null) {
      //terminated
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<OptionsBloc>().add(InitOptionsEvent(widget.link!));
      });
    }
    //background
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      context.read<OptionsBloc>().add(InitOptionsEvent(widget.link!));
    });
  }
}
