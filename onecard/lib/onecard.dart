import 'package:flutter/material.dart';
import 'Deal_card.dart';

class OneCard {
  //카드팩 생성
  CardPack user = CardPack();
  CardPack user_2 = CardPack();
  ComputerCardPack computer = ComputerCardPack();
  Dealer dealer = Dealer();
  int attack_stack = 1;
  bool isfirst = true;
  bool gameprogram = true;

  OneCard({required gameprogram}) {
    //7장 돌리기.
    for (int i = 0; i < 7; i++) {
      user.getCard(dealer.give());
      if(gameprogram){
        computer.getCard(dealer.give());
      }
      else{
        user_2.getCard(dealer.give());
      }
    }
    int attack_stack = 1;
    bool isfirst = true;
  }

  //show
  int show() {
    //last card 보여줌!
    if (isfirst) {
      do {
        dealer.take(dealer.give()); //맨 앞 카드 그냥 맨 뒤로 보내기.
      } while (dealer.lastCard() % 13 == 0 || dealer.lastCard() % 13 == 1);
      isfirst = false;
    }
    return dealer.lastCard();
  }

  //게임 종료 조건 --> 즉 카드를 얻거나 뺄 때
  int end() {
    if(!gameprogram){
      if (user.empty()) {
        return 0;
      } //승리 조건
      else if (computer.empty()) {
        return 1;
      }
      if (user.num() >= 24) {
        return 2;
      } else if (computer.num() >= 24) {
        return 3;
      } else {
        return -1;
      }
    }
    else{
      if (user.empty()) {
        return 0;
      } //승리 조건
      else if (user_2.empty()) {
        return 1;
      }


      if (user.num() >= 24) {
        return 2;
      } else if (user_2.num() >= 24) {
        return 3;
      } else {
        return -1;
      }
    }
  }

  bool computer_turn() {
    //동작 --> 컴퓨터가 카드 내는 것 까지.
    int value = computer.judge(dealer.lastCard()); //judge에서 value 반환 or -1 반환
    if (value == -1) {
      return false;
    }
    else {
      dealer.take(computer.putCard(value));
      countAttackstack();
      return true;
    }
  }
  //user가 낸 카드가 다음 카드으로 올 카드가 맞는지 체크
  bool user_turn(int usercard,{bool who = false}) {
    int lastcard = dealer.lastCard();

    int last_shape = lastcard ~/ 13;
    int last_number = lastcard % 13;
    int input_shape = usercard ~/ 13;
    int input_number = usercard % 13;

    if(who){
      if (input_shape == 4) {
        dealer.take(user.putCard(usercard));
        countAttackstack();
        return true;
      } //조커는 아무때나 제출가능.

      if (last_number == 0 || last_number == 1) {
        //공격일 때!
        if (last_number == 1 && last_shape < 4) {
          //공격 카드 2일 때 예외 )) A까지 가능
          if (last_shape == input_shape && input_number == 0) {
            dealer.take(user.putCard(usercard));
            countAttackstack();
            return true;
          }
        }
        if (last_number == input_number) {
          dealer.take(user.putCard(usercard));
          countAttackstack();
          return true;
        }
        else{return false;}
      }
      else { //공격 아닐 때
        if (last_shape == input_shape || last_number == input_number) {
          dealer.take(user.putCard(usercard));
          countAttackstack();
          return true;
        }
        return false;
      }
    }

    else{
      if (input_shape == 4) {
        dealer.take(user_2.putCard(usercard));
        countAttackstack();
        return true;
      } //조커는 아무때나 제출가능.

      if (last_number == 0 || last_number == 1) {
        //공격일 때!
        if (last_number == 1 && last_shape < 4) {
          //공격 카드 2일 때 예외 )) A까지 가능
          if (last_shape == input_shape && input_number == 0) {
            dealer.take(user_2.putCard(usercard));
            countAttackstack();
            return true;
          }
        }
        if (last_number == input_number) {
          dealer.take(user_2.putCard(usercard));
          countAttackstack();
          return true;
        }
        else{return false;}
      }
      else { //공격 아닐 때
        if (last_shape == input_shape || last_number == input_number) {
          dealer.take(user_2.putCard(usercard));
          countAttackstack();
          return true;
        }
        return false;
      }
    }

  }


  void dealerGive(int who) {
    switch (who) {
          //유저면 0 컴퓨터면 1
      case 0:
        for (int i = 0; i < attack_stack; i++) {
          user.getCard(dealer.give());
        }
        if(attack_stack > 1){isfirst = true;}
        attack_stack = 1;
        break;
      case 1:
        for (int i = 0; i < attack_stack; i++) {
          computer.getCard(dealer.give());
          if(attack_stack > 1){isfirst = true;}
        }
        attack_stack = 1;
        break;
      case 2:
        for (int i = 0; i < attack_stack; i++) {
          user_2.getCard(dealer.give());
        }
        if(attack_stack > 1){isfirst = true;}
        attack_stack = 1;
        break;
    }
  }
  void countAttackstack(){
    int lastcard = show();

    if(lastcard ~/13 <4 && lastcard % 13 == 0){
      if(attack_stack == 1){
        attack_stack+=2;
        return;
      }
      attack_stack += 3;
    }
    else if(lastcard ~/13 < 4 && lastcard % 13 == 1){
      if(attack_stack == 1){
        attack_stack+=1;
        return;
      }
      attack_stack += 2;
    }
    else if(lastcard ~/ 13 == 4){
      if(attack_stack == 1){
        attack_stack+=4;
        return;
      }
      attack_stack += 5;
    }
  }
}
