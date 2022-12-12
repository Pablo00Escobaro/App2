import 'package:app2/domain/option.dart';

class OptionMapper {
  Option mapRawDataToOption(String value) {
    return Option(
        isSelected: false, title: value, value: _isOther(value) ? "" : value);
  }

  bool _isOther(String value) => value.toLowerCase().contains("other");
}
