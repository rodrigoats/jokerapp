import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import '../blocs/joker_bloc.dart';
import '../widget/rollingnumbers.dart';

class ColumnRightWidget extends StatefulWidget {

  ColumnRightWidget({this.bloc});

  final JokerBloc bloc;


  _ColumnRightWidget createState() => _ColumnRightWidget();
}

class _ColumnRightWidget extends State<ColumnRightWidget> with TickerProviderStateMixin {

  int land = 0;
  String photo = 'images/card.png';

 @override
  Widget build(BuildContext context) {

   final valores = [
     100000.0,
     50000.0,
     10000.0,
     3000.0,
     1000.0,
     500.0,
     200.0
   ];

   WidgetsBinding.instance.addPostFrameCallback((_){

     if(widget.bloc.answersAnimation.value.startPlaying) {
       widget.bloc.dilation = 10.0;
       widget.bloc.answersAnimation.value.startPlayingHero = false;
       Navigator.of(context).push(MaterialPageRoute<void>(
           builder: (BuildContext context){
             return Scaffold(
                 body: Container(
                   color: Colors.black,
                   padding: EdgeInsets.all(16.0),
                   alignment: Alignment.topLeft,
                   child: HeroClass(
                     tag: 'hero',
                     value: valores[widget.bloc.getRightColumn()],
                     rolling: true,
                     bloc: widget.bloc,
                     image: 'images/card.png',
                     ),
                 )
             );
           })
       );
     }
   });

   return ListView.builder(itemExtent: 45,itemCount: 7,itemBuilder: (context, index){
     return ListTile(
       title: _getHeroAnimation(photo,index,context,widget.bloc),);
   });

  }
}

class HeroClass extends StatelessWidget {

  HeroClass({this.bloc,this.tag,this.value,this.image,this.rolling});

  final String tag;
  final String image;
  final double value;
  final bool rolling;
  final JokerBloc bloc;


  @override
  Widget build(BuildContext context) {

    timeDilation = bloc.dilation;
    WidgetsBinding.instance.addPostFrameCallback((_){
      if(bloc.answersAnimation.value.startPlaying){
        bloc.answersAnimation.value.startPlaying = false;
      } else if(bloc.answersAnimation.value.startPlayingHero){

      }
    });

    return Center(
      //width: width,
      child: Hero(
        tag: tag,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.contain,image: ExactAssetImage(image),),
              ),
              child: rolling ? RollingNumbers(value: value,bloc: bloc,) : Container(),
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

Widget _getHeroAnimation(String photo,int index,BuildContext context, JokerBloc bloc){



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

  if(index == bloc.getRightColumn()){
    return HeroClass(
      tag: 'hero',
      image: landing[index],
      rolling: false,
      bloc: bloc,
    );
  } else {
    return Image.asset(landingPb[index]);//
  }
}

