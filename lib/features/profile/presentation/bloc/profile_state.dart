part of 'profile_bloc.dart';

class ProfileState {

  final ActionStatus profile ;



  ProfileState copyWith({
    ActionStatus? profile,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
    );
  }

  const ProfileState({
    required this.profile,
  });
}
