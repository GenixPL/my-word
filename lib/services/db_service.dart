import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_word/models/set_info.dart';
import 'package:my_word/models/user.dart';


class DBService {
	
	//singleton stuff
	static final DBService _instance = DBService._init();
	
	static DBService get instance => _instance;
	
	DBService._init();
	
	
	
	static const _TAG = 'DBService';
	
	final _usersCollection = Firestore.instance.collection('users');
	final _privateSetsCollection = Firestore.instance.collection('private-sets');
	
	
	//USER
	Future<void> createUserDoc(FirebaseUser firebaseUser) async {
		try {
			await _usersCollection.document(firebaseUser.uid).setData({
				'id': firebaseUser.uid,
				'email': firebaseUser.email,
			});
		} catch (e) {
			print('$_TAG: createUserDoc: failure, error: ${e.toString()}');
			throw e;
		}
		
		print('$_TAG: createUserDoc: success');
	}
	
	Future<void> updateUserDoc(User user) async {
		try {
			await _usersCollection.document(user.id).setData(user.toMap(), merge: true);
		} catch (e) {
			print('$_TAG: updateUserDoc: failure, error: ${e.toString()}');
			throw e;
		}
		
		print('$_TAG: updateUserDoc: success');
	}
	
	Future<Map<String, dynamic>> getUserDoc(String userID) async {
		var docSnap;
		try {
			docSnap = await _usersCollection.document(userID).get();
		} catch (e) {
			print('$_TAG: getUserDoc: failure, error: ${e.toString()}');
			throw e;
		}
		
		print('$_TAG: getUserDoc: success');
		return docSnap.data;
	}
	
	Future<bool> checkUserDocExists(String userID) async {
		var docRef = _usersCollection.document(userID);
		
		var docSnap;
		try {
			docSnap = await docRef.get();
		} catch (e) {
			print('$_TAG: checkUserDocExists: failure, error: ${e.toString()}');
			throw e;
		}
		
		if (docSnap.exists) {
			print('$_TAG: checkUserDocExists: success (doc exists)');
			return true;
		} else {
			print('$_TAG: checkUserDocExists: success (doc doesn\'t exist)');
			return false;
		}
	}
	
	
	//SETS
	Future<void> createSetDoc(SetInfo setInfo) async {
		try {
			await _privateSetsCollection.document(setInfo.id).setData(setInfo.toMap());
		} catch (e) {
			print('$_TAG: createSetDoc: failure, error: ${e.toString()}');
			throw e;
		}
		
		print('$_TAG: createSetDoc: success');
	}
	
}