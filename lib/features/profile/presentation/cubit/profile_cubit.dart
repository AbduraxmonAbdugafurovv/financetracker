import 'package:financetreckerapp/features/profile/data/profile_remotedata.dart';
import 'package:financetreckerapp/features/profile/domain/user.dart';
import 'package:financetreckerapp/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.remotedata) : super(ProfileInitialState());
  final ProfileRemotedata remotedata;
  UserModel? user;
  Future getUser() async {
    print("LOADING.....");
    emit(ProfileLoadingState());
    user = remotedata.getCurrentUser();
    if (user != null) {
      print(user);
      emit(ProfileLoadedState(user!));
    } else {
      emit(ProfileInitialState());
    }
  }

  Future signOut() async {
    emit(ProfileLoadingState());
    await remotedata.logOut();
    user = remotedata.getCurrentUser();
    print("-----");
    print(user);
    if (user != null) {
      print("LOADED------");
      print(user);
      emit(ProfileLoadedState(user!));
    } else {
      print("LOGOUT ----");
      emit(ProfileLogOutState());
    }
  }
}
