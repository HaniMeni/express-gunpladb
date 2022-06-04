import express, { Request, Response } from "express"
import mysql from "mysql"

const router = express.Router()

const dbc = mysql.createConnection({
	host: 'localhost',
	user: 'root',
	password: 'mysql1234',
	database: 'gunpladb'
})

dbc.connect();
	

router.get('/mechanic', (req: Request, res: Response) => {
	const query: string = 'select * from mechanic'
	dbc.query(query, (err, rows) => {
		if (err) throw err
		res.send(rows)
	})
})

router.get('/gunpla', (req: Request, res: Response) => {
	const query: string = 'select * from gunpla'
	dbc.query(query, (err, rows) => {
		if (err) throw err
		res.send(rows)
	})
})

router.get('/image', (req: Request, res: Response) => {
	const query: string = 'select * from image'
	dbc.query(query, (err, rows) => {
		if (err) throw err
		res.send(rows)
	})
})

router.get('/select', (req: Request, res: Response) => {
	const query: string = `select * from mechanic where id = ${req.query.id}`
	dbc.query(query, (err, rows) => {
		if (err) throw err
		res.send(rows)
	})
})

router.get('/select_id', (req: Request, res: Response) => {
	const query: string = "select * from mechanic where id = ?"
	dbc.query(query, [ req.query.id ], (err, rows) => {
		if (err) throw err
		res.send(rows)
	})
})

router.get('/gunpla/:id', (req: Request, res: Response) => {
	const query: string = "select * from gunpla where id = ?"
	dbc.query(query, [ req.params.id ], (err, rows) => {
		if (err) throw err
		res.send(rows)
	})
})

router.post('/mechanic/', (req: Request, res: Response) => {
	const query: string = "insert into mechanic values (?)"
	const mechanic = [
		req.body.id,
		req.body.name,
		req.body.model,
		req.body.manufacturer,
		req.body.armor,
		req.body.height,
		req.body.weight
	]
	dbc.query(query, [ mechanic ], (err, rows) => {
		if (err) throw err
		res.json({
		  status: 200,
		  message: "Success: Add new mechanic"
		})
	})
})

export default router