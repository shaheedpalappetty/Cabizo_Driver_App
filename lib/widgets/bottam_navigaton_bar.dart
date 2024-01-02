// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:taxi_app/view/home_screen.dart';
import 'package:taxi_app/view/person_screen.dart';

class BottamNavBar extends StatefulWidget {
  const BottamNavBar({
    Key? key,
  }) : super(key: key);

  @override
  _BottamNavBarState createState() => _BottamNavBarState();
}

class _BottamNavBarState extends State<BottamNavBar>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 2, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BottomBar(
          // fit: StackFit.loose,
          icon: (width, height) => Center(
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: null,
              icon: Icon(
                Icons.arrow_upward_rounded,
                color: const Color.fromARGB(255, 255, 231, 18),
                size: width,
              ),
            ),
          ),
          borderRadius: BorderRadius.circular(10),
          duration: const Duration(seconds: 1),
          width: MediaQuery.of(context).size.width * 0.6,
          barColor: const Color.fromARGB(255, 56, 56, 55),
          start: 2,
          end: 0,
          offset: 10,
          barAlignment: Alignment.bottomCenter,
          iconHeight: 35,
          iconWidth: 35,
          reverse: false,
          hideOnScroll: false,
          scrollOpposite: false,
          onBottomBarHidden: () {},
          onBottomBarShown: () {},
          body: (context, controller) => TabBarView(
            controller: tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: const NeverScrollableScrollPhysics(),
            children: const [HomeScreen(), PersonScreen()],
          ),
          child: TabBar(
            indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
            controller: tabController,
            indicator: const UnderlineTabIndicator(),
            tabs: const [
              SizedBox(
                height: 55,
                width: 40,
                child: Center(
                    child: Icon(
                  Icons.home,
                  color: Colors.yellow,
                )),
              ),
              SizedBox(
                height: 55,
                width: 40,
                child: Center(
                    child: Icon(
                  Icons.person,
                  color: Colors.yellow,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
