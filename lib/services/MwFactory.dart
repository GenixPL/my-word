import 'package:my_word/services/db/MwDbService.dart';
import 'package:my_word/services/auth/MwAuthService.dart';
import 'package:my_word/services/auth/MwAuthServiceImpl.dart';
import 'package:my_word/services/db/MwDbServiceImpl.dart';
import 'package:my_word/services/user/MwUserService.dart';
import 'package:my_word/services/user/MwUserServiceImpl.dart';


class MwFactory {
	
	static MwAuthService _authService = MwAuthServiceImpl();
	static MwDbService _dbService = MwDbServiceImpl();
	static MwUserService _userService = MwUserServiceImpl(_authService, _dbService);
	
	
	static MwUserService get userService => _userService;
	
}