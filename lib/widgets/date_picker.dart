import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/animation.dart';
import 'package:date_format/date_format.dart';


/*区分年月日选择器*/
enum NUM_TYPE {
  NUM_TYPE_YEAR,
  NUM_TYPE_MONTH,
  NUM_TYPE_DAY,
}

class DatePicker extends StatefulWidget {

  final onSelect;

  DatePicker({Key key, this.onSelect}):super(key: key);

  @override
  _DatePicker createState ()=> new _DatePicker();
}


class _DatePicker extends State<DatePicker>{

  double bottom = 0;
//  double opacity = 0;

//  最小年
  int _minYear = 2019;
//  最大年份
  int _maxYear = 2030;
//  选中年份
  int _selectYear = 2019;

  int _minMonth = 1;
  int _maxMonth = 12;
  int _selectMonth = 1;

  int _minDay = 1;
  int _maxDay = 30;
  int _selectDay = 1;

  /*当前年份*/
  int _currentYear = 0;

  /*当前月份*/
  int _currentMonth = 0;

  /*当前日*/
  int _currentDay = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
//      opacity = 0.3;
      bottom = 80;
    });
    _getCurrentDate(); //获取当前时间
  }


//  Animation<RelativeRect> _animation;
//  AnimationController _controller;
//
//  _animation = EdgeInsetsTween()

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        AnimatedPositioned(bottom: bottom,duration: Duration(seconds: 1),child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Color(0xff1EBDA8)
                ),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Text('取消',style: TextStyle(color: Colors.white,fontSize: 16),),
                      ),
                      onTap: (){
                        onCancel();
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Text('确定',style: TextStyle(color: Colors.white,fontSize: 16),),
                      ),
                      onTap: (){
                        var date = "${_currentYear}-${_currentMonth}-${_currentDay}";
                        widget.onSelect(date);
                        onCancel();
                      },
                    )
                  ],
                ),
              ),
              Row(children: <Widget>[
                NumberPicker.integer(initialValue: _selectYear, minValue: _minYear, maxValue: _maxYear,
                  onChanged: (n){
                    //          _selectYear = n;
                    _numChanged(n, NUM_TYPE.NUM_TYPE_YEAR);
                  },
                  infiniteLoop: false,
                  itemExtent: 50,
                ),
                NumberPicker.integer(initialValue: _selectMonth, minValue: _minMonth, maxValue: _maxMonth,
                  onChanged: (n){
                    //          _selectMonth = n;
                    _numChanged(n, NUM_TYPE.NUM_TYPE_MONTH);
                  },
                ),
                NumberPicker.integer(initialValue: _selectDay, minValue: _minDay, maxValue: _maxDay,
                  onChanged: (n){
                    //          _selectYear = n;
                    _numChanged(n, NUM_TYPE.NUM_TYPE_DAY);
                  },
                ),
              ],mainAxisAlignment: MainAxisAlignment.spaceEvenly,)
            ],
          ),
        ))
      ],
    );
  }

  onCancel(){
    setState(() {
      bottom = 0;
//      opacity = 0;
    });
  }

  onSelect(){
    setState(() {
      bottom = 80;
//      opacity = 0.3;
    });
  }
/*选择器变化时*/
  void _numChanged(int newNum, NUM_TYPE type) {
    setState(() {
      if (type == NUM_TYPE.NUM_TYPE_YEAR) {
        _selectYear = newNum;
        if (_selectYear == _currentYear) {
          //选到了今年
          _minMonth = _currentMonth;
        } else {
          //如果当前选择的不是当前年份
          _maxMonth = 12;
          //根据年点年份月份获取当前月天数
          _maxDay = getDaysNum(_selectYear, _selectMonth);
        }
      } else if (type == NUM_TYPE.NUM_TYPE_MONTH) {
        //选择月份
        _selectMonth = newNum;
        _maxDay = getDaysNum(_selectYear, _selectMonth);
      } else if (type == NUM_TYPE.NUM_TYPE_DAY) {
        //选择日
        _selectDay = newNum;
      }

//      int _babyAge = _currentYear-_selectYear+1;
//      if(_selectMonth>_currentMonth){
//        _babyAge-=1;
//      }else if(_selectMonth==_currentMonth){
//        if(_selectDay>_currentDay){
//          _babyAge-=1;
//        }
//      }

    });
  }

  /*获取当前时间*/
  void _getCurrentDate() {
    _currentYear = int.parse(formatDate(DateTime.now(), [yyyy]));
//    _minYear = _currentYear;
    _currentMonth = int.parse(formatDate(DateTime.now(), [mm]));
    _currentDay = int.parse(formatDate(DateTime.now(), [dd]));


    setState(() {
      _selectYear = _currentYear;
      _selectMonth = _currentMonth;
      _selectDay = _currentDay;

      _minYear = _currentYear;
      _minMonth = _currentMonth;
      _minDay = _currentDay;
    });


    print("当前时间：${_currentYear}-${_currentMonth}-${_currentDay}");
  }

/*根据年份月份获取当前月有多少天*/
  int getDaysNum(int y, int m) {
    if (m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12) {
      return 31;
    } else if (m == 2) {
      if (((y % 4 == 0) && (y % 100 != 0)) || (y % 400 == 0)) {
        //闰年 2月29
        return 29;
      } else {
        //平年 2月28
        return 28;
      }
    } else {
      return 30;
    }
  }

}

