import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List images = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImages();
  }

  getImages() async {
    print('oi');
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=primeira guerra mundial&locale=pt-BR&per_page=50"),
        headers: {
          'Authorization':
              '563492ad6f91700001000001ca281f10fab5412199c820b61a07bd42'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      print(images);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App de imagens do pexels"),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.green.shade300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Text("Escolha suas imagens favoritas para visualizar!"),
              Icon(
                Icons.image,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  BuildGriview(context);
                },
                child: Text(
                  "Escolher imagem",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: EdgeInsets.all(20)),
              )
            ],
          )
        ],
      ),
    );
  }

  void BuildGriview(BuildContext) {
    showModalBottomSheet(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        context: context,
        builder: (context) {
          return BottomSheet(
            elevation: 20,
            backgroundColor: Colors.white,
            onClosing: () {},
            builder: (context) {
              return Column(
                children: [
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: 
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Insira o tópico",
                        hintText: "Exemplo: citologia",
                        suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.search, color: Colors.black,)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: GridView.builder(
                        itemCount: images.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 2,
                            crossAxisCount: 2,
                            childAspectRatio: 1.4,
                            mainAxisSpacing: 2),
                        itemBuilder: (context, index) {
                          return Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                    ),
                                    child: Image.network(
                                    images[index]['src']['tiny'],
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                ],
                              ));
                        }),
                    ),
                    
                  ),
                ],
              );
            },
          );
        });
  }
  searchImages() async {
    print('oi');
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=primeira guerra mundial&locale=pt-BR&per_page=50"),
        headers: {
          'Authorization':
              '563492ad6f91700001000001ca281f10fab5412199c820b61a07bd42'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
      print(images);
    });
  }
}
