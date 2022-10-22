import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/test/test1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColordark,
        title: const Text("Videos"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Material(
                child: TabBar(
                  indicatorColor: Colors.green,
                  tabs: const [
                    Tab(
                      text: "TRENDING",
                    ),
                    Tab(
                      text: "TECHNOLOGY",
                    ),
                    Tab(
                      text: "FEATURED",
                    ),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicator: RectangularIndicator(
                    color: kPrimaryColordark,
                    bottomLeftRadius: 100,
                    bottomRightRadius: 100,
                    topLeftRadius: 100,
                    topRightRadius: 100,
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  Container(
                      child: ListView(
                    children: const [
                      VideoYplayer(
                        titel:
                            'Traditional Paddy Cultivation Sri Lanka | Preparing Padi Fields For Rice Making',
                        link: 'u2W4DmcIFec',
                      ),
                      VideoYplayer(
                        titel:
                            'Paddy cultivation in Sri Lanka How to harvest and store Paddy yield correctly in Yala season',
                        link: 'A_nk6iz0Gqk',
                      ),
                      VideoYplayer(
                        titel:
                            'උඩරට මිනිස්සු තවමත් සාම්ප්‍රදායික ඇයි| Traditional Agriculture Methods in Sri Lanka',
                        link: 'hpJJAneEMGk',
                      ),
                      VideoYplayer(
                        titel:
                            'Paddy cultivation in Sri Lanka How to harvest and store Paddy yield correctly in Yala season',
                        link: 'A_nk6iz0Gqk',
                      ),
                    ],
                  )),
                  Container(
                      child: ListView(
                    children: const [
                      VideoYplayer(
                        titel:
                            'Traditional Paddy Cultivation Sri Lanka | Preparing Padi Fields For Rice Making',
                        link: 'u2W4DmcIFec',
                      ),
                      VideoYplayer(
                        titel:
                            'Paddy cultivation in Sri Lanka How to harvest and store Paddy yield correctly in Yala season',
                        link: 'A_nk6iz0Gqk',
                      ),
                      VideoYplayer(
                        titel:
                            'උඩරට මිනිස්සු තවමත් සාම්ප්‍රදායික ඇයි| Traditional Agriculture Methods in Sri Lanka',
                        link: 'hpJJAneEMGk',
                      ),
                      VideoYplayer(
                        titel:
                            'Paddy cultivation in Sri Lanka How to harvest and store Paddy yield correctly in Yala season',
                        link: 'A_nk6iz0Gqk',
                      ),
                    ],
                  )),
                  Container(
                      child: ListView(
                    children: const [
                      VideoYplayer(
                        titel:
                            'Traditional Paddy Cultivation Sri Lanka | Preparing Padi Fields For Rice Making',
                        link: 'u2W4DmcIFec',
                      ),
                      VideoYplayer(
                        titel:
                            'Paddy cultivation in Sri Lanka How to harvest and store Paddy yield correctly in Yala season',
                        link: 'A_nk6iz0Gqk',
                      ),
                      VideoYplayer(
                        titel:
                            'උඩරට මිනිස්සු තවමත් සාම්ප්‍රදායික ඇයි| Traditional Agriculture Methods in Sri Lanka',
                        link: 'hpJJAneEMGk',
                      ),
                      VideoYplayer(
                        titel:
                            'Paddy cultivation in Sri Lanka How to harvest and store Paddy yield correctly in Yala season',
                        link: 'A_nk6iz0Gqk',
                      ),
                    ],
                  )),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class VideoYplayer extends StatefulWidget {
  final String link;
  final String titel;
  const VideoYplayer({
    Key? key,
    required this.link,
    required this.titel,
  }) : super(key: key);

  @override
  State<VideoYplayer> createState() => _VideoYplayerState();
}

class _VideoYplayerState extends State<VideoYplayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.link,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        //mute: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 15, bottom: 2),
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.green,
                  handleColor: Colors.greenAccent,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 8, top: 3, bottom: 15),
              child: Text(
                widget.titel,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
