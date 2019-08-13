import 'package:flutter/material.dart';
import 'package:my_word/models/user_set.dart';


class EditSetPage extends StatefulWidget {
	
	final UserSet userSet;
	
	EditSetPage(this.userSet);
	
	@override
	_EditSetPageState createState() => _EditSetPageState(userSet);
}


class _EditSetPageState extends State<EditSetPage> {
	
	UserSet _set;
	
	_EditSetPageState(this._set);
	
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				centerTitle: true,
				title: Text('Manage Set'),
			),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						
						Expanded(
							flex: 90,
							child: Center(
							  child: Column(
							  	children: <Widget>[
							  		
							  		Text('${_set.name}'),
							  		Text('${_set.lang1}'),
							  		Text('${_set.lang2}'),
									  
								  ],
							  ),
							)
						),
						
						Expanded(
							flex: 10,
							child: Align(
								alignment: Alignment.bottomCenter,
								child: Padding(
									padding: const EdgeInsets.all(8.0),
									child: RaisedButton(
										color: Colors.green,
										child: Text(
											'Save',
											style: TextStyle(
												fontWeight: FontWeight.w600
											),
										),
										onPressed: () {
											print('save');
										}
									),
								),
							),
						),
					
					],
				),
			)
		);
	}
	
}