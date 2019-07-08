import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/network/request.dart';


class Register extends StatefulWidget{

  @override

  _Register createState()=> new _Register();
}

class _Register extends State<Register>{
  var phone = '',password = '',validCode='';
  bool isClick = true;   //是否可点击发送验证码
  String _verifyStr = '请输入验证码';              //倒计时时间
  Timer _timer = null;        //定时器
  var vCode;

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _phoneController = TextEditingController.fromValue(TextEditingValue(
        text: phone,
        selection: TextSelection.fromPosition(TextPosition(
          offset: phone.length,

        ))
    ));
    final _passwordController = TextEditingController.fromValue(TextEditingValue(
        text: password,
        selection: TextSelection.fromPosition(TextPosition(
          offset: password.length,

        ))
    ));
    final _validCodeController = TextEditingController.fromValue(TextEditingValue(
        text: validCode,
        selection: TextSelection.fromPosition(TextPosition(
          offset: validCode.length,

        ))
    ));

    sendValidCode() async{
      int time = 10;
      if(isClick){
        setState(() {
          _verifyStr = '已发送${time}s';
          isClick = false;
        });
        _timer = Timer.periodic(Duration(seconds: 1), (timer){
          if(time==0){
            _timer ?.cancel();
            setState(() {
              isClick = true;
              _verifyStr = '请输入验证码';
            });
          }else {
            setState(() {
              time--;
              _verifyStr = '已发送${time}s';
            });
          }
        });
        var obj = await HttpGo().get('/api/sms/register.json',{'mobile': _phoneController.text});
        if(obj.data['success']){
          Fluttertoast.showToast(msg: '发送成功！');
        }
      }
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          FocusScope.of(context).requestFocus(new FocusNode());
          Future.delayed(Duration(milliseconds: 100),(){
            Navigator.pop(context);
          });
        }),
        title: Center(child: Text('注册'),),
        backgroundColor: Color(0xff1EBDA8),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              SizedBox(height: 15,),
              TextField(
                maxLines: 1,maxLength: 11,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                autocorrect: true,
                decoration: InputDecoration(
//                    contentPadding: EdgeInsets.all(10),
//                    icon: ,               //图标
                    filled: true,
                    hintText: '请输入手机号码',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none
                    ),
                    suffixIcon: phone.isNotEmpty ?
                    Container(
                      width: 20,height: 20,child: IconButton(
                        icon: Icon(Icons.cancel,color: Colors.amberAccent,),
                        iconSize: 18,
                        alignment: Alignment.center,
                        onPressed: (){
                          _phoneController.clear();
                          setState(() {
                            phone = '';
                          });
                        }
                    ),)
                        : Text('')
                ),
                onChanged: (val){
                  setState(() {
                    phone = val;
                  });
                },
              ),
              SizedBox(height: 10,),
              TextField(
                maxLines: 1,maxLength: 6,
                controller: _validCodeController,
                keyboardType: TextInputType.phone,
                autocorrect: true,
                decoration: InputDecoration(
//                    contentPadding: EdgeInsets.all(10),
//                    icon: ,               //图标
                    filled: true,
                    hintText: '请输入验证码',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none
                    ),
                    suffixIcon: validCode.isNotEmpty ?
                    Container(
                      width: 20,height: 20,child: IconButton(
                        icon: Icon(Icons.cancel,color: Colors.amberAccent,),
                        iconSize: 18,
                        alignment: Alignment.center,
                        onPressed: (){
                          _validCodeController.clear();
                          setState(() {
                            validCode = '';
                          });
                        }
                    ),) 
                    : GestureDetector(
                      child: SizedBox(
                        width: 100,
                        height: 60,
                        child: Center(child: Text(_verifyStr,style: TextStyle(color: Colors.amberAccent),),),
                      ),
                      onTap: (){
                        sendValidCode();
                      },
                    )
                ),
                onChanged: (val){
                  setState(() {
                    validCode = val;
                  });
                },
              ),
              SizedBox(height: 10,),
              TextField(
                maxLines: 1,maxLength: 15,
                controller: _passwordController,
                keyboardType: TextInputType.phone,
                autocorrect: true,
                decoration: InputDecoration(
//                    contentPadding: EdgeInsets.all(10),
//                    icon: ,               //图标
                    filled: true,
                    hintText: '请输入6~15位数字及字母组成的密码',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none
                    ),
                    suffixIcon: password.isNotEmpty ?
                    Container(
                      width: 20,height: 20,child: IconButton(
                        icon: Icon(Icons.cancel,color: Colors.amberAccent,),
                        iconSize: 18,
                        alignment: Alignment.center,
                        onPressed: (){
                          _passwordController.clear();
                          setState(() {
                            password = '';
                          });
                        }
                    ),)
                        : Text('')
                ),
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: RaisedButton(
                  child: Text('注册',style: TextStyle(color: Colors.white, fontSize: 16),),
                  color: Color(0xff1EBDA8),
                  onPressed: () async{
                    FocusScope.of(context).requestFocus(new FocusNode());
                    final formData = {"password": password,"mobile": phone,"smsCode": vCode};
                    var res = await HttpGo().post('/api/user/register.json',formData);
                    if(res.data['success']){
                      Fluttertoast.showToast(msg: 'register success!');
                      Future.delayed(Duration(milliseconds: 100),(){
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}