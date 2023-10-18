
public aspect Logger {
	pointcut success() : call(void signUp());
    after() : success() {
    //Aspecto ejemplo: solo muestra este mensaje despus de haber creado un usuario 
    	System.out.println("**** User created ****");
    }
}
