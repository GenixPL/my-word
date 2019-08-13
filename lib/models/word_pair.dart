

class WordPair {
	
	String _word1;
	String _word2;
	
	String get word1 => _word1;
	String get word2 => _word2;
	
	set word1(String word) {
		word.trim();
		//TODO: possible validation here or somewhere else
		_word1 = word;
	}
	
	set word2(String word) {
		word.trim();
		//TODO: possible validation here or somewhere else
		_word2 = word;
	}
	
	WordPair(this._word1, this._word2);
	
	static WordPair fromMap(Map<String, dynamic> map) {
		var word1 = map['word1'] ?? (throw ArgumentError("word1 is required"));
		var word2 = map['word2'] ?? (throw ArgumentError("word2 is required"));
		
		return WordPair(word1, word2);
	}
	
	Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();
		
		map['word1'] = word1;
		map['word2'] = word2;
		
		return map;
	}
}