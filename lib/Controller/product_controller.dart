import 'package:get/get.dart';
import 'package:store_app/Models/product.dart';
import 'package:store_app/services/storage_service.dart';

class ProductController extends GetxController {
  @override
  Future<void> onReady() async {
    print('pro controller1');
    products.addAll(await StorageService.getProducts());
    for (var pro in products) {
      print('id : ${pro.id}, title : ${pro.title}');
    }
    print(products.length);
    print('pro controller2');
    update();
  }

  List<Product> products = [
    Product(
      id: '1',
      price: 59,
      title: "سماعات لاسلكية",
      subTitle: "جودة صوت عالية",
      image: "images/airpod.png",
      description: "لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري ات دولار ماجنا أليكيوا.",
      tags: [],
    ),
    Product(
      id: '2',
      price: 1099,
      title: "جهاز موبايل",
      subTitle: "وأصبح للموبايل قوة",
      image: "images/mobile.png",
      description: "لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري ات دولار ماجنا أليكيوا.",
      tags: [],
    ),
    Product(
      id: '3',
      price: 39,
      title: "نظارات ثلاثية الأبعاد",
      subTitle: "لنقلك للعالم الافتراضي",
      image: "images/class.png",
      description: "لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري ات دولار ماجنا أليكيوا.",
      tags: [],
    ),
    Product(
      id: '4',
      price: 56,
      title: "سماعات",
      subTitle: "لساعات استماع طويلة",
      image: "images/headset.png",
      description: "لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري ات دولار ماجنا أليكيوا.",
      tags: [],
    ),
    Product(
      id: '5',
      price: 68,
      title: "مسجل صوت",
      subTitle: "سجل اللحظات المهمة حولك",
      image: "images/speaker.png",
      description: "لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري ات دولار ماجنا أليكيوا.",
      tags: [],
    ),
    Product(
      id: '6',
      price: 39,
      title: "كاميرات كمبيوتر",
      subTitle: "بجودة ودقة صورة عالية",
      image: "images/camera.png",
      description: "لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري ات دولار ماجنا أليكيوا.",
      tags: [],
    ),
  ];
}
