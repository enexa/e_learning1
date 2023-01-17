// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/utils/data.dart';
import 'colors.dart';
import 'widget/courses.dart';
import 'widget/data.dart';
import 'widget/items.dart';
import 'widget/notification.dart';
class Try extends StatefulWidget {
  const Try({ Key? key }) : super(key: key);

  @override
  _TryState createState() => _TryState();
}

class _TryState extends State<Try> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: CustomScrollView(
        slivers: [
          
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => buildBody(),
              childCount: 1,
            ),
          )
        ],
      )
    );
  }

  Widget getAppBar(){
    return
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            NotificationBox(
              notifiedNumber: 1,
              onTap: () {
                
              },
            )
          ],
        ),
      );
  }

  buildBody(){
    return
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                getCategories(),
               const  SizedBox(height: 15,),
               const  Padding(
                  padding:  EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Text("Featured", style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 24,)),
                ),
                getFeature(),
              const   SizedBox(height: 15,),
                Container(
                  margin:const  EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:const  [
                      Text("Recommended", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: textColor),),
                      Text("See all", style: TextStyle(fontSize: 14, color: darker),),
                    ],
                  ),
                ),
                getRecommend(),
              ]
          ),
        ),
      );
  }

  int selectedCollection = 0;
  getCategories(){
    return 
      SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(categories.length, (index) => 
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: CategoryBox(
                selectedColor: Colors.white,
                data: categories[index],
                onTap: (){
                  setState(() {
                    selectedCollection =  index;
                  });
                },
              )
            ) 
          )
        ),
      );
  }

  getFeature(){
    return 
      CarouselSlider(
        options: CarouselOptions(
          height: 290,
          enlargeCenterPage: true,
          disableCenter: true,
          viewportFraction: .75,
        ),
        items: List.generate(features.length, 
          (index) => FeatureItem(
            onTap: (){
              
            },
            data: features[index]
          )
        )
      );
  }

  getRecommend(){
    return
    SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(recommends.length, (index) => 
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: RecommendItem(
                data: recommends[index],
                onTap: (){
                  
                },
              )
            ) 
          )
        ),
      );
  }

}



// import 'package:e_learning/constants.dart';
// import 'package:e_learning/view/screens/vedeo.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class Try extends StatefulWidget {
//   const Try({super.key});

//   @override
//   State<Try> createState() => _TryState();
// }

// class _TryState extends State<Try> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
      
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: ListView(
// children: [
//  SizedBox(height: 150,
// child: Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children:  [
//    const  Padding(padding: EdgeInsets.all(3.0),child:  Text('up comming events',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),

//          const SizedBox(height: 10,),
        
//          Container(
//           padding:const  EdgeInsets.all(8.0),
//           decoration:  BoxDecoration(
//                 color:Colors.white,
//             borderRadius: const BorderRadius.all(Radius.circular(10)),
//             boxShadow: [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.5),
//         spreadRadius: 5,
//         blurRadius: 7,
//         offset: Offset(0, 3), // changes position of shadow
//       ),
//     ],
//           ),
//             height: 100,
        
//            child:Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//              children: [
//                  Text('c++ assignment assignment will be submitted tommorow'),
//                kTextButton('GO TO EVENT', () {
//                 Navigator.of(context).pushAndRemoveUntil(
//                       MaterialPageRoute(builder: (context) => const Vedeo()),
//                       (route) => false);
//                })
//              ],
//            ),
//           ),
      

       

//   ],
// ),),


 
//     Row(
  
//     children: const [
  
//              Text('popular courses'),
  
//              SizedBox(width: 200,),
  
//   Icon(Icons.menu_rounded),
  
//     ],
  
//   ),
//     Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,

//   children: [
//     GestureDetector(

//       child:
//  Kblur( 
//    const CircleAvatar(backgroundColor: Colors.white,radius: 38,child:  Icon(FontAwesomeIcons.code),),),),
//   Kblur( const CircleAvatar(backgroundColor: Colors.white,radius:38,child: Icon(FontAwesomeIcons.python),),),
//    Kblur(const CircleAvatar(backgroundColor: Colors.white,radius: 38,child: Icon(FontAwesomeIcons.java),),),
//    Kblur(const CircleAvatar(backgroundColor: Colors.white,radius: 38,child: Icon(FontAwesomeIcons.book),),),
  
// ],),
// const Padding(
//   padding:  EdgeInsets.all(15.0),
//   child:    Text('continue learning'),
// ),

//   Row(
  
//     children: [
  
//         Kcontainer('Computer Science', 'java', '27 min',const Icon(FontAwesomeIcons.calendar)),
  
//         SizedBox(width: 10,),
  
//             Kcontainer('Software engineer', 'c++', '27 min',const Icon(FontAwesomeIcons.calendar)),
  
//             SizedBox(width: 10,),
  
//                 Kcontainer('Information Systems', 'Chapter 7', '27 min',const Icon(FontAwesomeIcons.calendar)),
  
                   
  
                      
  
        
  
//     ],
  
//   ),

// const Text('Last seen courses'),
// const ListTile(
//   title: Text('Basics of programming'),
//   subtitle: Text('1 hour 6 min'),
//   leading: Icon(FontAwesomeIcons.padlet),
//   trailing: Icon(FontAwesomeIcons.play),
// ),
// const ListTile(
//   leading: Icon(FontAwesomeIcons.padlet),
//   trailing: Icon(FontAwesomeIcons.play),
//   title: Text('Basics of programming'),
//   subtitle: Text('1 hour 6 min'),
// ),
// const ListTile(
//   leading: Icon(FontAwesomeIcons.padlet),
//   trailing: Icon(FontAwesomeIcons.play),
//   title: Text('Basics of programming'),
//   subtitle: Text('1 hour 6 min'),
// ),
// const ListTile(
//   leading: Icon(FontAwesomeIcons.padlet),
//   trailing: Icon(FontAwesomeIcons.play),
//   title: Text('Basics of programming'),
//   subtitle: Text('1 hour 6 min'),
// ),

// ],
        
//         ),
//       ),
//     );
//   }
// }
