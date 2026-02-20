import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Componants/main%20scaffold%20admin/admin_layout.dart';
import 'package:bena_food/Core/Componants/main%20scaffold%20user/user_layout.dart';
import 'package:bena_food/Feature/Admin/Add%20Restaurant/manager/add_restaurant_cubit.dart';
import 'package:bena_food/Feature/Admin/Manage%20Foods/manage/food_cubit.dart';
import 'package:bena_food/Feature/Admin/Orders/manager/admin_order_cubit.dart';
import 'package:bena_food/Feature/Auth/login_page.dart';
import 'package:bena_food/Feature/Auth/manager/auth_cubit.dart';
import 'package:bena_food/Feature/Auth/manager/auth_state.dart';
import 'package:bena_food/Feature/Edit/Edit%20Profile/manager/edit_profile_cubit.dart';
import 'package:bena_food/Feature/Edit/Forgot%20Password/manager/edit_password_cubit.dart';
import 'package:bena_food/Feature/Profile/manager/home_cubit.dart';
import 'package:bena_food/Feature/Profile/manager/home_state.dart';
import 'package:bena_food/Feature/User/Food%20List/manager/user_food_cubit.dart';
import 'package:bena_food/Feature/User/Order/manager/orders_cubit.dart';
import 'package:bena_food/Feature/User/cart/manager/cart_cubit.dart';
import 'package:bena_food/Feature/User/manager/user_home_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (context) => AuthCubit()..checkAuthStatus()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => EditPasswordCubit()),
        BlocProvider(create: (context) => EditProfileCubit()),
        BlocProvider(create: (context) => UserHomeCubit()),
        BlocProvider(create: (context) => AddRestaurantCubit()..getRestaurants()),
        BlocProvider(create: (context) => FoodCubit()),
        BlocProvider(create: (context) => UserFoodCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => AdminOrderCubit()),
        BlocProvider(create: (context) => OrdersCubit()),
      ],
      child: MaterialApp(
        title: 'Bena Food',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthCubit,AuthState>(
            builder: (context,state){
              if(state.authStatus == AuthStatus.authenticated){
                context.read<HomeCubit>().getProfile();
                return BlocBuilder<HomeCubit,HomeState>(
                    builder:(context,homeState) {
                      if (homeState.userModel == null) {
                        return UserLayout();
                      }
                      return homeState.userModel?.userType == 'Admin'
                          ? AdminLayout()
                          : UserLayout();

                    },
                    );
              }
              return state.authStatus == AuthStatus.unauthenticated
                  ? LoginPage()
                  : Scaffold(
                body: Center(child: CircularProgressIndicator(color: AppColors.primary,),),
              );
            }),
      ),
    );
  }
}