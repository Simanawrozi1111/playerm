import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicApp(),
    );
  }
}

class MusicApp extends StatefulWidget {
  const MusicApp({Key? key}) : super(key: key);

  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  AudioPlayer? audioPlayer;
  AudioCache? cache;
  Duration possition = Duration.zero;
  Duration musicLenght = Duration.zero;

  Widget slider() {
    return Container(
      width: 300,
      child: Slider.adaptive(
          activeColor: Colors.purple.shade800,
          inactiveColor: Colors.grey.shade300,
          value: possition.inSeconds.toDouble(),
          max: musicLenght.inSeconds.toDouble(),
          onChanged: ((value) {
            seekToSec(value.toInt());
          })),
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    audioPlayer?.seek(newPos);
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    cache = AudioCache(prefix: 'mySong.mp3');

    audioPlayer!.onDurationChanged
        .listen((d) => setState(() => musicLenght = d));
    audioPlayer!.onPositionChanged.listen((p) => setState(() => possition = p));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.purple.shade800,
                Colors.purple.shade100,
              ]),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 40,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    'I 💜 Music',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    ' Listen to your favorite Song',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: AssetImage('asset/1.jpg'),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'kalbimin tek sahibine',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 500,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${possition.inMinutes}:${possition.inSeconds.remainder(60)}',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              slider(),
                              Text(
                                '${musicLenght.inMinutes}:${musicLenght.inSeconds.remainder(60)}',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 45,
                              color: Colors.purple,
                              onPressed: () {},
                              icon: Icon(
                                Icons.skip_previous,
                              ),
                            ),
                            IconButton(
                              iconSize: 62,
                              color: Colors.purple,
                              onPressed: () {
                                if (!playing ) {
                                  // cache?.load('z8.mp3');
                                  audioPlayer?.play(AssetSource('mySong.mp3'));
                                  setState(() {
                                    playBtn = Icons.pause;
                                    playing = true;
                                  });
                                } else {
                                  audioPlayer?.pause();
                                  setState(() {
                                    playBtn = Icons.play_arrow;
                                    playing = true;
                                  });
                                }
                              },
                              icon: Icon(
                                playBtn,
                              ),
                            ),
                            IconButton(
                              iconSize: 45,
                              color: Colors.purple,
                              onPressed: () {},
                              icon: Icon(
                                Icons.skip_next,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
