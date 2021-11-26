import 'package:firedart/firedart.dart';

Future<void> emailSignUp(email, password) async {
  await FirebaseAuth.instance.signUp(
    email,
    password,
  );
}

Future<void> emailSignIn(email, password) async {
  await FirebaseAuth.instance.signIn(email, password);
}
