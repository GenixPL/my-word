import 'package:flutter/material.dart';
import 'package:my_word/models/user_set.dart';
import 'package:my_word/pages/account/account_menu_page.dart';
import 'package:my_word/pages/auth/auth_email_password_page.dart';
import 'package:my_word/pages/auth/auth_menu_page.dart';
import 'package:my_word/pages/home_page.dart';
import 'package:my_word/pages/sets/add_pair.dart';
import 'package:my_word/pages/sets/create_set_page.dart';
import 'package:my_word/pages/sets/edit_set_page.dart';
import 'package:my_word/pages/sets/sets_menu_page.dart';
import 'package:my_word/services/auth_service.dart';


class RouteGenerator {
	
	static String _lastRoute;
	
	static get lastRoute => _lastRoute;
	
	static Route<dynamic> generateRoute(RouteSettings settings) {
		final args = settings.arguments;
		
		if (!AuthService.instance.isSigned && !settings.name.contains('/auth')) {
			return MaterialPageRoute(builder: (_) => AuthMenuPage());
		}
		
		_lastRoute = settings.name;
		
		switch (settings.name) {
			case '/':
				return MaterialPageRoute(builder: (_) => HomePage());
			
			case '/auth':
				return MaterialPageRoute(builder: (_) => AuthMenuPage());
			
			case '/auth/email-password':
				return MaterialPageRoute(builder: (_) => AuthEmailPasswordPage());
			
			case '/account':
				return MaterialPageRoute(builder: (_) => AccountMenuPage());
			
			case '/sets':
				return MaterialPageRoute(builder: (_) => SetsPage());
			
			case '/sets/create':
				return MaterialPageRoute(builder: (_) => CreateSetPage());
			
			case '/sets/edit':
				return _editSetPageRoute(args);
			
			case '/sets/edit/add':
				return _addPairPageRoute(args);
				
			default:
				return _errorRoute('No path specified.');
		}
	}
	
	static Route<dynamic> _errorRoute(String msg) {
		return MaterialPageRoute(builder: (_) {
			return Scaffold(
				body: Center(
					child: Text('ERROR ROUTE \n $msg'),
				),
			);
		});
	}
	
	static Route<dynamic> _editSetPageRoute(Object args) {
		if (args == null) {
			return _errorRoute('No arguments specified.');
		}
		
		if (args is! UserSet) {
			return _errorRoute('Sepcified arguments are of bad type.');
		}
		
		return MaterialPageRoute(builder: (_) => EditSetPage(args));
	}
	
	static Route<dynamic> _addPairPageRoute(Object args) {
		if (args == null) {
			return _errorRoute('No arguments specified.');
		}
		
		if (args is! UserSet) {
			return _errorRoute('Sepcified arguments are of bad type.');
		}
		
		return MaterialPageRoute(builder: (_) => AddPairPage(args));
	}
	
}