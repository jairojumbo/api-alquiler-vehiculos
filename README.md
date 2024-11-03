# Proyecto: API REST con Node.js, Express y PostgreSQL

## 📄 Descripción

Este proyecto es un backend que consiste en una API RESTful desarrollada con Node.js y Express para interactuar con una base de datos PostgreSQL. La API permite realizar operaciones CRUD (Crear, Leer, Actualizar, Eliminar) sobre varias tablas de la base de datos. 

## 🛠️ Tecnologías Utilizadas

- **Node.js**: Entorno de ejecución para el servidor.
- **Express**: Framework para crear aplicaciones web y API.
- **PostgreSQL**: Base de datos relacional para almacenar la información.
- **Sequelize** (opcional): ORM para gestionar la base de datos.
- **Docker**: Contenerización de la aplicación.
- **Docker Compose**: Orquestación de contenedores.

## ✨ Características

- API RESTful para gestionar datos de una base de datos PostgreSQL.
- Rutas para realizar las operaciones CRUD sobre las tablas.
- Manejo de errores y validaciones.

## ✅ Requisitos Previos

Asegúrate de tener instalados los siguientes programas:

- **Node.js**: [Descargar Node.js](https://nodejs.org/)
- **PostgreSQL**: [Descargar PostgreSQL](https://www.postgresql.org/download/)
- **Docker**: [Descargar Docker](https://www.docker.com/)
- **Docker Compose**: Incluido con Docker Desktop.

## ⚙️ Instalación

1. Clona este repositorio:

   ```bash
   git clone https://github.com/jairojumbo/api-alquiler-vehiculos.git
   ```

2. Navega al directorio del proyecto:

   ```bash
   cd api-alquiler-vehiculos
   ```

3. Instala las dependencias necesarias:

   ```bash
   npm install
   ```

4. Crea un archivo `.env` en la raíz del proyecto para la configuración de la base de datos:

   ```
   DB_HOST=localhost
   DB_PORT=5432
   DB_USER=tu_usuario
   DB_PASSWORD=tu_password
   DB_NAME=tu_base_de_datos
   ```

## 🗄️ Configuración de la Base de Datos

Puedes visualizar el diagrama de la base de datos y sus relaciones en el siguiente enlace: [Diagrama de Base de Datos](https://dbdiagram.io/d/ALQUILER-VEHICULOS-67271d78b1b39dd85849db71).

![Diagrama de Base de Datos](https://github.com/jairojumbo/api-alquiler-vehiculos/blob/main/ALQUILER-VEHICULOS.png)

A continuación se presentan las instrucciones para crear las tablas en PostgreSQL utilizadas en este proyecto. Puedes ejecutar estos scripts en tu base de datos para configurar las tablas necesarias:

```sql
CREATE TABLE marca (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  nombre TEXT NOT NULL
);

CREATE TABLE estado (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  descripcion TEXT NOT NULL
);

CREATE TABLE tipo (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  descripcion TEXT NOT NULL,
  descripcion_ampliada TEXT NOT NULL,
  costo_alquiler NUMERIC(10, 2) NOT NULL
);

CREATE TABLE cliente (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  nombre TEXT NOT NULL,
  email TEXT NOT NULL,
  telefono TEXT NOT NULL
);

CREATE TABLE empleado (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  nombre TEXT NOT NULL,
  email TEXT NOT NULL,
  telefono TEXT NOT NULL,
  usuario TEXT NOT NULL,
  clave TEXT NOT NULL
);

CREATE TABLE metodo (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  descripcion TEXT NOT NULL
);

CREATE TABLE vehiculo (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  placa TEXT NOT NULL,
  id_marca BIGINT NOT NULL,
  id_tipo BIGINT NOT NULL,
  id_estado BIGINT NOT NULL,
  FOREIGN KEY (id_marca) REFERENCES marca (id),
  FOREIGN KEY (id_tipo) REFERENCES tipo (id),
  FOREIGN KEY (id_estado) REFERENCES estado (id)
);

CREATE TABLE alquiler (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  id_empleado BIGINT REFERENCES empleado (id),
  id_cliente BIGINT NOT NULL,
  id_vehiculo BIGINT NOT NULL,
  fecha_inicio TIMESTAMP NOT NULL,
  fecha_fin TIMESTAMP NOT NULL,
  fecha_entrega TIMESTAMP,
  costo NUMERIC(10, 2) NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES cliente (id),
  FOREIGN KEY (id_vehiculo) REFERENCES vehiculo (id)
);

CREATE TABLE pago (
  id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  id_empleado BIGINT REFERENCES empleado (id),
  id_alquiler BIGINT NOT NULL,
  id_metodo BIGINT NOT NULL,
  fecha TIMESTAMP NOT NULL,
  importe NUMERIC(10, 2) NOT NULL,
  FOREIGN KEY (id_alquiler) REFERENCES alquiler (id),
  FOREIGN KEY (id_metodo) REFERENCES metodo (id)
);
```

## 🚀 Despliegue con Docker Compose

Para facilitar el despliegue del proyecto, se ha incluido un archivo `docker-compose.yml` que contiene la configuración necesaria para ejecutar tanto el backend como la base de datos PostgreSQL en contenedores Docker.

1. Asegúrate de tener Docker y Docker Compose instalados.

2. Crea un archivo `.env` con la configuración de la base de datos, como se mencionó anteriormente.

3. Ejecuta el siguiente comando para iniciar los contenedores:

   ```bash
   docker-compose up
   ```

   Esto levantará tanto la base de datos PostgreSQL como el servidor Node.js.

4. La API estará disponible en `http://localhost:3000`.

### docker-compose.yml

A continuación se muestra un ejemplo del archivo `docker-compose.yml`:

```yaml
version: '3'
services:
  db:
    image: postgres:13
    environment:
      POSTGRES_USER: tu_usuario
      POSTGRES_PASSWORD: tu_password
      POSTGRES_DB: tu_base_de_datos
    ports:
      - '5432:5432'
    volumes:
      - postgres_data:/var/lib/postgresql/data

  api:
    build: .
    environment:
      DB_HOST: db
      DB_PORT: 5432
      DB_USER: tu_usuario
      DB_PASSWORD: tu_password
      DB_NAME: tu_base_de_datos
    ports:
      - '3000:3000'
    depends_on:
      - db

volumes:
  postgres_data:
```

## 📌 Uso

1. Inicia el servidor:

   ```bash
   npm start
   ```

2. La API estará disponible en `http://localhost:3000`.

### Rutas Principales

- `GET /marcas`: Obtener todos los registros de la tabla `marca`.
- `POST /marcas`: Crear un nuevo registro en la tabla `marca`.
- `PUT /marcas/:id`: Actualizar un registro existente en la tabla `marca`.
- `DELETE /marcas/:id`: Eliminar un registro de la tabla `marca`.

- `GET /estados`: Obtener todos los registros de la tabla `estado`.
- `POST /estados`: Crear un nuevo registro en la tabla `estado`.
- `PUT /estados/:id`: Actualizar un registro existente en la tabla `estado`.
- `DELETE /estados/:id`: Eliminar un registro de la tabla `estado`.

- `GET /tipos`: Obtener todos los registros de la tabla `tipo`.
- `POST /tipos`: Crear un nuevo registro en la tabla `tipo`.
- `PUT /tipos/:id`: Actualizar un registro existente en la tabla `tipo`.
- `DELETE /tipos/:id`: Eliminar un registro de la tabla `tipo`.

(Repite este patrón para las tablas `cliente`, `empleado`, `metodo`, `vehiculo`, `alquiler`, `pago`)

## 📜 Scripts Disponibles

- `npm start`: Inicia el servidor en modo producción.
- `npm run dev`: Inicia el servidor en modo desarrollo con nodemon.

## 🤝 Contribución

Si deseas contribuir a este proyecto, sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una nueva rama (`git checkout -b feature/nueva-funcionalidad`).
3. Realiza los cambios y haz commit (`git commit -m 'Añadir nueva funcionalidad'`).
4. Haz push a la rama (`git push origin feature/nueva-funcionalidad`).
5. Abre un Pull Request.

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para más detalles.

## 📬 Contacto

Creador - [Jairo Jumbo](https://github.com/jairojumbo)  
Correo electrónico: [jairojumbo@gmail.com](mailto:jairojumbo@gmail.com)

---
¡Gracias por visitar este proyecto!
