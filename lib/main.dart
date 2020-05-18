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

  bool enabled = true;

  List<dynamic> myFields = [];

  void onAdd(){
    setState(() {
      myFields.length %2 == 0 ?
      myFields.add(MyTextField(enabled: enabled,)) : myFields.add(MyContentField(enabled: enabled,));
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
        element.myFieldState.setState(() {
          element.enabled = enabled;
        });
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
      body: ListView.builder(
        itemCount: myFields.length,
        itemBuilder: (_,index){
          return myFields[index];
        },
      ),
    );
  }
}

class MyTextField extends StatefulWidget {

  bool enabled;

  MyTextField({this.enabled = true});

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        enabled: widget.enabled,
        decoration: InputDecoration(
          hintText: 'Input Field'
        ),
      ),
    );
  }
}

class MyContentField extends StatefulWidget {

  bool enabled;

  MyContentField({this.enabled = true});

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        enabled: widget.enabled,
        decoration: InputDecoration(
            hintText: 'Content Field'
        ),
      ),
    );
  }
}
