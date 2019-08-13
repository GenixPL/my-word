import 'package:flutter/material.dart';
import 'package:language_pickers/language.dart';
import 'package:language_pickers/language_picker_dialog.dart';
import 'package:my_word/models/user_set.dart';


class EditSetPage extends StatefulWidget {
	
	final UserSet userSet;
	
	EditSetPage(this.userSet);
	
	@override
	_EditSetPageState createState() => _EditSetPageState(userSet);
}


class _EditSetPageState extends State<EditSetPage> {
	
	UserSet _set;
	
	final _nameController = TextEditingController();
	bool _isNameValid = true;
	
	_EditSetPageState(this._set) {
		_nameController.text = _set.name;
	}
	
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				centerTitle: true,
				title: Text('Manage Set'),
			),
			resizeToAvoidBottomInset: false,
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						
						_name(context),
						_languages(context),
						_pairs(context),
						_bottom(context),
					
					],
				),
			));
	}
	
	Widget _name(BuildContext context) {
		return Padding(
			padding: EdgeInsets.all(8.0),
			child: TextFormField(
				style: TextStyle(
					fontSize: 16.0,
					fontWeight: FontWeight.w400,
				),
				controller: _nameController,
				onChanged: (str) {
					_set.name = str;
				},
				decoration: InputDecoration(
					hintText: 'Set Name',
					errorText: _isNameValid ? null : 'Field can\'t be empty.',
				),
			)
		);
	}
	
	Widget _languages(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.all(8.0),
			child: Row(
				children: <Widget>[
					
					Expanded(
						flex: 50,
						child: GestureDetector(
							child: Text(
								'${_set.lang1}',
								textAlign: TextAlign.center,
								style: TextStyle(
									fontSize: 20.0,
									fontWeight: FontWeight.w600,
								),
							),
							onTap: () {
								_openFirstDialog();
							},
						),
					),
					
					Expanded(
						flex: 50,
						child: GestureDetector(
							child: Text(
								'${_set.lang2}',
								textAlign: TextAlign.center,
								style: TextStyle(
									fontSize: 20.0,
									fontWeight: FontWeight.w600,
								),
							),
							onTap: () {
								_openSecondDialog();
							},
						),
					)
				
				]
			),
		);
	}
	
	Widget _pairs(BuildContext context) {
		return Expanded(
			child: Scrollbar(
			  child: ListView.separated(
			  	itemCount: _set.wordPairs.length,
			  	itemBuilder: _buildListTile,
			  	separatorBuilder: (context, i) => Divider(),
			  	
			  ),
			),
		);
	}
	
	Widget _buildListTile(BuildContext context, int i) {
		return Dismissible(
			key: Key(_set.wordPairs[i].id),
		  background: Container(color: Colors.grey,),
		  child: ListTile(
		  	title: Text(
		  		'${_set.wordPairs[i].word1} ${_set.wordPairs[i].word2}',
		  	),
		  	onTap: () {
		  		print('change pair');
		  	},
		  ),
			onDismissed: (direction) {
				setState(() {
					_set.removeWordPair(_set.wordPairs[i].id);
				});
			},
		);
	}
	
	Widget _bottom(BuildContext context) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceAround,
			children: <Widget>[
				
				Padding(
					padding: const EdgeInsets.all(8.0),
					child: RaisedButton(
						color: Colors.red,
						child: Text(
							'Remove',
							style: TextStyle(
								fontWeight: FontWeight.w600
							),
						),
						onPressed: () {
							print('remove');
							//TODO: ask if for sure
							//(encapsulate both under to user)
							//TODO: remove from user
							//TODO: remove from private-sets
						}
					),
				),
				
				Padding(
					padding: const EdgeInsets.all(8.0),
					child: RaisedButton(
						child: Text(
							'Add Pair',
							style: TextStyle(
								fontWeight: FontWeight.w600
							),
						),
						onPressed: () {
							Navigator.of(context).pushNamed('/sets/edit/add', arguments: _set);
						}
					),
				),
				
				Padding(
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
							_validateName();
							_set.addWordPair('aa', 'sss');
							print(_set.toMap());
						}
					),
				),
			
			],
		);
	}
	
	_validateName() {
		setState(() {
			_nameController.text = _nameController.text.trim();
			_nameController.text.isEmpty ? _isNameValid = false : _isNameValid = true;
		});
	}
	
	_openFirstDialog() {
		showDialog(
			context: context,
			builder: (context) =>
				LanguagePickerDialog(
					titlePadding: EdgeInsets.all(8.0),
					searchInputDecoration: InputDecoration(hintText: 'Search...'),
					isSearchable: true,
					title: Text('Select your language'),
					onValuePicked: (Language language) =>
						setState(() {
							_set.lang1 = language.isoCode.toUpperCase();
						}),
					itemBuilder: _buildDialogItem
				)
		);
	}
	
	_openSecondDialog() {
		showDialog(
			context: context,
			builder: (context) =>
				LanguagePickerDialog(
					titlePadding: EdgeInsets.all(8.0),
					searchInputDecoration: InputDecoration(hintText: 'Search...'),
					isSearchable: true,
					title: Text('Select your language'),
					onValuePicked: (Language language) =>
						setState(() {
							_set.lang2 = language.isoCode.toUpperCase();
						}),
					itemBuilder: _buildDialogItem
				)
		);
	}
	
	Widget _buildDialogItem(Language language) {
		return Row(
			children: <Widget>[
				Text(language.name),
				SizedBox(width: 8.0),
				Flexible(child: Text("(${language.isoCode})"))
			],
		);
	}
	
}