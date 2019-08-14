class MwSetInfo {
	
	String name;
	String _lang1;
	String _lang2;
	String _id;
	
	
	String get id => _id;
	
	String get lang1 => _lang1;
	
	String get lang2 => _lang2;
	
	
	set lang1(String lang) => _lang1 = lang.toUpperCase();
	
	set lang2(String lang) => _lang2 = lang.toUpperCase();
	
	
	MwSetInfo(this.name, String lang1, String lang2, this._id) {
		_lang1 = lang1.toUpperCase();
		_lang2 = lang2.toUpperCase();
	}
	
	static MwSetInfo fromMap(Map<dynamic, dynamic> map) {
		var name = map['name'] ?? (throw ArgumentError("set_name is required"));
		var lang1 = map['lang1'] ?? (throw ArgumentError("set_lang1 is required"));
		var lang2 = map['lang2'] ?? (throw ArgumentError("set_lang2 is required"));
		var id = map['id'] ?? (throw ArgumentError("set_id is required"));
		
		return MwSetInfo(name, lang1, lang2, id);
	}
	
	Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();
		
		map['name'] = name;
		map['lang1'] = lang1;
		map['lang2'] = lang2;
		map['id'] = id;
		
		return map;
	}
	
	MwSetInfo copy() {
		return MwSetInfo(name, lang1, lang2, id);
	}
	
}