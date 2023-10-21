import 'package:flutter/material.dart';

import '../../settings/constants.dart';

class TitleTags extends StatefulWidget {
  final String title;
  final List<String> tags;
  const TitleTags({super.key, required this.title, required this.tags});

  @override
  State<TitleTags> createState() => _TitleTagsState();
}

class _TitleTagsState extends State<TitleTags> {
  late String tagSelected;

  @override
  void initState() {
     tagSelected = widget.tags[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(
            widget.title,
            style: text22Title(context),
          ),
        ],
      ),
      SizedBox(height: 15),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...widget.tags.map((e) {
              return Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(right: 10),
                      height: 20,
                      child: OutlinedButton(
                          style: ButtonStyle(
                              backgroundColor: (tagSelected == e)
                                  ? MaterialStateProperty.all(primary(context))
                                  : MaterialStateProperty.all(
                                      bgColor(context))),
                          onPressed: () {
                            setState(() {
                              tagSelected = e;
                            });
                          },
                          child: Text(e,
                              style: text10mini(context)
                              .copyWith(
                                  color: (tagSelected == e)
                                      ? bgColor(context)
                                      : null
                                      )
                              ))),
                ],
              );
            }),
          ],
        ),
      ),
    ]);
  }
}
