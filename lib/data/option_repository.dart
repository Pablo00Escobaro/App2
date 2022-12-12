import 'package:app2/domain/option.dart';
import 'package:app2/domain/option_mapper.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:injectable/injectable.dart';

abstract class OptionRepository {
  //парсим path с диплинка для получение опции
  Map<String, Option> getOptions(PendingDynamicLinkData deepLink);
}

@Injectable(as: OptionRepository) 
class OptionRepositoryImpl extends OptionRepository {
  final OptionMapper _optionMapper = OptionMapper();
  @override
  Map<String, Option> getOptions(PendingDynamicLinkData deepLink) {
    Map<String, Option> options = {};
    List<String> separatedValues = [];

    separatedValues.addAll(deepLink.link.path.split('/'));

    separatedValues.removeWhere((value) =>
        value.contains('airastanapp2') ||
        value.contains('http') ||
        value.isEmpty ||
        value == "" ||
        value.length < 3);
        
    for (var element in separatedValues) {
      options.putIfAbsent(
          element, () => _optionMapper.mapRawDataToOption(element));
    }
    return options;
  }
}
