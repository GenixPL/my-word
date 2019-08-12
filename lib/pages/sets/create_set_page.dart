import 'package:flutter/material.dart';
import 'package:language_pickers/language.dart';
import 'package:language_pickers/language_picker_dialog.dart';
import 'package:language_pickers/utils/utils.dart';
import 'package:my_word/services/auth_service.dart';


class CreateSetPage extends StatefulWidget {
	@override
	_CreateSetPageState createState() => _CreateSetPageState();
}


class _CreateSetPageState extends State<CreateSetPage> {
	
	final _setNameController = TextEditingController();
	Language _lang1 = LanguagePickerUtils.getLanguageByIsoCode('en');
	Language _lang2 = LanguagePickerUtils.getLanguageByIsoCode('de');
	
	bool _isNameValid = false;
	
	
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
						flex: 80,
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget>[
								
								Padding(
									padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 32.0),
									child: TextField(
										style: TextStyle(
											fontSize: 16.0,
											fontWeight: FontWeight.w400,
										),
										controller: _setNameController,
										decoration: InputDecoration(
											hintText: 'Set Name',
											errorText: _isNameValid ? null : 'Set name can\'t be empty.',
										),
									)
								),
								
								Row(
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
								)
							
							],
						),
					),
					
					Expanded(
						flex: 10,
						child: Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget>[
								
								Padding(
									padding: const EdgeInsets.all(8.0),
									child: RaisedButton(
										child: Text(
											'Cancel',
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
											child: Text('Create'), //TODO: make this ad cancel more visible
											color: Colors.green,
											onPressed: () {
												setState(() {
													//TODO: remove beginning and ending white spaces
													//TODO: check if it has at least one char
													_setNameController.text.isEmpty ? _isNameValid = false : _isNameValid = true;
												});
												
												if (_isNameValid) {
													print('${_setNameController.text} + ${_lang1.isoCode.toUpperCase()} + ${_lang2.isoCode}');
													AuthService.instance.user.addSet(_setNameController.text, _lang1.isoCode.toUpperCase(), _lang2.isoCode.toUpperCase())
														.then((v) {
														Navigator.of(context).pop();
													})
														.catchError((e) {
														Scaffold.of(context).showSnackBar(
															SnackBar(
																content: Text('There was an error, try again. [${e.toString()}]'), //TODO: remove error info
																behavior: SnackBarBehavior.floating,
															)
														);
													});
												}
											}
										)
									),
								),
							
							],
						),
					),
				
				],
			),
		);
	}
	
	void _openFirstDialog() {
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
	
	void _openSecondDialog() {
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
