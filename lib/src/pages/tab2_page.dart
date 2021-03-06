import 'package:flutter/material.dart';
import 'package:getapp/src/models/category_model.dart';
import 'package:getapp/src/services/news_service.dart';
import 'package:getapp/src/theme/tema.dart';
import 'package:getapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _ListaCategorias(),
            Expanded(child: ListaNoticias(newsService.getArticulosCategoria))
          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    final newsService = Provider.of<NewsService>(context);

    return Container(
      width: double.infinity,
      height: 85,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            final cName = categories[index].name;
            return Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  _CategoryButton(categories[index]),
                  SizedBox(height: 5),
                  Text(
                    '${cName[0].toUpperCase()}${cName.substring(1)}',
                    style: TextStyle(
                        color: (newsService.selectedCategory ==
                                categories[index].name)
                            ? miTema.accentColor
                            : Colors.black87),
                  )
                ],
              ),
            );
          }),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Catergory categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(categoria.icon,
            color: (newsService.selectedCategory == this.categoria.name)
                ? miTema.accentColor
                : Colors.black87),
      ),
    );
  }
}
