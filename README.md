# Events Manager API

Esta proyecto propociona una API para gestionar eventos, incluyendo creación, modificación, eliminación y visualización. La API está construida con Node.js utilizando Express y MySQL para la base de datos.

## Requisitos previos

1. **Node.js**: Asegúrate de tener Node.js instalado.
2. **MySQL**: La base de datos debe estar configurada y ejecutándose.

## Instalación

1. Clona este repositorio.
   ```bash
   git clone <URL_DEL_REPOSITORIO>
   cd <NOMBRE_DEL_PROYECTO>

2. Instala las dependencias necesarias:
    ```bash
    npm istall

3. Importa las tablas necesarias en la base de datos MySQL utilizando el archivo SQL proporcionado.
    - En la carpeta bd, encontrarás el archivo events-manager.dump.sql
    - Importa este archivo en tu base de datos

4. Modifica el archivo .env en el directorio raíz del proyecto y añade las siguientes variables:
    ```bash
    DB_HOST=            # Host de la base de datos (e.g., localhost)
    DB_USER=            # Usuario de la base de datos (e.g., root)
    DB_PASSWORD=        # Contraseña del usuario
    DB_NAME=            # Nombre de la base de datos

5. Inicia el servidor
    ```bash
    npm start
    El servidor se iniciará en http://localhost:3000
    
## Endpoints

- Obtener todos los eventos:
    URL: /events
    Método: GET
    Descripción: Devuelve una lista de todos los eventos

- Crear un nuevo evento:
    URL: /events
    Método: POST
    Descripción: Crea un nuevo evento

- Actualizar un evento:
    URL: /events/:id
    Método: PUT
    Descripción: Actualiza la información de un evento existente

- Eliminar un evento:
    URL: /events/:id
    Método: DELETE
    Descripción: Elimina un evento existente