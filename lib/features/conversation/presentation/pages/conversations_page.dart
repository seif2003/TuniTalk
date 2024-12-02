import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunitalk/core/theme.dart';
import 'package:tunitalk/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:tunitalk/features/conversation/presentation/bloc/conversations_event.dart';
import 'package:tunitalk/features/conversation/presentation/bloc/conversations_state.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ConversationsBloc>(context).add(FetchConversations());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages",
        style:Theme.of(context).textTheme.titleLarge
      ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        actions: [
          IconButton(onPressed: (){},
              icon: Icon(Icons.search)
          )
        ],
      ),
      body: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding (
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            'Recent',
            style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Container(
            height: 100,
            padding: EdgeInsets.all(5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildRecentContact('ranim',context),
                _buildRecentContact('lina',context),
                _buildRecentContact('seif',context),
                _buildRecentContact('linouch',context),
                _buildRecentContact('lynda',context),
                _buildRecentContact('ghali',context)

              ],
            ),
          ),

          SizedBox(
            height:10,

          ),

          Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: DefaultColors.messageListPage,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)
                  )
                ),
                child: BlocBuilder<ConversationsBloc, ConversationsState>(
                  builder: (context, state) {
                    if(state is ConversationsLoading) {
                      return Center(child: CircularProgressIndicator(),);
                    }
                    else if (state is ConversationsLoaded) {
                      return ListView.builder(
                        itemCount: state.conversations.length,
                        itemBuilder: (context, index){
                          final conversation = state.conversations[index];
                          return _buildMessageTile(
                              conversation.participantName,
                              conversation.lastMessage,
                              conversation.lastMessageTime.toString()
                          );
                        },
                      );
                    }
                    else if (state is ConversationsError) {
                      return Center(child: Text(state.message),);
                    }
                    return Center(child: Text('No conversations found'),);
                  },
                ),
              )
          )
        ],
      ),
    );
  }

  Widget _buildMessageTile (String name , String message , String time) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading : CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/6858/6858504.png'),

      ),
        title: Text(
        name,
         style: TextStyle(color : Colors.white, fontWeight: FontWeight.bold)
    ),
      subtitle: Text(
        message,
        style: TextStyle(color: Colors.grey
        ),

        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        time,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }

  Widget _buildRecentContact(String name,BuildContext context){
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 10)
    ,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/6858/6858504.png'),
        ),
        SizedBox(height: 10),
        Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium
        ),


      ],
    ),
    );
  }
}
