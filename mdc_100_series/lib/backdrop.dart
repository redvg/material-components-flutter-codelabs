import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'model/product.dart';

const double _kFlingVelocity = 0.5;

class _FrontLayer extends StatelessWidget{

  final Widget child;

  const _FrontLayer({
    Key key,
    this.child
  }) :super(key: key);

  @override
  Widget build(BuildContext context){

    return Material(

      elevation: 16.0,

      shape: BeveledRectangleBorder(

        borderRadius: BorderRadius.only(

          topLeft: Radius.circular(46.0),
        )
      ),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[

          Expanded(

            child: child,
          ),
        ],
      ),
    );
  }
}

class Backdrop extends StatefulWidget{

  final Category category;

  final Widget frontLayer;

  final Widget backLayer;

  final Widget frontTitle;

  final Widget backTitle;

  const Backdrop({
    @required this.category, 
    @required this.frontLayer, 
    @required this.backLayer,
    @required this.frontTitle,
    @required this.backTitle}): 
    assert (category != null),
    assert (frontLayer != null),
    assert (backLayer != null),
    assert (frontTitle != null),
    assert (backTitle != null);

  @override
  _BackdropState createState() => _BackdropState();
                                
}

class _BackdropState extends State<Backdrop> with SingleTickerProviderStateMixin {

  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  AnimationController _animationController;

  bool get _frontLayerVisible{

    final AnimationStatus status = _animationController.status;

    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility(){

    _animationController.fling(

      velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity,
    );
  }

  @override
  void initState(){

    super.initState();

    _animationController = AnimationController(

      duration: Duration(
        
        microseconds: 600),

      value: 1.0,

      vsync: this,
    );
  }

  @override
  void dispose(){

    _animationController.dispose();

    super.dispose();
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    
    const double layerTitleHeight = 48.0;
    
    final Size layerSize = constraints.biggest;
    
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      
      begin: RelativeRect.fromLTRB(
          
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_animationController.view);

    return Stack(

      key: _backdropKey,
      
      children: <Widget>[
        
        widget.backLayer,
        
        PositionedTransition(
          
          rect: layerAnimation,
          
          child: _FrontLayer(
            
            child: widget.frontLayer,
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(){

    return AppBar(

      brightness: Brightness.light,
      
      elevation: 0.0,

      leading: IconButton(

        icon: Icon(Icons.menu),

        onPressed: _toggleBackdropLayerVisibility,
      ),

      title: Text('Shrine'),

      actions: <Widget>[

        IconButton(
          
          icon: Icon(Icons.search,),

          onPressed: (){},),

        IconButton(

          icon: Icon(Icons.tune),

          onPressed: (){},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar: _buildAppBar(),

      body: LayoutBuilder(
        
        builder: _buildStack,)
    );
  }
}