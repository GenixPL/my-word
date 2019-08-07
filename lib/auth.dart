import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';


class AuthService with ChangeNotifier {

	static const _TAG = 'AuthService';

	FirebaseAuth _auth = FirebaseAuth.instance;

	bool _isSigned = false;
	FirebaseUser _user; //TODO: change it to own user class


	bool get isSigned => _isSigned;

	FirebaseUser get user => _user;


	//singleton stuff
	static final AuthService _instance = AuthService._init();

	static AuthService get instance => _instance;

	AuthService._init();


	Future<FirebaseUser> checkUserExists() async {
		try {
			var user = await _auth.currentUser();

			if (user != null) {
				_isSigned = true;
				_user = user;

				print('$_TAG: init: success (user exists)');
				return user;

			} else {
				print('$_TAG: init: success (user doesn\'t exist)');
				return null;
			}
		} catch (e) {
			print('$_TAG: init: failure, error: ${e.toString()}');
			return null;
		}
	}

	Future<Exception> signInEmailPassword(String email, String password) async {
		try {
			var user = await _auth.signInWithEmailAndPassword(email: email, password: password);
			_user = user;
			_isSigned = true;

			print('$_TAG: signInEmailPassword: success');
			notifyListeners();
			return null;
		} catch (e) {
			print('$_TAG: signInEmailPassword: failure, error: ${e.toString()}');
			return e;
		}
	}

	Future<Exception> signUpEmailPassword(String email, String password) async {
		try {
			var user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
			_user = user;
			_isSigned = true;

			print('$_TAG: signUpEmailPassword: success');
			notifyListeners();
			return null;
		} catch (e) {
			print('$_TAG: signUpEmailPassword: failure, error: ${e.toString()}');
			return e;
		}
	}

	Future<Exception> signOut() async {
		try {
			await _auth.signOut();
			_user = null;
			_isSigned = false;

			print('$_TAG: signOut: success');
			notifyListeners();
			return null;
		} catch (e) {
			print('$_TAG: signOut: failure, error: ${e.toString()}');
			return e;
		}
	}
}
