class UnboardingContent{

  String image;
  String title;
  String description;

  UnboardingContent({required this.description,required this.image,required this.title});

}
List<UnboardingContent> contents=[

  UnboardingContent(
    description:"pick your food from our menu\n      more than 35",
    image :"images/screen1.png",

    title:"select from\n      Best Menu",
  ),

  UnboardingContent(
    description:"You can pay cash on delivery annd\n      Card payment is available",
    image :"images/screen2.png",

    title:"Easy and online payment",
  ),

  UnboardingContent(
    description:"Delivery your food at\n      your Doorstep",
    image :"images/screen1.png",

    title:"Quick delivery at your Doorstep\n      Best Menu",
  ),

];