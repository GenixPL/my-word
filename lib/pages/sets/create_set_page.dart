import 'package:flutter/material.dart';
import 'package:language_pickers/language.dart';
import 'package:language_pickers/language_picker_dialog.dart';
import 'package:language_pickers/utils/utils.dart';
import 'package:my_word/services/auth_service.dart';
import 'package:my_word/show_info.dart';


class CreateSetPage extends StatefulWidget {
	@override
	_CreateSetPageState createState() => _CreateSetPageState();
}


class _CreateSetPageState extends State<CreateSetPage> {
	
	final _nameController = TextEditingController();
	Language _lang1 = LanguagePickerUtils.getLanguageByIsoCode('en');
	Language _lang2 = LanguagePickerUtils.getLanguageByIsoCode('de');
	
	bool _isNameValid = true;
	
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			resizeToAvoidBottomInset: false,
			appBar: AppBar(
				centerTitle: true,
				title: Text('Create New Set'),
			),
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					
					Expanded(
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget>[
								
								_name(context),
								_languages(context),
							
							],
						),
					),
					
					_bottom(context),
				
				],
			),
		);
	}
	
	Widget _name(BuildContext context) {
		return Padding(
			padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 32.0),
			child: TextField(
				style: TextStyle(
					fontSize: 16.0,
					fontWeight: FontWeight.w400,
				),
				controller: _nameController,
				decoration: InputDecoration(
					hintText: 'Set Name',
					errorText: _isNameValid ? null : 'Set name can\'t be empty.',
				),
			)
		);
	}
	
	Widget _languages(BuildContext context) {
		return Row(
			children: <Widget>[
				
				Expanded(
					flex: 50,
					child: GestureDetector(
						child: Text(
							'${_lang1.name} (${_lang1.isoCode})',
							textAlign: TextAlign.center,
							style: TextStyle(
								fontSize: 16.0,
								fontWeight: FontWeight.w400,
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
							'${_lang2.name} (${_lang2.isoCode})',
							textAlign: TextAlign.center,
							style: TextStyle(
								fontSize: 16.0,
								fontWeight: FontWeight.w400,
							),
						),
						onTap: () {
							_openSecondDialog();
						},
					),
				)
			
			]
		);
	}
	
	Widget _bottom(BuildContext context) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget>[
				
				Padding(
					padding: const EdgeInsets.all(8.0),
					child: RaisedButton(
						child: Text(
							'Cancel',
							style: TextStyle(
								fontWeight: FontWeight.w600
							),
						),
						color: Colors.red,
						onPressed: () {
							Navigator.of(context).pop();
						}
					),
				),
				
				Padding(
					padding: const EdgeInsets.all(8.0),
					child: Builder(builder: (context) =>
						RaisedButton(
							child: Text(
								'Create',
								style: TextStyle(
									fontWeight: FontWeight.w600
								),
							),
							color: Colors.green,
							onPressed: () {
								_validateName();
								
								if (_isNameValid) {
									AuthService.instance.user.addSet(_nameController.text, _lang1.isoCode.toUpperCase(), _lang2.isoCode.toUpperCase())
										.then((v) {
										Navigator.of(context).pop();
									})
										.catchError((e) {
										ShowInfo.error(context, '', e);
									});
								}
							}
						)
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
							_lang1 = language;
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
							_lang2 = language;
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
