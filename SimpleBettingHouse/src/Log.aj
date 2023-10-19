import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Calendar;

import com.bettinghouse.User;

public aspect Log {

    File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    
    pointcut logOutPoint(User user): call(* effectiveLogOut(User)) && args(user);

    after(User user) : logOutPoint(user) {

      // Mostrar Log In en pantalla
      String logIn = "Sessión iniciada por Usuario: [" + user.getNickname() + "]  Fecha: [" + LocalDateTime.now() + "]";
      
      //Dejar pasar 1 segundo
      try {
		Thread.sleep(1000);
	} catch (InterruptedException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
      String logOut = "Sessión cerrada por Usuario: [" + user.getNickname() + "]  Fecha: [" + LocalDateTime.now() + "]";

      // Mostrar Log In en pantalla
      System.out.print(logIn + "\n" + logOut);

      // Guardar información en archivo
      try {
        FileWriter archivo = new FileWriter("Log.txt", true);
        archivo.write(logIn + "\n");
        archivo.write(logOut + "\n");
        archivo.close();
      } catch (IOException e) {
        System.out.println("Error al guardar información en archivo: " + e.getMessage());
      }
    }
}