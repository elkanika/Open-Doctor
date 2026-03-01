# Open Doctor 🏥⚖️

<p align="center">
  <em>Sistema de Gestión Jurídica Open Source</em>
</p>

## Acerca del Proyecto

**Open Doctor** es una plataforma de gestión para estudios jurídicos, diseñada para ser rápida, segura (aislamiento mediante multitenancy) y amigable. 
Creado por **[elkanika](https://github.com/elkanika)**, este software permite gestionar clientes, expedientes, plazos procesales y visualizar eventos en un calendario interactivo, con un diseño moderno basado en Tailwind CSS.

## Características

- 🏢 **Multi-estudio (Multitenant):** Bases de datos aisladas por estudio jurídico.
- 👥 **Gestión de Clientes y Expedientes:** Mantené el control total sobre tus casos.
- 📅 **Calendario y Plazos:** Visualizá los vencimientos en un calendario interactivo.
- 📎 **Gestión Documental:** Subí documentos adjuntos a tus clientes y expedientes.
- 📧 **Alertas por Email:** Notificaciones automáticas para plazos próximos a vencer.

---

## Cómo Instalar y Usar

Open Doctor puede correrse de dos formas: mágicamente a través de Docker (ideal para usuarios finales que solo quieren usar el sistema) o de forma manual nativa (ideal para desarrolladores).

### Opción 1: Docker Compose (Para Usuarios Finales) - ¡Recomendado! 🐳

La forma más rápida de tener Open Doctor corriendo en tu computadora sin instalar Ruby ni configurar bases de datos.

1. Descargá e instalá [Docker Desktop](https://www.docker.com/products/docker-desktop/).
2. Cloná o descargá este repositorio en tu computadora y descomprímelo:
   ```bash
   git clone https://github.com/elkanika/Open-Doctor.git
   cd Open-Doctor
   ```
3. Ejecutá el siguiente comando en la terminal para crear y levantar toda la plataforma:
   ```bash
   docker compose up -d --build
   ```
4. Abrí tu navegador web y entrá a **[http://localhost:3000](http://localhost:3000)**.

_Nota: El sistema creará la base de datos automáticamente al arrancar. Para exponerlo en internet de manera real (producción), recordá cambiar las contraseñas y la variable `SECRET_KEY_BASE` en el archivo `docker-compose.yml`._

### Opción 2: Desde Código Fuente (Para Desarrolladores) 💻

Si querés modificar Open Doctor o aportar código:

1. **Requisitos:** 
   - Ruby 3.4+
   - PostgreSQL 15+
   - Redis
2. Cloná el repositorio y navegá a la carpeta del proyecto.
3. Instalá las dependencias del sistema:
   ```bash
   bundle install
   ```
4. Creá y prepará la base de datos local:
   ```bash
   rails db:create db:migrate
   ```
5. Levantá el servidor de desarrollo (este comando arrancará Rails, Tailwind y Sidekiq/SolidQueue en simultáneo):
   ```bash
   bin/dev
   ```
6. Entrá a [http://localhost:3000](http://localhost:3000).

---

## Licencia y Créditos

Este proyecto está bajo la Licencia **Apache 2.0**. 

Tenés la libertad de descargar, instalar, modificar, distribuir y usar Open Doctor (incluso comercialmente). La única condición fundamental es otorgar los **créditos correspondientes a [elkanika](https://github.com/elkanika)** como creador original del software, manteniendo los avisos de copyright en la distribución. Podés leer los términos completos en el archivo `LICENSE`.
