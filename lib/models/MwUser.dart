import 'package:my_word/models/MwSetInfo.dart';


class MwUser {
	
	String _id;
	String _email;
	List<MwSetInfo> _sets;
	
	
	String get id => _id;
	
	String get email => _email;
	
	List<MwSetInfo> get sets => _sets;
	
	
	MwUser(this._id, this._email, this._sets);
	
	static MwUser fromMap(Map<String, dynamic> map) {
		var id = map['id'] ?? (throw ArgumentError('id is required'));
		var email = map['email'] ?? (throw ArgumentError('email is required'));
		
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
	
}

