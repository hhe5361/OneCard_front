import 'package:flutter/material.dart';
import 'OneCard.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GamePage2 extends StatefulWidget{

  @override
  State<GamePage2> createState() => _GamePage2State();
}

class _GamePage2State extends State<GamePage2>{
  bool turn = true; //turn 구분
  OneCard game = OneCard(gameprogram: false);

  Future<bool> nextTurn() {//딜레이 줄 부분
    return Future.delayed(const Duration(milliseconds: 2000), () {

      return Future(() => true);
    });
  }

  String who(){
    if(turn) return "player 1";
    else return "player 2";
  }

  bool EndMsg(BuildContext ctx){
    int score = game.end();
    String msg = "";
    if(score == -1) return false;

    if(score == 0 || score == 3){
      msg = "Player1 win!";
    }
    else if(score == 1 || score == 2){
      msg = "Player2 win${score}";
    }

    showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("${msg}"),
          content:SingleChildScrollView(
              child: Container(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  child: Text("Ok"),
                  onPressed: (){
                    Navigator.pushNamed(context, '/HomePage');
                  },
                ),
              )
          ),
        );
      },
    );
    return true;
  }
  void toast_center(String msg) {
    Fluttertoast.showToast(
        msg: '${msg}',
        gravity: ToastGravity.CENTER,
        fontSize: 25.0,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT);
  }

  void toast_bottom(String msg) {
    Fluttertoast.showToast(
        msg: '${msg}',
        gravity: ToastGravity.BOTTOM,
        fontSize: 15.0,
        backgroundColor: Colors.white,
        textColor: Colors.redAccent,
        toastLength: Toast.LENGTH_SHORT);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Play Onecard!",style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Container(
                color: Colors.white,
                child: Text("+${game.user.num()} : player 1",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black)),
              ),
              Expanded(
                child: ListView(
                    scrollDirection: Axis.horizontal,

                    children: <Widget>[
                      for(int card in game.user_2.card)
                        TextButton(
                            child: Image(image: AssetImage("trumpcard/${card}.jpg"),height: 150,width: 100,),
                            onPressed: () {
                              setState(() {
                                if(!turn) {toast_bottom("player1의 차례가 아닙니다! 기다려주세요.");}
                                else{
                                  if(game.user_turn(card,who: turn)){
                                    toast_center("player 1이 제출에 성공하였습니다!");
                                    EndMsg(context);
                                    turn = !turn;
                                  }
                                  else {
                                    toast_center("player 1이 제출에 실패하였습니다!");
                                  }
                                }
                              });
                            }
                        ),
                    ]
                ),
              ),
              Divider(color: Colors.black,thickness: 1,height: 20,),
              Container(
                color: Colors.green,
                child: Row(
                  children: <Widget>[
                    Container(margin: EdgeInsets.all(10),padding: EdgeInsets.all(15),child: Image (image: AssetImage("trumpcard/${game.show()}.jpg"),height: 180,width: 100)),//이미지
                    Column(
                      children: <Widget>[
                        Text("<${who()} turn!>",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                        SizedBox(height: 10,),
                        Text("attack stack : +${game.attack_stack}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                        SizedBox(height: 10,),
                        ElevatedButton(//user만 누를 수 있음!
                          child: Text("Get card!",style: TextStyle(fontSize: 20)),
                          onPressed: (){
                            setState(() {
                              if(turn){//true는 user2 차례라고 보죠?
                                game.dealerGive(2);
                              }
                              else {
                                game.dealerGive(0);
                              }
                              EndMsg(context);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.black,thickness: 1,height: 20,),
              Container(
                color: Colors.white,
                child: Text("+${game.user.num()} :player 2",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black)),
              ),
              Expanded(
                child: ListView(
                    scrollDirection: Axis.horizontal,

                    children: <Widget>[
                      for(int card in game.user.card)
                        TextButton(
                            child: Image(image: AssetImage("trumpcard/${card}.jpg"),height: 150,width: 100,),
                            onPressed: () {
                              setState(() {
                                if(turn) {toast_bottom("player2의 차례가 아닙니다! 기다려주세요.");}
                                else{
                                  if(game.user_turn(card,who: turn)){
                                    toast_center("player2가 제출에 성공하였습니다!");
                                    EndMsg(context);
                                    turn = !turn;
                                  }
                                  else {
                                    toast_center("player2가 제출에 실패하였습니다!");
                                  }
                                }
                              });
                            }
                        ),
                    ]
                ),
              ),
            ],
          ),
        )
    );
  }
}

