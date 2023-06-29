import 'dart:ui';

import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 20,
      right: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      backgroundColor: Colors.transparent,
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      backgroundColor: Colors.transparent,
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.grey.shade500,
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      backgroundColor: Colors.transparent,
                      icon: Icon(
                        Icons.music_note_rounded,
                        color: Colors.grey.shade500,
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      backgroundColor: Colors.transparent,
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.grey.shade500,
                      ),
                      label: ""),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
