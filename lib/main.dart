import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: BuyingsList(),
      )
    );
  }
}

class BuyingsList extends StatefulWidget {
  const BuyingsList({Key? key}) : super(key: key);

  @override
  State<BuyingsList> createState() => _BuyingsListState();
}

class _BuyingsListState extends State<BuyingsList> {
  final List<Buying> _buyings = [
    Buying(establishment: 'Teste', value: 10, date: DateTime.now()),
    Buying(establishment: 'Teste 2', value: 20, date: DateTime.now()),
    Buying(establishment: 'Teste 2', value: 20, date: DateTime.now()),
    Buying(establishment: 'Teste 2', value: 20, date: DateTime.now()),
    Buying(establishment: 'Teste 2', value: 20, date: DateTime.now()),
    Buying(establishment: 'Teste 2', value: 20, date: DateTime.now()),
    Buying(establishment: 'Teste 2', value: 20, date: DateTime.now()),
    Buying(establishment: 'Teste 2', value: 20, date: DateTime.now()),
    Buying(establishment: 'Teste 2', value: 20, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Buyings')
      ),
      body: ListView.builder(
        itemCount: _buyings.length,
        itemBuilder: (context, index) {
          return BuyingListItem(buying: _buyings[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final Future future = Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => NewBuying()
            )
          );
          future.then((res) => {
            print('voltou')
          });
        },
      ),
    );
  }
}

class BuyingListItem extends StatelessWidget {
  final Buying buying;

  const BuyingListItem({Key? key, required this.buying}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(buying.establishment),
        contentPadding: const EdgeInsets.all(16.0),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: const EdgeInsets.only(top: 8.0), child: Text(buying.getFormattedDate())),
            Padding(padding: const EdgeInsets.only(top: 8.0), child: Text(buying.getFormattedValue()))
          ],
        ), 
      )
    );
  }
}

class NewBuying extends StatefulWidget {
  const NewBuying({Key? key}) : super(key: key);

  @override
  State<NewBuying> createState() => _NewBuyingState();
}

class _NewBuyingState extends State<NewBuying> {
  final List<NewItem> _items = [
    NewItem(product: 'Macarrão', amount: 3, amountType: 'unit', price: 2.5),
    NewItem(product: 'Feijão', amount: 1, amountType: 'unit', price: 3),
    NewItem(product: 'Picanha', amount: 1, amountType: 'weight', price: 35),
    NewItem(product: 'Picanha', amount: 1, amountType: 'weight', price: 35),
    NewItem(product: 'Picanha', amount: 1, amountType: 'weight', price: 35),
    NewItem(product: 'Picanha', amount: 1, amountType: 'weight', price: 35),
    NewItem(product: 'Picanha', amount: 1, amountType: 'weight', price: 35),
    NewItem(product: 'Picanha', amount: 1, amountType: 'weight', price: 35),
    NewItem(product: 'Picanha', amount: 1, amountType: 'weight', price: 35),
    NewItem(product: 'Picanha', amount: 1, amountType: 'weight', price: 35),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Buying')
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Establishment'
              ),
            )
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, bottom: 16),
            child: Text(
              'Items',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return NewItemListItem(item: _items[index]);
              },
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          print('vamo adicionar');
        },
      ),
    );
  }
}

class NewItemListItem extends StatelessWidget {
  final NewItem item;

  const NewItemListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.product),
        // contentPadding: const EdgeInsets.all(16.0),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0), 
              child: Text('Amount: ${item.amount}')
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0), 
              child: Text('Unit price: R\$ ${item.price}')
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0), 
              child: Text('Total: R\$ ${item.totalPrice}')
            )
          ],
        ), 
      )
    );
  }
}

class NewItem {
  final String product;
  final int amount;
  final String amountType;
  final double price;
  late double totalPrice;

  NewItem({
    required this.product,
    required this.amount,
    required this.amountType,
    required this.price
  }) {
    totalPrice = amount * price;
  }
}

class Buying {
  final String establishment;
  final double value;
  final DateTime date;

  Buying({
    required this.establishment, 
    required this.value, 
    required this.date
  });

  String getFormattedValue() {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  String getFormattedDate() {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }
}