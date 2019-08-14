import 'package:flutter/foundation.dart';
import 'package:my_word/models/MwSet.dart';
import 'package:my_word/models/MwSetInfo.dart';


abstract class MwUserService with ChangeNotifier {
	
	String get id;
	
	String get email;
	
	bool get isSigned;
	
	List<MwSetInfo> get setsInfo;
	
	
	
	Future<void> checkUserExists();
	
	Future<void> signInEmailPassword(String email, String password);
	
	Future<void> signUpEmailPassword(String email, String password);
	
	Future<void> signOut();
	
	
	
	Future<void> createSet(String name, String lang1, String lang2);
	
	Future<MwSet> getSet(String setId);
	
	Future<void> updateSet(MwSet set);
	
	Future<void> deleteSet(String setId);
}
