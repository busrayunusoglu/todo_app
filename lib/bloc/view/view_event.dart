part of 'view_bloc.dart';

@immutable
abstract class ViewEvent {}

class ChangeView extends ViewEvent {
  final ViewState state;

  ChangeView({required this.state});
}

class PreviousView extends ViewEvent {}

class GetLoginScreen extends ViewEvent {}
