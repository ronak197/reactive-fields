import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(
  MyApp()
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool enabled = false;

  List<dynamic> myFields = [];
  int keyValue = 1;

  void onAdd(){
    setState(() {
      myFields.length %2 == 0 ?
      myFields.add(
          MyTextField(
            key: ValueKey(++keyValue),
            enabled: enabled,
            onDismissed: (d,index){
              print(index);
              myFields.removeAt(index);
              setState(() {
              });
            },
          )
      ) :
      myFields.add(
          MyContentField(
            key: ValueKey(++keyValue),
            enabled: enabled,
            onDismissed: (d,index){
              print(index);
              myFields.removeAt(index);
              setState(() {
              });
            },
          )
      );
    });
  }

  void onSubtract(){
    setState(() {
      myFields.removeLast();
    });
  }

  void onTouchChange(){
    setState(() {
      enabled = !enabled;
      myFields.forEach((element) {
        element.enabled = enabled;
        element.myFieldState.setState((){});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: onAdd,
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: onSubtract,
            child: Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: onTouchChange,
            child: Icon(Icons.touch_app),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text('Reactive Fields'),
      ),
      body: ReorderableListView(
        onReorder: (oldIndex,newIndex){
          setState(() {
            if(oldIndex < newIndex){
              newIndex-=1;
            }
            final dynamic data = myFields.removeAt(oldIndex);
            myFields.insert(newIndex, data);
          });
        },
        children: List.generate(myFields.length, (index){
          myFields[index].listIndex = index;
          return myFields[index];
        }),
      ),
    );
  }
}

class MyTextField extends StatefulWidget {

  Key key;
  Function(DismissDirection,int) onDismissed;
  int listIndex;
  bool enabled;

  MyTextField({this.key,this.onDismissed, this.enabled = true});


  _MyTextFieldState _myTextFieldState = _MyTextFieldState();

  _MyTextFieldState get myFieldState{
    return _myTextFieldState;
  }

  @override
  _MyTextFieldState createState() => _myTextFieldState;
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey('asd'),
      onDismissed: (d){widget.onDismissed(d,widget.listIndex);},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: TextField(
                enabled: widget.enabled,
                decoration: InputDecoration(
                    hintText: 'Title Field'
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Icon(Icons.menu))
          ],
        ),
      ),
    );
  }
}

class MyContentField extends StatefulWidget {

  Key key;
  Function(DismissDirection,int) onDismissed;
  int listIndex;
  bool enabled;

  MyContentField({this.key,this.onDismissed, this.enabled});

  _MyContentFieldState _myContentFieldState = _MyContentFieldState();

  _MyContentFieldState get myFieldState{
    return _myContentFieldState;
  }

  @override
  _MyContentFieldState createState() => _myContentFieldState;
}

class _MyContentFieldState extends State<MyContentField> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey('asmda'),
      onDismissed: (d){widget.onDismissed(d,widget.listIndex);},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: TextField(
                enabled: widget.enabled,
                decoration: InputDecoration(
                    hintText: 'Content Field'
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Icon(Icons.menu))
          ],
        ),
      ),
    );
  }
}
