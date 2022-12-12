import 'package:app2/domain/option.dart';
import 'package:app2/presentation/bottom_sheet_page.dart';
import 'package:flutter/material.dart';

class OptionsLoadedWidget extends StatelessWidget {
  final Map<String, Option> options;
  const OptionsLoadedWidget({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: options.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int i) {
            String key = options.keys.elementAt(i);
            if (options[key]!.isSelected) {
              if (key.toLowerCase().contains('other')) {
                return ListTile(
                  title: Text('${options[key]!.title} ${options[key]!.value}'),
                );
              } else {
                return ListTile(
                  title: Text(options[key]!.title),
                );
              }
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18),
        child: ElevatedButton(
          child: const Padding(
            padding:  EdgeInsets.only(top: 10.0, bottom: 10),
            child:  Text('Select options'),
          ),
          onPressed: () => _optionsBottomSheet(context),
        ),
      ),
    );
  }

  Future<void> _optionsBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      isDismissible: true,
      elevation: 10,
      isScrollControlled: true,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      barrierColor: Colors.transparent,
      context: context,
      builder: (ctx) {
        return const BottomSheetPage();
      },
    );
  }
}
