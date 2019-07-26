import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;


import '../widget/rollingnumbers.dart';
import '../blocs/joker_bloc.dart';


class HeroClass extends StatelessWidget {

  HeroClass({this.bloc,this.tag,this.onTap,this.value,this.image,this.rolling});

  final String tag;
  final String image;
  final VoidCallback onTap;
  final double value;
  final bool rolling;
  final JokerBloc bloc;


  @override
  Widget build(BuildContext context) {
    timeDilation = 10.0;

    return Center(
      //width: width,
      child: Hero(
          tag: tag,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.contain,image: ExactAssetImage(image),),
                ),
                child: rolling ? RollingNumbers(value: value,) : Container(),
              ),
            ),
          ),
        flightShuttleBuilder: (flightContext, animation, direction,
            fromContext, toContext){
          return Image.asset('images/joker.png');//
          //RollingNumbers(value: 200)
        },
      ),
    );
  }
}

class SummaryPage extends StatelessWidget{

  final int land = 0;
  @override
  Widget build(BuildContext context) {



    String photo = 'images/card.png';
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(),
        ),
        Expanded(
          flex: 6,
          child: Container(),
        ),
        Expanded(
          flex: 2,
          child: Container(
              child:ListView.builder(itemExtent: 45,itemCount: 7,itemBuilder: (context, index){
                return ListTile(
                  title: _getHeroAnimation(photo,index,context,land),);
              })
          ),
        ),
      ],
    );
  }
}

Widget _getHeroAnimation(String photo,int index,BuildContext context, int land){

  var valores = [
    50000.0,
    10000.0,
    3000.0,
    1000.0,
    500.0,
    200.0,
    0.0,];

   var landingPb = [
      'images/cinquentamil-pb.png',
      'images/dezmil-pb.png',
      'images/tresmil-pb.png',
      'images/mil-pb.png',
      'images/quinhentos-pb.png',
      'images/duzentos-pb.png',
      'images/zero-pb.png',
    ];
    var landing = [
      'images/cinquentamil.png',
      'images/dezmil.png',
      'images/tresmil.png',
      'images/mil.png',
      'images/quinhentos.png',
      'images/duzentos.png',
      'images/zero.png',
    ];

    if(index == land){
      return HeroClass(
        tag: 'hero',
        image: landing[index],
        rolling: false,
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context){
            return Scaffold(
                body: Container(
                  color: Colors.black,
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.topLeft,
                  child: HeroClass(
                    tag: 'hero',
                    value: valores[index],
                    rolling: true,
                    image: 'images/card.png',
                    onTap: (){Navigator.of(context).pop();},
                  ),
                )
            );
          }));
        },
      );
    } else {
      return Image.asset(landingPb[index]);//
    }
}

