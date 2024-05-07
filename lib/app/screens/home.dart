import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_blog/app/screens/latest.dart';
import 'package:simple_blog/app/screens/trending.dart';
import 'package:simple_blog/app/utils/constants.dart';
import 'package:simple_blog/app/utils/size_config.dart';

import '../utils/components/app_route.dart';
import '../utils/reusables.dart';
import 'featured.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<String> secondTabBar = <String>[
    'Featured',
    'Latest',
    'Trending',
  ];



  int _current = 0;

  final List<Widget> _tabs =[
    const Featured(),
    const Latest(),
    const Trending(),
  ];


  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return  Scaffold(
      backgroundColor: Palette.kBackground,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(
            left: getScreenWidth(24),
            right: getScreenWidth(24),
            top: getScreenHeight(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                      text: "Home",
                      color: Colors.black,
                      size: 24,
                      font: FontFamily.kSemiBold,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w500),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, AppRoute.createBlog);
                    },
                    child: const CustomText(
                        text: "Create",
                        color: Palette.kPrimary,
                        size: 24,
                        font: FontFamily.kSemiBold,
                        textAlign: TextAlign.center,
                        weight: FontWeight.w500),
                  ),

                ],
              ),
              SizedBox(
                height: getScreenHeight(80),
                child: ListView.builder(
                    itemCount: secondTabBar.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _current = index;
                          });
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(right: getScreenWidth(20)),
                              child: CustomText(
                                  text: secondTabBar[index],
                                  size: 16,
                                  weight: FontWeight.w500,
                                  color: _current==index? Palette.kPrimary:
                                  Palette.k1E,
                                  font: FontFamily.kSemiBold
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              _tabs[_current],
            ],
          ),
        ),
      ),
    );
  }
}
