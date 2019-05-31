import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/qdaily.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/utils/time_utils.dart';

class ItemComment extends StatelessWidget {
  final CommentBean comment;

  ItemComment({Key key, @required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildTopView(comment.author, comment.publishTime),
          Container(
              padding: EdgeInsets.only(left: 48, top: 20, bottom: 20),
              alignment: Alignment.centerLeft,
              child: Text('${comment?.content}')),
          ListView.builder(
              itemCount: comment.childComments.length,
              padding: EdgeInsets.only(left: 48, top: 0),
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(children: <Widget>[
                    _buildTopView(comment?.childComments[index]?.author,
                        comment.childComments[index].publishTime),
                    Container(
                        padding: EdgeInsets.only(left: 48, top: 20, bottom: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                            '@${comment?.childComments[index]?.parentUser?.name}:${comment?.childComments[index]?.content}')),
                  ]),
                );
              })
        ],
      ),
    );
  }

  Widget _buildTopView(AuthorBean author, int publishTime) {
    return Row(children: <Widget>[
      ImageLoadView('${author?.avatar}',
          width: 40,
          height: 40,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      SizedBox(width: 8),
      Text('${author?.name}'),
      SizedBox(width: 8),
      Text(
          "${TimeUtils.getDateStrByMs(publishTime * 1000, format: DateFormat.ZH_MONTH_DAY)}"),
      Spacer(),
      Icon(FeatherIcons.thumbsUp, size: 20)
    ]);
  }
}
