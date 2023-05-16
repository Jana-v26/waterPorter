import 'package:flutter/material.dart';

class FetchingDropLocation extends StatefulWidget {
  const FetchingDropLocation({Key? key}) : super(key: key);

  @override
  State<FetchingDropLocation> createState() => _FetchingDropLocationState();
}

class _FetchingDropLocationState extends State<FetchingDropLocation> {
  final _dropLocation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 80, 10, 30),
      child: Column(
        children: [
          TextField(
            controller: _dropLocation,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.pin_drop,
                  color: Colors.green,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search_outlined,
                    color: Colors.blue,
                  ),
                  onPressed: () {},
                ),
                label: Text("Drop locaion"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0))),
          )
        ],
      ),
    );
  }
}
