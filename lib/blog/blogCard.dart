// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class BlogCard extends StatelessWidget {
  final String title;
  final String text;
  final String photo;

  const BlogCard({Key? key, this.photo = '', this.text = '', this.title = ''})
      : super(key: key);

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
                child: Image.network(photo),
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
                      title,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  collapsed: Text(
                    text,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            text,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
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
      ),
    );
  }
}
