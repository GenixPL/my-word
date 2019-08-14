

class MWSetInfo {

	String name;
	String lang1;
	String lang2;
	String _id;

	
	String get id => _id;

	
	MWSetInfo(this.name, this.lang1, this.lang2, this.id);

	static MWSetInfo fromMap(Map<dynamic, dynamic> map) {
		var name = map['name'] ?? (throw ArgumentError("set_name is required"));
		var lang1 = map['lang1'] ?? (throw ArgumentError("set_lang1 is required"));
		var lang2 = map['lang2'] ?? (throw ArgumentError("set_lang2 is required"));
		var id = map['id'] ?? (throw ArgumentError("set_id is required"));

		return MWSetInfo(name, lang1, lang2, id);
	}

	Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();

		map['name'] = name;
		map['lang1'] = lang1;
		map['lang2'] = lang2;
		map['id'] = id;

		return map;
	}
	
	MWSetInfo copy() {
		return MWSetInfo(name, lang1, lang2, id);
	}

}