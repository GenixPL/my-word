import 'package:my_word/models/MwSetInfo.dart';
import 'package:my_word/models/MwSet.dart';
import 'package:my_word/services/MwDBService.dart';


class MwUser {
	
	//TODO: move logic to separate service
	
	static const _TAG = 'User';
	
	String _id;
	String _email;
	List<MwSetInfo> _sets;
	
	
	String get id => _id;
	
	String get email => _email;
	
	List<MwSetInfo> get sets => _sets;
	
	
	
	MwUser(this._id, this._email, this._sets);
	
	static MwUser fromMap(Map<String, dynamic> map) {
		var id = map['id'] ?? (throw ArgumentError("id is required"));
		var email = map['email'] ?? (throw ArgumentError("email is required"));
		
		var sets = List<MwSetInfo>();
		if (map.containsKey('sets')) {
			var setsList = map['sets'] as List;
			setsList.forEach((setMap) => sets.add(MwSetInfo.fromMap(setMap)));
		}
		
		return MwUser(id, email, sets);
	}
	
	Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();
		
		map['id'] = id;
		map['email'] = email;
		map['sets'] = sets.map((setInfo) => setInfo.toMap()).toList();
		
		return map;
	}
	
	
	Future<void> addSet(String name, String lang1, String lang2) async {
		var setInfo = MwSetInfo(name, lang1, lang2, _getNewSetID());
		
		try {
			await MwDbService.instance.createSetDoc(setInfo);
		} catch (e) {
			print('$_TAG: addSet: failure (createSetDoc), error: ${e.toString()}');
			throw e;
		}
		
		sets.add(setInfo);
		try {
			await MwDbService.instance.updateUserDoc(this);
		} catch (e) {
			print('$_TAG: addSet: failure (updateUserDoc), error: ${e.toString()}');
			
			throw e;
		}
		
		print('$_TAG: addSet: success');
	}
	
	Future<void> updateSet(MwSet set) async {
		_updateSetInfo(set.setInfo);
		
		try {
			await MwDbService.instance.updateUserDoc(this);
		} catch (e) {
			print('$_TAG: updateSet: failure (updateUserDoc), error: ${e.toString()}');
		}
		
		try {
			await MwDbService.instance.updateSetDoc(set);
		} catch (e) {
			print('$_TAG: updateSet: failure (updateSetDoc), error: ${e.toString()}');
		}
		
		print('$_TAG: updateSet: success');
	}
	
	Future<void> deleteSet(String setID) async {
		_removeSetInfo(setID);
		
		try {
			await MwDbService.instance.updateUserDoc(this);
		} catch (e) {
			print('$_TAG: deleteSet: failure (updateUserDoc), error: ${e.toString()}');
		}
		
		try {
			await MwDbService.instance.deleteSetDoc(setID);
		} catch (e) {
			print('$_TAG: deleteSet: failure (deleteSetDoc), error: ${e.toString()}');
		}
		
		print('$_TAG: deleteSet: success');
	}
	
	String _getNewSetID() {
		return _id + '_' + DateTime
			.now()
			.millisecondsSinceEpoch
			.toString();
	}
	
	void _updateSetInfo(MwSetInfo info) {
		_removeSetInfo(info.id);
		_sets.add(info.copy());
	}
	
	void _removeSetInfo(String setID) {
		_sets.removeWhere((set) => set.id == setID);
	}
}

