import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcPage extends StatefulWidget {
  @override
  _CalcPageState createState() => _CalcPageState();
}



class _CalcPageState extends State<CalcPage>{
  String userInput = "0";
  String answer = "0";
  String expression = "";
  final List<String> buttons = [
    'C', '+/-', 'Del', '/',
    '7', '8', '9', 'x',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '00', '0', '.', '=',
  ];

  buttonPressed(String buttonText) {
    setState(() {
      if(buttonText == "C") {
        userInput = "0";
        answer = "0";
      }
      else if (buttonText == "+/-") {
        if (userInput != "0") {
          if (userInput.startsWith("-")) {
            userInput = userInput.substring(1,userInput.length);
          } else {
            userInput = "-" + userInput;
          }
        }
      }
      else if(buttonText == "Del") {
        userInput = userInput.substring(0, userInput.length-1);
        if (userInput == "") {
          userInput = "0";
        }
      }
      else if (buttonText == "=") {
        expression = userInput;
        expression = expression.replaceAll('/','/');
        expression = expression.replaceAll('x','*');

        try{
          Parser p = Parser();
          Expression ex = p.parse(expression);

          ContextModel c = ContextModel();
          answer = '${ex.evaluate(EvaluationType.REAL, c)}';

        } catch(e) {
          answer = "Error";
        }
      }

      else {
        if(userInput == "0") {
          userInput = buttonText;
        } else {
          userInput = userInput + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(userInput, style: TextStyle(fontSize: 60.0,color: Colors.white),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(answer, style: TextStyle(fontSize: 90.0,color: Colors.white),),
          ),
          Expanded(
            child: Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton(buttons.elementAt(0),Colors.orange),
                        buildButton(buttons.elementAt(1),Colors.lightBlue),
                        buildButton(buttons.elementAt(2),Colors.lightBlue),
                        buildButton(buttons.elementAt(3),Colors.lightBlue),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton(buttons.elementAt(4),Colors.grey),
                          buildButton(buttons.elementAt(5),Colors.grey),
                          buildButton(buttons.elementAt(6),Colors.grey),
                          buildButton(buttons.elementAt(7),Colors.lightBlue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(buttons.elementAt(8),Colors.grey),
                          buildButton(buttons.elementAt(9),Colors.grey),
                          buildButton(buttons.elementAt(10),Colors.grey),
                          buildButton(buttons.elementAt(11),Colors.lightBlue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(buttons.elementAt(12),Colors.grey),
                          buildButton(buttons.elementAt(13),Colors.grey),
                          buildButton(buttons.elementAt(14),Colors.grey),
                          buildButton(buttons.elementAt(15),Colors.lightBlue),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(buttons.elementAt(16),Colors.grey),
                          buildButton(buttons.elementAt(17),Colors.grey),
                          buildButton(buttons.elementAt(18),Colors.lightBlue),
                          buildButton(buttons.elementAt(19),Colors.greenAccent),
                        ]
                    ),
                  ]
                ),
              ),
            ],
          )
        ],
      )
    );
  }
  Widget buildButton(String buttonText, Color buttonColor) {
    return Container(
      height: 60.0,
      width: 80.0,
      child: ElevatedButton(
        onPressed: () => buttonPressed(buttonText),
        style: ElevatedButton.styleFrom(
          primary: buttonColor
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.normal,
            color: Colors.white
          ),
        ),
      ),
    );
  }


}

