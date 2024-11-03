const express = require('express');
const { Pool } = require('pg');
const app = express();
const port = 3000;

require('dotenv').config();

app.use(express.json());

// Configuración de la conexión a PostgreSQL
const pool = new Pool({
    user: process.env.POSTGRES_USER,
    host: process.env.DB_HOST,
    database: process.env.POSTGRES_DB,
    password: process.env.POSTGRES_PASSWORD,
    port: process.env.DB_PORT,
});


// Rutas para la tabla MARCA
app.get('/marcas', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM MARCA');
        res.json(result.rows);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.post('/marcas', async (req, res) => {
    try {
        const { nombre } = req.body;
        const result = await pool.query('INSERT INTO MARCA (nombre) VALUES ($1) RETURNING *', [nombre]);
        res.json(result.rows[0]);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.put('/marcas/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { nombre } = req.body;
        const result = await pool.query('UPDATE MARCA SET nombre = $1 WHERE id_marca = $2 RETURNING *', [nombre, id]);
        res.json(result.rows[0]);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.delete('/marcas/:id', async (req, res) => {
    try {
        const { id } = req.params;
        await pool.query('DELETE FROM MARCA WHERE id_marca = $1', [id]);
        res.json({ message: 'Marca eliminada' });
    } catch (err) {
        res.status(500).json(err);
    }
});

// Rutas para la tabla ESTADO
app.get('/estados', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM ESTADO');
        res.json(result.rows);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.post('/estados', async (req, res) => {
    try {
        const { descripcion } = req.body;
        const result = await pool.query('INSERT INTO ESTADO (descripcion) VALUES ($1) RETURNING *', [descripcion]);
        res.json(result.rows[0]);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.put('/estados/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { descripcion } = req.body;
        const result = await pool.query('UPDATE ESTADO SET descripcion = $1 WHERE id_estado = $2 RETURNING *', [descripcion, id]);
        res.json(result.rows[0]);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.delete('/estados/:id', async (req, res) => {
    try {
        const { id } = req.params;
        await pool.query('DELETE FROM ESTADO WHERE id_estado = $1', [id]);
        res.json({ message: 'Estado eliminado' });
    } catch (err) {
        res.status(500).json(err);
    }
});

// Rutas para la tabla TIPO
app.get('/tipos', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM TIPO');
        res.json(result.rows);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.post('/tipos', async (req, res) => {
    try {
        const { descripcion, descripcion_ampliada, costo_alquiler } = req.body;
        const result = await pool.query(
            'INSERT INTO TIPO (descripcion, descripcion_ampliada, costo_alquiler) VALUES ($1, $2, $3) RETURNING *',
            [descripcion, descripcion_ampliada, costo_alquiler]
        );
        res.json(result.rows[0]);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.put('/tipos/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { descripcion, descripcion_ampliada, costo_alquiler } = req.body;
        const result = await pool.query(
            'UPDATE TIPO SET descripcion = $1, descripcion_ampliada = $2, costo_alquiler = $3 WHERE id_tipo = $4 RETURNING *',
            [descripcion, descripcion_ampliada, costo_alquiler, id]
        );
        res.json(result.rows[0]);
    } catch (err) {
        res.status(500).json(err);
    }
});

app.delete('/tipos/:id', async (req, res) => {
    try {
        const { id } = req.params;
        await pool.query('DELETE FROM TIPO WHERE id_tipo = $1', [id]);
        res.json({ message: 'Tipo eliminado' });
    } catch (err) {
        res.status(500).json(err);
    }
});

// Repite este patrón para CLIENTE, EMPLEADO, METODO, VEHICULO, ALQUILER, PAGO

// Escuchar en el puerto configurado
app.listen(port, () => {
    console.log(`API escuchando en http://localhost:${port}`);
});
