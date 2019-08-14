

class MwWordPair {
	
	String _id;
	String word1;
	String word2;
	
	
	String get id => _id;
	
	
	MwWordPair(this._id, this.word1, this.word2);
	
	static MwWordPair fromMap(Map<dynamic, dynamic> map) {
		var id = map['id'] ?? (throw ArgumentError("id is required"));
		var word1 = map['word1'] ?? (throw ArgumentError("word1 is required"));
		var word2 = map['word2'] ?? (throw ArgumentError("word2 is required"));
		
		return MwWordPair(id, word1, word2);
	}
	
	static MwWordPair createNew(String word1, String word2) {
		var id = DateTime.now().millisecondsSinceEpoch.toString();
		
		return MwWordPair(id, word1, word2);
	}
	
	Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();
		
		map['id'] = id;
		map['word1'] = word1;
		map['word2'] = word2;
		
		return map;
	}
	
	MwWordPair copy(){
		return MwWordPair(_id, word1, word2);
	}
}