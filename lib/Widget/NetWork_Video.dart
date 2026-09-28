import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class NetworkVideoWidget extends StatefulWidget {
  final String videoUrl;
  const NetworkVideoWidget({super.key, required this.videoUrl});

  @override
  State<NetworkVideoWidget> createState() => _NetworkVideoWidgetState();
}

class _NetworkVideoWidgetState extends State<NetworkVideoWidget> {
  late final VideoPlayerController videoShow;
  bool _ready = false;
  bool _error = false;
  bool _muted = false;

  @override
  void initState() {
    super.initState();
    videoShow = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    videoShow.setLooping(true);
    videoShow.initialize().then((_) {
      if (!mounted) return;
      setState(() => _ready = true);
      videoShow.play();
    }).catchError((_) {
      if (mounted) setState(() => _error = true);
    });
  }

  @override
  void dispose() {
    videoShow.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (videoShow.value.isPlaying) {
      videoShow.pause();
    } else {
      videoShow.play();
    }
  }

  void _toggleMute() {
    setState(() => _muted = !_muted);
    videoShow.setVolume(_muted ? 0 : 1);
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return d.inHours > 0 ? '${d.inHours}:$m:$s' : '$m:$s';
  }

  Widget _placeholder(double w, double h, Widget child) {
    return Container(
      width: w,
      height: h,
      color: Colors.black,
      alignment: Alignment.center,
      child: child,
    );
  }

  Widget _controls() {
    return Container(
      color: const Color(0xFF111111),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ValueListenableBuilder<VideoPlayerValue>(
        valueListenable: videoShow,
        builder: (_, v, __) {
          return Row(
            children: [
              IconButton(
                onPressed: _togglePlay,
                icon: Icon(
                  v.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              Text(_fmt(v.position),
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(width: 8),
              Expanded(
                child: VideoProgressIndicator(
                  videoShow,
                  allowScrubbing: true,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  colors: const VideoProgressColors(
                    playedColor: Colors.redAccent,
                    bufferedColor: Colors.white30,
                    backgroundColor: Colors.white12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(_fmt(v.duration),
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
              IconButton(
                onPressed: _toggleMute,
                icon: Icon(
                  _muted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final w = media.size.width;
    final maxH = media.size.height * 0.5;
    const minH = 220.0;

    if (_error) {
      return _placeholder(
          w, minH, const Icon(Icons.error_outline, color: Colors.white54, size: 40));
    }

    if (!_ready) {
      return _placeholder(
          w, minH, const CircularProgressIndicator(color: Colors.white));
    }

    final size = videoShow.value.size;
    final ratio =
    (size.width == 0 || size.height == 0) ? 16 / 9 : size.width / size.height;
    final height = (w / ratio).clamp(minH, maxH).toDouble();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _togglePlay,
          child: ClipRect(
            child: Container(
              width: w,
              height: height,
              color: Colors.black,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      width: size.width,
                      height: size.height,
                      child: VideoPlayer(videoShow),
                    ),
                  ),
                  ValueListenableBuilder<VideoPlayerValue>(
                    valueListenable: videoShow,
                    builder: (_, v, __) => IgnorePointer(
                      child: AnimatedOpacity(
                        opacity: v.isPlaying ? 0 : 1,
                        duration: const Duration(milliseconds: 200),
                        child: const Icon(Icons.play_circle_fill,
                            color: Colors.white70, size: 56),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _controls(),
      ],
    );
  }
}