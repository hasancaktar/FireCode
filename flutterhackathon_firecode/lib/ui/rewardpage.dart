import 'package:flutter/material.dart';



class RewardPage extends StatefulWidget {
  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Theme.of(context).primaryColor,),
              onPressed: (){
                Navigator.pop(context);
              },
      ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Ödüller',style: Theme.of(context).textTheme.headline6),
      ),
      body: 
      Stack(children: [
       
        Container(child: Image(image: AssetImage('assets/img/prize.png')),),
        
      ], )
    );
  }
}