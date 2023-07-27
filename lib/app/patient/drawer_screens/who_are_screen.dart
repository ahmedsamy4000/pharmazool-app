import 'package:flutter/material.dart';
import 'package:pharmazool/components/utils/app_theme_colors.dart';

class WhoAreScreenPatient extends StatelessWidget {
  const WhoAreScreenPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "من نحن",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/who_are_us.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                '"مرحبا بك',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                'تعاني الغالبيه  من مشكلة البحث العشوائي عن العلاج، وهذا يسبب ضياعًا للوقت والجهد ويعرض حياتهم للخطر، خاصة في الحالات الحرجة التي لا تحتمل التأخير. لذلك، إذا كنت تعاني من هذه المشكلة، فيجب اتخاذ الإجراءات اللازمة لتجنب المشاكل الصحية والوقتية',
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                'السبب والهدف من تطبيق فارمازول هو تسهيل وتحسين عملية الحصول على الأدوية. يساعد تطبيق فارمازول الأفراد على العثور على الأدوية المطلوبة بسهولة وسرعة، مما يوفر الوقت والجهد ويضمن الحصول على الرعاية الصحية المناسبة في الوقت المناسب. ',
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                'يعتمد تطبيق فارمازول على تقنيات الذكاء الاصطناعي والموقع الجغرافي لتحديد أقرب صيدلية تحتوي على الدواء المطلوب، مما يجعل عملية الحصول على الدواء أسهل وأكثر سرعة وفعالية. ',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                'هدف تطبيق فارمازول أيضًا إلى حل مشكلة النقص في الأدوية والتخلص من الأدوية الزائدة، من خلال تحفيز المستخدمين على التبرع بالأدوية الزائدة لمن يحتاجونها. بالإضافة إلى ذلك، يهدف تطبيق فارمازول إلى تطوير شبكة عالمية من الصيادلة ومزودي الرعاية الصحية، من خلال توفير قائمة شاملة بجميع الصيادلة المسجلين في التطبيق. بالتالي، يساعد تطبيق فارمازول على تحسين الوصول إلى الرعاية الصحية.',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'قريب من البيت , قريب للقلب.',
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
