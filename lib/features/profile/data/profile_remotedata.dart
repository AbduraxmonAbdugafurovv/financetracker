
import 'package:financetreckerapp/features/profile/domain/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class ProfileRemotedata {
  final fb.FirebaseAuth _auth;
  // final FirebaseFirestore _firestore;

  ProfileRemotedata(this._auth);

  // Auth’dan olish
  UserModel? getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      return UserModel(uid: user.uid, email: user.email ?? "");
    }
    return null;
  }

  Future logOut() async {
    await _auth.signOut();
  }
}
