import 'package:flutter/material.dart';
import 'package:my_word/models/user_set.dart';


class AddPairPage extends StatefulWidget {
	
	final UserSet userSet;
	
	AddPairPage(this.userSet);
	
	@override
	_AddPairPageSate createState() => _AddPairPageSate(userSet);
}


class _AddPairPageSate extends State<AddPairPage> {
	
	UserSet _set;
	
	final _word1Controller = TextEditingController();
	final _word2Controller = TextEditingController();
	bool _isWord1Valid = true;
	bool _isWord2Valid = true;
	
	_AddPairPageSate(this._set);
	
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				centerTitle: true,
				title: Text('Add Pair'),
			),
			body: Center(
				child: Column(
					children: <Widget>[
						
						_pair(context),
						
						_bottom(context),
					
					],
				),
			),
		);
	}
	
	Widget _pair(BuildContext context) {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					
					Padding(
						padding: EdgeInsets.all(8.0),
						child: TextFormField(
							style: TextStyle(
								fontSize: 16.0,
								fontWeight: FontWeight.w400,
							),
							controller: _word1Controller,
							decoration: InputDecoration(
								hintText: 'First part',
								errorText: _isWord1Valid ? null : 'Field can\'t be empty.',
							),
						)
					),
					
					Padding(
						padding: EdgeInsets.all(8.0),
						child: TextFormField(
							style: TextStyle(
								fontSize: 16.0,
								fontWeight: FontWeight.w400,
							),
							controller: _word2Controller,
							decoration: InputDecoration(
								hintText: 'Second part',
								errorText: _isWord2Valid ? null : 'Field can\'t be empty.',
							),
						)
					),
				
				],
			),
		
		);
	}
	
	Widget _bottom(BuildContext context) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget>[
				
				Padding(
					padding: const EdgeInsets.all(8.0),
					child: RaisedButton(
						color: Colors.red,
						child: Text(
							'Cancel',
							style: TextStyle(
								fontWeight: FontWeight.w600
							),
						),
						onPressed: () {
							Navigator.of(context).pop();
						},
					),
				),
				
				Padding(
					padding: const EdgeInsets.all(8.0),
					child: RaisedButton(
						color: Colors.green,
						child: Text(
							'Add',
							style: TextStyle(
								fontWeight: FontWeight.w600
							),
						),
						onPressed: () {
							_validateWords();
							
							if (_isWord1Valid && _isWord2Valid) {
								FocusScope.of(context).requestFocus(new FocusNode());
								_set.addWordPair(_word1Controller.text, _word2Controller.text);
								Navigator.of(context).pop();
							}
						},
					),
				),
			
			],
		);
	}
	
	_validateWords() {
		setState(() {
			_word1Controller.text = _word1Controller.text.trim();
			_word1Controller.text.isEmpty ? _isWord1Valid = false : _isWord1Valid = true;
			
			_word2Controller.text = _word2Controller.text.trim();
			_word2Controller.text.isEmpty ? _isWord2Valid = false : _isWord2Valid = true;
		});
	}
}