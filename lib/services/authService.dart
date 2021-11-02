import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpermate/decisionTree.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // wylogowywanie
  Future<void> signOut() async {
    _auth.signOut();
  }

  // tworzenie użytkowników za pomocą emaila i hasłą
  Future<User?> createUserEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
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
}