# Proyecto: API REST con Node.js, Express y PostgreSQL

<div align="center">
   .. image:: https://nodejs.org/es
    :target: https://nodejs.org](https://img.shields.io/badge/Node.js-20.1.9-%235FA04E?style=plastic&link=https%3A%2F%2Fnodejs.org%2Fen%2F
</div>

## 📄 Descripción

🚗💻 Proyecto de Alquiler de Vehículos - Backend

🌐 API RESTful: Desarrollada con Node.js y Express, esta API permite gestionar 🚘 alquileres de vehículos de forma eficiente y escalable.

📊 Base de Datos: Utiliza PostgreSQL para almacenar la información en varias tablas, gestionando los datos de vehículos, clientes y reservas.

⚙️ Operaciones CRUD: La API permite operaciones:

➕ Crear
🔍 Leer
✏️ Actualizar
❌ Eliminar
Estas operaciones están diseñadas para interactuar con todos los elementos de la base de datos de forma organizada.

🐳 Despliegue: La API está empaquetada y lista para desplegarse mediante Docker Compose, facilitando su instalación y administración en diferentes entornos.

🛠️ Herramientas Principales: Node.js, Express, PostgreSQL, Docker Compose

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

Esta sección te guiará paso a paso para poner en funcionamiento el proyecto en tu entorno local.

1. **Clona este repositorio**:

   Utiliza el siguiente comando para clonar el repositorio en tu máquina local.

   ```bash
   git clone https://github.com/jairojumbo/api-alquiler-vehiculos.git
   ```

2. **Navega al directorio del proyecto**:

   Dirígete al directorio donde se encuentra el proyecto clonado.

   ```bash
   cd api-alquiler-vehiculos
   ```

3. **Construye y despliega los contenedores**:

   Utiliza el siguiente comando para construir la imagen Docker y desplegar los contenedores en segundo plano:

   ```bash
   docker-compose up --build -d
   ```

4. **Utiliza el archivo de configuración `.env` incluido en el repositorio**:

   No es necesario crear un archivo `.env`, ya que el proyecto ya incluye uno en la raíz del repositorio. Puedes modificar este archivo para establecer las configuraciones de conexión a la base de datos según tus necesidades. El contenido del archivo es el siguiente:

   ```
   POSTGRES_USER=postgres
   POSTGRES_PASSWORD=postgres
   POSTGRES_DB=alquilervehiculos
   DB_HOST=localhost
   DB_PORT=5432
   ```

## 🗄️ Configuración de la Base de Datos

Se ha colocado un archivo en el proyecto dentro de la carpeta `init_db` con el nombre `basealquilervehiculos.sql` que se ejecuta al momento de levantar la base de datos. Este archivo crea las tablas necesarias y también inserta datos de ejemplo para facilitar el uso de la aplicación.

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

Sigue los siguientes pasos para desplegar la aplicación utilizando Docker Compose. Esto permitirá ejecutar tanto la base de datos como el servidor Node.js de manera conjunta y contenerizada.

Este proyecto ha sido probado utilizando [Play with Docker](https://labs.play-with-docker.com/), una herramienta que permite probar contenedores Docker en un entorno virtual de manera rápida y sencilla.

<div align="center">
  <img src="https://github.com/jairojumbo/api-alquiler-vehiculos/blob/main/PLAY-WITH-DOCKER.PNG" alt="Play with Docker" width="50%">
</div>

Para acceder al contenedor desde la consola de Windows en ambas máquinas, se debe generar una clave SSH con el siguiente comando:

```bash
ssh-keygen -t ecdsa
```

Sigue los siguientes pasos para desplegar la aplicación utilizando Docker Compose. Esto permitirá ejecutar tanto la base de datos como el servidor Node.js de manera conjunta y contenerizada.

1. **Asegúrate de tener Docker y Docker Compose instalados**:
   
   Docker es necesario para contenerizar las aplicaciones y Docker Compose ayuda a orquestar los contenedores. Puedes descargarlos desde [Docker](https://www.docker.com/).

2. **Crea un archivo `.env`**:
   
   Asegúrate de crear un archivo `.env` en la raíz del proyecto con la configuración de la base de datos, tal como se mencionó en la sección de instalación.

3. **Ejecuta Docker Compose**:
   
   Utiliza el siguiente comando para construir la imagen Docker y desplegar los contenedores en segundo plano:
   
   ```bash
   docker-compose up --build -d
   ```
   
   Esto levantará tanto la base de datos PostgreSQL como el servidor Node.js en contenedores separados, pero interconectados.

4. **Accede a la API**:
   
   Una vez que los contenedores estén corriendo, la API estará disponible en `http://localhost:3000`. Puedes utilizar herramientas como Postman o simplemente tu navegador para probar las distintas rutas disponibles.

### docker-compose.yml

A continuación se muestra el archivo `docker-compose.yml` utilizado en este proyecto:

```yaml
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: alquilervehiculos_app
    ports:
      - "3000:3000"
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: alquilervehiculos
      DB_HOST: db
      DB_PORT: 5432
    depends_on:
      - db
    networks:
      - alquiler_network
    restart: unless-stopped

  db:
    image: postgres:13
    container_name: alquilervehiculos_db
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: alquilervehiculos
    ports:
      - "5432:5432"
    volumes:
      - pgdata:/var/lib/postgresql/data
      - ./init_db:/docker-entrypoint-initdb.d
    networks:
      - alquiler_network
    restart: unless-stopped

volumes:
  pgdata:

networks:
  alquiler_network:
    driver: bridge
```

### Dockerfile

A continuación se muestra el archivo `Dockerfile` utilizado en este proyecto:

```dockerfile
# Usar una imagen base de Node.js
FROM node:20

# Crear y establecer el directorio de trabajo
WORKDIR /app

# Copiar el package.json y package-lock.json
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar el código de la aplicación
COPY . .

# Exponer el puerto de la aplicación
EXPOSE 3000

# Comando para ejecutar la aplicación
CMD ["node", "index.js"]
```

## 📌 Uso

Después de haber seguido los pasos de instalación y despliegue, puedes ejecutar el proyecto y acceder a las distintas rutas para interactuar con la base de datos.

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
