import 'package:flutter/material.dart';
import 'package:instrumaster_v1/features/users/Presentation/pages/login.dart';
import 'package:instrumaster_v1/onboarding/pages/content_model.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<StatefulWidget> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentPage = 0;
  late PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Flexible(
              fit: FlexFit.tight,
              child: PageView.builder(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(
                    () {
                      currentPage = index;
                      print(index);
                    },
                  );
                },
                itemBuilder: (_, i) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFFDBE00),
                    ),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(
                              image: AssetImage(contents[i].image),
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              contents[i].title,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              contents[i].description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 40),
            decoration: const BoxDecoration(
              color: Color(0xFFFDBE00),
            ),
            width: 900,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD355),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Saltar',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    contents.length,
                    (index) => buildDot(index: index),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF3C351F),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  height: 70,
                  width: 70,
                  child: MaterialButton(
                    onPressed: () async {
                      currentPage == contents.length - 1
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginPage(),
                              ),
                            )
                          : _controller.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.bounceIn,
                            );
                      print('Hello');
                    },
                    child: const Text(
                      'Sig.',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 8),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: currentPage == index ? const Color(0xFFB98A00) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
