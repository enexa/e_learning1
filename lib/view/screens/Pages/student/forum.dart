
// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/service/forumservice.dart';
import '../../../../controller/service/use_service.dart';
import '../../../../models/api_response.dart';
import '../../../../models/utils/forum.dart';
import '../../widget/constants.dart';
import '../teacher/comment_screen.dart';
import 'askforum.dart';
import 'login.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

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

    if(response.error == null){
      setState(() {
        _postList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    }
    else if (response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Login()), (route) => false)
      });
    }
    else {
      Get.snackbar("Error", "${response.error}",
    
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: Colors.red,
    icon: const Icon(Icons.error,color: Colors.red,),
    
    

    );
    }
  }


  void _handleDeletePost(int postId) async {
    ApiResponse response = await deleteforum(postId);
    if (response.error == null){
      retrievePosts();
    }
    else if(response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Login()), (route) => false)
      });
    } 
    else {
     Get.snackbar("Error", "${response.error}",
    
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: Colors.red,
    icon: const Icon(Icons.error,color: Colors.red,),
    
    

    );
    }
  }



  // post like dislik
  void _handlePostLikeDislike(int postId) async {
    ApiResponse response = await likeUnlikeAnswer(postId);

    if(response.error == null){
      retrievePosts();
    }
    else if(response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Login()), (route) => false)
      });
    } 
    else {
     Get.snackbar("Error", "${response.error}",
    
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: Colors.red,
    icon: const Icon(Icons.error,color: Colors.red,),
    
    

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
    return _loading ? const Center(child:CircularProgressIndicator()) :
   
       Stack(
        children: [
          ListView.builder(
            itemCount: _postList.length,
            itemBuilder: (BuildContext context, int index){
              forums post = _postList[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            children: [
                            
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  image: post.user!.image != null ?
                                    DecorationImage(image: NetworkImage('${post.user!.image}')) : null,
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.amber
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Text(
                                '${post.user!.name}',
                                style:const  TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17
                                ),
                              )
                            ],
                          ),
                        ),
                        post.user!.id == userId ?
                        PopupMenuButton(
                          child: const Padding(
                            padding: EdgeInsets.only(right:10),
                            child: Icon(Icons.more_vert, color: Colors.black,)
                          ),
                          itemBuilder: (context) => [
                           
                            // const PopupMenuItem(
                            //   value: 'edit',
                            //   child: Text('Edit')
                            // ),
                           const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete')
                            )
                          ],
                          onSelected: (val){
                            if(val == 'edit'){
                              Get.to(Forum(forum: post,title:'Edit Post' ,));
                              //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Forum(
                              //    title: 'Edit Post',
                              //    forum: post,
                              //  )));
                            } else {
                              _handleDeletePost(post.id ?? 0);
                            }
                          },
                        ) :const  SizedBox()
                      ],
                    ),
                    const SizedBox(height: 12,),
                    Text('${post.body}'),
                   
                    Row(
                      children: [
                       
                         kLikeAndComment(
                          post.commentsCount ?? 0,
                          Icons.sms_outlined,
                          Colors.black54,
                          (){
                            Get.to(CommentScreen(postId: post.id));
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CommentScreen(
                              postId: post.id,
                            )));
                          }
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
            }
          ),
           Positioned(
              bottom: 16,
              left: 2,
              right: 2,
              child: TextButton(
                    style: ButtonStyle(shape:       
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.blue)
                        )
                      )
                    ),
                   onPressed: () => Get.to(const Forum(title: 'Ask Forum',)),
                    child: const Text('Ask Forum',style:TextStyle(fontSize: 15),),
                  ),
              ),
        ],
      );
    
  }
}