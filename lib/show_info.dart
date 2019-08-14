import 'package:flutter/material.dart';


class ShowInfo {
	
	static const _TAG = 'ShowInfo';
	
	
	ShowInfo._();
	
	static simple(BuildContext context, String msg) {
		Scaffold.of(context).showSnackBar(
			SnackBar(
				content: Text('$msg'),
				behavior: SnackBarBehavior.floating,
			)
		);
	}
	
	static error(BuildContext context, String msg, Object e) {
		print('$_TAG: error: ${e.toString()}');
		
		Scaffold.of(context).showSnackBar(
			SnackBar(
				content: Text('There was an error ($msg), try again. [${e.toString()}]'), //TODO: remove error info
				behavior: SnackBarBehavior.floating,
			)
		);
	}
}