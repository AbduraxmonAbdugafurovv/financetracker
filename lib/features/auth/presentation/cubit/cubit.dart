
import 'package:financetreckerapp/features/auth/data/auth_data_source.dart';
import 'package:financetreckerapp/features/auth/presentation/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  AuthCubit(this.repository) : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    final user = await repository.signIn(email, password);
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthError("Sign in failed"));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    final user = await repository.signUp(email, password);
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthError("Sign up failed"));
    }
  }
}
