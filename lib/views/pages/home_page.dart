import 'package:calculator_app/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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
    '9','8','7','x',
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
                    // SizedBox(
                    //   height: 50,
                    // ),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white60,
                      ),
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
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:Colors.white60,
                      ),
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
                            userAnswer='';
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
                            if(userQuestion.length==0){
                              userAnswer='';
                            }
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.red,
                        textColor: Colors.white,
                      );
                    }
                    else if(index==buttons.length-1){
                      return MyButtons(
                        buttonTapped: (){
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blueGrey[700],
                        textColor: Colors.white60,
                      );
                    }else if(index==buttons.length-2){
                      return MyButtons(
                        buttonTapped: (){
                          setState(() {
                            // equalPressed();
                            userQuestion=userAnswer;
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blueGrey[100],
                        textColor: Colors.blueGrey[700],
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
    if(x=='%'||x=='/'||x=='x'||x=='-'||x=='+'||x=='='){
      return true;
    }
    return false;
  }


  void equalPressed(){
    String finalQuestion=userQuestion;
    finalQuestion=finalQuestion.replaceAll(RegExp('x'), '*');

    Parser p=Parser();
    Expression exp=p.parse(finalQuestion);
    ContextModel cm=ContextModel();
    double eval=exp.evaluate(EvaluationType.REAL, cm);

    userAnswer=eval.toString();

  }
}
