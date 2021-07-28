import 'package:flutter/material.dart';
import 'package:haru/about/widgets/about_detail.dart';

import 'widgets/page_file_builder.dart';

class AboutPage extends StatelessWidget {
  static const routeName = '/about';
  final GlobalKey<PageFlipBuilderState> pageFlipKey;
  const AboutPage({Key? key, required this.pageFlipKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageFlipBuilder(
      key: pageFlipKey,
      frontBuilder: (context) => AboutDetail(
        bgImage: 'assets/images/yosemite2.png',
        myImage: 'assets/images/us/hsj.JPG',
        myName: '황성준',
        myFuture: 'Future Startup Founder',
        myEmail: 'charles9306@knou.ac.kr',
        myWords:
            '경진대회를 준비하면서 앱 개발에 몰입할 수 있었습니다.\n\n짧은 기간동안 재미있게 만들며 성장한 느낌입니다.\n\n다들 멋진 작품 만드시느라 정말 수고 많으셨습니다.\n\n여기 계신 모든 분들이 대한민국을 빛내주시리라 믿습니다.\n',
        onFlip: () => pageFlipKey.currentState!.flip(),
      ),
      backBuilder: (context) => AboutDetail(
        bgImage: 'assets/images/multnomah_falls.png',
        myImage: 'assets/images/us/bje.JPG',
        myName: '변지은',
        myFuture: 'Future Application Developer',
        myEmail: 'bje0507@knou.ac.kr',
        myWords:
            '경진대회에 참여하도록 도와주신 성준님께 감사드립니다. \n\n하루 프로젝트를 하면서 좀 더 성장한 느낌이 들었습니다. \n\n 수고 많으셨습니다!',
        onFlip: () => pageFlipKey.currentState!.flip(),
      ),
    );
  }
}
