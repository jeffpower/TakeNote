import 'package:firebase_auth/firebase_auth.dart';
import 'package:take_note/core/models/status.dart';
import 'package:take_note/core/services/auth_utils.dart';
import 'package:take_note/core/viewmodels/base_model.dart';
import 'package:take_note/locator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';

class LoginModel extends BaseModel {
  
  FirebaseAuth _mAuth = FirebaseAuth.instance;
  AuthUtils authUtils = locator<AuthUtils>();
  final GoogleSignIn googleSignIn = GoogleSignIn();


  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = 
      await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken
    );

    final AuthResult authResult = await _mAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _mAuth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'Successfully signed in - $user';

  }

  

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print('User signed out');
  }

  Future<AuthResult> loginUser(String email, String password) async {
    setState(
      Status.BUSY
    );
    var result = _mAuth.signInWithEmailAndPassword(
      email: email,
      password: password
    );

    setState(
      Status.IDLE
    );

    return result;
  }

  Future<AuthResult> registerUser(String email, String password) async {
    setState(
     Status.BUSY
    );
    var result = _mAuth.createUserWithEmailAndPassword(
      email: email,
      password: password
    );

    setState(
       Status.IDLE
    );

    return result;
  }
  

}