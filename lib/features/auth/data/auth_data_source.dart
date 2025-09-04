import 'package:financetreckerapp/features/auth/domain/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

// Repository – Firebase bilan ishlaydi
class AuthRepository {
  final fb.FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

  Future<UserModel?> signIn(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final fb.User? fbUser = result.user;
      if (fbUser != null) {
        return UserModel(uid: fbUser.uid, email: fbUser.email!);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<UserModel?> signUp(String email, String password) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final fb.User? fbUser = result.user;
      if (fbUser != null) {
        return UserModel(uid: fbUser.uid, email: fbUser.email!);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<UserModel?> getCurrentUser() async {
    final fb.User? fbUser = _firebaseAuth.currentUser;
    if (fbUser != null) {
      return UserModel(uid: fbUser.uid, email: fbUser.email!);
    }
    return null;
  }
}
