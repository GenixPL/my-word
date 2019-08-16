import 'package:flutter/material.dart';


class ShowInfo {
	
	static const _TAG = 'ShowInfo';
	
	
	ShowInfo._();
	
	static simple(BuildContext context, String msg) {
		Scaffold.of(context).showSnackBar(
			SnackBar(
				content: Text(
					'$msg',
					style: TextStyle(
						color: Colors.white,
					),
				),
				behavior: SnackBarBehavior.floating,
				backgroundColor: Color.fromRGBO(64, 64, 64, 1.0),
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