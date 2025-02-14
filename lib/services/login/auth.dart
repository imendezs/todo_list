import 'package:firebase_auth/firebase_auth.dart';

class AuthLogin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createAcount(String correo, String pass) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: correo, password: pass);
      return (userCredential.user?.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 1;
      } else if (e.code == 'email-already-in-use') {
        return 2;
      }
    } catch (e) {
      print(e);
    }
  }

  Future signInEmailAndPassword(String correo, String pass) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: correo,
        password: pass,
      );

      final user = userCredential.user;

      if (user?.uid != null) {
        return user?.uid;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 1;
      } else if (e.code == 'wrong-password') {
        return 2;
      } else if (e.code == 'invalid-credential') {
        return 4;
      } else {
        return 3;
      }
    }
    return 3;
  }

/*Future signInEmailAndPassword(String correo, String pass) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: correo,
        password: pass,
      );
      final user = userCredential.user;
      if (user?.uid != null) {
        return user?.uid;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 1;
      } else if (e.code == 'wrong-password') {
        return 2;
      } else {
        return 3;
      }
    }
  }*/
}
