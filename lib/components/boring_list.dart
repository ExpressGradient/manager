import 'package:flutter/material.dart';
import '../firebase_utils.dart';
import './boring_card.dart';

class BoringList extends StatelessWidget {
  Future<List> _getCards(BuildContext context) async {
    List<Widget> _cards = [];
    List _projects = await getProjects();

    _projects.forEach((_project) => _cards.add(boringCard(_project, context)));

    return _cards;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _getCards(context),
        builder: (context, snapshot) {
          if(snapshot.hasError) return Center(child: Text("Error in fetching data", style: TextStyle(color: Colors.white, fontSize: 25.0)));

          if(!snapshot.hasData) return CircularProgressIndicator(
            backgroundColor: Colors.black,
          );

          return RefreshIndicator(
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: snapshot.data,
            ),
            onRefresh: () => _getCards(context),
            color: Color(0xff1b1b1b),
          );
        }
      )
    );
  }
}