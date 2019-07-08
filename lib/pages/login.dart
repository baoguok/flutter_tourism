import 'package:flutter/material.dart';
//import 'package:flutter_app/widgets/input.dart';
import 'package:flutter_app/network/request.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/model/models.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {

  @override
  _Login createState()=> new _Login();
}

class _Login extends State<Login> {
  String username='';
  var password = '';
  bool isPassword = true;

  FocusNode nameFocus = FocusNode();
  FocusNode pwdFocus = FocusNode();


    @override
  Widget build(BuildContext context) {
    final namecontroller = new TextEditingController.fromValue(TextEditingValue(
        text: this.username,
        selection: TextSelection.fromPosition(TextPosition(
            offset: username.length,
            affinity: TextAffinity.downstream
        ))
    ));
    final pwdcontroller = new TextEditingController.fromValue(TextEditingValue(
        text: password,
        selection: TextSelection.fromPosition(TextPosition(
            offset: password.length
        ))
    ));

//    namecontroller.addListener((){
//      setState(() {
//        username = namecontroller.text;
//      });
//    });
    // TODO: implement build
    return ScopedModelDescendant<Models>(
      builder: (context,child,model){
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
              FocusScope.of(context).requestFocus(FocusNode());
//              pwdFocus.unfocus();
              Navigator.pop(context);
            }),
            title: Center(child: Text('登录'),),
            backgroundColor: Color(0xff1EBDA8),
            actions: <Widget>[
              Center(child: GestureDetector(
                child: Text('注册',style: TextStyle(fontSize: 16),),
                onTap: (){
                  Navigator.pushNamed(context, 'register');
                },
              ),),
              SizedBox(width: 15,)
            ],
          ),
          body: Scrollbar(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  TextField(
                    focusNode: nameFocus,
                    controller: namecontroller,
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                    maxLength: 11,
                    autocorrect: true,
//                    autofocus: true,
                    decoration: InputDecoration(
//                    contentPadding: EdgeInsets.all(10),
//                    icon: ,               //图标
                        filled: true,
                        hintText: '请输入手机号码',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none
                        ),
                        suffixIcon: username.isNotEmpty ?
                        Container(
                          width: 20,height: 20,child: IconButton(
                            icon: Icon(Icons.cancel,color: Colors.amberAccent,),
                            iconSize: 18,
                            alignment: Alignment.center,
                            onPressed: (){
                              namecontroller.clear();
                              setState(() {
                                username = '';
                              });
                            }
                        ),)
                            : Text('')
                    ),
                    onChanged: (val){
                      setState(() {
                        username = val;
                      });
                    },
                    onEditingComplete: (){
                      nameFocus.unfocus();
                    },
                  ),
                  TextField(
                    focusNode: pwdFocus,
                    controller: pwdcontroller,
//                  keyboardType: TextInputType.datetime,
                    maxLines: 1,
                    maxLength: 20,
                    autocorrect: true,
//                  autofocus: true,
                    obscureText: isPassword,
                    decoration: InputDecoration(
//                    contentPadding: EdgeInsets.all(10),
//                    icon: ,               //图标
                        filled: true,
                        hintText: '请输入密码',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none
                        ),
                        suffixIcon: password.isNotEmpty?
                        Container(
                          child: Ispassword(),
                        ): Text('')
                    ),
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: RaisedButton(
                      child: Text('登录',style: TextStyle(color: Colors.white, fontSize: 16),),
                      color: Color(0xff1EBDA8),
                      onPressed: () async{
                        FocusScope.of(context).requestFocus(new FocusNode());
//                      this.login();
                        final formData = {"password": this.password,"mobile": this.username};
                        var res = await HttpGo().post('/api/user/login.json',formData);
                        if(res.data['success']){
                          model.getUserInfo(res.data['data']);
                          Future.delayed(Duration(milliseconds: 100),(){
                            Navigator.pop(context, 'personal');
                          });
                        }
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
//                  padding: EdgeInsets.only(right: 15),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){

                      },
                      child: Text('忘记密码？',style: TextStyle(color: Colors.red),),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  
  login() async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    final formData = {"password": this.password,"mobile": this.username};
    var res = await HttpGo().post('/api/user/login.json',formData);
    if(res.data['success']){
      perfs.setString('userInfo', res.data['data'].toString());
      Navigator.pop(context, 'personal');
    }
  }

  Ispassword(){
    if(isPassword){
      return IconButton(icon: Icon(Icons.remove_red_eye),
          iconSize: 18,
          color: Colors.amberAccent,
          onPressed: (){
            setState(() {
              isPassword = !isPassword;
            });
          });
    }else{
      return GestureDetector(
        child: Image.asset('images/icon-test-2@3x.png',width: 5,fit: BoxFit.fitWidth,
          color: Colors.amberAccent),
        onTap: (){
          setState(() {
            isPassword = !isPassword;
          });
        },
      );
    }
  }

}