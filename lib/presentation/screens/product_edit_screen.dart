import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wholecela/business_logic/category_bloc/category_bloc.dart';
import 'package:wholecela/business_logic/color_bloc/color_bloc.dart';
import 'package:wholecela/business_logic/seller/seller_bloc.dart';
import 'package:wholecela/business_logic/store_product/store_product_bloc.dart';
import 'package:wholecela/business_logic/user_bloc/user_bloc.dart';
import 'package:wholecela/core/extensions/price_formatter.dart';
import 'package:wholecela/core/extensions/to_hex_color.dart';
import 'package:wholecela/data/models/category.dart';
import 'package:wholecela/data/models/color.dart';
import 'package:wholecela/data/models/seller.dart';
import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/data/models/product.dart';
import 'package:wholecela/presentation/screens/profile_screen.dart';
import 'package:wholecela/presentation/utils/dialogs/product_add_colors_dialog.dart';
import 'package:wholecela/presentation/utils/loaders/screen_loading.dart';
import 'package:wholecela/presentation/widgets/avatar_image.dart';

class ProductEditScreen extends StatefulWidget {
  final String productId;
  static Route route({required String productId}) {
    return MaterialPageRoute(
      builder: (context) => ProductEditScreen(
        productId: productId,
      ),
    );
  }

  const ProductEditScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  late User loggedUser;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future<XFile?> getImage(ImageSource media) async {
    return await picker.pickImage(source: media);
  }

  late List<ColorModel> colors;

  final _titleFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  bool isEditTitleField = false;

  final _descriptionFormKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  bool isEditDescriptionField = false;

  final _priceFormKey = GlobalKey<FormState>();
  TextEditingController priceController = TextEditingController();
  bool isEditPriceField = false;

  final _stockFormKey = GlobalKey<FormState>();
  TextEditingController stockController = TextEditingController();
  bool isEditStockField = false;

  late Category? selectedCategory;
  late List<Category> categories;

  List<String> _selectedColors = [];

