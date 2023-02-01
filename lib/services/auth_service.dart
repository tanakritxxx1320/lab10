import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static GoogleSignIn _googleSignin = GoogleSignIn();
  Future<void> signinWithgoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignin.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    print(googleUser?.displayName);
    print(googleAuth?.accessToken);
    print(googleAuth?.idToken);

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user);
  }

  Future<void> signoutbygoogle() async {
    await FirebaseAuth.instance.signOut().then((value) {
      _googleSignin.signOut();
    });
  }
}
