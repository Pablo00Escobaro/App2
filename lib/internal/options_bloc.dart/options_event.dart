import 'package:equatable/equatable.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

abstract class OptionsEvent extends Equatable {
  const OptionsEvent();
}

class InitOptionsEvent extends OptionsEvent {
  final PendingDynamicLinkData link;
  const InitOptionsEvent(this.link);

  @override
  List<Object> get props => [link];
}
class OptionPressed extends OptionsEvent{
  final String optionKey;
  const OptionPressed(this.optionKey);

  @override 
  List<Object> get props => [optionKey];
}
class OtherOptionValueChanged extends OptionsEvent{
  final String optionKey;
  final String value;
  const OtherOptionValueChanged({required this.optionKey, required this.value});
  
  @override 
  List<Object> get props => [optionKey, value];
}
