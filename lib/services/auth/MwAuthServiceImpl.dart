import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_word/services/auth/MwAuthService.dart';


class MwAuthServiceImpl extends MwAuthService{
	
	static const _TAG = 'AuthService';
	
	FirebaseAuth _auth = FirebaseAuth.instance;
	
	
	Future<FirebaseUser> getCurrentUser() async {
		var firebaseUser;
		try {
			firebaseUser = await _auth.currentUser();
		} catch (e) {
			print('$_TAG: checkUserExists: failure (currentUser), error: ${e.toString()}');
			throw e;
		}
		
		return firebaseUser;
	}
	
	Future<AuthResult> signInEmailPassword(String email, String password) async {
		var authResult;
		try {
			authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
		} catch (e) {
			print('$_TAG: signInEmailPassword: failure (signInWithEmailAndPassword), error: ${e.toString()}');
			throw e;
		}
		
		return authResult;
	}
	
	Future<AuthResult> signUpEmailPassword(String email, String password) async {
		var authResult;
		try {
			authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
		} catch (e) {
			print('$_TAG: signUpEmailPassword: failure (createUserWithEmailAndPassword), error: ${e.toString()}');
			throw e;
		}
		
		return authResult;
	}
	
	Future<void> signOut() async {
		try {
			await _auth.signOut();
		} catch (e) {
			print('$_TAG: signOut: failure, error: ${e.toString()}');
			throw e;
		}
		
		print('$_TAG: signOut: success');
	}
}