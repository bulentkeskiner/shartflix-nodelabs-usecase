import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/language/presentation/bloc/lang_event.dart';
import 'package:shartflix/features/language/presentation/bloc/lang_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<ChangeLanguageEvent>((event, emit) {
      emit(LanguageState());
    });
  }
}
