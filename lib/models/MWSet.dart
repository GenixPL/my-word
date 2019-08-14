import 'package:my_word/models/MWSetInfo.dart';
import 'package:my_word/models/MWWordPair.dart';


class MWSet {
	
	MWSetInfo _setInfo;
	List<MWWordPair> _wordPairs;
	
	
	String get id => _setInfo.id;
	
	String get name => _setInfo.name;
	
	String get lang1 => _setInfo.lang1;
	
	String get lang2 => _setInfo.lang2;
	
	List<MWWordPair> get wordPairs => _wordPairs;
	
	MWSetInfo get setInfo => _setInfo.copy();
	
	
	set name(String name) {
		_setInfo.name = name;
	}
	
	set lang1(String lang) {
		_setInfo.lang1 = lang;
	}
	
	set lang2(String lang) {
		_setInfo.lang2 = lang;
	}
	
	
	MWSet(this._setInfo, this._wordPairs);
	
	static MWSet fromMap(Map<dynamic, dynamic> map) {
		var setInfo = MWSetInfo.fromMap(map);
		
		var wordPairs = List<MWWordPair>();
		if (map.containsKey('wordPairs')) {
			var wordPairsList = map['wordPairs'] as List;
			wordPairsList.forEach((pairMap) => wordPairs.add(MWWordPair.fromMap(pairMap)));
		}
		
		return MWSet(setInfo, wordPairs);
	}
	
	Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();
		
		map.addAll(_setInfo.toMap());
		map['wordPairs'] = _wordPairs.map((setInfo) => setInfo.toMap()).toList();
		
		return map;
	}
	
	addWordPair(String word1, String word2) {
		_wordPairs.add(MWWordPair.createNew(word1, word2));
	}
	
	removeWordPair(String wordPairID) {
		_wordPairs.removeWhere((pair) => pair.id == wordPairID);
	}
}