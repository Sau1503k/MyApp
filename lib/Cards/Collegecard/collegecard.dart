import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class CollegeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(

      children: [
        SizedBox(height:20),
        CarouselSlider(
        items:[Container(
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // image: DecorationImage(
          //   image: AssetImage("images/IIT Bombay.jpg",
          //   ),
          //   fit: BoxFit.cover
          // )
        ),child: Image.network("https://firebasestorage.googleapis.com/v0/b/myapp-86e87.appspot.com/o/Colleges%2FIIT's%2FIIT%20Goa%2FCollegeImages%2FIIT%20Goa.jpg?alt=media&token=479ab90a-4789-4919-b53a-729a128e1499",
          fit: BoxFit.cover,),
        )], options: CarouselOptions(
          height: 250,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16/9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,

        ))
      ],
    );
  }
}
