import 'package:animationsequence/widgets/animationwidget.dart';
import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  String _message = "I am animating";

  @override
  Widget build(BuildContext context) {
    List<Image> frames = [
      const Image(image: AssetImage('assets/img/flames/confetti_1.png')),
      const Image(image: AssetImage('assets/img/flames/confetti_2.png')),
      const Image(image: AssetImage('assets/img/flames/confetti_3.png')),
      const Image(image: AssetImage('assets/img/flames/confetti_4.png')),
      const Image(image: AssetImage('assets/img/flames/confetti_5.png')),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Sequnce Animation'),),
      body: Column(
        children: [
          AnimationSequence(
            images: frames, 
            frameDuration: 200,
            startOnLoad: true,
            loop: false,
            underImage: const Image(image: AssetImage('assets/img/flames/thought_gone.png')),
            onCompleteAction: () {
              setState(() {
                _message = 'I have finished animating';
              });
            },
          ),
          Text(_message),
        ],
      ),
    );
  }
}