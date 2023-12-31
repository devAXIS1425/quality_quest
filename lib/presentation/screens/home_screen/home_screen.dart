
import 'package:quality_quest/core/service_locator.dart';
import 'package:quality_quest/domain/repository/repository.dart';
import 'package:quality_quest/library.dart';
import 'package:quality_quest/presentation/bloc/get_science/get_science_bloc.dart';

import 'main_notification_screen/main_notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<ScienceType> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// #background Color
      backgroundColor: CustomColors.oxFFFFFFFF,

      // #AppBar
      appBar: AppBar(
        title: Text(
          Strings.qualityQuestTXT,
          style: Style.qualityQuestST,
        ),
        actions: [
          IconButton(
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            icon: Image(
              image: const AssetImage('assets/icons/ic_search.png'),
              height: 25.sp,
              width: 25.sp,
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const NotificationMainScreen(),
          //       ),
          //     );
          //   },
          //   icon: Badge(
          //     largeSize: 9.sp,
          //     smallSize: 9.sp,
          //     backgroundColor: CustomColors.oxFFD32F2F,
          //     alignment: const Alignment(1, -1),
          //     child: Image(
          //       image: const AssetImage('assets/icons/ic_bell.png'),
          //       height: 25.sp,
          //       width: 25.sp,
          //     ),
          //   ),
          // ),
          const SizedBox(width: 10),
        ],
        elevation: 3,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),

      /// #Body
      body: FutureBuilder(
        future: (repository as RepositoryImplementation).network.fetchScienceTypes(api: Api.getScienceTypes),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final scienceTypes = snapshot.data;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GridView.builder(
                      padding:
                          const EdgeInsets.only(top: 20, left: 8, right: 8),
                      scrollDirection: Axis.vertical,
                      itemCount: scienceTypes?.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.sp,
                        mainAxisSpacing: 20.sp,
                        mainAxisExtent: 258.sp,
                      ),
                      itemBuilder: (context, index) {
                        final scienceType = scienceTypes?[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                     DetailDiscoverScreen(data: scienceType.name,),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.topCenter,
                            decoration: const BoxDecoration(
                              color: CustomColors.oxFFEEEEEE,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              width: 200.sp,
                              height: 250.sp,
                              decoration: const BoxDecoration(
                                color: CustomColors.oxFFFFFFFF,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// #Cover Image

                                  Image(height: 125.sp,width: 200.sp,fit: BoxFit.fitWidth,image: const AssetImage("assets/images/img_idea.png",),),


                                  const Spacer(flex: 3),

                                  /// #Title
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Text(
                                      scienceType!.name,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  const Spacer(flex: 3),

                                  /// #Questions Quantity
                                  const QuestionsQuantity(),

                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
