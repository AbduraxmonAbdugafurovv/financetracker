

import 'package:financetreckerapp/features/profile/domain/user.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  UserModel user;
  ProfileLoadedState(this.user);
}

class ProfileErrorState extends ProfileState {
  String message;
  ProfileErrorState(this.message);
}
