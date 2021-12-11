import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpermate/services/firebaseService.dart';
import 'package:helpermate/services/userSecureStorage.dart';
import 'package:helpermate/models/userState.dart';

class AuthService {
  //todo refactor na controler
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // wylogowywanie
  Future<void> signOut() async {
    UserSecureStorage.reset();
    _auth.signOut();
  }

  // tworzenie użytkowników za pomocą emaila i hasłą
  Future<User?> createUserEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      //dane sesyjne
      UserSecureStorage.setUID(userCredential.user!.uid);
      // bo nie wypełnione dane
      UserSecureStorage.setUserState(UserState.ERROR);
      // save dane
      FirebaseService().createUserData(email, userCredential.user!.uid);



      return userCredential.user;
      //todo elsy
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('diffrent');
        print(e.message);
      }
    }
    return null;
  }

  //logowanie za pomocą emaila i hasłą
  Future<User?> signInEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      // dane sesyjne
      UserSecureStorage.setUID(userCredential.user!.uid);
      // pobierz fullname

      FirebaseService().readHelperData().then((value) =>
          UserSecureStorage.setFullname(value!.fullName));

      // jeśli wszystko ok to
      UserSecureStorage.setUserState(UserState.GOOD);

      return userCredential.user;
      //todo elsy
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('diffrent');
        print(e.message);
      }
      return null;
    }
  }

  Future resetPassword() async {
    try {
      String? email = _auth.currentUser!.email;
      if(email != null) {
        _auth.sendPasswordResetEmail(email: email);
      }
      return;
      //todo elsy
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('diffrent');
        print(e.message);
      }
      return null;
    }
  }

  Future resetPasswordForEmail(String email) async {
    try {
      _auth.sendPasswordResetEmail(email: email);
      return;
      //todo elsy
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('diffrent');
        print(e.message);
      }
      return null;
    }
  }
}