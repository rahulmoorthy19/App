import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewModel extends StatefulWidget{
  DatabaseReference _db;
  String _email;
  NewModel(DatabaseReference db, String email){
    this._db = db;
    this._email = email;
  }
  @override
  State<StatefulWidget> createState() {
    return _NewModelState();
  }
}
class _NewModelState extends State<NewModel>{
  DatabaseReference modelRef;
  final formKey = GlobalKey<FormState>();
  String ModelName;
  String ModelKey;
  FocusNode _focusNode = new FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

      modelRef = widget._db.child(widget._email).push();
      ModelKey = modelRef.key;
      return Scaffold(
        resizeToAvoidBottomPadding: true,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("New Model"),
          centerTitle: true,
          elevation: 0,

        ),
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.save, color: Theme.of(context).primaryColor,),
            backgroundColor: Colors.white,
            label: Text("Save", style: TextStyle(color: Theme.of(context).primaryColor),),
            onPressed: save,
        ),
        body: Container(
          margin: EdgeInsets.all(20),
            child:
            Form(

              key: formKey,
              child: Column(
                  children: <Widget>[

                    Container(
                      margin: EdgeInsets.only(top: 25, bottom: 100),
                      child:
                      Hero(
                        child: Icon(Icons.book, size: 100, color: Colors.white,),
                        tag: "newModel",
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top:10, bottom: 10),
                      child:TextFormField(
                        enabled: false,
                        validator: (input) {
                          if (input.isEmpty) {
                            return "Unique ID is empty!";
                          }
                        },
                        initialValue: ModelKey,
                        style: TextStyle(
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(10))),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(10))),
                            disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(10))),
                            labelText: "Unique ID",
                            errorStyle: TextStyle(color: Colors.yellow),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: "Raleway")),
                        onSaved: (input) => ModelKey = input,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:10, bottom: 10),
                      child:TextFormField(
                        validator: (input) {
                          if (input.isEmpty) {
                            return "Model Name is empty!";
                          }
                        },
                        style: TextStyle(
                            color: Colors.white
                        ),
                        focusNode: _focusNode,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(10))),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(10))),
                            disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.all(Radius.circular(10))),
                            labelText: "Model Name",
                            errorStyle: TextStyle(color: Colors.yellow),
                            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow), borderRadius: BorderRadius.all(Radius.circular(10))),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: "Raleway")),
                        onSaved: (input) => ModelName = input,
                      ),
                    ),

                  ]
              ),
            ),
        ),
      );
    }
  void save(){
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      modelRef.set({
        'ModelName': ModelName,
      });
      Navigator.pop(context);

    }
  }
  _showDialog(title, text, okButton) {
    showDialog(
      context: context,
      builder: (context) {
        List<Widget> actions = null;
        Widget content = null;
        if (okButton == true) {
          actions = <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ];
          content = Text(
            text,
            textAlign: TextAlign.center,
          );
        } else {
          actions = <Widget>[];
          content = Container(
            height: 100,
            child: SpinKitDoubleBounce(color: Theme.of(context).primaryColor),
          );
        }
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: content,
          actions: actions,
        );
      },
      barrierDismissible: okButton,
    );
  }
}