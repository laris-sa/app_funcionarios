import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _allData = [    {'id': 1, 'title': 'Item 1', 'desc': 'Description 1'},    {'id': 2, 'title': 'Item 2', 'desc': 'Description 2'},    {'id': 3, 'title': 'Item 3', 'desc': 'Description 3'},  ];

  bool _isLoading = false;

  void _refreshData() async {
    setState(() {
      _isLoading = true;
    });

    // Simulating API call or data fetching

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _deleteData(int id) {
    setState(() {
      _allData.removeWhere((element) => element['id'] == id);
    });
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData = _allData.firstWhere((element) => element['id'] == id);
      _titleController.text = existingData['title'];
      _descController.text = existingData['desc'];
    } else {
      _titleController.text = '';
      _descController.text = '';
    }

    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Title",
              ),
            ),
            SizedBox(height: 5),
            TextField(
              controller: _descController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Description",
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (id == null) {
                      final newItem = {
                        'id': _allData.length + 1,
                        'title': _titleController.text,
                        'desc': _descController.text,
                      };
                      _allData.add(newItem);
                    } else {
                      final existingItem =
                          _allData.firstWhere((element) => element['id'] == id);
                      existingItem['title'] = _titleController.text;
                      existingItem['desc'] = _descController.text;
                    }
                  });

                  _titleController.text = "";
                  _descController.text = "";

                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    id == null ? "Add Funcionário" : "Atualizar",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF2A1AA1),
      appBar: AppBar(
        title: Text("LarissaH & JadiseL"),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _allData.length,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.all(15),
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      _allData[index]['title'],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  subtitle: Text(_allData[index]['desc']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showBottomSheet(_allData[index]['id']);
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.deepPurple,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _deleteData(_allData[index]['id']);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Color.fromARGB
                          (255, 0, 0,0 ),
),
),
],
),
),
),
),
floatingActionButton: FloatingActionButton(
onPressed: () {
showBottomSheet(null);
},
child: Icon(Icons.add),
),
);
}
}

void main() {
runApp(MaterialApp(
debugShowCheckedModeBanner: false,
home: HomeScreen(),
));
}





