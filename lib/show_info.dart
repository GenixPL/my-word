import 'package:flutter/material.dart';


class ShowInfo {
	
	ShowInfo._();
	
	static simple(BuildContext context, String msg) {
		Scaffold.of(context).showSnackBar(
			SnackBar(
				content: Text('$msg'),
				behavior: SnackBarBehavior.floating,
			)
		);
	}
	
	static error(BuildContext context, String msg, Exception e) {
		Scaffold.of(context).showSnackBar(
			SnackBar(
				content: Text('There was an error ($msg), try again. [${e.toString()}]'), //TODO: remove error info
				behavior: SnackBarBehavior.floating,
			)
		);
	}
}