import 'package:my_word/models/set_info.dart';
import 'package:my_word/models/word_pair.dart';


class UserSet {
	
	SetInfo _setInfo;
	List<WordPair> _wordPairs;
	
	
	String get name => _setInfo.name;
	
	String get lang1 => _setInfo.lang1;
	
	String get lang2 => _setInfo.lang2;
	
	List<WordPair> get wordPairs => _wordPairs;
	
	
	set name(String name) {
		_setInfo.name = name;
	}
	
	set lang1(String lang) {
		_setInfo.lang1 = lang;
	}
	
	set lang2(String lang) {
		_setInfo.lang2 = lang;
	}
	
	
	UserSet(this._setInfo, this._wordPairs);
	
	static UserSet fromMap(Map<String, dynamic> map) {
		print('fromMap: $map');
		
		var setInfo = SetInfo.fromMap(map);
		
		print('fromMap: ${setInfo.toMap()}');
		
		var wordPairs = List<WordPair>();
		if (map.containsKey('wordPairs')) {
			var wordPairsList = map['wordPairs'] as List;
			wordPairsList.forEach((pairMap) => wordPairs.add(WordPair.fromMap(pairMap)));
		}
		
		print('fromMap: ${wordPairs.map((setInfo) => setInfo.toMap()).toList()}');
		
		return UserSet(setInfo, wordPairs);
	}
	
	Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();
		
		map.addAll(_setInfo.toMap());
		map['wordPairs'] = _wordPairs.map((setInfo) => setInfo.toMap()).toList();
		
		return map;
	}
	
	addWordPair(String word1, String word2) {
		_wordPairs.add(WordPair.createNew(word1, word2));
	}
	
	removeWordPair(String wordPairID) {
		_wordPairs.removeWhere((pair) => pair.id == wordPairID);
	}
}