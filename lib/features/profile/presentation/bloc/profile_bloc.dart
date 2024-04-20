import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notebin/core/models/action_status.dart';
import 'package:notebin/core/models/user_model.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/use_case/profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final ProfileUseCase profileUseCase ;
  ProfileBloc(this.profileUseCase) : super(ProfileState(profile: ActionWait())) {
    on<LoadUserProfile>((event, emit) async {
      emit(ProfileState(profile: ActionWait()));
      var dataState = await profileUseCase.profile();

      if (dataState is DataSuccess) {
        emit(state.copyWith(profile: ActionSuccess<UserModel>(dataState.data))) ;
      }

      if (dataState is DataFailed) {
        emit(state.copyWith(profile: ActionError())) ;
      }
    });
  }
}
