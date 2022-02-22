import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supdup/core/error/failures.dart';
import 'package:supdup/core/usecse/usecase.dart';
import 'package:supdup/core/utils/constants.dart';
import 'package:supdup/features/domain/entities/data_entity.dart';
import 'package:supdup/features/domain/use_cases/data_use_case.dart';

part 'second_screen_event.dart';
part 'second_screen_state.dart';

class SecondScreenBloc extends Bloc<SecondScreenEvent, SecondScreenState> {
  final DataUseCase _dataUseCase;

  SecondScreenBloc({
required  final DataUseCase dataUseCase
}) :assert(dataUseCase != null),
  _dataUseCase=dataUseCase,
super(SecondScreenInitial());

  @override
  Stream<SecondScreenState> mapEventToState(
    SecondScreenEvent event,
  ) async* {
    if (event is SecondScreenEvent) {
      yield SecondScreenLoadingState();
      final data = await _dataUseCase.call(NoParams());
      yield* data.fold((failure) async* {
        if (failure is CacheFailure) {
          yield SecondScreenErrorState(message: failure.message);
        } else if (failure is ServerFailure) {
          yield SecondScreenErrorState(message: failure.message);
        } else {
          yield SecondScreenErrorState(message: Constants.ERROR_UNKNOWN);
        }
      }, (loadedDataEntity) async* {
        print("ffffffffffffff");
        yield SecondScreenLoadedState(dataEntity: loadedDataEntity);
      });
    }
  }
}
