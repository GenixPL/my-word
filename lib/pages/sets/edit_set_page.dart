import 'package:flutter/material.dart';
import 'package:language_pickers/language.dart';
import 'package:language_pickers/language_picker_dialog.dart';
import 'package:my_word/services/MwFactory.dart';
import 'package:my_word/models/MwSet.dart';
import 'package:my_word/show_info.dart';


class EditSetPage extends StatefulWidget {
	
	final MwSet _set;
	
	EditSetPage(this._set);
	
	@override
	_EditSetPageState createState() => _EditSetPageState(_set);
}


class _EditSetPageState extends State<EditSetPage> {
	
	MwSet _set;
	
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
				textAlign: TextAlign.center,
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
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: <Widget>[
					
					Expanded(
						child: Padding(
							padding: const EdgeInsets.all(8.0),
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
					),
					
					Expanded(
						child: Padding(
							padding: const EdgeInsets.all(8.0),
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
			background: Container(color: Colors.red,),
			child: GestureDetector(
				child: Row(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						
						Expanded(
							child: Padding(
								padding: const EdgeInsets.all(8.0),
								child: Text(
									'${_set.wordPairs[i].word1}',
									textAlign: TextAlign.center,
									style: TextStyle(
										fontSize: 16.0,
										fontWeight: FontWeight.w400
									),
								),
							),
						),
						
						Padding(
							padding: const EdgeInsets.all(8.0),
							child: Text(
								' - ',
								textAlign: TextAlign.center,
								style: TextStyle(
									fontSize: 16.0,
									fontWeight: FontWeight.w400
								),),
						),
						
						Expanded(
							child: Padding(
								padding: const EdgeInsets.all(8.0),
								child: Text(
									'${_set.wordPairs[i].word2}',
									textAlign: TextAlign.center,
									style: TextStyle(
										fontSize: 16.0,
										fontWeight: FontWeight.w400
									),
								),
							),
						),
					
					
					],
				),
				onTap: () {
					Navigator.of(context).pushNamed('/sets/edit/edit-pair', arguments: _set.wordPairs[i]);
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
							showDialog(
								context: context,
								builder: (BuildContext context) {
									// return object of type Dialog
									return Dialog(
										child: Column(
											mainAxisSize: MainAxisSize.min,
											children: <Widget>[
												
												Padding(
													padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
													child: Text(
														'This cannot be undone!',
														textAlign: TextAlign.center,
														style: TextStyle(
															fontWeight: FontWeight.w600,
															fontSize: 24.0,
														),
													),
												),
												
												Row(
													mainAxisSize: MainAxisSize.min,
													mainAxisAlignment: MainAxisAlignment.center,
													children: <Widget>[
														
														FlatButton(
															child: new Text(
																'Cancel',
																style: TextStyle(
																	color: Colors.white,
																),
															),
															onPressed: () {
																Navigator.of(context).pop();
															},
														),
														
														FlatButton(
															child: new Text(
																'Remove',
																style: TextStyle(
																	color: Colors.red,
																),
															),
															onPressed: () {
																MwFactory.userService.deleteSet(_set.id)
																	.then((v) {
																	Navigator.of(context).pop();
																	Navigator.of(context).pop();
																}).catchError((e) {
																	ShowInfo.error(context, '', e);
																	Navigator.of(context).pop();
																});
															},
														),
													
													],
												),
											
											],
										),
									);
								},
							);
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
							_validateName();
							
							MwFactory.userService.updateSet(_set)
								.then((v) {
								Navigator.of(context).pop();
							})
								.catchError((e) {
								ShowInfo.error(context, '', e);
							});
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
				Flexible(child: Text('(${language.isoCode})'))
			],
		);
	}
	
}