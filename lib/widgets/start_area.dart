import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'start_button_animated.dart';
import '../utils/global_audio_player.dart';
import '../utils/round_provider.dart';

class StartArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    audioPlayer.playSoundLetsGo();
    final round = Provider.of<RoundProvider>(context, listen: false);

    return Center(
      child: AnimatedStartButton(95, 55, Colors.white, round.startGame),
    );
  }
}
