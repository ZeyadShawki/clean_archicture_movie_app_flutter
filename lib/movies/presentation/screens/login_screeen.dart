
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: unused_import
import 'package:movies_app_clean_arch/core/utils/enum_movie_state.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/login_cubit/login_cubit.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/movie_screen.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/register_screen.dart';

import '../../../core/service_loacater/si.dart';



// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
 final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
  create: (context) => si<LoginCubit>(),

  child: BlocConsumer<LoginCubit,LoginState>(
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
            SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body:     SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,

                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 70,),


                          const SizedBox(height: 35,),
                            const Spacer(),
                          SizedBox(
                             height: MediaQuery.of(context).size.height*0.6,
                            width: double.infinity,
                            child: Card(

                              color:Colors.black87.withOpacity(0.8),
                              shape:const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 40,),
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
                                          hintText: 'Email / Username',
                                          prefixIcon: Icon(Icons.person,color: Colors.grey,),
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
                                      obscureText: context.read<LoginCubit>().passwordIsHidden,
                                      controller: passwordController,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),
                                      validator: (value){
                                        if(value!.isEmpty||value.length<=8) {
                                          return 'Please enter valid password more than 8 characters';
                                        }
                                        return null;
                                      },
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
                                          suffix: IconButton
                                            (onPressed: ()=> context.read<LoginCubit>().isPasswordHidden(),
                                              icon: Icon( context.read<LoginCubit>().suffixIcon,color: Colors.grey,)),
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
                                    const SizedBox(height: 50,),
                                    InkWell(
                                      onTap: (){
                                        if(_formkey.currentState!.validate()) {
                                          context.read<LoginCubit>().login(emailController.text, passwordController.text);
                                        }


                                        },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 12),
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(30)
                                        ),
                                        child: const Text(
                                          'Login',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    const Text('OR',
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
                                    TextButton(onPressed: (){},
                                        child: const Text(
                                          'Forgot your Password',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),
                                        )),
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Don\'t Have an account?',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),
                                        ),
                                       const SizedBox(width: 5,),
                                         InkWell(
                                           onTap: (){
                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterScreen()));
                                           },
                                           child: const Text(
                                            'Register Now',
                                            style: TextStyle(
                                                color: Colors.blue
                                            ),
                                        ),
                                         )
                                      ],
                                    ),

                                  ],
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
            ),

          ],
        );
      },
      listener: (context,state)
  {
    if(state is LoginSuccessState) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeMovieScreen()));
    }
  })
);
  }
}
