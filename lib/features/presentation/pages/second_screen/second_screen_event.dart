part of 'second_screen_bloc.dart';

abstract class SecondScreenEvent extends Equatable {
  const SecondScreenEvent();
}
class SecondScreenListEvent extends SecondScreenEvent{
  @override
  List<Object> get props => [];
}