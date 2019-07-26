import 'package:flutter/material.dart';
import '../blocs/joker_bloc.dart';

class ColumnLeftWidget  extends StatefulWidget {

  const ColumnLeftWidget({Key key, this.bloc}) : super(key: key);

  final JokerBloc bloc;

   @override
   _ColumnLeftWidget createState() => _ColumnLeftWidget();
}

class _ColumnLeftWidget extends State<ColumnLeftWidget> with TickerProviderStateMixin {


  Animation<Offset> animation;
  Animation<Offset> animation1;
  Animation<Offset> animation2;

  AnimationController controller;
  AnimationController controller1;
  AnimationController controller2;

  var offset = Offset(0,-1);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 5000),vsync: this,);
    controller1 = AnimationController(duration: Duration(milliseconds: 5000),vsync: this,);
    controller2 = AnimationController(duration: Duration(milliseconds: 5000),vsync: this,);
    _initAnimation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initAnimation();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _initAnimation() async {
    animation = _getOffsetAnimation(controller);
    animation1 = _getOffsetAnimation(controller1);
    animation2 = _getOffsetAnimation(controller2);
  }

  Animation<Offset> _getOffsetAnimation(AnimationController cont){

    return  Tween<Offset>(
        begin: Offset(0, -1),
        end:  Offset(0, 0)
    ).animate(cont);
  }


  void _startAnimation() {
    if(widget.bloc.getLeftColumn() < 3) {
      return;
    } else if(widget.bloc.getLeftColumn()<6){
     _addColumnAnimation(animation,controller);
     controller.forward();
    } else if(widget.bloc.getLeftColumn()<7){
     _addColumnAnimation(animation1,controller1);
     controller1.forward();
    } else {
     _addColumnAnimation(animation2,controller2);
     controller2.forward();
    }
  }

  void _addColumnAnimation(Animation<Offset> animation, AnimationController control){
    animation = Tween<Offset>(
        begin: Offset(0, -1),
        end:  Offset(0, 0)
    ).animate(control)
      ..addListener((){
        setState(() {
          offset = animation.value;
        });
      })..addStatusListener((status){
        if(status == AnimationStatus.completed)
          controller.stop();
      });

  }

  @override
  void didUpdateWidget(ColumnLeftWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _playAnimation()  {
    _startAnimation();
  }

  var _alignment = Alignment.topCenter;
  var top = FractionalOffset.topCenter;
  var bottom = FractionalOffset.bottomCenter;

  @override
  Widget build(BuildContext context) {

    if(widget.bloc.startLeftColumnAnimation){
      _playAnimation();
    }

    return ListView.builder(
          itemCount: 7,
          itemExtent: 45,
          itemBuilder: (context, index) {
            return ListTile(
              title: _titleListTile(context,index, null)
            );
          }
      );
  }

  Widget _titleListTile(BuildContext context, int index, JokerBloc bloc){

    if(widget.bloc.getLeftColumn() < 3) {
      return _getNormalTile(index, true);
    } else if(widget.bloc.getLeftColumn() < 6) {
      if(index < widget.bloc.getLeftColumn()) {
        if(widget.bloc.startLeftColumnAnimation){
          return _getAnimatedTile(index,animation);
        }
        return _getNormalTile(index, false);
      } else {
        return _getNormalTile(index, true);
      }
    } else if(widget.bloc.getLeftColumn() < 7) {
      if(index < 3){
        return _getNormalTile(index, false);
      } else if(widget.bloc.startLeftColumnAnimation && index < 6){
        return _getAnimatedTile(index,animation1);
      } else {
        if(!widget.bloc.startLeftColumnAnimation && index < 6){
          return _getNormalTile(index, false);
        }
        return _getNormalTile(index, true);
      }
    } else {
      if(index < 6){
        return _getNormalTile(index, false);
      } else if(widget.bloc.startLeftColumnAnimation){
        return _getAnimatedTile(index, animation2);
      } else {
        return _getNormalTile(index, false);
      }
    }
  }


  Widget _getNormalTile(int index, bool joker) {
    return Container(
        width: 50,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0),),
          image: DecorationImage(image: ExactAssetImage(joker ? 'images/joker.png': 'images/joker-pb.png'),fit: BoxFit.contain,),
        ),
        alignment: _alignment,
    );
  }

  Widget _getAnimatedTile(int index, Animation<Offset> animez) {
    return Container(
        width: 50,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0),),
          image: DecorationImage(image: ExactAssetImage('images/joker.png'),fit: BoxFit.contain,),
        ),
        alignment: _alignment,
        child:  FractionalTranslation(
          translation: animez.value,
          child: Opacity(
            opacity: 1.0,
            child: Image.asset('images/joker-pb.png'),
          ),
        )
    );
  }


}
