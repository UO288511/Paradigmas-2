package cliente;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.InputMismatchException;
import java.util.Scanner;

import lib.ChannelException;
import lib.CommClient;
import lib.ProtocolMessages;
import lib.UnknownOperation;

public class Cliente {

	private static CommClient com;	// canal de comunicación del cliente (singleton)
	
	/**
	 * Envío del mensaje correspondiente a un evento que no tendrá respuesta
	 * por parte del servidor. Para crear el mensaje se requiere la clave con
	 * la que se registro el evento en el servidor y la información adicional
	 * que se precise (argumentos requeridos por el manejador del evento).
	 * @param id identificador del evento
	 * @param args argumentos requeridos por el manejador del evento (operación
	 * del servicio). El parámetro es opcional.
	 * @throws IOException conexión fallida
	 * @throws ChannelException error del canal de comunicación
	 */
	private static void enviarSinRespuesta(String id, Object...args)
			throws IOException, ChannelException {
		ProtocolMessages peticion;
		
		// Crear mensaje a enviar
		peticion = new ProtocolMessages(id, args);
		// Enviar mensaje de solicitud al servidor
		// (También se ejecutará la función asociada)
		Cliente.com.sendEvent(peticion);		
	}
	
	/**
	 * Envío del mensaje correspondiente a un evento y que debe tener respuesta
	 * por parte del servidor. El envío del mensaje es síncrono y ha de esperarse
	 * el mensaje de respuesta (puede ser una excepción). Tras recibir el mensaje
	 * de respuesta, procesa éste y se retorna un objeto o lanza una excepción.
	 * Retorna {@code null} si la función asociada al evento no retorna ningún
	 * resultado (es de tipo {@code void})
	 * @param id identificador del evento
	 * @param args argumentos requeridos por la función asociada al evento (opcional)
	 * @return el valor retornado por la función asociada al evento o {@code null}
	 * si dicha función retorna {@code void}.
	 * @throws IOException conexión fallida
	 * @throws ChannelException error del canal de comunicación
	 * @throws ClassNotFoundException el mensaje recibido no es del formato correcto
	 * @throws UnknownOperation si el evento enviado al servidor es desconocido
	 * @throws Exception excepciones genéricas asociadas con la operación concreta
	 */
	private static Object enviarConRespuesta(String id, Object...args)
			throws IOException, ChannelException, ClassNotFoundException,
			UnknownOperation, Exception {
		ProtocolMessages respuesta;
		Object result = null;

		// Enviar la petición
		Cliente.enviarSinRespuesta(id, args);
		// Esperar por la respuesta
		respuesta = Cliente.com.waitReply();
		// Procesar valor del retorno de la función asociada al evento o
		// lanzar una excepción
		result = Cliente.com.processReply(respuesta);
		
		// Retornar el resultado
		return result;		
	}
	
	private static void exceptionInfo(Exception e) {
		String str = e.getMessage();
		System.err.printf("Error: %s\n",
				str != null ? str : e.getClass().getSimpleName());
	}

	/**
	 * Bucle principal del cliente. En este caso el cliente lo que permite
	 * es invocar una cualquiera de las operaciones de servicio (lanzar
	 * el evento correspondiente), seleccionando una opción en un menú que
	 * se muestra de forma repetitiva.
	 * <p>Para cada evento lanzado se muestra en consola el resultado
	 * (objeto o excepción) de la evaluación de la operación de servicio,
	 * si es que este se puede dar.</p>
	 */
	public static void run() {
		Scanner sin = new Scanner(System.in);
		int opcion;
		
		do {
			// Mostrar el menú
			System.out.println("\n0. Salir");
		    System.out.println("1. Pedirle al servicio que salude");
		    System.out.println("2. Cambiar el saludo del servicio");
		    System.out.println("3. Número de usuarios conectados");
		    System.out.println("4. Restablecer el estado al inicio");
		    System.out.print("\n¿Opción? ");
			    
		    // Leer la opción elegida
			try {
				opcion = sin.nextInt();
			} catch (InputMismatchException e) {
				opcion = -1;
			}
			sin.nextLine();

			// Lanzar el evento y mostrar, si fuera el caso,
			// el resultado de la operación de servicio
			//Your code here
			
			try {
				switch (opcion) {
				case 0:
					break;
				case 1:
					System.out.println(enviarConRespuesta("saluda"));
					break;
				case 2:
					System.out.print("Nuevo saludo: ");
                    String nuevoSaludo = sin.nextLine();
                    enviarSinRespuesta("cambiaSaludo", nuevoSaludo);
					break;
				case 3:
					System.out.println(enviarConRespuesta("usuariosConectados"));
					break;
				case 4:
					enviarSinRespuesta("reset");
					break;
				default:
					System.err.println("Opción no válida");
				}
			} catch (Exception e) {
				Cliente.exceptionInfo(e);
			}
		} while (opcion != 0);
		
		sin.close();
	}
	
    public static void main(String[] args) {
    	
	    try {
			// 1. Crear el canal de comunicación y establecer la
			// conexión con el servicio por defecto en localhost
			Cliente.com = new CommClient();
			
			// activa el registro de mensajes que salen o llegan
			// al cliente (operación opcional)
			Cliente.com.activateMessageLog();
		} catch (UnknownHostException e) {
			Cliente.exceptionInfo(e);
			System.exit(-1);	// salida con error
		} catch (IOException | ChannelException e) {
			Cliente.exceptionInfo(e);
			System.exit(-1);	// salida con error
		}
	    
	    // Ejecutar el bucle principal del cliente
	    Cliente.run();

		// Cierra el canal de comunicación y desconecta el cliente
		Cliente.com.disconnect();
		
	} // main

} // class Cliente
