import 'package:flutter/material.dart';
import 'package:movpedia/features/classes/view/classes_view.dart';
import 'package:movpedia/features/home/views/home_screen.dart';
import 'package:movpedia/features/messages/view/messages_view.dart';
import 'package:movpedia/features/proflie/view/profile_view.dart';
import 'package:movpedia/theme.dart';
import 'package:movpedia/utilities/enter_exit_route.dart';

class StandardLayout extends StatelessWidget {
  final Widget bodyWidget;
  final bool appBar;
  final Widget appBarTitle;
  final bool backButtonAppBar;
  final bool bottomBar;

  StandardLayout({
    @required this.bodyWidget,
    this.appBarTitle,
    this.appBar = false,
    this.bottomBar = false,
    this.backButtonAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        appBar: appBar,
        backButtonAppBar: backButtonAppBar,
        appBarTitle: appBarTitle,
      ),
      body: bodyWidget,
      bottomNavigationBar: BottomBarMenu(bottomBar: bottomBar),
    );
  }
}

class BottomBarMenu extends StatelessWidget implements PreferredSizeWidget {
  final bool bottomBar;
  const BottomBarMenu({this.bottomBar = false});

  Size get preferredSize {
    return new Size.fromHeight(bottomBar ? 80.0 : 0);
  }

  @override
  Widget build(BuildContext context) {
    if (!bottomBar) {
      return SizedBox(
        width: 0,
      );
    }
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            spreadRadius: 1,
          )
        ],
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context, ScaleRoute(widget: HomeScreen()));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/icons/home-icon.jpg',
                  width: 40,
                ),
                Text(
                  'home'.toUpperCase(),
                  style: AppTheme.menuBarText,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, ScaleRoute(widget: ClassesView()));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/icons/burble-icon.jpg',
                  width: 40,
                ),
                Text(
                  'My class'.toUpperCase(),
                  style: AppTheme.menuBarText,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, ScaleRoute(widget: MessagesScreen()));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/icons/message-icon.jpg',
                  width: 40,
                ),
                Text(
                  'message'.toUpperCase(),
                  style: AppTheme.menuBarText,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, ScaleRoute(widget: ProfileScreen()));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/icons/people-icon.jpg',
                  width: 40,
                ),
                Text(
                  'profile'.toUpperCase(),
                  style: AppTheme.menuBarText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final bool backButtonAppBar;
  final bool appBar;
  final Widget appBarTitle;

  TopBar(
      {this.backButtonAppBar = false, this.appBar = false, this.appBarTitle});

  Size get preferredSize {
    return new Size.fromHeight(appBar ? 80.0 : 0);
  }

  @override
  Widget build(BuildContext context) {
    if (!appBar) {
      return SizedBox(
        width: 0,
      );
    }
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          backButtonAppBar
              ? MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  minWidth: 0,
                  padding: const EdgeInsets.all(0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppTheme.colorTextEnabled,
                    size: 25,
                  ),
                )
              : SizedBox(
                  width: 0,
                ),
          appBarTitle != null
              ? Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: appBarTitle,
              )
              : SizedBox(
                  width: 0,
                ),
        ],
      ),
    );
  }
}
