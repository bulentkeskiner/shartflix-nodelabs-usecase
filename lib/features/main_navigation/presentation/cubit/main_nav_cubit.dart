import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavCubit extends Cubit<int> {
  MainNavCubit() : super(0);

  void changeTab(int index) => emit(index);
}
