// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  GestureTapCallback? onTap,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,

}) => TextFormField(
  controller: controller,
  keyboardType: type,
  validator: validate,
  onTap : onTap,
  onFieldSubmitted: (s){
    onSubmit!(s);
  },
  onChanged: (s){
    onChange!(s);
  },
  obscureText: isPassword ,
  decoration: InputDecoration(
    labelText: label,
    enabled: isClickable,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: Icon(
      suffix,
    ),

    /*suffix != null ?
  IconButton(
    onPressed:suffixPressed,
      icon: Icon(suffix),
  ) : null,*/
    border: const OutlineInputBorder(),

  ),
);

Widget buildArticleItem(article, context) => InkWell(
  onTap: ()
  {
    navigaTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          width: 120.0,
  
          height: 120.0,
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(10.0),
  
            image: DecorationImage(image: NetworkImage('${article['urlToImage']}'),
  
              //image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png'),
  
              fit: BoxFit.cover,
  
            ),
  
          ),
  
        ),
  
        const SizedBox(
  
          width: 20.0,
  
        ),
  
        Expanded(
  
          child: Container(
  
            height: 120.0,
  
            child: Column(
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              children: [
  
                Expanded(
  
                  child: Text(
  
                     '${article['title']}',
  
                    //'title',
  
                    maxLines: 3,
  
                    overflow: TextOverflow.ellipsis,
  
                    style: Theme.of(context).textTheme.bodyText1,
  
                  ),
  
                ),
  
                Text(
  
                  '${article['publishedAt']}',
  
                  //'publishedAt',
  
                  style: const TextStyle(
  
                    color: Colors.grey,
  
                  ),
  
                ),
  
              ],
  
            ),
  
          ),
  
        ),
  
      ],
  
    ),
  
  ),
);

Widget articleBuilder(list,context,{isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context,index) => buildArticleItem(list[index], context),
    separatorBuilder:(context,index) => myDivider(),
    itemCount: 10,
  ),
  fallback: (context) => isSearch ? Container() :  const Center(child: CircularProgressIndicator()),
);

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
      start: 20.0
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],

  ),
);

void navigaTo(context, Widget) =>  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => Widget,
  ),
);