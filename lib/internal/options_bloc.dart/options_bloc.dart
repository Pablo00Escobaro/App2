import 'package:app2/data/option_repository.dart';
import 'package:app2/domain/option.dart';
import 'package:app2/internal/options_bloc.dart/options_event.dart';
import 'package:app2/internal/options_bloc.dart/options_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class OptionsBloc extends Bloc<OptionsEvent, OptionState> {
  final OptionRepository _optionRepository;

  OptionsBloc(this._optionRepository) : super(OptionsEmpty()) {
    on<InitOptionsEvent>(_initOptionsEvent);
    on<OptionPressed>(_optionPressed);
    on<OtherOptionValueChanged>(_otherOptionValueChanged);
  }

  Map<String, Option> get options {
    try {
      var optionLoaded = state as OptionsLoaded;
      return optionLoaded.options;
    } catch (e) {
      return {};
    }
  }

  void _initOptionsEvent(
      InitOptionsEvent event, Emitter<OptionState> emit) {
    emit(OptionsLoading());
    Map<String, Option> options = _optionRepository.getOptions(event.link);

    if (options.isEmpty) {
      emit(OptionsEmpty());
      return;
    }
    emit(OptionsLoaded(options));
  }

  void _optionPressed(OptionPressed event, Emitter<OptionState> emit) {
    Option currentOption = options[event.optionKey]!;
    bool changed = !currentOption.isSelected;

    Map<String, Option> temp = {};
    temp.addAll(options);
    temp[event.optionKey] = currentOption.copyWith(selected: changed);

    emit(OptionsLoaded(temp));
  }

  void _otherOptionValueChanged(
      OtherOptionValueChanged event, Emitter<OptionState> emit) {
    Option currentOption = options[event.optionKey]!;

    Map<String, Option> temp = {};
    temp.addAll(options);
    temp[event.optionKey] = currentOption.copyWith(newValue: event.value);

    emit(OptionsLoaded(temp));
  }
}
