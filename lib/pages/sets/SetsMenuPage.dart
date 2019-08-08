import 'package:flutter/material.dart';
import 'package:my_word/main_drawer.dart';


class SetsPage extends StatelessWidget {

	@override
  Widget build(BuildContext context) {
    return Scaffold(
	    appBar: AppBar(
		    title: Text('Sets'),
		    centerTitle: true,
	    ),
	    drawer: MainDrawer(),
	    body: Center(
		    child: Text('sets menu'),
	    ),
    );
  }

}