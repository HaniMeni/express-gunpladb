import express from "express"
import cors from "cors"
import bodyParser from "body-parser"
import router from "./gunpla"

const app = express()

app.use(cors())
app.use(bodyParser.json())

app.use('/gunpladb', router)

app.listen('3000', () => {
	console.log('Server Started')
})
