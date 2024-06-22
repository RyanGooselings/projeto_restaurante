import 'package:receita_app/models/receitasalva.dart';
import 'package:receita_app/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:receita_app/widgets/boh.dart';
import 'package:receita_app/widgets/btnmkp.dart';
import 'package:receita_app/widgets/estrela.dart';
import 'package:receita_app/models/receitamodel.dart';
import 'tema.dart';
import 'package:receita_app/widgets/dialogreceita.dart';

class SavedRecipesScreen extends StatefulWidget {
  const SavedRecipesScreen({super.key, required this.canScroll});

  final bool canScroll;

  @override
  State<SavedRecipesScreen> createState() => _SavedRecipesScreenState();
}

class _SavedRecipesScreenState extends State<SavedRecipesScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SavedRecipesViewModel>();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: constraints.isMobile
              ? const EdgeInsets.only(
                  left: MarketplaceTheme.spacing7,
                  right: MarketplaceTheme.spacing7,
                  bottom: MarketplaceTheme.spacing7,
                  top: MarketplaceTheme.spacing7,
                )
              : const EdgeInsets.only(
                  left: MarketplaceTheme.spacing7,
                  right: MarketplaceTheme.spacing7,
                  bottom: MarketplaceTheme.spacing1,
                  top: MarketplaceTheme.spacing7,
                ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(MarketplaceTheme.defaultBorderRadius),
              topRight: Radius.circular(50),
              bottomRight:
                  Radius.circular(MarketplaceTheme.defaultBorderRadius),
              bottomLeft: Radius.circular(MarketplaceTheme.defaultBorderRadius),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: MarketplaceTheme.borderColor),
                borderRadius: const BorderRadius.only(
                  topLeft:
                      Radius.circular(MarketplaceTheme.defaultBorderRadius),
                  topRight: Radius.circular(50),
                  bottomRight:
                      Radius.circular(MarketplaceTheme.defaultBorderRadius),
                  bottomLeft:
                      Radius.circular(MarketplaceTheme.defaultBorderRadius),
                ),
                color: Colors.white,
              ),
              child: constraints.isMobile
                  ? ListView.builder(
                      physics: widget.canScroll
                          ? const PageScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      itemCount: viewModel.recipes.length,
                      itemBuilder: (context, idx) {
                        final recipe = viewModel.recipes[idx];
                        return Container(
                          margin: EdgeInsets.only(top: idx == 0 ? 70 : 0),
                          child: Align(
                            heightFactor: .5,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: MarketplaceTheme.spacing7,
                                vertical: MarketplaceTheme.spacing7,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .99,
                                height: 200,
                                child: _ListTile(
                                  constraints: constraints,
                                  key: Key('$idx-${recipe.hashCode}'),
                                  recipe: recipe,
                                  idx: idx,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : GridView.count(
                      physics: widget.canScroll
                          ? const PageScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      childAspectRatio: 1.5,
                      children: [
                        ...List.generate(viewModel.recipes.length, (idx) {
                          final recipe = viewModel.recipes[idx];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: MarketplaceTheme.spacing7,
                              vertical: MarketplaceTheme.spacing7,
                            ),
                            child: _ListTile(
                              key: Key('$idx-${recipe.hashCode}'),
                              recipe: recipe,
                              idx: idx,
                              constraints: constraints,
                            ),
                          );
                        }),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _ListTile extends StatefulWidget {
  const _ListTile({
    super.key,
    required this.recipe,
    this.idx = 0,
    required this.constraints,
  });

  final Recipe recipe;
  final int idx;
  final BoxConstraints constraints;

  @override
  State<_ListTile> createState() => _ListTileState();
}

class _ListTileState extends State<_ListTile> {
  final List<Color> colors = [
    MarketplaceTheme.primary,
    MarketplaceTheme.secondary,
    MarketplaceTheme.tertiary,
    MarketplaceTheme.scrim,
  ];

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SavedRecipesViewModel>();
    final color = colors[widget.idx % colors.length];

    return GestureDetector(
      child: HighlightBorderOnHoverWidget(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(MarketplaceTheme.defaultBorderRadius),
          topRight: Radius.circular(50),
          bottomRight: Radius.circular(MarketplaceTheme.defaultBorderRadius),
          bottomLeft: Radius.circular(MarketplaceTheme.defaultBorderRadius),
        ),
        color: color,
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -2),
                color: Colors.black38,
                blurRadius: 5,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(MarketplaceTheme.defaultBorderRadius),
              topRight: Radius.circular(50),
              bottomRight:
                  Radius.circular(MarketplaceTheme.defaultBorderRadius),
              bottomLeft: Radius.circular(MarketplaceTheme.defaultBorderRadius),
            ),
            color: Colors.white,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(MarketplaceTheme.defaultBorderRadius),
                topRight: Radius.circular(50),
                bottomRight:
                    Radius.circular(MarketplaceTheme.defaultBorderRadius),
                bottomLeft:
                    Radius.circular(MarketplaceTheme.defaultBorderRadius),
              ),
              color: color.withOpacity(.3),
            ),
            padding: const EdgeInsets.all(MarketplaceTheme.spacing7),
            child: Stack(
              children: [
                Text(
                  widget.recipe.title,
                  style: MarketplaceTheme.heading3,
                ),
                Positioned(
                  top: widget.constraints.isMobile ? 40 : 60,
                  left: 0,
                  child: Text(
                    widget.recipe.cuisine,
                    style: MarketplaceTheme.subheading1,
                  ),
                ),
                Positioned(
                  right: 15,
                  top: widget.constraints.isMobile ? 40 : 60,
                  child: StartRating(
                    initialRating: widget.recipe.rating,
                    starColor: color,
                    onTap: null,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () async {
        await showDialog<Null>(
          context: context,
          builder: (context) {
            return RecipeDialogScreen(
              recipe: widget.recipe,
              subheading: Row(
                children: [
                  const Text('My rating:'),
                  const SizedBox(width: 10),
                  StartRating(
                    initialRating: widget.recipe.rating,
                    starColor: MarketplaceTheme.tertiary,
                    onTap: (index) {
                      widget.recipe.rating = index + 1;
                      viewModel.updateRecipe(widget.recipe);
                    },
                  ),
                ],
              ),
              actions: [
                MarketplaceButton(
                  onPressed: () {
                    viewModel.deleteRecipe(widget.recipe);
                    Navigator.of(context).pop();
                  },
                  buttonText: "Delete Recipe",
                  icon: Symbols.delete,
                ),
              ],
            );
          },
        );
      },
    );
  }
}