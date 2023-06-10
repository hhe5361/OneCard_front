import 'package:flutter/material.dart';
import 'OneCard.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GamePage extends StatefulWidget{

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>{
  int turn = 0; //turn 구분
  OneCard game = OneCard(gameprogram: true);

  Future<bool> computer() {//flutter 내 컴퓨터 동작
    setState(() {
      turn = 1;
    });
    return Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        if (game.computer_turn()) {
          toast_center("컴퓨터가 카드를 냈습니다!");
        }
        else {
          toast_center("컴퓨터가 카드를 먹습니다!");
          game.dealerGive(1);
        }
        turn = 0;
      });
      return Future(() => true);
    });
  }

  bool EndMsg(BuildContext ctx){
    int score = game.end();
    String msg = "";
    if(score == -1) return false;
    if(score == 0 || score == 3){
      msg = "you win!";
    }
    else if(score == 1 || score == 2){
      msg = "you lose! (ㅋㅋ 반성하세요 컴퓨터한테 진 거)";
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
    print("required,${game.user.card}");
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(
                    image: AssetImage("trumpcard/back.jpg"),
                    height: 150,
                    width: 100,
                  ),
                  SizedBox(width: 20,),
                  Text("+${game.computer.num()}",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold))
                ],
              ),
              Divider(color: Colors.black,thickness: 1,height: 20,),
              Container(
                color: Colors.green,
                child: Row(
                  children: <Widget>[
                    Container(margin: EdgeInsets.all(10),padding: EdgeInsets.all(15),child: Image (image: AssetImage("trumpcard/${game.show()}.jpg"),height: 180,width: 100)),//이미지
                    Column(
                      children: <Widget>[
                        Text("attack stack : +${game.attack_stack}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                        SizedBox(height: 10,),
                        ElevatedButton(//user만 누를 수 있음!
                          child: Text("Get card!",style: TextStyle(fontSize: 20)),
                          onPressed: (){
                            setState(() {
                              if(turn == 1) {toast_bottom("당신의 턴이 아닙니다! 기다려주세요.");}
                              else{
                                game.dealerGive(0);//user 카드 먹고
                                if(!EndMsg(context)){
                                  computer();
                                  EndMsg(context);
                                }
                              }
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
                child: Text("+${game.user.num()}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black)),
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
                                if(turn == 1) {toast_bottom("당신의 턴이 아닙니다! 기다려주세요.");}
                                else{
                                  if(game.user_turn(card)){
                                    toast_center("제출에 성공하였습니다!");
                                    if(!EndMsg(context)){
                                      computer();
                                      EndMsg(context);
                                    }
                                  }
                                  else {
                                    toast_center("제출에 실패하였습니다!");
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

