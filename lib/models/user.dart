import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_word/models/set_info.dart';
import 'package:my_word/models/user_set.dart';
import 'package:my_word/services/db_service.dart';


class User {
	
	//TODO: move logic to separate service
	
	static const _TAG = 'User';
	
	String _id;
	String _email;
	List<SetInfo> _sets;
	
	
	String get id => _id;
	
	String get email => _email;
	
	List<SetInfo> get sets => _sets;
	
	
	
	User(this._id, this._email, this._sets);
	
	static User fromMap(Map<String, dynamic> map) {
		var id = map['id'] ?? (throw ArgumentError("id is required"));
		var email = map['email'] ?? (throw ArgumentError("email is required"));
		
		var sets = List<SetInfo>();
		if (map.containsKey('sets')) {
			var setsList = map['sets'] as List;
			setsList.forEach((setMap) => sets.add(SetInfo.fromMap(setMap)));
		}
		
		return User(id, email, sets);
	}
	
	Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();
		
		map['id'] = id;
		map['email'] = email;
		map['sets'] = sets.map((setInfo) => setInfo.toMap()).toList();
		
		return map;
	}
	
	
	Future<void> addSet(String name, String lang1, String lang2) async {
		var setInfo = SetInfo(name, lang1, lang2, _getNewSetID());
		
		try {
			await DBService.instance.createSetDoc(setInfo);
		} catch (e) {
			print('$_TAG: addSet: failure (createSetDoc), error: ${e.toString()}');
			throw e;
		}
		
		sets.add(setInfo);
		try {
			await DBService.instance.updateUserDoc(this);
		} catch (e) {
			print('$_TAG: addSet: failure (updateUserDoc), error: ${e.toString()}');
			
			throw e;
		}
		
		print('$_TAG: addSet: success');
	}
	
	Future<void> updateSet(UserSet set) async {
		_updateSetInfo(set.setInfo);
		
		try {
			DBService.instance.updateUserDoc(this);
		} catch (e) {
			print('$_TAG: updateSet: failure (updateUserDoc), error: ${e.toString()}');
		}
		
		try {
			DBService.instance.updateSetDoc(set);
		} catch (e) {
			print('$_TAG: updateSet: failure (updateSetDoc), error: ${e.toString()}');
		}
		
		print('$_TAG: updateSet: success');
	}
	
	String _getNewSetID() {
		return _id + '_' + DateTime.now().millisecondsSinceEpoch.toString();
	}
	
	void _updateSetInfo(SetInfo info) {
		_sets.removeWhere((set) => set.id == info.id);
		_sets.add(info.copy());
	}
}

