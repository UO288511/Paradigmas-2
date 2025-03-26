package cliente;

import java.io.IOException;
import java.net.UnknownHostException;

import lib.ChannelException;
import lib.CommClient;
import lib.ProtocolMessages;

public class Cliente1 {

    private static CommClient com;    // canal de comunicación del cliente
    
    private static String saludame() throws Exception {
        Object resultado = null;
        
        // crear mensaje a enviar
        ProtocolMessages peticion = new ProtocolMessages("saluda");
        
        // enviar mensaje de solicitud al servidor
        com.sendEvent(peticion);
        
        // esperar respuesta
        ProtocolMessages respuesta = com.waitReply();
        
        // procesar respuesta
        resultado = com.processReply(respuesta);
        
        return (String) resultado;
    }
    
    private static void cambiaSaludo(String str) throws Exception {
    	
        Object resultado = null;

        // Crear mensaje a enviar con el saludo
        ProtocolMessages peticion = new ProtocolMessages("cambiaSaludo",str);
      

        // Enviar mensaje de solicitud al servidor
        com.sendEvent(peticion);
        
        // esperar respuesta
        ProtocolMessages respuesta = com.waitReply();
        
        // procesar respuesta
        resultado = com.processReply(respuesta);
    }
    
    private static void reset() throws Exception {
    	
        Object resultado = null;

        // Crear mensaje a enviar
        ProtocolMessages peticion = new ProtocolMessages("reset");
        
        // Enviar mensaje de solicitud al servidor
        com.sendEvent(peticion);
        
     // esperar respuesta
        ProtocolMessages respuesta = com.waitReply();
        
        // procesar respuesta
        resultado = com.processReply(respuesta);
    }
    
    public static void main(String[] args) {
        try {
            // Crear el canal de comunicación y establecer la conexión con el servicio
            com = new CommClient();
            
            // opcional: activar el registro de mensajes del cliente
//            com.activateMessageLog();
        } catch (UnknownHostException e) {
            System.err.printf("Servidor desconocido. %s\n", e.getMessage());
            e.printStackTrace();
            System.exit(-1);    // salida con error
        } catch (IOException | ChannelException e) {
            System.err.printf("Error: %s\n", e.getMessage());
            e.printStackTrace();
            System.exit(-1);    // salida con error
        }
        
        try {

        	System.out.println(saludame()); 
        	System.out.println(saludame()); 
        	System.out.println(saludame()); 
        	
        	
            
            
            cambiaSaludo("Cambiando el saludo");  
            System.out.println(saludame()); 
            System.out.println(saludame()); 
            
           
            cambiaSaludo("Otro cambio de saludo");
            System.out.println(saludame());  
            
            
            reset();  
            System.out.println(saludame());  
            
            
            
        } catch (IOException | ChannelException e) {
            System.err.printf("Error: %s\n", e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {  // excepción del servicio
            System.err.printf("Error: %s\n", e.getMessage());
            e.printStackTrace();
        } finally {
            // Cierra el canal de comunicación y desconecta el cliente
            com.disconnect();
        }
    }
}
