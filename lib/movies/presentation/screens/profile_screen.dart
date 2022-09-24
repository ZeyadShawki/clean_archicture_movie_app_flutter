import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/profile_cubit/my_profile_cubit.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/login_screeen.dart';

import '../../../core/service_loacater/si.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=> si<MyProfileCubit>()..getUserInfo(),
        child: BlocConsumer<MyProfileCubit,MyProfileState>(
          listener: (context,state){
           if(state is SignOutSuccessState) {
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
           }
          },
          builder: (context,state){
            if(state is MyProfileSuccess){
              return Scaffold(
                backgroundColor: Colors.grey.shade900,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body:   SizedBox(
                  width: double.infinity,

                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        Container(

                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 100),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [


                               const SizedBox(height: 60,),
                               Text(state.user.userName,
                               style: const TextStyle(
                                 color: Colors.white,
                                 fontSize: 30,
                                 fontWeight: FontWeight.w500
                               ),
                                 textAlign: TextAlign.center,
                               ),
                              const SizedBox(height: 10,),
                              Text(state.user.email,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),
                                textAlign: TextAlign.center,
                              ),
                         const SizedBox(height: 35,),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                   Column(
                                     children: const [
                                       Text('115',style: TextStyle(
                                         color: Colors.white,
                                         fontSize: 20
                                       ),),
                                       Text('Followers',
                                       style: TextStyle(
                                         color: Colors.grey
                                       ),),

                                     ],
                                   ),
                                  Column(
                                    children: const [
                                      Text('115',style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20
                                      ),),
                                      Text('watched movies',
                                        style: TextStyle(
                                            color: Colors.grey
                                        ),),

                                    ],
                                  ),
                                  Column(
                                    children: const [
                                      Text('115',style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20
                                      ),),
                                      Text('Following',
                                        style: TextStyle(
                                            color: Colors.grey
                                        ),),

                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 20,),
                              InkWell(
                                onTap: (){
                                 context.read<MyProfileCubit>().signOut();
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                   borderRadius: BorderRadius.circular(20),
                                  ),
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: const Text(
                                    'SignOut',
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                         Align(
                           alignment: Alignment.topCenter,
                           child: CircleAvatar(
                            backgroundImage: NetworkImage(state.user.profileImage),
                            radius: 80,
                        ),
                         ),
                      ],
                    ),
                  ),
                ),
              );
            }else
              {
                return Scaffold(
                  backgroundColor: Colors.grey.shade900,
                   body: const Center(child: CircularProgressIndicator(),),
                );
              }
          },
    )
    );

  }
}
