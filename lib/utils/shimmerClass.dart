import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListWithImg extends StatelessWidget {
  final double? height;

  const ShimmerListWithImg({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext buildContext, int index) {
          return _LoadingItem(
            height: height,
          );
        });
  }
}

class _LoadingItem extends StatelessWidget {
  final double? height;

  const _LoadingItem({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF656565).withOpacity(0.15),
              blurRadius: 2.0,
              spreadRadius: 1.0,
            )
          ]),
      child: Wrap(
        children: <Widget>[
          Shimmer.fromColors(
            baseColor: Colors.black38,
            highlightColor: Colors.white,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          width: height ?? h * 0.1,
                          height: height ?? h * 0.1,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0,
                                    right: 5.0,
                                    top: 10.0,
                                    bottom: 20),
                                child: Container(
                                  height: 12.5,
                                  width: w * 0.5,
                                  color: Colors.black12,
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0, top: 10.0),
                                child: Container(
                                  height: 9.5,
                                  width: w * 0.8,
                                  color: Colors.black12,
                                )),
                          ],
                        ),
                      )
                    ],
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
