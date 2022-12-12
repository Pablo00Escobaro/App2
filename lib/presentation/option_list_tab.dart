import 'package:app2/internal/options_bloc.dart/options_bloc.dart';
import 'package:app2/presentation/widgets/options_loaded_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../internal/options_bloc.dart/options_state.dart';
import 'widgets/options_empty_widget.dart';
import 'widgets/options_loading_widget.dart';

class OptionListTab extends StatefulWidget {
  const OptionListTab({super.key});

  @override
  State<OptionListTab> createState() => _OptionListTabState();
}

class _OptionListTabState extends State<OptionListTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionsBloc, OptionState>(
      builder: (BuildContext context, state) {
        if (state is OptionsLoading) {
          return const OptionsLoadingWidget();
        } else if (state is OptionsLoaded) {
          return OptionsLoadedWidget(options: state.options);
        } else {
          return const OptionsEmptyWidget();
        }
      },
    );
  }

}
