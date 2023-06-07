import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../controller/service/forumservice.dart';
import '../../../../controller/service/use_service.dart';
import '../../../../models/api_response.dart';
import '../../../../models/utils/forum.dart';
import '../../widget/constants.dart';
import '../teacher/comment_screen.dart';
import 'askforum.dart';
import 'login.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  List<dynamic> _postList = [];
  int userId = 0;
  bool _loading = true;

  // get all posts
  Future<void> retrievePosts() async {
    userId = await getUserId();
    ApiResponse response = await getForums();

    if (response.error == null) {
      setState(() {
        _postList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false)
          });
    } else {
      Get.snackbar(
        "Error",
        "${response.error}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.red,
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
    }
  }

  void _handleDeletePost(int postId) async {
    ApiResponse response = await deleteforum(postId);
    if (response.error == null) {
      retrievePosts();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false)
          });
    } else {
      Get.snackbar(
        "Error",
        "${response.error}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.red,
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
    }
  }

  void _handlePostLikeDislike(int postId) async {
    ApiResponse response = await likeUnlikeAnswer(postId);

    if (response.error == null) {
      retrievePosts();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false)
          });
    } else {
      Get.snackbar(
        "Error",
        "${response.error}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.red,
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    retrievePosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? ListView.builder(
            itemCount: 5, // Display shimmer effect for 5 items
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 10.0,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        width: 200.0,
                        height: 10.0,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        width: 150.0,
                        height: 10.0,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        width: double.infinity,
                        height: 10.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : Stack(
            children: [
              RefreshIndicator(
                onRefresh: () {
                  return retrievePosts();
                },
                child: ListView.builder(
                  itemCount: _postList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Forums post = _postList[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        image: post.user!.image != null
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                    '${post.user!.image}'),
                                                fit: BoxFit.cover)
                                            : null,
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${post.user!.name}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                              post.user!.id == userId
                                  ? PopupMenuButton(
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Icons.more_vert,
                                          color: Colors.black,
                                        ),
                                      ),
                                      itemBuilder: (context) => [
                                        // const PopupMenuItem(
                                        //   value: 'edit',
                                        //   child: Text('Edit')
                                        // ),
                                        const PopupMenuItem(
                                            value: 'delete',
                                            child: Text('Delete')),
                                      ],
                                      onSelected: (val) {
                                        if (val == 'edit') {
                                          Get.to(Forum(
                                            forum: post,
                                            title: 'Edit Post',
                                          ));
                                          //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Forum(
                                          //    title: 'Edit Post',
                                          //    forum: post,
                                          //  )));
                                        } else {
                                          _handleDeletePost(post.id ?? 0);
                                        }
                                      },
                                    )
                                  : const SizedBox()
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text('${post.body}'),
                          Row(
                            children: [
                              kLikeAndComment(
                                post.commentsCount ?? 0,
                                Icons.sms_outlined,
                                Colors.black54,
                                () {
                                  Get.to(CommentScreen(postId: post.id));
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CommentScreen(
                                        postId: post.id,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 0.5,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 16,
                left: 2,
                right: 2,
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  onPressed: () =>
                      Get.to(const Forum(title: 'Ask Forum',)),
                  child: const Text(
                    'Ask Forum',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          );
  }
}
