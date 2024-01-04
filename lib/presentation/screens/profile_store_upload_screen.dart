import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/category_bloc/category_bloc.dart';
import 'package:wholecela/business_logic/location_bloc/location_bloc.dart';
import 'package:wholecela/business_logic/store_product/store_product_bloc.dart';
import 'package:wholecela/business_logic/user_bloc/user_bloc.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/data/models/category.dart';
import 'package:wholecela/data/models/user.dart';

class ProfileStoreUploadScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const ProfileStoreUploadScreen(),
    );
  }

  const ProfileStoreUploadScreen({super.key});

  @override
  State<ProfileStoreUploadScreen> createState() =>
      _ProfileStoreUploadScreenState();
}

class _ProfileStoreUploadScreenState extends State<ProfileStoreUploadScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();

  TextEditingController quantityController = TextEditingController();

  TextEditingController priceController = TextEditingController();

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
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoreProductBloc, StoreProductState>(
      listener: (context, state) {
        if (state is StoreProductStateAdded) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            "Create Product",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<LocationBloc>().add(LoadLocations());
          },
          color: kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const Text(
                    "Product Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  verticalSpace(),
                  TextFormField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text(
                        "Title",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(),
                  TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Quantity is required';
                      }
                      if (int.tryParse(value) == null) {
                        return 'A valid number is required';
                      }
                      if (int.tryParse(value) != null) {
                        if (int.tryParse(value)! < 1) {
                          return 'A valid number is required';
                        }
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text(
                        "Quantity",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Price is required';
                      }
                      if (double.tryParse(value) == null) {
                        return 'A valid price is required';
                      }
                      if (double.tryParse(value) != null) {
                        if (double.tryParse(value)! <= 0) {
                          return 'A valid price is required';
                        }
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text(
                        "Price (USD)",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Product Category: ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: categories.map((Category category) {
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
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: BlocBuilder<StoreProductBloc, StoreProductState>(
                          builder: (context, state) {
                            if (state is StoreProductStateLoading) {
                              return ElevatedButton(
                                onPressed: () {},
                                child: const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            }
                            return ElevatedButton(
                              onPressed: () {
                                if (selectedCategory != null) {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<StoreProductBloc>().add(
                                          AddStoreProduct(
                                            title: titleController.text.trim(),
                                            quantity: int.parse(
                                                quantityController.text.trim()),
                                            price: double.parse(
                                                priceController.text.trim()),
                                            categoryId: selectedCategory!.id,
                                            ownerId: loggedUser.id,
                                          ),
                                        );
                                  }
                                }
                              },
                              child: const Text(
                                "Submit",
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
