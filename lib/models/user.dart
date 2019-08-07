import 'package:firebase_auth/firebase_auth.dart';


class User {

	String _id;
	String _email;


	String get id => _id;

	String get email => _email;


	User(FirebaseUser firebaseUser) {
		_id = firebaseUser.uid;
		_email = firebaseUser.email;
	}
}