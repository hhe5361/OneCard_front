import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appbar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  buttonColor: Colors.black,
                  child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          Navigator.pushNamed(context, '/GamePage');
                        });
                      },
                      child: const Text("with computer",style: TextStyle(color: Colors.white),)
                  ),
                ),
                const SizedBox(width: 30),
                ButtonTheme(
                  buttonColor: Colors.black,
                  child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          Navigator.pushNamed(context, '/GamePage2');
                        });
                      },
                      child: const Text("with friend",style: TextStyle(color: Colors.white),)
                  ),
                )
              ],

            ),
            ButtonTheme(
              buttonColor: Colors.black,
              child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      Navigator.pushNamed(context, '/Help');
                    });
                  },
                  child: const Text("show Game rule",style: TextStyle(color: Colors.white),)
              ),
            ),
            //const SizedBox(height: 50,),
            const Image(
              image: AssetImage("trumpcard/home.png"),
              width: 500,
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}

AppBar appbar(){
  return AppBar(
    centerTitle: true,
    title: Text("Play Onecard!",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
    backgroundColor: Colors.black
  );
}
