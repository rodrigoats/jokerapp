import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';
import '../model/appState.dart';
import '../blocs/joker_bloc.dart';

class SummaryWidget  extends StatefulWidget{

   @override
  _SummaryWidget createState() => _SummaryWidget();



}

class _SummaryWidget extends State<SummaryWidget> with TickerProviderStateMixin{

  Animation<Offset> animation;
  AnimationController controller;

  final List<String> landing = [
    'images/cinquentamil.png',
    'images/dezmil.png',
    'images/tresmil.png',
    'images/mil.png',
    'images/quinhentos.png',
    'images/duzentos.png',
    'images/zero.png',
  ];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 10000),vsync: this);
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

  void _initAnimation(){
    animation = Tween<Offset>(
      begin: Offset(10,10),
      end: Offset(10,10),
    ).animate(controller);
  }

  void _startAnimation() async{

    animation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 0.9),
    ).animate(controller);

    await controller.forward().orCancel;

  }

  @override
  void didUpdateWidget(SummaryWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _playAnimation() async {
    await _startAnimation;

  }

  @override
  Widget build(BuildContext context) {

    final appState = AppStateProvider.of<AppState>(context);
    JokerBloc bloc = appState.bloc;
    return Container(
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              GestureDetector(
                child: IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: _playAnimation),
              )
            ],

          ), Column(
            children: <Widget>[
                FractionalTranslation(
                translation: Offset(0.0, 0.9),
                  child: Image.asset(
                    landing[bloc.getRightColumn()],
                    width: 200,
                    height: 200,
                  ),
                )
            ],
          )
        ],
      ),
    );

  }
}
