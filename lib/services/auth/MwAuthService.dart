import 'package:firebase_auth/firebase_auth.dart';


abstract class MwAuthService {
	
	Future<FirebaseUser> getCurrentUser();
	
	Future<AuthResult> signInEmailPassword(String email, String password);
	
	Future<AuthResult> signUpEmailPassword(String email, String password);
	
	Future<void> signOut();
}
