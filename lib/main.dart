import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const YeobaekApp());
}

// ============================================================
// 여백 앱
// ============================================================

class YeobaekApp extends StatelessWidget {
  const YeobaekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '여백',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: YeobaekColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: YeobaekColors.primary,
        ),
        fontFamily: 'sans',
      ),
      home: const HomeScreen(),
    );
  }
}

// ============================================================
// 색상
// ============================================================

class YeobaekColors {
  static const background = Color(0xFFF7F5F0);
  static const primary = Color(0xFF8FA99D);
  static const primaryDark = Color(0xFF52665D);
  static const text = Color(0xFF3F4944);
  static const subText = Color(0xFF777D78);
  static const border = Color(0xFFD9D9D2);
  static const white = Color(0xFFFFFFFF);

  // 불멍 색상
  static const fireDark = Color(0xFF7A4632);
  static const fire = Color(0xFFE58B4A);
  static const fireLight = Color(0xFFF5C36B);
}

// ============================================================
// 앱 데이터
// ============================================================

class YeobaekData {
  static int restSecondsToday = 0;
  static int restCountToday = 0;

  static String? todayMessage;

  static bool hasWrittenToday = false;

  static int firewood = 0;

  static final List<String> communityMessages = [
    '오늘은 조금 천천히 걸었다.',
    '집에 오는 길의 바람이 좋았다.',
    '아무것도 하지 않는 시간이 생각보다 좋았다.',
    '오늘 하루도 어찌어찌 지나갔다.',
    '괜찮은 척하지 않아도 되는 하루였으면.',
    '창밖을 한참 바라봤다.',
  ];

  static const List<String> recommendedMessages = [
    '오늘은 조금 느려도 괜찮아요.',
    '잠깐 멈춘다고 뒤처지는 건 아니에요.',
    '쉬는 것도 오늘을 보내는 방법이에요.',
    '아무것도 하지 않아도 충분한 하루예요.',
    '지금 이 순간만큼은 서두르지 않아도 돼요.',
    '오늘 하루도 충분히 잘 지나왔어요.',
  ];
}

// ============================================================
// 홈 화면
// ============================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YeobaekColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 3),

              const Text(
                '여백',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 8,
                  color: YeobaekColors.text,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                '잠시, 아무것도 하지 않아도 괜찮아요.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: YeobaekColors.subText,
                ),
              ),

              const Spacer(),

              const Text(
                '지금 잠시 쉬어갈까요?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: YeobaekColors.text,
                ),
              ),

              const SizedBox(height: 26),

              // 3분 쉬어가기
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RestScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: YeobaekColors.primary,
                    foregroundColor: YeobaekColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    '3분 쉬어가기',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // 오늘의 여백
              SizedBox(
                width: double.infinity,
                height: 58,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TodayScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: YeobaekColors.primaryDark,
                    side: const BorderSide(
                      color: YeobaekColors.border,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    '오늘의 여백',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // 장작 미니게임
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FirewoodGameScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: YeobaekColors.primaryDark,
                    side: const BorderSide(
                      color: YeobaekColors.border,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    '🪵 작은 장작  ${YeobaekData.firewood}개',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // 오늘의 한마디
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CommunityScreen(),
                    ),
                  );
                },
                child: const Text(
                  '오늘의 한마디',
                  style: TextStyle(
                    color: YeobaekColors.subText,
                  ),
                ),
              ),

              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// 휴식 화면
// ============================================================

class RestScreen extends StatefulWidget {
  const RestScreen({super.key});

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  static const int defaultSeconds = 180;

  int remainingSeconds = defaultSeconds;
  int elapsedSeconds = 0;

  Timer? timer;

