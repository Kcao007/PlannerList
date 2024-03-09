import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;

  get user => auth.currentUser;
  get uid => user.uid;

  String getUID() {
    return user.uid;
  }

  Future signOut() async {
    await auth.signOut();
  }
}

