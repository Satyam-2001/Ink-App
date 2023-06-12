const express = require('express')
const multer = require('multer')
const extractImage = require('../tools/extract_text.js')
const router = new express.Router()

const upload = multer({
    limits: {
        fileSize: 1000000
    },
    fileFilter(req, file, cb) {
        if (!file.originalname.match(/\.(jpg|jpeg|png)$/)) {
            return cb(new Error('Upload a jpg'))
        }
        cb(undefined, true)
    }
})

router.post('/letter/image', upload.single('upload'), async (req, res) => {

    try {
        const data = await extractImage(req.file)
        res.status(200).send(data)
    }
    catch (e) {
        res.status(500).send()
    }
})

module.exports = router