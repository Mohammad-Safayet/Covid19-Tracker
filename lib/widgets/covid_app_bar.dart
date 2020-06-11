import 'package:flutter/material.dart';

class CovidAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget appBarWidget;

  const CovidAppBar({
    Key key,
    this.title,
    this.appBarWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        padding: const EdgeInsets.all(18.0),
        height: 75.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '${this.title}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontFamily: "JosefinSlab",
                fontWeight: FontWeight.bold,
                letterSpacing: 5.0,
              ),
            ),
            this.appBarWidget,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(170.0);
}
