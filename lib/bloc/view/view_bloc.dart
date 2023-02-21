import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'view_event.dart';

part 'view_state.dart';

class ViewBloc extends Bloc<ViewEvent, ViewState> {
  List<ViewState> listState = [];

  ViewBloc() : super(ViewInitialState()) {
    on<ChangeView>((event, emit) {
      listState.add(event.state);
      emit(event.state);
    });
    on<PreviousView>((event, emit) {
      listState.removeLast();
      ViewState state = listState.last;
      emit(state);
    });
    on<GetLoginScreen>((event, emit) {
      listState.clear();
      listState = [AutoPlaceState()];
      emit(listState.last);
    });
  }
}
