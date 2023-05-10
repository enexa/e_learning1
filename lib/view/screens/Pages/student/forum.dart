
// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../../../../controller/service/comment_service.dart';
import '../../../../controller/service/use_service.dart';
import '../../../../models/api_response.dart';
import '../../../../models/comment.dart';
import '../../widget/constants.dart';
import 'login.dart';




class Forum extends StatefulWidget {
  final int? postId;

   const Forum({super.key, 
    this.postId
  });

  @override
  _ForumState createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  List<dynamic> _commentsList = [];
  bool _loading = true;
  int userId = 0;
  int _editCommentId = 0;
  final TextEditingController _txtCommentController = TextEditingController();

  // Get comments
  Future<void> _getComments() async {
    userId = await getUserId();
    ApiResponse response = await getComments(widget.postId ?? 0);

    if(response.error == null){
      setState(() {
        _commentsList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
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
  // create comment
  void _createComment() async {
    ApiResponse response = await createComment(widget.postId ?? 0, _txtCommentController.text);

    if(response.error == null){
      _txtCommentController.clear();
      _getComments();
    } 
    else if(response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Login()), (route) => false)
      });
    }
    else {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }

  // edit comment
void _editComment() async {
    ApiResponse response = await editComment(_editCommentId, _txtCommentController.text);

    if(response.error == null) {
      _editCommentId = 0;
      _txtCommentController.clear();
      _getComments();
    }
    else if(response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Login()), (route) => false)
      });
    } 
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }


  // Delete comment
  void _deleteComment(int commentId) async {
    ApiResponse response = await deleteComment(commentId);

    if(response.error == null){
      _getComments();
    }
    else if(response.error == unauthorized){
      logout().then((value) => {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Login()), (route) => false)
      });
    } 
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }

  @override
  void initState() {
    _getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // body: _loading ? const Center(child: CircularProgressIndicator(),) :
    body:  Column(
        children: [
     const    Center(child: Text('welcome to BDU forum ask anything')),
          Expanded(
            child: RefreshIndicator(
              onRefresh: (){
                return _getComments();
              },
              child: ListView.builder(
                itemCount: _commentsList.length,
                itemBuilder: (BuildContext context, int index) {
                  Comment comment = _commentsList[index];
                  return Container(
                    padding:const  EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black26, width: 0.5)
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    image: comment.user!.image != null ? DecorationImage(
                                      image: NetworkImage('${comment.user!.image}'),
                                      fit: BoxFit.cover
                                    ) : null,
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.blueGrey
                                  ),
                                ),
                              const  SizedBox(width: 10,),
                                Text(
                                  '${comment.user!.name}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16
                                  ),
                                )
                              ],
                            ),
                            comment.user!.id == userId ?
                             PopupMenuButton(
                              child:const  Padding(
                                padding: EdgeInsets.only(right:10),
                                child: Icon(Icons.more_vert, color: Colors.black,)
                              ),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child:  Text('Edit')
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete')
                                )
                              ],
                              onSelected: (val){
                                if(val == 'edit'){
                                  setState(() {
                                    _editCommentId = comment.id ?? 0;
                                    _txtCommentController.text = comment.comment ?? '';
                                  });
                                  
                                } else {
                                  _deleteComment(comment.id ?? 0);
                                }
                              },
                            ) :const  SizedBox()
                          ],
                        ), const SizedBox(height: 10,),
                        Text('${comment.comment}')
                      ],
                    ),
                  );
                }
              )
            )
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black26, width: 0.5
              )
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: kInputDecoration('Ask'),
                  controller: _txtCommentController,
                ),
              ),
              IconButton(
                icon:const  Icon(Icons.send),
                onPressed: (){
                  if(_txtCommentController.text.isNotEmpty){
                    setState(() {
                      _loading = true;
                    });
                  if (_editCommentId > 0){
                    _editComment();
                  } else {
                    _createComment();
                  }
                  }
                },
              )
            ],
          ),
        )
        ]
      ),
    );
  }
}