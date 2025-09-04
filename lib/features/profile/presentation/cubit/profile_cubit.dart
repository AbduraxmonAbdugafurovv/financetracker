import 'package:financetreckerapp/features/profile/data/profile_remotedata.dart';
import 'package:financetreckerapp/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.remotedata) : super(ProfileInitialState());
  final ProfileRemotedata remotedata;
  Future getUser() async {
    print("LOADING.....");
    emit(ProfileLoadingState());
    final user = remotedata.getCurrentUser();
    if (user != null) {
      print(user);
      emit(ProfileLoadedState(user));
    } else {
      emit(ProfileInitialState());
    }
  }
}
