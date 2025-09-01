import 'package:financetreckerapp/features/auth/domain/entity/entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String uid,
    required String email,
   
  }) : super(uid: uid, email: email, );

  factory UserModel.fromFirebaseUser(dynamic user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      
    );
  }
}
