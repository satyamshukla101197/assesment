part of 'second_screen_bloc.dart';

abstract class SecondScreenState extends Equatable {
  const SecondScreenState();
}

class SecondScreenInitial extends SecondScreenState {
  @override
  List<Object> get props => [];
}

class SecondScreenLoadingState extends SecondScreenState {
  @override
  List<Object> get props => [];
}
class SecondScreenErrorState extends SecondScreenState {
  final String message;

  SecondScreenErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class SecondScreenLoadedState extends SecondScreenState {
  final DataEntityResult? dataEntity;
  SecondScreenLoadedState({ this.dataEntity,});

  @override
  List<Object> get props => [dataEntity!,];
}