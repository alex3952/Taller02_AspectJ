import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import com.bettinghouse.Person;
import com.bettinghouse.User;


public aspect Logger {
	

	pointcut successLog(User usr): call(* effectiveLog*(User)) && args(usr);

    after(User usr): successLog(usr) {
        System.out.println("Log");
        String suceso = "cerrada";
        if (thisJoinPoint.getSignature().getName().equals("effectiveLogIn")) {
            suceso = "iniciada";
        }
        String msg = String.format("Sesión %s por usuario: [%s]", suceso, usr.getNickname());
        escribirLog("Log.txt",msg);
    }
	

    pointcut singUpPoint(User user, Person person): call(void successfulSignUp(User, Person)) && args(user, person);

    after(User user, Person person) : singUpPoint(user, person) {
      // Mostrar información en pantalla
      String parte1 = "Usuario Registrado: ";
      String parte2 = "[nickname = " + user.getNickname();
      String parte3 = ", password = " + user.getPassword() +"]";
      String parte4 = parte1+parte2+parte3;
      
      escribirLog("Register.txt",parte4);
    }
    
    private static void escribirLog(String fileName, String text) {
        File file = new File(fileName);
        SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
        String time = sdf.format(Calendar.getInstance().getTime());

        try (PrintWriter out = new PrintWriter(new FileWriter(file, true))) {
            text = text + String.format("\tFecha: [%s]",sdf.format(Calendar.getInstance().getTime()));
            out.println(text);
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
}
