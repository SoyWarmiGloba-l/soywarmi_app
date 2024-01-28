
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:soywarmi_app/data/model/comments_model.dart';

import '../../utilities/nb_colors.dart';
import '../../utilities/nb_images.dart';

class CustomComment extends StatelessWidget {
  CommentsModel comment;
  CustomComment({super.key, required this.comment});
  final _endPoint = dotenv.env['API_ENDPOINT'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 10),
      child: Row(
        children: [
           Padding(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              radius: 18,
              backgroundImage:NetworkImage(comment.ownerPhoto),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: NbSecondSecondaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8,top: 8,right: 8,bottom: 4),
                    child: Text(comment.ownerName,style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,top: 4,right: 8,bottom: 8),
                    child: Text(comment.content),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
