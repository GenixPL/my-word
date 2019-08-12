import 'package:flutter/material.dart';
import 'package:my_word/main_drawer.dart';
import 'package:my_word/pages/sets/create_set_page.dart';


class SetsPage extends StatelessWidget {
	
	@override
  Widget build(BuildContext context) {
    return Scaffold(
	    appBar: AppBar(
		    title: Text('Sets'),
		    centerTitle: true,
	    ),
	    drawer: MainDrawer(),
	    resizeToAvoidBottomInset: false,
	    body: Center(
		    child: Column(
			    children: <Widget>[

			    	Expanded(
					    flex: 90,
					    child: Container(color: Colors.amberAccent,),

				    ),

				    Expanded( //TODO: child -> row with information how to handle actions
					    flex: 10,
					    child: FloatingActionButton(
						    backgroundColor: Colors.redAccent,
						    child: Text(
							    '+',
							    style: TextStyle(
								    fontSize: 32.0,
								    fontWeight: FontWeight.w400,
								    color: Colors.white,
							    ),
						    ),
						    onPressed: () async {
						    	Navigator.of(context).pushNamed('/sets/create');
						    }
					    ),

				    ),

			    ],
		    ),
	    ),
    );
  }

}