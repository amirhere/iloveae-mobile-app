
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';



class CarouselWidget extends PreferredSize {


    final double height;
    final List<NetworkImage> networkImagesList;


    CarouselWidget({
        this.height = kToolbarHeight,
        @required  this.networkImagesList,

    });



    @override
    Size get preferredSize => Size.fromHeight(height);

    @override
    Widget build(BuildContext context) {

        return Container(
            height: height * (1 / 3.5),
            child: Center(
                child: SizedBox.expand(
                    child: Carousel(
                        dotSize: 4.0,
                        dotSpacing: 15.0,
                        dotColor: Color(0xFF573555),
                        indicatorBgPadding: 5.0,
                        images: networkImagesList),
                ),
            ),
        );
    }
}
