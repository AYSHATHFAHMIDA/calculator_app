import 'package:calculator_app/views/widgets/buttons.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var userQuestion='';
  var userAnswer='';

  final List<String> buttons=[
    'C','DEL','%','/',
    '9','8','7','X',
    '6','5','4','-',
    '3','2','1','+',
    '0','.','ANS','=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                        child: Text(
                          userQuestion,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                        child: Text(
                            userAnswer,
                          style: TextStyle(
                            fontSize: 20
                          ),
                        )
                    ),
                  ],
                ),
              )
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if(index==0){
                      return MyButtons(
                        buttonTapped: (){
                          setState(() {
                            userQuestion='';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textColor: Colors.white,
                      );
                    }
                    else if (index==1){
                      return MyButtons(
                        buttonTapped: (){
                          setState(() {
                            userQuestion=userQuestion.substring(0,userQuestion.length-1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.red,
                        textColor: Colors.white,
                      );
                    }
                    else{
                    return MyButtons(
                    buttonTapped: (){
                      setState(() {
                        userQuestion+=buttons[index];
                      });
                    },
                    buttonText: buttons[index],
                    color: isOperator(buttons[index])?Colors.blueGrey[700]:Colors.blueGrey[100],
                    textColor: isOperator(buttons[index])?Colors.white60:Colors.blueGrey[700],
                    );
                    }

                  },


                ),
              )
            ),
          ],
        ),
      ),
    );
  }
  bool isOperator(String x){
    if(x=='%'||x=='/'||x=='X'||x=='-'||x=='+'||x=='='){
      return true;
    }
    return false;
  }
}
