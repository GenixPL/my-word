import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_word/models/user.dart';


class DBService {

	//singleton stuff
	static final DBService _instance = DBService._init();

	static DBService get instance => _instance;

	DBService._init();




	static const _TAG = 'DBService';

	final _usersCollection = Firestore.instance.collection('users');
	final _privateSetsCollection = Firestore.instance.collection('private-sets');


	Future<Exception> createUserDoc(FirebaseUser firebaseUser) async {
		try {
			await _usersCollection.document(firebaseUser.uid).setData({
				'id': firebaseUser.uid,
				'email': firebaseUser.email,
			});

			print('$_TAG: createUserDoc: success');
			return null;
		} catch (e) {
			print('$_TAG: createUserDoc: failure, error: ${e.toString()}');
			return e;
		}
	}

	Future<Exception> updateUserDoc(User user) async {
		try {
			await _usersCollection.document(user.id).setData(user.toMap(), merge: true);

			print('$_TAG: updateUserDoc: success');
			return null;
		} catch (e) {
			print('$_TAG: updateUserDoc: failure, error: ${e.toString()}');
			return e;
		}
	}

	Future<Map<String, dynamic>> getUserDoc(String userID) async {
		try {
			var docSnap = await _usersCollection.document(userID).get();
			print('$_TAG: getUserDoc: success');
			return docSnap.data;
		} catch (e) {
			print('$_TAG: getUserDoc: failure, error: ${e.toString()}');
			throw e;
		}
	}

	Future<bool> checkUserDocExists(String userID) async {
		var docRef = _usersCollection.document(userID);

		try {
			var docSnap = await docRef.get();
			if (docSnap.exists) {
				print('$_TAG: checkUserDocExists: success (doc exists)');
				return true;
			} else {
				print('$_TAG: checkUserDocExists: success (doc doesn\'t exist)');
				return false;
			}
		} catch (e) {
			print('$_TAG: checkUserDocExists: failure, error: ${e.toString()}');
			throw e;
		}
	}

}