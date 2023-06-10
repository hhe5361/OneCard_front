
class CardPack{
  List<int> card = [];

    int putCard(int value) {//value 반환
      card.remove(value);
      return value;
    }
    void getCard(int value){
      card.add(value);
    }
    int num(){
      return card.length;
    }

    bool empty(){
      return card.isEmpty;
    }
}

class ComputerCardPack extends CardPack{
  Map<int, List<int>> card_shape = {0: [], 1: [], 2: [], 3: [], 4: []}; //space, clover,diamond,heart, joker 순으로 저장..

  @override
  int putCard(int value) {
    //for 멤버 변수 관리
    int shape = value ~/ 13;
    card_shape[shape]?.remove(value);
    card.remove(value);
    return value;
  }
  @override
  void getCard(int value) {
    //for 멤버 변수 관리
    int shape = value ~/ 13;
    card_shape[shape]?.add(value);
    card.add(value);
  }

  int judge(int lastcard) { //제출할 거 없으면 -1반환, 있으면 value 반환.
    int last_shape = lastcard ~/ 13;
    int last_number = lastcard % 13;

    if (last_number == 0 || last_number == 1) {//공격일 때!
      if (last_number == 0 && last_shape < 4) {//공격 카드 A일때
        for (int card in card) {// A 있?
          if (card % 13 == last_number) {return card;}
        }
      }
      if (last_number == 1 && last_shape < 4) { //공격 카드 2일 때
        for (int card in card_shape[last_shape]!) {//같은 모양의 2 or A 제출
          if (card % 13 == 1 || card % 13 == 0) {return card;}
        }
        for (int card in card) { // 전체에서 2 있?
          if (card % 13 == last_number) {return card;}
        }
      }
      if (card_shape[4]?.length != 0) {return card_shape[4]![0];} //조커있?
      return -1; //없으면 먹어야지~
    }
    else {//not the case of attacked!
      if (card_shape[last_shape]?.length == 0) {//같은 모양 카드 없대요~
        for (int card in card) {//같은 숫자 있는지 check!
          if (card % 13 == last_number) {return card;}
        }
        if (card_shape[4]?.length != 0) {return card_shape[4]![0];} //!은 null check 조커 제출
        else {return -1;}
      }
      else {return card_shape[last_shape]![0];} //같은 모양 카드 제출.
    }
  }
}

class Dealer {
  List<int> dealer_card = [];
  List<int> table_card = [];
  int point_index = 54 ~/ 2;

  Dealer() {
    //기본 생성자
    for (int i = 0; i < 54; i++) {
      dealer_card.add(i);
    }
    dealer_card.shuffle();
    table_card.add(give());
  }

  int lastCard() {
    return table_card.last;
  }

  int give() {
    if (point_index == 0) {
      int lastcard = table_card.last;
      dealer_card.addAll(table_card);
      dealer_card.remove(lastcard);
      table_card = [lastcard];
      dealer_card.shuffle();
      point_index = dealer_card.length - 1;
    }
    int value = dealer_card[0];
    dealer_card.removeAt(0);
    point_index--;
    return value;
  }

  void take(int value) {
    table_card.add(value);
  }
}
