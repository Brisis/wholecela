import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholecela/business_logic/auth_bloc/authentication_bloc.dart';
import 'package:wholecela/business_logic/location_bloc/location_bloc.dart';
import 'package:wholecela/business_logic/user_bloc/user_bloc.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/data/models/location.dart';
import 'package:wholecela/data/models/user.dart';
import 'package:wholecela/presentation/screens/auth/reset_screen.dart';
import 'package:wholecela/presentation/widgets/avatar_image.dart';
import 'package:wholecela/presentation/widgets/menu_drawer.dart';

class ProfileScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const ProfileScreen(),
    );
  }

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  final _phoneFormKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  final _streetFormKey = GlobalKey<FormState>();
  TextEditingController streetController = TextEditingController();

  // final _latlngFormKey = GlobalKey<FormState>();
  // TextEditingController latlngController = TextEditingController();

  late User loggedUser;

  late Location selectedLocation;
  late List<Location> locations;

  @override
  void initState() {
    super.initState();
    loggedUser = context.read<UserBloc>().state.user!;
    locations = context.read<LocationBloc>().state.locations!;
    selectedLocation = locations.first;
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = loggedUser.name;
    phoneController.text = loggedUser.phone == null ? "" : loggedUser.phone!;
    streetController.text = loggedUser.street == null ? "" : loggedUser.street!;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadedUser) {
          setState(() {
            loggedUser = state.user;
          });

          if (loggedUser.locationId != null) {
            setState(() {
              selectedLocation = locations.firstWhere(
                  (location) => location.id == loggedUser.locationId);
            });
          }
        }

        if (state is UserStateError) {
          print(state.message);
        }
      },
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        drawer: MenuDrawer(
          user: loggedUser.copyWith(),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            "My Profile",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   ProfileScreen.route(),
                // );
              },
              icon: AvatarImage(
                imageUrl: loggedUser.imageUrl,
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<LocationBloc>().add(LoadLocations());
          },
          color: kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                const Text(
                  "Account Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                verticalSpace(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/images/user.jpg",
                      ),
                    ),
                    horizontalSpace(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                verticalSpace(),
                EditUserForm(
                  label: "Name",
                  formKey: _nameFormKey,
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  onPressed: () {
                    if (_nameFormKey.currentState!.validate()) {
                      context.read<UserBloc>().add(
                            UserEventUpdateDetails(
                              user: loggedUser.copyWith(
                                name: nameController.text,
                              ),
                            ),
                          );
                    }
                  },
                ),
                verticalSpace(),
                EditUserForm(
                  label: "Phone",
                  formKey: _phoneFormKey,
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone is required';
                    }
                    return null;
                  },
                  onPressed: () {
                    if (_phoneFormKey.currentState!.validate()) {
                      context.read<UserBloc>().add(
                            UserEventUpdateDetails(
                              user: loggedUser.copyWith(
                                phone: phoneController.text,
                              ),
                            ),
                          );
                    }
                  },
                ),
                verticalSpace(),
                EditUserForm(
                  label: "Street Address",
                  formKey: _streetFormKey,
                  controller: streetController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Street address is required';
                    }
                    return null;
                  },
                  onPressed: () {
                    if (_streetFormKey.currentState!.validate()) {
                      context.read<UserBloc>().add(
                            UserEventUpdateDetails(
                              user: loggedUser.copyWith(
                                street: streetController.text,
                              ),
                            ),
                          );
                    }
                  },
                ),
                verticalSpace(),
                // EditUserForm(
                //   label: "LatLng (lat,lng)",
                //   formKey: _latlngFormKey,
                //   controller: latlngController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'LatLng is required';
                //     }

                //     return null;
                //   },
                //   onPressed: () {
                //     if (_latlngFormKey.currentState!.validate()) {
                //       context.read<UserBloc>().add(
                //             UserEventUpdateDetails(
                //               user: loggedUser.copyWith(
                //                 latlng: latlngController.text,
                //               ),
                //             ),
                //           );
                //     }
                //   },
                // ),
                //verticalSpace(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Location: ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    BlocBuilder<LocationBloc, LocationState>(
                      builder: (context, state) {
                        if (state is LoadedLocations) {
                          return DropdownButton(
                            underline: const SizedBox.shrink(),
                            focusColor: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            value: selectedLocation,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: locations.map((Location location) {
                              return DropdownMenuItem(
                                value: location,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    location.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (Location? newValue) {
                              setState(() {
                                selectedLocation = newValue!;
                              });
                            },
                          );
                        }

                        return const Text("No locations");
                      },
                    ),
                  ],
                ),
                verticalSpace(height: 15),
                const Text(
                  "Login Security",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                verticalSpace(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "********",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    horizontalSpace(),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          ResetScreen.route(),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 16,
                      ),
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
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<AuthenticationBloc>()
                              .add(AuthenticationEventLogoutUser());
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   LoginScreen.route(),
                          //   ((Route<dynamic> route) => false),
                          // );
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(color: kWarningColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditUserForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final void Function() onPressed;
  const EditUserForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.label,
    required this.validator,
    required this.onPressed,
  });

  @override
  State<EditUserForm> createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {
  bool isEditField = false;
  @override
  Widget build(BuildContext context) {
    //bool isEditing = widget.isEditName;
    return editForm();
  }

  Form editForm() {
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
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isEditField = !isEditField;
                  });
                },
                icon: const Icon(
                  Icons.edit,
                  size: 18,
                ),
              ),
            ),
          ),
          verticalSpace(height: 15),
          isEditField
              ? BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is LoadedUser) {
                      setState(() {
                        isEditField = !isEditField;
                      });
                    }

                    if (state is UserStateError) {
                      print(state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is UserStateLoading) {
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
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
