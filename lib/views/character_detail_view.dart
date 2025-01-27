import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:stratplus_marvel/controllers/marvel_controller.dart';

class CharacterDetailView extends StatelessWidget {
  const CharacterDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final MarvelController _marvelController = Get.find<MarvelController>();
    final character = Get.arguments;


    return Scaffold(
      appBar: AppBar(
        title:  Text(character.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:  Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             ClipRRect(
               borderRadius: BorderRadius.circular(16),
               child: Image.network(
                 character.imageUrl,
                 width: 200,
                 height: 200,
                 fit: BoxFit.cover,
                 errorBuilder: (context, error, stackTrace) {
                   return const Icon(Icons.broken_image, size: 200);
                 },
               ),
             ),
             SizedBox(height: 16,),
             Text(
                      character.description.isNotEmpty
                          ? character.description
                          : 'Sin descripción.',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}