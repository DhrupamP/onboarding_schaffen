import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'name_page.dart';

int index = 0;

const items = [
  Color(0xffF7E830),
  Color(0xff037CD5),
  Color(0xffF7E830),
  Color(0xff037CD5),
];

const txtcolor = [Colors.black, Colors.white, Colors.black, Colors.white];

const images = [
  "assets/cash.png"
      "assets/delivery.png"
      "assets/customer.png"
];
const headings = ["Cash On Delivery", "Fast Delivery", "Good Customer Service"];

const content = [
  "We provide cash on delivery option on everything thing you order.",
  "Fastest delivery across the country guaranteed.",
  "24/7 customer service. Contact us anytime from anywhere."
];

class FlowPager extends StatefulWidget {
  const FlowPager({Key? key}) : super(key: key);

  @override
  _FlowPagerState createState() => _FlowPagerState();
}

class _FlowPagerState extends State<FlowPager>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<double> _notifier = ValueNotifier(0.0);
  final _button = GlobalKey();
  final _pageController = PageController();
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat(reverse: true);
  late final Animation<Offset> _animation = Tween(
          begin: Offset.zero, end: const Offset(0, 0.08))
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void initState() {
    _pageController.addListener(() {
      _notifier.value = _pageController.page as double;
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _notifier.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String imagePicker(int idx) {
      if (idx == 0) {
        return "assets/cash.png";
      } else if (idx == 1) {
        return "assets/delivery.png";
      } else if (idx == 2) {
        return "assets/customer.png";
      } else {
        return "assets/cash.png";
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          // Custom Painter
          AnimatedBuilder(
            animation: _notifier,
            builder: (_, __) => CustomPaint(
              painter: FlowPainter(
                context: context,
                notifier: _notifier,
                target: _button,
                colors: items,
              ),
            ),
          ),

          // PageView
          PageView.builder(
            controller: _pageController,
            itemCount: items.length - 1,
            itemBuilder: (c, i) => Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: SlideTransition(
                        position: _animation,
                        child: Image(
                          image: AssetImage(imagePicker(i)),
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        headings[i],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.actor(
                            fontSize: 40,
                            color: txtcolor[i],
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      content[i],
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: GoogleFonts.dmSans(
                        fontSize: 25,
                        color: txtcolor[i],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          // Anchor Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: GestureDetector(
                onTap: () {
                  if (index == 2) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => NamePage()),
                        (route) => false);
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     PageRouteBuilder(transitionsBuilder:
                    //         (context, animation, secondaryAnimation, child) {
                    //       final tween =
                    //           Tween(begin: Offset(0, 1.0), end: Offset.zero);
                    //       final offsetAnimation = animation.drive(tween);
                    //       return SlideTransition(
                    //         position: _animation,
                    //         child: NamePage(),
                    //       );
                    //     }, pageBuilder: (BuildContext context,
                    //         Animation<double> animation,
                    //         Animation<double> secondaryAnimation) {
                    //       return NamePage();
                    //     }),
                    //     (route) => false);
                  }
                  setState(() {
                    print("next page");
                    print(index);
                    _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.decelerate);
                    index++;
                  });
                },
                child: ClipOval(
                  child: AnimatedBuilder(
                    animation: _notifier,
                    builder: (_, __) {
                      final animatorVal =
                          _notifier.value - _notifier.value.floor();
                      double opacity = 0, iconPos = 0;
                      int colorIndex;
                      if (animatorVal < 0.5) {
                        opacity = (animatorVal - 0.5) * -2;
                        iconPos = 80 * -animatorVal;
                        colorIndex = _notifier.value.floor() + 1;
                      } else {
                        colorIndex = _notifier.value.floor() + 2;
                        iconPos = -80;
                      }
                      if (animatorVal > 0.9) {
                        iconPos = -250 * (1 - animatorVal) * 10;
                        opacity = (animatorVal - 0.9) * 10;
                      }
                      colorIndex = colorIndex % items.length;
                      return SizedBox(
                        key: _button,
                        width: 80,
                        height: 80,
                        child: Transform.translate(
                          offset: Offset(iconPos, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: items[colorIndex],
                            ),
                            child: Icon(
                              Icons.chevron_right,
                              color: Colors.white.withOpacity(opacity),
                              size: 30,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FlowPainter extends CustomPainter {
  final BuildContext context;
  final ValueNotifier<double> notifier;
  final GlobalKey target;
  final List<Color> colors;

  RenderBox? _renderBox;

  FlowPainter(
      {required this.context,
      required this.notifier,
      required this.target,
      required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final screen = MediaQuery.of(context).size;
    if (_renderBox == null) {
      _renderBox = target.currentContext?.findRenderObject() as RenderBox;
    }
    if (_renderBox == null) return;
    final page = notifier.value.floor();
    final animatorVal = notifier.value - page;
    final targetPos = _renderBox!.localToGlobal(Offset.zero);
    final xScale = screen.height * 8, yScale = xScale / 2;
    var curvedVal = Curves.easeInOut.transformInternal(animatorVal);
    final reverseVal = 1 - curvedVal;

    Paint buttonPaint = Paint(), bgPaint = Paint();
    Rect buttonRect, bgRect = Rect.fromLTWH(0, 0, screen.width, screen.height);

    if (animatorVal < 0.5) {
      bgPaint..color = colors[page % colors.length];
      buttonPaint..color = colors[(page + 1) % colors.length];
      buttonRect = Rect.fromLTRB(
        targetPos.dx - (xScale * curvedVal), //left
        targetPos.dy - (yScale * curvedVal), //top
        targetPos.dx + _renderBox!.size.width * reverseVal, //right
        targetPos.dy + _renderBox!.size.height + (yScale * curvedVal), //bottom
      );
    } else {
      bgPaint..color = colors[(page + 1) % colors.length];
      buttonPaint..color = colors[page % colors.length];
      buttonRect = Rect.fromLTRB(
        targetPos.dx + _renderBox!.size.width * reverseVal, //left
        targetPos.dy - yScale * reverseVal, //top
        targetPos.dx + _renderBox!.size.width + xScale * reverseVal, //right
        targetPos.dy + _renderBox!.size.height + yScale * reverseVal, //bottom
      );
    }

    canvas.drawRect(bgRect, bgPaint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(buttonRect, Radius.circular(screen.height)),
      buttonPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
