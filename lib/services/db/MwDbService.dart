import 'package:my_word/models/MwSet.dart';
import 'package:my_word/models/MwSetInfo.dart';
import 'package:my_word/models/MwUser.dart';


abstract class MwDbService {
	
	Future<void> createUserDoc(String id, String email);
	
	Future<void> updateUserDoc(MwUser user);
	
	Future<Map<String, dynamic>> getUserDoc(String userID);
	
	
	
	Future<void> createSetDoc(MwSetInfo setInfo);
	
	Future<Map<String, dynamic>> getSetDoc(String setID);
	
	Future<void> updateSetDoc(MwSet set);
	
	Future<void> deleteSetDoc(String setID);
}