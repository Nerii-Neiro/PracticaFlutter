
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController conUser = TextEditingController();
  TextEditingController conPsw = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/fondo2.jpg')
            )
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 100,
              child: Image.asset('assets/images/logo.png',width: 350)
              ),
            Positioned(
              bottom: 200,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(87, 0, 0, 0),
                  borderRadius: BorderRadius.circular(10)
                ),
                height: 200,
                width: 400,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      controller: conUser,
                      style:  TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelStyle:  TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                        label: Text('Correo de Telefono'),
                        border: OutlineInputBorder()
                      ),
                      
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: conPsw,
                      style:  TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      obscureText: false,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        labelStyle:  TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                        label: Text('Contraseña'),
                        border: OutlineInputBorder()
                      ),
                      
                    )
                  ],
                ),
              )
            ),
            Positioned(
              top: 380,
              child: InkWell(
                          
                      onTap:  (){
                      isLoading = true;
                      setState((){ });

                      Future.delayed(const Duration(seconds: 4)).then((value) {
                        Navigator.pushNamed(context,'/dash');
                      },);
                      

                      /*
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context)=>const DashboardScreen(),
                            ) 
                        );
                      
                       */

                      },
                     child: Positioned(
                      top: 600,
                      child: Lottie.asset('assets/images/boton.json', width: 220) 
                    ),
            
              )

            ),
            Positioned(
              top: 250,
              child: isLoading? Lottie.asset('assets/images/loading.json', height: 150) : Container()
            )
          ],
        ),
      ),
    );
  }
}