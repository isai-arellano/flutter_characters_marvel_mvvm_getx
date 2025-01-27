import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stratplus_marvel/controllers/marvel_controller.dart';
import 'package:stratplus_marvel/widgets/character_item.dart';

class CharacterListView extends StatefulWidget {
  const CharacterListView({super.key});

  @override
  State<CharacterListView> createState() => _CharacterListViewState();
}

class _CharacterListViewState extends State<CharacterListView> {
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll(){
    final MarvelController marvelController = Get.put(MarvelController());
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      marvelController.addMoreCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    final MarvelController marvelController = Get.put(MarvelController());
    
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Personajes (${marvelController.totalCharacters})')),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50), 
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: marvelController.searchCharacters,
              decoration: InputDecoration(
                hintText: 'Buscar personaje',
                border: OutlineInputBorder(),
              ),
            ),
          )
        ),
      ),
      body: Obx((){
        if (marvelController.isLoading.value && marvelController.characters.isEmpty){
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            controller: _scrollController,
            itemCount: marvelController.characters.length + 1,
            itemBuilder: (context, index){
              if (index == marvelController.characters.length){
                return const Center(child: CircularProgressIndicator());
              }
              final character = marvelController.characters[index];
              return CharacterItem(
                name: character.name,
                description: character.description,
                imageUrl: character.imageUrl,
                 onTap: () => Get.toNamed('/detail', arguments: character),
              );
            }
          );
        }
      }),
    );
  }
}