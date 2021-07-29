
import 'package:apk/MyFlutterApp.dart';
import 'package:apk/Screen/HomeScreen.dart';
 import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ModelPage.dart';
import 'package:page_view_indicator/page_view_indicator.dart';


class onHomeBoarding extends StatefulWidget {
  const onHomeBoarding({Key key}) : super(key: key);

  @override
  _onHomeBoardingState createState() => _onHomeBoardingState();
}

class _onHomeBoardingState extends State<onHomeBoarding> {

  List<PageModel> pages = <PageModel>[];

  ValueNotifier<int>_pageViewNotifier=ValueNotifier(0);

  void _addPages() {
    pages.add(PageModel(
        'Bienvenue ', 'Maroc Post Suivi des envois par téléphone  ',
        MyFlutterApp.barid, 'assets/images/dog.png'));
    pages.add(PageModel('Amanaty',
        'Amana Messagerie Nationale est le service assurant la collecte, le transport et la livraison des colis partout au Maroc',
        MyFlutterApp.amana, 'assets/images/amana.jpg'));
    pages.add(PageModel(
        'Pourquoi ?', ' restez connecté avec votre colis et continuez d attendre  ',
        MyFlutterApp.map, 'assets/images/track.jpg'));
  }

  @override
  Widget build(BuildContext context) {
    _addPages();


    return Stack(

      children: <Widget>[
        Scaffold(
          body: PageView.builder(
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: DecorationImage(
                        colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.2),
                        BlendMode.dstATop),
                            image: ExactAssetImage(pages[index].image),
                            fit: BoxFit.cover),
                      )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: double.infinity),
                      Transform.translate(
                        child: Icon(pages[index].icon, size: 200,
                          color: Colors.orange,),
                        offset: Offset(-2, 50),
                      ),


                      Text(pages[index].title, style: TextStyle(
                        color: Colors.orange,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                        textAlign: TextAlign.center,


                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 48, right: 48, top: 0),
                        child: Text(pages[index].description,
                          style: TextStyle(color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,),

                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                ],

              );
            },
            itemCount: pages.length,
            onPageChanged: (index){
              _pageViewNotifier.value=index;
            }


          ),
        ),
        Transform.translate(
            offset:Offset(0,175),
          child:Align(
            alignment: Alignment.center,
            child: _displayPageIndicator(pages.length),
          ),
        ),





        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                color: Colors.yellow,

                child: Text('COMMENCER',
                  style: TextStyle(
                      color: Colors.white, fontSize: 16, letterSpacing: 1),
                ),
                onPressed: () {


                       Navigator.push(context, MaterialPageRoute(builder: (context){
                        return  LoginScreen();
                        //update seen
                         _updateSeen();
                       }));




                },
              ),
            ),
          ),
        )

      ],


    );
  }
  Widget _displayPageIndicator(int length){


    return PageViewIndicator(

      pageIndexNotifier: _pageViewNotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.grey,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 12.0,
          color: Colors.orange,
        ),
      ),
    );

  }
 void _updateSeen() async{
   SharedPreferences prefs=await SharedPreferences.getInstance();
   prefs.setBool( 'seen', true);

 }

  }





