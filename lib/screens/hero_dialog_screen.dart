import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroDialog extends StatelessWidget {
  const HeroDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        alignment: Alignment.center,
        widthFactor: 0.7,
      heightFactor: 0.7,
      child: Container(
        child: Hero(
          tag: "profile-image",
          child: Container(
                  width: double.infinity,
                  height: 100,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            "https://images.unsplash.com/flagged/photo-1566127992631-137a642a90f4",
                          ),
                          fit: BoxFit.cover)),
                )
        ),
      ),
    );
  }
}
