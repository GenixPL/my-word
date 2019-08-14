import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_word/models/MwSet.dart';
import 'package:my_word/models/MwSetInfo.dart';
import 'package:my_word/models/MwUser.dart';
import 'package:my_word/services/db/MwDbService.dart';


class MwDbServiceImpl extends MwDbService {
	
	static const _TAG = 'DBService';
	
	final _usersCollection = Firestore.instance.collection('users');
	final _privateSetsCollection = Firestore.instance.collection('private-sets');
	
	
	Future<void> createUserDoc(String id, String email) async {
		try {
			await _usersCollection.document(id).setData({
				'id': id,
				'email': email,
			});
		} catch (e) {
			print('$_TAG: createUserDoc: failure, error: ${e.toString()}');
			throw e;
		}
		
		print('$_TAG: createUserDoc: success');
	}
	
	Future<void> updateUserDoc(MwUser user) async {
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
	
	
	
	Future<void> createSetDoc(MwSetInfo setInfo) async {
		try {
			await _privateSetsCollection.document(setInfo.id).setData(setInfo.toMap());
		} catch (e) {
			print('$_TAG: createSetDoc: failure, error: ${e.toString()}');
			throw e;
		}
		
		print('$_TAG: createSetDoc: success');
	}
	
	Future<Map<String, dynamic>> getSetDoc(String setID) async {
		var docSnap;
		try {
			docSnap = await _privateSetsCollection.document(setID).get();
		} catch (e) {
			print('$_TAG: getSetDoc: failure, error: ${e.toString()}');
			throw e;
		}
		
		print('$_TAG: getSetDoc: success');
		
		return docSnap.data;
	}
	
	Future<void> updateSetDoc(MwSet set) async {
		try {
			await _privateSetsCollection.document(set.id).setData(set.toMap(), merge: true);
		} catch (e) {
			print('$_TAG: updateSetDoc: failure, error: ${e.toString()}');
			throw e;
		}
		
		print('$_TAG: updateSetDoc: success');
	}
	
	Future<void> deleteSetDoc(String setID) async {
		try {
			await _privateSetsCollection.document(setID).delete();
		} catch (e) {
			print('$_TAG: deleteSetDoc: failure, error: ${e.toString()}');
			throw e;
		}
		
		print('$_TAG: deleteSetDoc: success');
	}
}