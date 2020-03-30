import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:the_link_up/AppUI/LoginPage.dart';
import 'package:the_link_up/Constant/APP_Gradient.dart';
import 'package:the_link_up/Constant/OnBosrdPageList.dart';
import 'package:the_link_up/Constant/RestrudentAppConstatant.dart';

class OnboadPageContener extends StatefulWidget {
  @override
  _OnboadPageContenerState createState() => _OnboadPageContenerState();
}

class _OnboadPageContenerState extends State<OnboadPageContener> {
  var _controller = new PageController();
  bool isVisible = false;
  int currentIndexPage = 0;

  void nextPage() {
    _controller.nextPage(
        duration: Duration(milliseconds: 10), curve: Curves.easeInOut);
  }

  void setCurrentPage(int index) {
    setState(() {
      currentIndexPage = index;
      print(currentIndexPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).copyWith().backgroundColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            // Box decoration takes a gradient
            gradient: backgroundLinearGradient,
          ),
          padding: EdgeInsets.only(left: 0.0, right: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ///skip Button
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: !isVisible,
                  child: FlatButton(
                    onPressed: () {
                      _controller.jumpToPage(2);
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0.0, top: 10.0),
                        child: Text(
                          'Skip',
                          style: KskipButton,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              /// pager view
              Expanded(
                flex: 6,
                child: Container(
                    child: PageView(
                  controller: _controller,
                  children: OnBoardingpageList,
                  onPageChanged: (index) {
                    setCurrentPage(index);

                    if (index == 2) {
                      setState(() {
                        isVisible = true;
                      });
                    } else {
                      setState(() {
                        isVisible = false;
                      });
                    }
                  },
                )),
              ),
              /// Get Started Button
              Expanded(
                flex: 0,
                child: Visibility(
                  visible: isVisible,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    backgroundColor: Colors.red,
                    label: Padding(
                      padding: EdgeInsets.only(
                          top: 50.0, bottom: 50.0, left: 50.0, right: 50.0),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins Medium',
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              /// Dots Indicator
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20.0,
                          ),
                          child: DotsIndicator(
                            dotsCount: OnBoardingpageList.length,
                            position: currentIndexPage.toDouble(),
                            decorator: DotsDecorator(
                              color: Colors.grey,
                              activeColor: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      ///### Next button
      floatingActionButton: Visibility(
        visible: !isVisible,
        child: Container(
          height: 100.0,
          width: 100.0,
          child: FloatingActionButton(
            onPressed: nextPage,
            disabledElevation: 0.0,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            //Theme.of(context).copyWith().backgroundColor,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Next',
                style: KskipButton.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
