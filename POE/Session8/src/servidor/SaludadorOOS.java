package servidor;

import comun.AccionNoPermitida;
import comun.ISaludador;

/**
 * Clase del objeto de operaciones de servicio (OOS). Por ahora, se ignorarán
 * los problemas específicos de la programación concurrente como, por ejemplo,
 * la exclusión mutua de recursos compartidos.
 */
public class SaludadorOOS implements ISaludador {
	// Información común a todos los OOS de los clientes
	private final static String SALUDO_DEFECTO = "¡Soy el saludador!";
	
	// Información exclusiva del OOS de un cliente
	private int estado;			// estado de control
	private String str;			// estado de datos
	private static int contador;

	/**
	 * Crea el objeto de servicio con el saludo por defecto.
	 */
	public SaludadorOOS() {
		this(SALUDO_DEFECTO);
	}
	
	/**
	 * Crea el objeto de servicio con el saludo que se especifica.
	 * @param str el saludo del objeto
	 */
	public SaludadorOOS(String str) {
		this.str = (str == null || str.isEmpty()) ? SALUDO_DEFECTO : str;
		this.estado = 0;
		contador++;
	}
	
	@Override
	public String saluda() {
		this.estado = 1;
		return str;
	}

	@Override
	public void cambiaSaludo(String str) throws AccionNoPermitida {
		if (this.estado == 0) {
			throw new AccionNoPermitida();
		}
		this.str = (str == null || str.isEmpty()) ? SALUDO_DEFECTO : str;
	}
	
	@Override
	public void reset() {
		this.estado = 0;
	}
	
	public int usuariosConectados() {
		return contador;
	};
}
