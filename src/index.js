const express = require("express")
const letterRouter = require("./routers/letter")

const app = express()
const port = process.env.PORT || 3000


app.use(express.json())
app.use(letterRouter)

app.listen(port, () => {
    console.log(`Server is running on ${port}`)
})