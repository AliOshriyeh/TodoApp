class SupabaseAPI {
  static const SUPABASE_URL = "https://crkgqwaxiyyaglnwtjxq.supabase.co";
  static const SUPABASE_PUB_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNya2dxd2F4aXl5YWdsbnd0anhxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYzNDg5ODYsImV4cCI6MjA2MTkyNDk4Nn0.MYztZHFU18YbsOuYJd5kIh6AW37gC1QqXxkpd8NIv_8";
}
//   final _supabase = Supabase.instance.client;

//   // Future getAllRawRecipe() async {
//   //   debugPrint(printSignifier + "Initializing Supabase Fetch #Recipes");
//   //   try {
//   //     final query = await Supabase.instance.client.from('Recipes').select().order('recipeId', ascending: true);
//   //     return query;
//   //   } on PostgrestException catch (error) {
//   //     //TODO - Make A Toast For it
//   //     debugPrint('Request failed with status: ${error.code}');
//   //     // return error;
//   //     rethrow;
//   //   } on ClientException catch (e) {
//   //     debugPrint('Request failed: ${e.message}');
//   //     // return error;
//   //     rethrow;
//   //   }
//   // }

//   // Future getAllRawIngredient() async {
//   //   debugPrint(printSignifier + "Initializing Supabase Fetch #Ingredients");
//   //   try {
//   //     final query = await Supabase.instance.client.from('Ingredients').select();
//   //     return query;
//   //   } on PostgrestException catch (error) {
//   //     //TODO - Make A Toast For it
//   //     debugPrint('Request failed with status: ${error.code}');
//   //     // return error;
//   //     rethrow;
//   //   } on ClientException catch (e) {
//   //     debugPrint('Request failed: ${e.message}');
//   //     // return error;
//   //     rethrow;
//   //   }
//   // }

//   // Future addNewRawRecipe(Recipe recipeItem) async {
//   //   debugPrint(printSignifier + "Initializing Supabase Upload #Recipes");
//   //   try {
//   //     // var newId = (await getAllRawRecipe()).last['recipeId'];
//   //     var newRecipe = await Supabase.instance.client.from('Recipes').insert({
//   //       // 'recipeId': newId,
//   //       'recipeName': recipeItem.name,
//   //       'recipeCategory': recipeItem.category,
//   //       'recipeOrigin': recipeItem.origin,
//   //       'recipeInstructions': recipeItem.instructions,
//   //       'recipeThumb': recipeItem.thumbnail,
//   //       'strIngredients': recipeItem.ingredients,
//   //       'strMeasures': recipeItem.measures,
//   //       "modified_at": DateTime.timestamp().toString(),
//   //       "recipeConfirmation": recipeItem.authorization,
//   //     }).select();
//   //     return newRecipe;
//   //   } on PostgrestException catch (error) {
//   //     //TODO - Make A Toast For it
//   //     debugPrint('Request failed with status: ${error.code}');
//   //     return error;
//   //   } on ClientException catch (error) {
//   //     debugPrint('Request failed: ${error.message}');
//   //     return error;
//   //   }
//   // }

//   Future userLoginByEmail(String email, String pass) async {
//     debugPrint(printSignifier + "Initializing Supabase Login #Email");
//     final AuthResponse response = await _supabase.auth.signInWithPassword(email: email, password: pass);
//     return response.user;
//   }

//   Future userSignUpByEmail(String email, String pass, String phone) async {
//     try {
//       final AuthResponse response = await _supabase.auth.signUp(email: email, /*phone: phone,*/ password: pass, channel: OtpChannel.sms);
//       return response;
//     } on AuthException catch (error) {
//       debugPrint('Request failed: ${error.message}');
//       //FIXME - Make a better notification
//       return error;
//     } on ClientException catch (error) {
//       debugPrint('Request failed: ${error.message}');
//       return error;
//     } catch (error) {
//       debugPrint(error.toString());
//       return error;
//     }

//     // print('RESPONSE $res');
//     // final Session? session = res.session;
//     // print('SESSion $session');
//     // final User? user = res.user;
//     // print('USER $user');
//   }

//   Future userLogout() async {
//     debugPrint(printSignifier + "Initializing Supabase Log Out");
//     final response = await _supabase.auth.signOut();
//     // final response = await _supabase.dispose();
//     return response;
//   }
// }
