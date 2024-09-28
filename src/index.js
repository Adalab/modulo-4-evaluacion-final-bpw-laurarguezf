//Servidor de Express

//Importar bibliotecas
const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');
require('dotenv').config();

//Crear servidor
const server = express();
const serverPort = 3000;

//Config
server.use(cors());
server.use(express.json({limit: '50Mb'}));

//MySQL connection
async function getConnection() {
  try {
		const connection = await mysql.createConnection({
			host: process.env['DB_HOST'],
			port: 3306,
			user: process.env['DB_USER'],
			password: process.env['DB_PASSWORD'],
			database: process.env['DB_NAME']
		});

		await connection.connect();

		return connection;
	}
	catch(error) {
		console.log(error);

		return null;		
	}
}

//Arrancar el servidor
server.listen(serverPort, () => {
  console.log(`Server listening at http://localhost:${serverPort}`);
});


//ENDPOINTS

// -------- Listar todos los eventos --------
server.get('/events', async (req, res) => {
	//Nos conectamos
	const connection = await getConnection();
	
	if( !connection ) {
		res.status(500).json({success: false, error: 'Error con la conexión.'});
		return;
	}

	//Obtenemos los datos
	const [results] = await connection.query('SELECT * FROM events;');

	//Devolvemos los resultados
	if (!results) {
		res.status(500).json({
			success: false,
			error: 'Datos no encontrados'
		})
	}
	else {
		res.status(200).json(results);
	}
	
	//Cerramos conexión
	await connection.close();
});


// -------- Insertar una nueva entrada en 'events' --------
server.post('/events', async (req, res) => {
	//Nos conectamos
	const connection = await getConnection();

	if( !connection ) {
		res.status(500).json({success: false, error: 'Error con la conexión.'});
	}

	//Comprobamos que están todos los datos
	const {name, description, idcategories} = req.body;

	if (!name || !description || !idcategories) {
		return res.status(400).json({error: 'Faltan datos para crear el evento.'})
	}

	//Insertamos nuevos datos
	const [results] = await connection.execute(
		`INSERT INTO events (name, description, date, capacity, price, idcategories, idlocations, idorganizers) 
			VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
			[req.body.name, req.body.description, req.body.date || null, req.body.capacity || null, req.body.price || null, req.body.idcategories, req.body.idlocations || null, req.body.idorganizers || null]);
	
	//Devolvemos un JSON en función de los resultados del insert
	if (results.affectedRows === 1)	{
		res.status(201).json({
			success: true,
			message: 'Evento creado correctamente',
			id: results.insertId
		})
	}
	else {
		res.status(500).json({
			success: false,
			error: 'Datos no insertados'
		})
	};

	//Cerramos conexión
	await connection.close();
});


// -------- Actualizar una entrada existente en 'events' --------
server.put('/events/:id', async (req, res) => {
	//Nos conectamos
	const connection = await getConnection();

	if( !connection ) {
		res.status(500).json({success: false, error: 'Error con la conexión.'});
	}

	//Modificamos datos ya existentes
	const [results] = await connection.execute(
		`UPDATE events 
			SET name=?, description=?, date=?, capacity=?, price=?, idcategories=?, idlocations=?, idorganizers=? 
			WHERE idevents=?`,
			[req.body.name, req.body.description, req.body.date || null, req.body.capacity || null, req.body.price || null, req.body.idcategories, req.body.idlocations || null, req.body.idorganizers || null, req.params.id]);

	//Devolvemos un JSON en función de los resultados del update
	if( results.changedRows === 1 ) {
		res.status(200).json({
			success: true,
			message: 'Evento modificado correctamente'
		});
	}
	else {
		res.status(500).json({
			success: false,
			error: 'Evento no modificado'
		});
	}

	//Cerramos conexión
	await connection.close();
});


// -------- Eliminar una entrada existente en 'events' --------
server.delete('/events/:id', async (req, res) => {
	//Nos conectamos
	const connection = await getConnection();

	if( !connection ) {
		res.status(500).json({success: false, error: 'Error con la conexión.'});
	}

	//Borramos datos ya existentes
	const [results] = await connection.execute(
		`DELETE FROM events
			WHERE idevents=?`,
			[req.params.id]);

	//Devolvemos un JSON en función de los resultados del delete
	if( results.affectedRows === 1 ) {
		res.status(200).json({
			success: true,
			message: 'Evento borrado correctamente'
		});
	}
	else {
		res.status(500).json({
			success: false,
			error: 'Evento no borrado'
		});
	}

	//Cerramos conexión	
	await connection.close(); 
});