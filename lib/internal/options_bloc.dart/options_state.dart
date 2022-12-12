import 'package:app2/domain/option.dart';
import 'package:equatable/equatable.dart';

abstract class OptionState extends Equatable {
  const OptionState();
}


class OptionsLoading extends OptionState {

  @override
  List<Object> get props => [];
}

class OptionsEmpty extends OptionState {

  @override
  List<Object> get props => [];
}

class OptionsLoaded extends OptionState{
  final Map<String, Option> options;
  const OptionsLoaded(this.options);

  @override
  List<Object> get props => [options];
}


