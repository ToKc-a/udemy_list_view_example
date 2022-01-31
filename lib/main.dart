import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Building List View'),
          centerTitle: true,
        ),
        body: BodyListView(),
      ),
    );
  }
}

class BodyListView extends StatelessWidget {
  const BodyListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _myDynamicListViewWithHead();
  }
}

//Статический список. Хорошо при небольшом списке
Widget _myStatListView() {
  return ListView(
    padding: EdgeInsets.all(8.0),
    //shrinkWrap: true, //Ограничение ScrollView величиной списка, сильно влияет на производительность
    //scrollDirection: Axis.horizontal, //Смена ориентации
    //itemExtent:300, //Ширина/высота каждого элемента при горизонтальном/вертикальном ListView
    //reverse: true, //Реверсивный список
    children: [
      ListTile(
        title: Text('Sun'),
        subtitle: Text('Today Clear'),
        leading: Icon(Icons.wb_sunny),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        title: Text('Clody'),
        subtitle: Text('Today Cloudy'),
        leading: Icon(Icons.wb_cloudy),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        title: Text('Snow'),
        subtitle: Text('Today Snow'),
        leading: Icon(Icons.ac_unit),
        trailing: Icon(Icons.keyboard_arrow_right),
      )
    ],
  );
}

//Динамический список из 10000 элементов
Widget _myDynamicListView() {
  final List<String> items = List<String>.generate(10000, (i) => 'Item $i');
  return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('${items[index]}'),
            leading: Icon(
              Icons.insert_photo,
              color: Colors.red,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        );
      });
}

//Динамический список из 10000 элементов
Widget _myDynamicListViewWithHead() {
  final List<ListItem> items = List<ListItem>.generate(
      10000,
          (i) => i % 6 == 0
          ? HeadingItem('Heading $i')
          : MessageItem('Sender $i', 'Message body $i'));
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];

      if (item is HeadingItem) {
        return ListTile(
          title: Text(
            item.heading,
            style: Theme.of(context).textTheme.headline5,
          ),
        );
      } else if (item is MessageItem) {
        return ListTile(
          title: Text(item.sender),
          subtitle: Text(item.body),
          leading: Icon(
            Icons.insert_photo,
            color: Colors.red,
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
        );
      }
      return Container();
    },
  );
}

abstract class ListItem {}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}
