import 'package:flutter/material.dart';
import 'package:tunitalk/core/theme.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/6858/6858504.png'),
            ),
            SizedBox(
              width: 10,
            ),
          Text(
            "ranim",
            style: Theme.of(context).textTheme.titleMedium
          )
        ],

      ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){},
              icon: Icon(Icons.search)
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                _buildReceivedMessage(context,'hello ! ena ranim '),
                _buildSentMessage(context,'nice name ranim!'),
                _buildReceivedMessage(context,'hello ! ena ranim '),
                _buildSentMessage(context,'nice name ranim!'),
              ],
            )
          ),
          _buildInputMessage()

        ],
      ),

    );
  }
  Widget _buildReceivedMessage (BuildContext context , String message){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(right: 30,top: 5, bottom: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: DefaultColors.receiverMessage,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(
            message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildSentMessage (BuildContext context , String message){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(right: 30,top: 5, bottom: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: DefaultColors.senderMessage,
            borderRadius: BorderRadius.circular(15)
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildInputMessage(){
    return Container(
      decoration: BoxDecoration(
        color: DefaultColors.sentMessageInput,
        borderRadius: BorderRadius.circular(25)
      ),
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          GestureDetector(
            child: Icon(
              Icons.camera_alt,
              color: Colors.grey,
            ),
            onTap: (){},
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(child: TextField(
            decoration: InputDecoration(
              hintText: "message",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none
            ),
            style: TextStyle(
              color: Colors.white),
            )
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            child: Icon(
              Icons.send,
              color: Colors.grey,
            ),
            onTap: (){},
          )
        ],
      ),
    );
  }

}
