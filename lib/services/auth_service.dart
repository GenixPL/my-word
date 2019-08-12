import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:my_word/models/user.dart';
import 'package:my_word/services/db_service.dart';

class AuthService with ChangeNotifier {
	
	//singleton stuff
	static final AuthService _instance = AuthService._init();
	
	static AuthService get instance => _instance;
	
	AuthService._init();
	
	
	
	static const _TAG = 'AuthService';
	
	FirebaseAuth _auth = FirebaseAuth.instance;
	
	bool _isSigned = false;
	User _user;
	
	
	
	bool get isSigned => _isSigned;
	
	User get user => _user;
	
	
	Future<void> checkUserExists() async {
		var firebaseUser;
		try {
			firebaseUser = await _auth.currentUser();
		} catch (e) {
			print('$_TAG: checkUserExists: failure (currentUser), error: ${e.toString()}');
			throw e;
		}
		
		if (firebaseUser == null) {
			print('$_TAG: checkUserExists: success (user doesn\'t exist)');
			
			return;
		}
		
		var userDoc;
		try {
			userDoc = await DBService.instance.getUserDoc(firebaseUser.uid);
		} catch (e) {
			print('$_TAG: checkUserExists: failure (getUserDoc), error: ${e.toString()}');
			throw e;
		}
		
		_user = User.fromMap(userDoc);
		_isSigned = true;
		
		print('$_TAG: checkUserExists: success (user exists)');
		notifyListeners();
	}
	
	Future<void> signInEmailPassword(String email, String password) async {
		if (_isSigned) {
			signOut();
		}
		
		var authResult;
		try {
			authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
		} catch (e) {
			print('$_TAG: signInEmailPassword: failure (signInWithEmailAndPassword), error: ${e.toString()}');
			throw e;
		}
		
		var userDoc;
		try {
			userDoc = await DBService.instance.getUserDoc(authResult.user.uid);
		} catch (e) {
			print('$_TAG: signInEmailPassword: failure (getUserDoc), error: ${e.toString()}');
			throw e;
		}
		
		_user = User.fromMap(userDoc);
		_isSigned = true;
		
		print('$_TAG: signInEmailPassword: success');
		notifyListeners();
	}
	
	Future<void> signUpEmailPassword(String email, String password) async {
		var authResult;
		try {
			authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
		} catch (e) {
			print('$_TAG: signUpEmailPassword: failure (createUserWithEmailAndPassword), error: ${e.toString()}');
			throw e;
		}
		
		try {
			await DBService.instance.createUserDoc(authResult.user);
		} catch (e) {
			print('$_TAG: signUpEmailPassword: failure (createUserDoc), error: ${e.toString()}');
			throw e;
		}
		
		var userDoc;
		try {
			userDoc = await DBService.instance.getUserDoc(authResult.user.uid);
		} catch (e) {
			print('$_TAG: signUpEmailPassword: failure (getUserDoc), error: ${e.toString()}');
			throw e;
		}
		
		_user = User.fromMap(userDoc);
		_isSigned = true;
		
		print('$_TAG: signUpEmailPassword: success');
		notifyListeners();
	}
	
	Future<void> signOut() async {
		try {
			await _auth.signOut();
		} catch (e) {
			print('$_TAG: signOut: failure, error: ${e.toString()}');
			throw e;
		}
		
		_user = null;
		_isSigned = false;
		
		print('$_TAG: signOut: success');
		notifyListeners();
	}
}
