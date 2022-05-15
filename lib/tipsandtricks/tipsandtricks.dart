import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class TipsAndTricks extends StatelessWidget {
  const TipsAndTricks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog"),
      ),
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.blue,
          useInkWell: true,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Card1(),
          ],
        ),
      ),
    );
  }
}

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class Card1 extends StatelessWidget {
  const Card1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 220,
              child: Image.asset("assets/Handshake.png"),
            ),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "How to find the perfect teammate",
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                collapsed: const Text(
                  loremIpsum,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var _ in Iterable.generate(5))
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          loremIpsum,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
