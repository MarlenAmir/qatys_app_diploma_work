import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatelessWidget {
  final List<String> videoUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         SizedBox(height: 20,),
          Container(
                width: double.infinity,
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: Image.network(
                    'https://i.ytimg.com/vi/xHejVZ7QUcY/maxresdefault.jpg',
                    fit: BoxFit.fill,
                    
                  ),
                ),
              ),
          SizedBox(height: 20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text('О Программе', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
              ),
              SizedBox(height: 10,),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam urna mauris, lobortis sed enim ac, ultrices tincidunt urna. Vivamus convallis nunc tempor lorem egestas efficitur. Integer eget suscipit urna. Donec eget ante sit amet leo vestibulum congue sed id nulla. Duis cursus lacus vitae congue fermentum. Proin accumsan nisi eu tincidunt venenatis. Duis a vehicula arcu, ut luctus turpis. Proin gravida elit neque, vel ultrices libero gravida id. Suspendisse aliquam a ligula et egestas. Vestibulum lobortis nisi non mi rutrum, id dapibus justo pretium. Suspendisse potenti. Praesent vel blandit nibh. Vestibulum sit amet neque quis magna aliquam cursus. Phasellus dolor quam, blandit sit amet pellentesque ac, venenatis vitae lectus. Integer euismod id lacus eu tempus. Suspendisse lobortis eleifend nunc.', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: videoUrls.length,
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                 
                  child: VideoPlayerWidget(videoUrl: videoUrls[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String? videoUrl;

  VideoPlayerWidget({Key? key, this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl!);
    _initializeVideoPlayerFuture = _controller!.initialize();
    _controller!.setLooping(true);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                _controller!.play();
              },
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.pause),
              onPressed: () {
                _controller!.pause();
              },
            ),
          ],
        ),
      ],
    );
  }
}
