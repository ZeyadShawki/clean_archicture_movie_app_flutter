import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_clean_arch/core/utils/enum_movie_state.dart';
import 'package:movies_app_clean_arch/movies/presentation/controller/search_cubit/search_for_movie_cubit.dart';

import '../../../core/network/api_constants.dart';

class SearchListView extends StatelessWidget {
  const SearchListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<SearchForMovieCubit,SearchForMovieState>
      (builder: (context,state){

      if(state.searchState==RequestState.isLoaded) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(

            height: MediaQuery.of(context).size.height*0.8,

              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context,index) {
                    return   searchItemWidget(
                        posterpath: state.searchList[index]
                            .posterPath.toString(),
                        title: state.searchList[index].title
                            .toString(),
                        rating: state.searchList[index].voteAverage!
                            .toInt(),
                        relesedate: state.searchList[index]
                            .releaseDate.toString());
                  },
                  separatorBuilder: (context,index)=>const SizedBox(height: 20,),
                  itemCount: state.searchList.length),

          ),
        );
      } else {
        return const Center(child: CircularProgressIndicator(),);
      }
    }, listener: (context,state){}
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
              image: NetworkImage(

                ApiConstants().networkimagemaker(posterpath),

              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                style: TextStyle(
                    color: Colors.deepPurpleAccent.shade700,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
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
