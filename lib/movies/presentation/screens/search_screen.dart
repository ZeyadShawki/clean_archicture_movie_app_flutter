import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_clean_arch/core/network/api_constants.dart';
import 'package:movies_app_clean_arch/core/utils/app_colors.dart';
import 'package:movies_app_clean_arch/core/utils/enum_movie_state.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/search_cubit/search_for_movie_cubit.dart';
import 'package:movies_app_clean_arch/movies/presentation/screens/movie_details_screen.dart';

import '../../../core/service_loacater/si.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchForMovieCubit>(
      create: (context) {
       return si<SearchForMovieCubit>();
      },

      child:   BlocConsumer<SearchForMovieCubit, SearchForMovieState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Scaffold(

    appBar: AppBar(

       backgroundColor: Colors.transparent,
       actions:[
         Icon(Icons.movie_creation_outlined,color: AppColors.primarytextfieldpurplecolor,size: 30,),
         const SizedBox(width: 10,),

       ],
       leading: IconButton(
         onPressed: (){
           Navigator.pop(context);
         },
         icon: const Icon(
           Icons.arrow_back_ios_new_outlined
         ),
       ),
       elevation: 0,
       centerTitle: true,
       title: Text('Search',style: TextStyle(
         color: AppColors.primarytextfieldpurplecolor,
         fontSize: 25
       ),),
     ),
    backgroundColor: Colors.grey.withOpacity(0.2),
    resizeToAvoidBottomInset: false,

    body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key:_formkey,
        child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,

        decoration: BoxDecoration(

        color: Colors.blueAccent.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30)
        ),
        child: TextFormField(

        style: const TextStyle(
        color: Colors.white,
        ),
        validator: (value){
          // ignore: unnecessary_null_comparison
          if(value!.isEmpty&&value!=null) {
            return 'Please type the movie name';
          } else {
            return null;
          }
        },
        controller: _searchController,
        onChanged: (String value) {
           if(_formkey.currentState!.validate()) {
             context.read<SearchForMovieCubit>().searchForMovie(_searchController.text);
           }
        },

      decoration:InputDecoration(
      prefixIcon: const Icon(Icons.search,color: Colors.white,),
      hintText: 'Search for movie',

      hintStyle: const TextStyle(
      color: Colors.white
      ),

   focusedErrorBorder: const OutlineInputBorder(

       borderSide: BorderSide(
       style: BorderStyle.none,
       )
   ),
      focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(30)
      ),
      enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(30,),
      )

      ),

      ),
      ),
          if(state.searchState==RequestState.isLoaded&&_searchController.text!='')...[
            const SizedBox(height: 20,),
            Text('Search Result (${state.searchList.length})',style: TextStyle(
              fontSize: 20,
              color: AppColors.primarytextfieldpurplecolor
            ),
            textAlign: TextAlign.start,),
         SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height*0.7,
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index) {
                  return   InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          MovieDetailsScreen(id: state.searchList[index].id!.toInt(),)));
                    },
                    child: searchItemWidget(
                        posterpath: state.searchList[index]
                            .posterPath.toString()==''?
                        'https://img.freepik.com/free-vector/internet-network-warning-404-error-page-file-found-web-page-internet-error-page-issue-found-network-404-error-present-by-man-sleep-display_1150-55450.jpg?w=740&t=st=1663006046~exp=1663006646~hmac=d14191cc254ee49be9fe5a83ede0836c3e8085c67d04be6746f0d1977ce085bb'
                            : state.searchList[index]
                            .posterPath.toString(),
                        title: state.searchList[index].title
                            .toString(),
                        rating: state.searchList[index].voteAverage!
                            .toInt(),
                        relesedate:  state.searchList[index]
                            .releaseDate.toString()),
                  );
                },
                separatorBuilder: (context,index)=>const SizedBox(height: 20,),
                itemCount: state.searchList.length),
          ),
        ),]
         else if(_searchController.text=='')
           SizedBox(
               height: MediaQuery.of(context).size.height*0.8,
               child:  Center(child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: const [
                   Icon((Icons.movie_creation_outlined),size: 100,color: Colors.white,),
                   Text('Start Search',style: TextStyle(
                     color: Colors.white
                   ),)
                 ],
               ),))
          else if(state.searchState==RequestState.isLoading)
            SizedBox(
                height: MediaQuery.of(context).size.height*0.8,
                child: const Center(child: CircularProgressIndicator()))

      ],
      ),
      ),
      ),
    ),
    );
  },
),
    );
  }

  Widget searchItemWidget(
      {required String posterpath,required  String title,required int rating,required String relesedate}){
    return Row(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:  Image(
              height: 130,
              width: 100,
              fit: BoxFit.cover,
              image: NetworkImage(

            ApiConstants().networkimagemaker(posterpath)==
                'https://image.tmdb.org/t/p/w500null'?
            'https://img.freepik.com/free-vector/internet-network-warning-404-error-page-file-found-web-page-internet-error-page-issue-found-network-404-error-present-by-man-sleep-display_1150-55450.jpg?w=740&t=st=1663006046~exp=1663006646~hmac=d14191cc254ee49be9fe5a83ede0836c3e8085c67d04be6746f0d1977ce085bb'
                :ApiConstants().networkimagemaker(posterpath),

          )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: Text(title,
                  style: TextStyle(
                    color: AppColors.primarytextfieldpurplecolor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
               const SizedBox(height: 10,),
              Text('Rating $rating',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                  ),
                textAlign: TextAlign.start,
                ),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Text(relesedate.split('-').first,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

            ],
          ),
        ),

      ],
    );
  }

}
