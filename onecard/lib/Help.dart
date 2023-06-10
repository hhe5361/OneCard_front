import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Game Rule",style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
      ),
      body: Container(
        margin: EdgeInsets.all(50),
        color: Colors.grey,
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text("1. 시작할 때 플레이어들은 카드를 각각 7장씩 부여받습니다.",style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 25),
            Text("2. 플레이어와 컴퓨터의 승리 조건은 자신의 카드를 모두 없애는 것입니다!",style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 25),
            Text("3. 단, 카드가 24장을 넘기게 되는 순간 바로 탈락하게 됩니다.",style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 25),
            Text("4. 일반적으로 카드의 제출조건은 같은 모양일 것, 또는 같은 숫자일 것입니다.",style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 25),
            Text("5. 카드 중에는 공격카드가 존재합니다. 공격카드는 2, A, joker로 왼쪽부터 가장 약한 공격순입니다.",style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 25),
            Text("6. 2의 경우 2장의 카드를, A의 경우 3장, joker의 경우 5장의 카드가 attack stack에 반영됩니다. 공격은 오직 공격으로만 받을 수 있습니다",style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
