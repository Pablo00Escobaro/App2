import 'package:app2/internal/time_bloc/time_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TimeTab extends StatefulWidget {
  const TimeTab({super.key});

  @override
  State<TimeTab> createState() => _TimeTabState();
}

class _TimeTabState extends State<TimeTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeBloc, DateTime>(
      builder: (BuildContext context, state) {
        return Center(
          child: Text(DateFormat.Hms().format(state), style: const TextStyle(fontSize: 18),),
        );
      },
    );
  }
}
