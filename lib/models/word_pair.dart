

class WordPair {
	
	String word1;
	String word2;
	
	WordPair(this.word1, this.word2);
	
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