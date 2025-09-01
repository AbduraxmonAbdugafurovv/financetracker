import 'package:financetreckerapp/features/auth/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String email, String password);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<UserModel> signIn(String email, String password) async {
    final result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return UserModel.fromFirebaseUser(result.user!);
  }

  @override
  Future<UserModel> signUp(String email, String password) async {
    final result = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return UserModel.fromFirebaseUser(result.user!);
  }

  @override
  Future<void> signOut() async => firebaseAuth.signOut();

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }
}
