import 'package:app2/domain/option.dart';
import 'package:app2/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../internal/options_bloc.dart/options_bloc.dart';
import '../internal/options_bloc.dart/options_event.dart';
import '../internal/options_bloc.dart/options_state.dart';
import 'widgets/options_empty_widget.dart';

class BottomSheetPage extends StatefulWidget {
  const BottomSheetPage({super.key});

  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<OptionsBloc>(),
      child: BlocBuilder<OptionsBloc, OptionState>(
        builder: (context, state) {
          if (state is OptionsLoaded) {
            return _BottomSheetBody(options:state.options);
          } else {
            return const OptionsEmptyWidget();
          }
        },
      ),
    );
  }
}
class _BottomSheetBody extends StatefulWidget {
  final Map<String, Option> options;
  const _BottomSheetBody({required this.options});

  @override
  State<_BottomSheetBody> createState() => __BottomSheetBodyState();
}

//не успел отрефачить :p
class __BottomSheetBodyState extends State<_BottomSheetBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height * 0.8,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 18,
                      right: 18,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 27,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 7,
                          ),
                          const Text(
                            "Select options: ",
                            style: TextStyle(fontSize: 20),
                          ),
                          InkWell(
                            child: const Icon(Icons.close),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 27,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.options.length,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int i) {
                          String key = widget.options.keys.elementAt(i);

                          if (key.toLowerCase().contains("other")) {
                            return CheckboxListTile(
                              value: widget.options[key]!.isSelected,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Row(
                                children: [
                                  Text(widget.options[key]!.title),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Flexible(
                                      child: SizedBox(
                                    height: 30,
                                    child: TextFormField(
                                      initialValue: widget.options[key]!.value,
                                      maxLines: 1,
                                      onChanged: (value) {
                                        context.read<OptionsBloc>().add(
                                              OtherOptionValueChanged(
                                                optionKey: key,
                                                value: value,
                                              ),
                                            );
                                      },
                                      decoration: const InputDecoration(
                                          enabled: true,
                                          enabledBorder: OutlineInputBorder(),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder()),
                                    ),
                                  ))
                                ],
                              ),
                              onChanged: (bool? value) => context
                                  .read<OptionsBloc>()
                                  .add(OptionPressed(key)),
                            );
                          }
                          return CheckboxListTile(
                            value: widget.options[key]!.isSelected,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(widget.options[key]!.title),
                            onChanged: (bool? value) => context
                                .read<OptionsBloc>()
                                .add(OptionPressed(key)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
  }
}
