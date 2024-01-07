import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/category_bloc/category_bloc.dart';
import 'package:wholecela/business_logic/seller_bloc/seller_bloc.dart';
import 'package:wholecela/business_logic/user_bloc/user_bloc.dart';
import 'package:wholecela/data/models/category.dart';
import 'package:wholecela/data/models/seller.dart';
import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/data/models/product.dart';
import 'package:wholecela/presentation/screens/profile_store_upload_screen.dart';
import 'package:wholecela/presentation/utils/loaders/screen_loading.dart';
import 'package:wholecela/presentation/widgets/avatar_image.dart';
import 'package:wholecela/presentation/widgets/product_item_shop_card.dart';

class ProfileStoreScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const ProfileStoreScreen(),
    );
  }

  const ProfileStoreScreen({
    super.key,
  });

  @override
  State<ProfileStoreScreen> createState() => _ProfileStoreScreenState();
}

class _ProfileStoreScreenState extends State<ProfileStoreScreen> {
  late User loggedUser;

  late Category? selectedCategory;
  late List<Category> categories;

  @override
  void initState() {
    super.initState();
    loggedUser = context.read<UserBloc>().state.user!;
    categories = context.read<CategoryBloc>().state.categories!;
    if (categories.isNotEmpty) {
      selectedCategory =
          categories.firstWhere((category) => category.name == "All");
    }

    if (categories.isEmpty) {
      selectedCategory = null;
    }

    context.read<SellerBloc>().add(LoadSeller(id: loggedUser.id));
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerBloc, SellerState>(
      buildWhen: (previous, current) => previous.props != current.props,
      builder: (context, state) {
        if (state is LoadedSeller) {
          Seller seller = state.seller;
          List<Product> products = seller.products;

          return Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(
                seller.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: AvatarImage(
                    imageUrl: seller.imageUrl,
                    isSeller: true,
                  ),
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<SellerBloc>().add(LoadSeller(id: seller.id));
                context.read<CategoryBloc>().add(LoadCategories());
              },
              color: kPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${products.length} Products",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context
                                .read<SellerBloc>()
                                .add(LoadSeller(id: seller.id));
                            context.read<CategoryBloc>().add(LoadCategories());
                          },
                          icon: const Icon(
                            Icons.refresh,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .6,
                          child: CupertinoSearchTextField(
                            prefixIcon: const Icon(
                              CupertinoIcons.search,
                              size: 16,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            controller: searchController,
                            onChanged: (value) {},
                            onSubmitted: (value) {},
                            autocorrect: true,
                          ),
                        ),
                        BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                            if (state is LoadedCategories) {
                              return selectedCategory != null
                                  ? DropdownButton(
                                      underline: const SizedBox.shrink(),
                                      focusColor: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      value: selectedCategory,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items:
                                          categories.map((Category category) {
                                        return DropdownMenuItem(
                                          value: category,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Text(
                                              category.name,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (Category? newValue) {
                                        setState(() {
                                          selectedCategory = newValue!;
                                        });
                                      },
                                    )
                                  : const Text("No Categories");
                            }

                            return const Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    verticalSpace(
                      height: 15,
                    ),
                    products.isNotEmpty
                        ? Expanded(
                            child: GridView.count(
                              shrinkWrap: true,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                              childAspectRatio: 1.6 / 2,
                              //physics: const NeverScrollableScrollPhysics(),
                              children: List.generate(
                                products.length,
                                (index) => ProductItemShopCard(
                                  product: products[index],
                                ),
                              ),
                            ),
                          )
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 50.0),
                              child: Text(
                                "Your wholesale is Empty",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                Navigator.push(
                  context,
                  ProfileStoreUploadScreen.route(),
                );
              },
              tooltip: 'Add Product',
              child: const Icon(
                Icons.add,
                color: kBlackColor,
              ),
            ),
          );
        }

        return const ScreenViewLoading();
      },
    );
  }
}
