part of 'tap_bar_cubit.dart';

@immutable
abstract class TapBarState {}

class AllTasks extends TapBarState {}

class CompletedTask extends TapBarState {}

class UncompletedTask extends TapBarState {}
