import 'package:flutter/material.dart';


class Inputs extends StatefulWidget{

  final String title;
  final maxlength;
  final callback;


  Inputs({this.title, this.maxlength, this.callback});

  @override
  _Input createState()=> new _Input();
}

class _Input extends State<Inputs>{
//  final String title;
//  final maxlength;
//  final callback;
//
//  Inputs({this.title, this.maxlength, this.callback});

  var value;

  @override
  Widget build(BuildContext context) {
    final controller = new TextEditingController();
    controller.addListener((){
      this.value = controller.text;
    });
    // TODO: implement build
    return Stack(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          maxLines: 1,
          maxLength: widget.maxlength,
          autocorrect: true,
          autofocus: true,
          decoration: InputDecoration(
//                    contentPadding: EdgeInsets.all(10),
//                    icon: ,               //图标
              filled: true,
              hintText: widget.title,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none
              )
          ),
          onSubmitted: submitValue(),
        ),

      ],
    );
  }
//
  submitValue(){
//    widget.callback(value);
  }
}