import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_word/models/set_info.dart';


class User {

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
}

