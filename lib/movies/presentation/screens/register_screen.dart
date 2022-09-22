import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_clean_arch/core/utils/enum_movie_state.dart';
import 'package:movies_app_clean_arch/movies/data/models/user_model.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/register_cubit/register_cubit.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/register_cubit/register_state.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/movie_screen.dart';
import '../../../core/service_loacater/si.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController usernameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return   BlocProvider(create: (context)=>si<RegisterCubit>(),
        child: BlocConsumer<RegisterCubit,RegisterInitial>(
      listener: (context,state){
            if(state.registerstate==RequestState.isLoaded) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeMovieScreen()));
            }
      },
      builder: (context,state){
        return Stack(
          children: [

            Container(
              decoration:  BoxDecoration(
                  color: Colors.grey,

                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(Colors.grey.shade500, BlendMode.darken),
                      fit: BoxFit.cover,
                      image: const NetworkImage(
                          'https://wallpaperaccess.com/full/752715.jpg'
                      )
                  )
              ),
            ),
            Scaffold(
              resizeToAvoidBottomInset: true,

              backgroundColor: Colors.transparent,
              body:     SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,

                  child:  Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),

                          InkWell(
                            onTap: (){
                           context.read<RegisterCubit>().pickAndUploadImage();
                            },
                            child: Stack(
                              children: [

                                Center(
                                  child: CircleAvatar(
                                   radius: 70,
                                   backgroundColor: Colors.white,
                                   backgroundImage:
                                   context.read<RegisterCubit>().image==null
                                  ? const NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Breezeicons-actions-22-im-user.svg/1200px-Breezeicons-actions-22-im-user.svg.png'):
                                       FileImage(context.read<RegisterCubit>().image as File) as ImageProvider,
                         ),
                                ),
                                  const Positioned
                                    (
                                      left: 70,
                                      right: 10,
                                      bottom: 0,
                                      child: Icon(Icons.add,size: 50,color: Colors.grey,)),

                              ],
                            ),
                          ),
                        const SizedBox(height: 10,),
                        const Text('Add your Profile Image',style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                        ),),
                        const SizedBox(height: 30,),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.6,
                          width: double.infinity,
                          child: Card(

                            color:Colors.black87.withOpacity(0.8),
                            shape:const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                            ),
                            child:  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14.0),
                              child: SingleChildScrollView(
                                child:  SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 30,),
                                      TextFormField(
                                        controller: usernameController,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                        validator: (value){
                                          if(value!.isEmpty) {
                                            return 'Please enter valid username';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            focusedErrorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey
                                              ),),
                                            errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                )
                                            ),
                                            border: InputBorder.none,
                                            hintText: 'User Name',
                                            prefixIcon: Icon(Icons.person,color: Colors.grey,),
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold
                                            ),
                                            enabledBorder: UnderlineInputBorder(

                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                )
                                            ),

                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,

                                                )
                                            )
                                        ),

                                      ),
                                      const SizedBox(height: 20,),
                                      TextFormField(

                                        validator: (value){
                                          if(value!.isEmpty||!value.endsWith('.com')) {
                                            return 'Please enter valid email';
                                          }
                                          return null;
                                        },
                                        controller: emailController,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),

                                        decoration: const InputDecoration(

                                            border: InputBorder.none,
                                            hintText: 'Email',
                                            prefixIcon: Icon(Icons.email,color: Colors.grey,),
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold
                                            ),

                                            errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey
                                              ),

                                            ),
                                            focusedErrorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey
                                              ),),
                                            enabledBorder: UnderlineInputBorder(

                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                )
                                            ),

                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,

                                                )
                                            )
                                        ),

                                      ),
                                      const SizedBox(height: 20,),
                                      TextFormField(
                                        controller: passwordController,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                        validator: (value){
                                          if(value!.isEmpty||value.length<=7) {
                                            return 'Please enter valid password more than 8 characters';
                                          }
                                          return null;
                                        },
                                        obscureText: context.read<RegisterCubit>().passwordIsHidden,
                                        decoration:  InputDecoration(
                                            focusedErrorBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey
                                              ),),
                                            errorBorder: const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                )
                                            ),
                                            border: InputBorder.none,
                                            hintText: 'Password',
                                            prefixIcon: const Icon(Icons.lock_outline_rounded,color: Colors.grey,),
                                            suffix: IconButton(
                                              onPressed: ()=>context.read<RegisterCubit>().isPasswordHidden(),
                                             icon:  Icon(context.read<RegisterCubit>().suffixIcon,color: Colors.grey,) ),
                                            hintStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold
                                            ),
                                            enabledBorder: const UnderlineInputBorder(

                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                )
                                            ),

                                            focusedBorder: const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,

                                                )
                                            )
                                        ),

                                      ),
                                      const SizedBox(height: 20,),
                                      TextFormField(
                                        controller: phoneController,
                                        keyboardType: TextInputType.phone,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                        validator: (value){
                                          if(value!.isEmpty||value.length<=7) {
                                            return 'Please enter valid phone number';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            focusedErrorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey
                                              ),),
                                            errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                )
                                            ),
                                            border: InputBorder.none,
                                            hintText: 'Phone number',
                                            prefixIcon: Icon(Icons.phone_android,color: Colors.grey,),
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold
                                            ),
                                            enabledBorder: UnderlineInputBorder(

                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                )
                                            ),

                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,

                                                )
                                            )
                                        ),

                                      ),

                                     const SizedBox(height: 20,),

                                      InkWell(
                                        onTap: (){
                                          if(_formkey.currentState!.validate()) {
                                           context.read<RegisterCubit>().
                                           register(UserModel(
                                               userName: usernameController.text,
                                               email: emailController.text,
                                               password: passwordController.text,
                                               phone: phoneController.text,
                                               profileImage:
                                               context.read<RegisterCubit>().url==''?
                                               'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Breezeicons-actions-22-im-user.svg/1200px-Breezeicons-actions-22-im-user.svg.png'
                                                   :context.read<RegisterCubit>().url
                                            ));
                                          }


                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 12),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.circular(30)
                                          ),
                                          child: const Text(
                                            'Register',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      const Text('OR With',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.white,
                                            backgroundImage:  NetworkImage(
                                                'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png'
                                            ),

                                          ),
                                          SizedBox(width: 15,),
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.white,
                                            backgroundImage:  NetworkImage(
                                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZsdQ3Zv0zHlt1f1kRVkKg7GlQ0Z9qXkx6muCvfrw&s'
                                            ),

                                          )
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        );
      },
      ),
    );
  }
}
