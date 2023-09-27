import 'package:flutter/material.dart';

class AnimationSequence extends StatefulWidget {
  final List<Image> images;
  final int frameDuration;
  final bool startOnLoad;
  final Image? underImage;
  final int repetitions;
  final bool loop;
  final Function? onCompleteAction;
  
  const AnimationSequence({
    super.key,
    required this.images,
    required this.frameDuration,
    required this.startOnLoad,
    this.underImage,
    this.repetitions = 1,
    this.loop =true,
    this.onCompleteAction,
  });

  @override
  State<AnimationSequence> createState() => _AnimationSequenceState();
}

class _AnimationSequenceState extends State<AnimationSequence> with TickerProviderStateMixin{
  int _currentImage = 0;
  bool stop = false;
  bool completed = false;
  int _repetitionCount = 0;
  late AnimationController _sequenceAnimController; 


  @override
  void initState() {
    super.initState();

    _sequenceAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.frameDuration),
    ) ;

    _sequenceAnimController.addListener(() {
      print("Current Image ${_currentImage}");
      if(_repetitionCount < widget.repetitions || widget.loop) {
        if(_sequenceAnimController.isCompleted) {
          
          _sequenceAnimController.reset();
          _sequenceAnimController.forward();
          setState(() {
            if(_currentImage < (widget.images.length -1)) {
              _currentImage++;
            } else {
              //Reset
              _currentImage = 0;
              if(widget.loop) {
                _repetitionCount++;
              } else {
                if(_repetitionCount < widget.repetitions) {
                  _repetitionCount++;
                }
              }
            }
          });
        }
      } else {
        //The animation is finished
        setState(() {
          completed = true;
          if(widget.onCompleteAction != null) {
            widget.onCompleteAction!();
          }
        });
      }  
    }) ;
  }

  @override
  void dispose() {
    super.dispose();
    _sequenceAnimController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.startOnLoad) {
      //print('Forward $_currentImage');
      _sequenceAnimController.forward();
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        widget.underImage != null
        ? SizedBox(
          width: double.infinity,
          child: widget.underImage!
        )
        : const SizedBox() ,
        Visibility(
          visible: !completed || widget.underImage == null,
          child: AnimatedBuilder(
            animation: _sequenceAnimController,
            builder: (contex,child) {
              return widget.images[_currentImage];
            },
          ),
        )
      ]

    );
  }
}