import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;

import com.bettinghouse.User;

public aspect Logger {
	pointcut success() : call(void signUp());
    after() : success() {
    	System.out.println("**** User created ****");
    }
    
    pointcut singUpPoint(User user): call(* successfulSignUp(User, Person)) && args(user);

    before(User user) : singUpPoint(user) {

      // Mostrar información en pantalla
      String parte1 = "Usuario Registrado: ";
      String parte2 = "[nickname = " + user.getNickname();
      String parte3 = ", password = " + user.getPassword();
      String parte4 = "] Fecha: [" + LocalDateTime.now() + "]";
      
      System.out.print(parte1);
      System.out.print(parte2);
      System.out.println(parte3);
      System.out.println(parte4);

      // Guardar información en archivo
      try {
        FileWriter archivo = new FileWriter("Register.txt", true);
        archivo.write(parte1);
        archivo.write(parte2);
        archivo.write(parte3);
        archivo.write(parte4);
        archivo.close();
      } catch (IOException e) {
        System.out.println("Error al guardar información en archivo: " + e.getMessage());
      }
    }
}
