// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tap_bar_state.dart';

class TapBarCubit extends Cubit<TapBarState> {
  int currentIndex = 0;

  TapBarCubit() : super(AllTasks());

  void changeTabbar(int index) {
    currentIndex = index;
    switch (index) {
      case 0:
        emit(AllTasks());
        break;
      case 1:
        emit(CompletedTask());
        break;
      case 2:
        emit(UncompletedTask());
        break;
    }
  }
}
