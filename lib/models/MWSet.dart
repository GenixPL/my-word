import 'package:my_word/models/MwSetInfo.dart';
import 'package:my_word/models/MwWordPair.dart';


class MwSet {
	
	MwSetInfo _setInfo;
	List<MwWordPair> _wordPairs;
	
	
	String get id => _setInfo.id;
	
	String get name => _setInfo.name;
	
	String get lang1 => _setInfo.lang1;
	
	String get lang2 => _setInfo.lang2;
	
	List<MwWordPair> get wordPairs => _wordPairs;
	
	MwSetInfo get setInfo => _setInfo.copy();
	
	
	set name(String name) {
		_setInfo.name = name;
	}
	
	set lang1(String lang) {
		_setInfo.lang1 = lang;
	}
	
	set lang2(String lang) {
		_setInfo.lang2 = lang;
	}
	
	
	MwSet(this._setInfo, this._wordPairs);
	
	static MwSet fromMap(Map<dynamic, dynamic> map) {
		var setInfo = MwSetInfo.fromMap(map);
		
		var wordPairs = List<MwWordPair>();
		if (map.containsKey('wordPairs')) {
			var wordPairsList = map['wordPairs'] as List;
			wordPairsList.forEach((pairMap) => wordPairs.add(MwWordPair.fromMap(pairMap)));
		}
		
		return MwSet(setInfo, wordPairs);
	}
	
	Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();
		
		map.addAll(_setInfo.toMap());
		map['wordPairs'] = _wordPairs.map((setInfo) => setInfo.toMap()).toList();
		
		return map;
	}
	
	addWordPair(String word1, String word2) {
		_wordPairs.add(MwWordPair.createNew(word1, word2));
	}
	
	removeWordPair(String wordPairID) {
		_wordPairs.removeWhere((pair) => pair.id == wordPairID);
	}
}