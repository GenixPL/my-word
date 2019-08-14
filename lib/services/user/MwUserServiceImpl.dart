import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_word/models/MwSet.dart';
import 'package:my_word/models/MwSetInfo.dart';
import 'package:my_word/models/MwUser.dart';
import 'package:my_word/services/auth/MwAuthService.dart';
import 'package:my_word/services/db/MwDbService.dart';
import 'package:my_word/services/user/MwUserService.dart';



class MwUserServiceImpl extends MwUserService {
	
	static const _TAG = 'MwUserService';
	
	MwAuthService _auth;
	MwDbService _db;
	
	MwUser _user;
	
	
	MwUserServiceImpl(this._auth, this._db);
	
	
	@override
	String get id {
		return _user != null ? _user.id : null;
	}
	
	@override
	String get email {
		return _user != null ? _user.email : null;
	}
	
	@override
	bool get isSigned {
		return _user != null;
	}
	
	@override
	List<MwSetInfo> get setsInfo {
		return _user != null ? _user.sets : null;
	}
	
	
	
	@override
	Future<void> checkUserExists() async {
		var firebaseUser;
		try {
			firebaseUser = await _auth.getCurrentUser();
		} catch (e) {
			print('$_TAG: checkUserExists: failure (checkUserExists), error: ${e.toString()}');
			throw e;
		}
		
		if (firebaseUser == null) {
			print('$_TAG: checkUserExists: success (user doesn\'t exist)');
			
			return;
		}
		
		var userDoc;
		try {
			userDoc = await _db.getUserDoc(firebaseUser.uid);
		} catch (e) {
			print('$_TAG: checkUserExists: failure (getUserDoc), error: ${e.toString()}');
			throw e;
		}
		
		try {
			_user = MwUser.fromMap(userDoc);
		} catch (e) {
			print('$_TAG: checkUserExists: failure (fromMap), error: ${e.toString()}');
			throw e;
		}
		
		notifyListeners();
		
		print('$_TAG: checkUserExists: success (user exists)');
	}
	
	@override
	Future<void> signInEmailPassword(String email, String password) async {
		if (_user != null) {
			signOut();
		}
		
		var authResult;
		try {
			authResult = await _auth.signInEmailPassword(email, password);
		} catch (e) {
			print('$_TAG: signInEmailPassword: failure (signInEmailPassword), error: ${e.toString()}');
			throw e;
		}
		
		var userDoc;
		try {
			userDoc = await _db.getUserDoc(authResult.user.uid);
		} catch (e) {
			print('$_TAG: signInEmailPassword: failure (getUserDoc), error: ${e.toString()}');
			throw e;
		}
		
		_user = MwUser.fromMap(userDoc);
		
		notifyListeners();
		
		print('$_TAG: signInEmailPassword: success');
	}
	
	@override
	Future<void> signUpEmailPassword(String email, String password) async {
		if (_user != null) {
			signOut();
		}
		
		AuthResult authResult;
		try {
			authResult = await _auth.signUpEmailPassword(email, password);
		} catch (e) {
			print('$_TAG: signUpEmailPassword: failure (signUpEmailPassword), error: ${e.toString()}');
			throw e;
		}
		
		try {
			await _db.createUserDoc(authResult.user.uid, authResult.user.email);
		} catch (e) {
			print('$_TAG: signUpEmailPassword: failure (createUserDoc), error: ${e.toString()}');
			throw e;
		}
		
		var userDoc;
		try {
			userDoc = await _db.getUserDoc(authResult.user.uid);
		} catch (e) {
			print('$_TAG: signUpEmailPassword: failure (getUserDoc), error: ${e.toString()}');
			throw e;
		}
		
		try {
			_user = MwUser.fromMap(userDoc);
		} catch (e) {
			print('$_TAG: signUpEmailPassword: failure (fromMap), error: ${e.toString()}');
			throw e;
		}
		
		notifyListeners();
		
		print('$_TAG: signUpEmailPassword: success');
	}
	
	@override
	Future<void> signOut() async {
		if (_user == null) {
			return;
		}
		
		try {
			await _auth.signOut();
		} catch (e) {
			print('$_TAG: signOut: failure, error: ${e.toString()}');
			throw e;
		}
		
		_user = null;
		
		notifyListeners();
		
		print('$_TAG: signOut: success');
	}
	
	
	
	@override
	Future<void> createSet(String name, String lang1, String lang2) async {
		if (_user == null) {
			throw StateError('user not signed in');
		}
		
		var setInfo = MwSetInfo(name, lang1, lang2, _getNewSetID());
		try {
			await _db.createSetDoc(setInfo);
		} catch (e) {
			print('$_TAG: createSet: failure (createSetDoc), error: ${e.toString()}');
			throw e;
		}
		
		_user.sets.add(setInfo);
		try {
			await _db.updateUserDoc(_user);
		} catch (e) {
			print('$_TAG: createSet: failure (updateUserDoc), error: ${e.toString()}');
			throw e;
		}
		
		notifyListeners();
		
		print('$_TAG: addSet: success');
	}
	
	@override
	Future<MwSet> getSet(String setId) async {
		if (_user == null) {
			throw StateError('user not signed in');
		}
		
		var setDoc;
		try {
			setDoc = await _db.getSetDoc(setId);
		} catch (e) {
			print('$_TAG: getSet: failure (getSetDoc), error: ${e.toString()}');
			throw e;
		}
		
		var set;
		try {
			set = MwSet.fromMap(setDoc);
		} catch (e) {
			print('$_TAG: getSet: failure (fromMap), error: ${e.toString()}');
			throw e;
		}
		
		print('$_TAG: getSet: success');
		
		return set;
	}
	
	@override
	Future<void> updateSet(MwSet set) async {
		if (_user == null) {
			throw StateError('user not signed in');
		}
		
		_updateSetInfo(set.setInfo);
		
		try {
			await _db.updateUserDoc(_user);
		} catch (e) {
			print('$_TAG: updateSet: failure (updateUserDoc), error: ${e.toString()}');
			throw e;
		}
		
		try {
			await _db.updateSetDoc(set);
		} catch (e) {
			print('$_TAG: updateSet: failure (updateSetDoc), error: ${e.toString()}');
			throw e;
		}
		
		notifyListeners();
		
		print('$_TAG: updateSet: success');
	}
	
	@override
	Future<void> deleteSet(String setId) async {
		if (_user == null) {
			throw StateError('user not signed in');
		}
		
		_removeSetInfo(setId);
		
		try {
			await _db.updateUserDoc(_user);
		} catch (e) {
			print('$_TAG: deleteSet: failure (updateUserDoc), error: ${e.toString()}');
		}
		
		try {
			await _db.deleteSetDoc(setId);
		} catch (e) {
			print('$_TAG: deleteSet: failure (deleteSetDoc), error: ${e.toString()}');
		}
		
		notifyListeners();
		
		print('$_TAG: deleteSet: success');
	}
	
	
	
	String _getNewSetID() {
		return id + '_' + DateTime
			.now()
			.millisecondsSinceEpoch
			.toString();
	}
	
	void _updateSetInfo(MwSetInfo info) {
		_removeSetInfo(info.id);
		_user.sets.add(info.copy());
	}
	
	void _removeSetInfo(String setID) {
		_user.sets.removeWhere((set) => set.id == setID);
	}
}