  void showMultiSelect() async {
    final List<ColorModel>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<ColorBloc, ColorState>(
          builder: (context, state) {
            if (state is LoadedColors) {
              final colors = state.colors;
              return ProductColorsMultiSelectFormDialog(colors: colors);
            }

            if (state is ColorStateLoading) {
              return const AlertDialog(
                title: Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                ),
              );
            }

            if (state is ColorStateError) {
              return AlertDialog(
                title: Center(
                  child: Text(state.message!.message!),
                ),
              );
            }

            return AlertDialog(
              title: const Center(child: Text("Product Colors")),
              content: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<ColorBloc>().add(LoadColors());
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(10.0),
                  ),
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                child: const Text("Load Colors"),
              ),
            );
          },
        );
      },
    );

    if (results != null) {
      setState(() {
        _selectedColors = results.map((e) => e.id).toList();
      });

      if (_selectedColors.isNotEmpty) {
        context.read<StoreProductBloc>().add(StoreProductUpdateColors(
              productId: widget.productId,
              colors: _selectedColors,
            ));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    context
        .read<StoreProductBloc>()
        .add(LoadStoreProduct(id: widget.productId));
    loggedUser = context.read<UserBloc>().state.user!;
    colors = context.read<ColorBloc>().state.colors!;

    categories = context.read<CategoryBloc>().state.categories!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerBloc, SellerState>(
      builder: (context, state) {
        if (state is LoadedSeller) {
          Seller seller = state.seller;

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
                  onPressed: () {
                    Navigator.push(
                      context,
                      ProfileScreen.route(),
                    );
                  },
                  icon: AvatarImage(
                    imageUrl: seller.imageUrl,
                    isSeller: true,
                  ),
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                context
                    .read<StoreProductBloc>()
                    .add(LoadStoreProduct(id: widget.productId));
              },
              color: kPrimaryColor,
              child: BlocConsumer<StoreProductBloc, StoreProductState>(
                listener: (context, state) {
                  if (state is LoadedStoreProduct) {
                    final product = state.product;
                    titleController.text = product.title;
                    descriptionController.text =
                        product.description == null ? "" : product.description!;
                    priceController.text = product.price.toString();
                    stockController.text = product.quantity.toString();
                  }
                },
                builder: (context, state) {
                  if (state is LoadedStoreProduct) {
                    Product product = state.product;
                    selectedCategory = categories.firstWhere(
                        (category) => category.id == product.categoryId);
                    List<ColorModel> productColors = product.colors;

                    return ListView(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 350,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                image: product.imageUrl != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            "${AppUrls.SERVER_URL}/${product.imageUrl}"),
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage(
                                            "assets/images/product.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                onPressed: () async {
                                  XFile? image =
                                      await getImage(ImageSource.gallery);
                                  if (image != null) {
                                    context.read<StoreProductBloc>().add(
                                          StoreProductUpdateImage(
                                            product: product.copyWith(
                                              imageUrl: image.path,
                                            ),
                                          ),
                                        );
                                  }
                                },
                                icon: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: kWhiteColor,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(height: 15),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    product.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  horizontalSpace(width: 15),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isEditTitleField = !isEditTitleField;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                              isEditTitleField
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: EditDetailsForm(
                                        label: "Product Title",
                                        formKey: _titleFormKey,
                                        controller: titleController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Product Title is required';
                                          }
                                          return null;
                                        },
                                        onPressed: () {
                                          if (_titleFormKey.currentState!
                                              .validate()) {
                                            context
                                                .read<StoreProductBloc>()
                                                .add(
                                                  StoreProductUpdateDetails(
                                                    product: product.copyWith(
                                                      title: titleController
                                                          .text
                                                          .trim(),
                                                    ),
                                                  ),
                                                );
                                          }
                                        },
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              verticalSpace(height: 15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    product.description != null
                                        ? product.description!
                                        : "No description",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  horizontalSpace(width: 15),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isEditDescriptionField =
                                            !isEditDescriptionField;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                              isEditDescriptionField
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: EditDetailsForm(
                                        label: "Product Description",
                                        formKey: _descriptionFormKey,
                                        controller: descriptionController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Product Description is required';
                                          }
                                          return null;
                                        },
                                        onPressed: () {
                                          if (_descriptionFormKey.currentState!
                                              .validate()) {
                                            context
                                                .read<StoreProductBloc>()
                                                .add(
                                                  StoreProductUpdateDetails(
                                                    product: product.copyWith(
                                                      description:
                                                          descriptionController
                                                              .text
                                                              .trim(),
                                                    ),
                                                  ),
                                                );
                                          }
                                        },
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              verticalSpace(height: 15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    formatPrice(product.price),
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  horizontalSpace(width: 15),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isEditPriceField = !isEditPriceField;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                              isEditPriceField
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: EditDetailsForm(
                                        label: "Product Price",
                                        formKey: _priceFormKey,
                                        controller: priceController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Product price is required';
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
                                        onPressed: () {
                                          if (_priceFormKey.currentState!
                                              .validate()) {
                                            context
                                                .read<StoreProductBloc>()
                                                .add(
                                                  StoreProductUpdateDetails(
                                                    product: product.copyWith(
                                                      price: double.parse(
                                                          priceController.text
                                                              .trim()),
                                                    ),
                                                  ),
                                                );
                                          }
                                        },
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              verticalSpace(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                underline:
                                                    const SizedBox.shrink(),
                                                focusColor: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                value: selectedCategory,
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                items: categories
                                                    .map((Category category) {
                                                  return DropdownMenuItem(
                                                    value: category,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0),
                                                      child: Text(
                                                        category.name,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged:
                                                    (Category? newValue) {
                                                  context
                                                      .read<StoreProductBloc>()
                                                      .add(
                                                        StoreProductUpdateDetails(
                                                          product:
                                                              product.copyWith(
                                                            categoryId:
                                                                newValue!.id,
                                                          ),
                                                        ),
                                                      );
                                                  setState(() {
                                                    selectedCategory = newValue;
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
                              verticalSpace(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Product Colors: ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      horizontalSpace(),
                                      productColors.isNotEmpty
                                          ? Row(
                                              children: List.generate(
                                                productColors.length,
                                                (index) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: SizedBox(
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          HexColor.fromHex(
                                                        productColors[index]
                                                            .hexCode,
                                                      ),
                                                      radius: 8,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const Text(
                                              "No Colors",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: showMultiSelect,
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(
                                height: 15,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.greenAccent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      "${product.quantity} left in stock",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  horizontalSpace(width: 15),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isEditStockField = !isEditStockField;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                              isEditStockField
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: EditDetailsForm(
                                        label: "Product Quantity",
                                        formKey: _stockFormKey,
                                        controller: stockController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Product Quantity is required';
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
                                        onPressed: () {
                                          if (_stockFormKey.currentState!
                                              .validate()) {
                                            context
                                                .read<StoreProductBloc>()
                                                .add(
                                                  StoreProductUpdateDetails(
                                                    product: product.copyWith(
                                                      quantity: int.parse(
                                                          stockController.text
                                                              .trim()),
                                                    ),
                                                  ),
                                                );
                                          }
                                        },
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              verticalSpace(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            floatingActionButton:
                BlocBuilder<StoreProductBloc, StoreProductState>(
              builder: (context, state) {
                if (state is StoreProductStateLoading) {
                  return const FloatingActionButton(
                    shape: CircleBorder(),
                    onPressed: null,
                    tooltip: 'Deleting',
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                  );
                }

                return FloatingActionButton(
                  shape: const CircleBorder(),
                  onPressed: () {},
                  tooltip: 'Delete',
                  child: const Icon(
                    Icons.delete,
                    color: kWarningColor,
                  ),
                );
              },
            ),
          );
        }

        return const ScreenViewLoading();
      },
    );
  }
}

class EditDetailsForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final void Function() onPressed;
  const EditDetailsForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.label,
    required this.validator,
    required this.onPressed,
  });

  @override
  State<EditDetailsForm> createState() => _EditDetailsFormState();
}

class _EditDetailsFormState extends State<EditDetailsForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            decoration: InputDecoration(
              label: Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          verticalSpace(height: 15),
          BlocConsumer<StoreProductBloc, StoreProductState>(
            listener: (context, state) {
              if (state is StoreProductStateError) {
                print(state.message);
              }
            },
            builder: (context, state) {
              if (state is StoreProductStateLoading) {
                return Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: widget.onPressed,
                      child: const Text(
                        "Save Changes",
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