  final AudioPlayer audioPlayer = AudioPlayer();

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted) return;

        if (remainingSeconds > 0) {
          setState(() {
            remainingSeconds--;
            elapsedSeconds++;
          });
        } else {
          timer?.cancel();
          _finishRest();
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }

  // ==========================================================
  // 숲소리
  // ==========================================================

  Future<void> _toggleForestSound() async {
    try {
      if (isPlaying) {
        await audioPlayer.pause();

        if (!mounted) return;

        setState(() {
          isPlaying = false;
        });
      } else {
        await audioPlayer.setReleaseMode(
          ReleaseMode.loop,
        );

        await audioPlayer.play(
          AssetSource(
            'sounds/soundreality-nature-forest-sound-537925.mp3',
          ),
        );

        if (!mounted) return;

        setState(() {
          isPlaying = true;
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '숲소리를 재생할 수 없어요.\nassets/sounds 폴더와 pubspec.yaml을 확인해주세요.',
          ),
        ),
      );
    }
  }

  // ==========================================================
  // 시간 표시
  // ==========================================================

  String get timeText {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  // ==========================================================
  // 휴식 멈추기
  // ==========================================================

  void _stopRest() {
    timer?.cancel();

    if (elapsedSeconds == 0) {
      Navigator.pop(context);
      return;
    }

    _finishRest();
  }

  // ==========================================================
  // 휴식 완료
  // ==========================================================

  void _finishRest() {
    timer?.cancel();
    audioPlayer.stop();

    YeobaekData.restSecondsToday += elapsedSeconds;
    YeobaekData.restCountToday++;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => RestCompleteScreen(
          elapsedSeconds: elapsedSeconds,
        ),
      ),
    );
  }

  // ==========================================================
  // 시간 연장
  // ==========================================================

  void _extend(int seconds) {
    setState(() {
      remainingSeconds += seconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YeobaekColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            const Text(
              '여백',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 5,
                color: YeobaekColors.subText,
              ),
            ),

            const SizedBox(height: 50),

            Text(
              timeText,
              style: const TextStyle(
                fontSize: 58,
                fontWeight: FontWeight.w300,
                letterSpacing: 2,
                color: YeobaekColors.text,
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              '잠시 쉬어가세요.',
              style: TextStyle(
                fontSize: 18,
                color: YeobaekColors.text,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              '중간에 멈춰도 괜찮아요.\n더 쉬고 싶다면 연장해도 좋아요.',
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.6,
                fontSize: 14,
                color: YeobaekColors.subText,
              ),
            ),

            const Spacer(),

            // 숲소리
            OutlinedButton.icon(
              onPressed: _toggleForestSound,
              icon: Icon(
                isPlaying
                    ? Icons.volume_up
                    : Icons.volume_off,
              ),
              label: Text(
                isPlaying
                    ? '숲소리 끄기'
                    : '숲소리 켜기',
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: YeobaekColors.primaryDark,
                side: const BorderSide(
                  color: YeobaekColors.border,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextButton(
              onPressed: _stopRest,
              child: const Text(
                '잠시 멈추기',
                style: TextStyle(
                  color: YeobaekColors.subText,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 연장 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ExtensionButton(
                  text: '+1분',
                  onPressed: () => _extend(60),
                ),
                const SizedBox(width: 10),
                _ExtensionButton(
                  text: '+3분',
                  onPressed: () => _extend(180),
                ),
                const SizedBox(width: 10),
                _ExtensionButton(
                  text: '+5분',
                  onPressed: () => _extend(300),
                ),
              ],
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 시간 연장 버튼
// ============================================================

class _ExtensionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _ExtensionButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: YeobaekColors.primaryDark,
        side: const BorderSide(
          color: YeobaekColors.border,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Text(text),
    );
  }
}

// ============================================================
// 휴식 완료
// ============================================================

class RestCompleteScreen extends StatelessWidget {
  final int elapsedSeconds;

  const RestCompleteScreen({
    super.key,
    required this.elapsedSeconds,
  });

  String get formattedTime {
    if (elapsedSeconds < 60) {
      return '$elapsedSeconds초';
    }

    final minutes = elapsedSeconds ~/ 60;
    final seconds = elapsedSeconds % 60;

    if (seconds == 0) {
      return '$minutes분';
    }

    return '$minutes분 $seconds초';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YeobaekColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '잘 쉬었어요.',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: YeobaekColors.text,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                '$formattedTime 쉬어갔어요.',
                style: const TextStyle(
                  fontSize: 16,
                  color: YeobaekColors.subText,
                ),
              ),

              const SizedBox(height: 70),

              const Text(
                '오늘의 한마디를 남겨볼까요?',
                style: TextStyle(
                  fontSize: 17,
                  color: YeobaekColors.text,
                ),
              ),

              const SizedBox(height: 28),

              if (!YeobaekData.hasWrittenToday)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const MessageWriteScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: YeobaekColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      '한마디 남기기',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  );
                },
                child: const Text(
                  '이제 충분해요',
                  style: TextStyle(
                    color: YeobaekColors.subText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// 오늘의 여백
// ============================================================

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  String get restTime {
    final minutes =
        YeobaekData.restSecondsToday ~/ 60;
    final seconds =
        YeobaekData.restSecondsToday % 60;

    if (minutes == 0) {
      return '$seconds초';
    }

    if (seconds == 0) {
      return '$minutes분';
    }

    return '$minutes분 $seconds초';
  }

  @override
  Widget build(BuildContext context) {
    final message =
        YeobaekData.todayMessage ??
        YeobaekData.recommendedMessages[
          DateTime.now().day %
              YeobaekData.recommendedMessages.length
        ];

    return Scaffold(
      backgroundColor: YeobaekColors.background,
      appBar: AppBar(
        backgroundColor: YeobaekColors.background,
        elevation: 0,
        title: const Text(
          '오늘의 여백',
          style: TextStyle(
            color: YeobaekColors.text,
            fontSize: 19,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            const SizedBox(height: 30),

            const Text(
              '오늘 잠깐 쉬어간 시간',
              style: TextStyle(
                color: YeobaekColors.subText,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              restTime,
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w300,
                color: YeobaekColors.text,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '${YeobaekData.restCountToday}번 쉬어갔어요.',
              style: const TextStyle(
                color: YeobaekColors.subText,
              ),
            ),

            const SizedBox(height: 60),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEBE4),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const Text(
                    '오늘의 한마디',
                    style: TextStyle(
                      fontSize: 14,
                      color: YeobaekColors.subText,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    '"$message"',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1.6,
                      color: YeobaekColors.text,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                '돌아가기',
                style: TextStyle(
                  color: YeobaekColors.subText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 한마디 작성
// ============================================================

class MessageWriteScreen extends StatefulWidget {
  const MessageWriteScreen({super.key});

  @override
  State<MessageWriteScreen> createState() =>
      _MessageWriteScreenState();
}

class _MessageWriteScreenState
    extends State<MessageWriteScreen> {
  final TextEditingController controller =
      TextEditingController();

  static const int maxLength = 50;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _saveMessage() {
    final text = controller.text.trim();

    if (text.isEmpty) {
      return;
    }

    YeobaekData.todayMessage = text;
    YeobaekData.hasWrittenToday = true;

    YeobaekData.communityMessages.insert(
      0,
      text,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const MessageSavedScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YeobaekColors.background,
      appBar: AppBar(
        backgroundColor: YeobaekColors.background,
        elevation: 0,
        title: const Text(
          '오늘의 한마디',
          style: TextStyle(
            color: YeobaekColors.text,
            fontSize: 19,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            const SizedBox(height: 30),

            const Text(
              '오늘 하루를 한마디로 남겨보세요.',
              style: TextStyle(
                fontSize: 16,
                color: YeobaekColors.subText,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: controller,
              maxLength: maxLength,
              maxLines: 5,
              onChanged: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: '오늘의 마음을 적어보세요.',
                hintStyle: const TextStyle(
                  color: Color(0xFFAAAAA3),
                ),
                filled: true,
                fillColor: const Color(0xFFEDEBE4),
                counterStyle: const TextStyle(
                  color: YeobaekColors.subText,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed:
                    controller.text.trim().isEmpty
                        ? null
                        : _saveMessage,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      YeobaekColors.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor:
                      const Color(0xFFD9D9D2),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  '남기기',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              '하루에 한마디만 남길 수 있어요.',
              style: TextStyle(
                fontSize: 12,
                color: YeobaekColors.subText,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 한마디 저장 완료
// ============================================================

class MessageSavedScreen extends StatelessWidget {
  const MessageSavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YeobaekColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                const Text(
                  '오늘의 한마디를 남겼어요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: YeobaekColors.text,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  '오늘은 이 한마디면 충분해요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: YeobaekColors.subText,
                  ),
                ),

                const SizedBox(height: 60),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(
                        context,
                        (route) => route.isFirst,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          YeobaekColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text('돌아가기'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// 오늘의 한마디 커뮤니티
// ============================================================

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YeobaekColors.background,
      appBar: AppBar(
        backgroundColor: YeobaekColors.background,
        elevation: 0,
        title: const Text(
          '오늘의 한마디',
          style: TextStyle(
            color: YeobaekColors.text,
            fontSize: 19,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 12,
        ),
        children: [
          const Text(
            '하루에 한마디만.',
            style: TextStyle(
              fontSize: 14,
              color: YeobaekColors.subText,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            '읽고 지나가도 괜찮아요.',
            style: TextStyle(
              fontSize: 14,
              color: YeobaekColors.subText,
            ),
          ),

          const SizedBox(height: 30),

          ...YeobaekData.communityMessages.map(
            (message) => _MessageCard(
              message: message,
            ),
          ),

          const SizedBox(height: 30),

          if (!YeobaekData.hasWrittenToday)
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const MessageWriteScreen(),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor:
                    YeobaekColors.primaryDark,
                side: const BorderSide(
                  color: YeobaekColors.border,
                ),
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                '오늘의 한마디 남기기',
              ),
            ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// ============================================================
// 한마디 카드
// ============================================================

class _MessageCard extends StatelessWidget {
  final String message;

  const _MessageCard({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEBE4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '"$message"',
        style: const TextStyle(
          fontSize: 16,
          height: 1.6,
          color: YeobaekColors.text,
        ),
      ),
    );
  }
}

// ============================================================
// 장작 미니게임
// ============================================================

class FirewoodGameScreen extends StatefulWidget {
  const FirewoodGameScreen({super.key});

  @override
  State<FirewoodGameScreen> createState() =>
      _FirewoodGameScreenState();
}

class _FirewoodGameScreenState
    extends State<FirewoodGameScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fireController;

  int get firewood => YeobaekData.firewood;

  // 장작 개수에 따라 불의 단계가 변함
  int get fireLevel {
    if (firewood >= 15) return 3;
    if (firewood >= 5) return 2;
    if (firewood >= 1) return 1;
    return 0;
  }

  @override
  void initState() {
    super.initState();

    _fireController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 900,
      ),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _fireController.dispose();
    super.dispose();
  }

  // ==========================================================
  // 장작 줍기
  // ==========================================================

  void _addFirewood() {
    setState(() {
      YeobaekData.firewood++;
    });
  }

  // ==========================================================
  // 장작 하나 사용
  // ==========================================================

  void _useFirewood() {
    if (YeobaekData.firewood <= 0) {
      return;
    }

    setState(() {
      YeobaekData.firewood--;
    });
  }

  // ==========================================================
  // 불멍 문구
  // ==========================================================

  String get fireMessage {
    switch (fireLevel) {
      case 3:
        return '불이 활활 타오르고 있어요.';
      case 2:
        return '따뜻한 불빛이 조금씩 커지고 있어요.';
      case 1:
        return '작은 불씨가 피어났어요.';
      default:
        return '장작을 모아 작은 불을 피워보세요.';
    }
  }

  // ==========================================================
  // 불 표시
  // ==========================================================

  Widget _buildFire() {
    if (fireLevel == 0) {
      return const Text(
        '🪵',
        style: TextStyle(
          fontSize: 100,
        ),
      );
    }

    double fireSize;

    switch (fireLevel) {
      case 1:
        fireSize = 90;
        break;
      case 2:
        fireSize = 120;
        break;
      default:
        fireSize = 150;
    }

    return AnimatedBuilder(
      animation: _fireController,
      builder: (context, child) {
        final movement =
            (_fireController.value - 0.5) * 6;

        return Transform.translate(
          offset: Offset(0, movement),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '🔥',
                style: TextStyle(
                  fontSize: fireSize,
                ),
              ),

              if (fireLevel >= 2)
                const Text(
                  '🔥',
                  style: TextStyle(
                    fontSize: 34,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YeobaekColors.background,
      appBar: AppBar(
        backgroundColor:
            YeobaekColors.background,
        elevation: 0,
        title: const Text(
          '작은 장작',
          style: TextStyle(
            color: YeobaekColors.text,
            fontSize: 19,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 28,
          ),
          child: Column(
            children: [
              const Spacer(),

              // =================================================
              // 불멍 공간
              // =================================================

              AnimatedContainer(
                duration:
                    const Duration(milliseconds: 500),
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: fireLevel == 0
                      ? const Color(0xFFEDEBE4)
                      : const Color(0xFFE9E0D2),
                  borderRadius:
                      BorderRadius.circular(30),
                ),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // 바닥 장작
                      Positioned(
                        bottom: 35,
                        child: Text(
                          fireLevel == 0
                              ? '🪵 🪵'
                              : '🪵🪵🪵',
                          style:
                              const TextStyle(
                            fontSize: 32,
                          ),
                        ),
                      ),

                      // 불
                      Padding(
                        padding:
                            const EdgeInsets.only(
                          bottom: 30,
                        ),
                        child: _buildFire(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Text(
                '장작 $firewood개',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: YeobaekColors.text,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                fireMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: YeobaekColors.subText,
                ),
              ),

              const SizedBox(height: 30),

              // 장작 줍기
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _addFirewood,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        YeobaekColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),
                  child: const Text(
                    '🪵 장작 줍기',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // 장작 태우기
              if (firewood > 0)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: _useFirewood,
                    style:
                        OutlinedButton.styleFrom(
                      foregroundColor:
                          YeobaekColors
                              .primaryDark,
                      side:
                          const BorderSide(
                        color:
                            YeobaekColors.border,
                      ),
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          18,
                        ),
                      ),
                    ),
                    child: const Text(
                      '🔥 장작 하나 태우기',
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              const Text(
                '장작을 모을수록 불멍이 따뜻해져요.',
                style: TextStyle(
                  fontSize: 12,
                  color: YeobaekColors.subText,
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}