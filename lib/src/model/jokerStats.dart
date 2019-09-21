

class JokerStats{


  JokerStats({this.rightColumn,this.leftColumn});

  int rightColumn;
  int leftColumn;
  final prize = [50000,10000,3000,1000,500,200,0];
  int losts = 3;
  void addCorrect(){
    rightColumn--;
    _verify();
  }

  void addWrong(){
    print('rightColumn: $rightColumn');
    if(leftColumn <= losts) {
      leftColumn += losts;
    } else {
      if(leftColumn<=6)
        leftColumn++;

      rightColumn += 2;
    }
    print('rightColumn: $rightColumn');
    _verify();
  }

  int getPrize(){
    print('$prize');
    print('$rightColumn');
    return prize[rightColumn];
  }

  void _verify(){
     if(rightColumn>6){
      rightColumn=6;
    } else if(rightColumn<0){
      rightColumn=0;
    }
  }

  void reset() {
    rightColumn = 6;
    leftColumn = 0;
  }
}





