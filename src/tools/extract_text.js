const Tesseract = require('tesseract.js')
const Jimp = require('jimp');
const { getPixels } = require('ndarray-pixels');

const extraxtTextImageData = async (buffer) => {
    try {
        const data = await Tesseract.recognize(
            buffer,
            'eng',
        )
        const arr = [];
        for (let obj of data.data.symbols) {
            if (obj.page.psm == 'SINGLE_BLOCK') {
                const { text, bbox, baseline, confidence } = obj;
                arr.push({
                    text,
                    box: bbox,
                    baseline,
                    confidence,
                })
            }
        }
        return arr;
    }
    catch (e) { }
}

const getImage = (box, pixels) => {
    const { data, shape } = pixels
    const [width, height] = shape
    const { x0, x1, y0, y1 } = box
    const img_width = x1 - x0
    const img_height = y1 - y0
    return new Promise((resolve, reject) => {
        new Jimp(img_width, img_height, function (err, image) {
            if (err) {
                reject(err)
            }
            for (let i = 0; i < img_height; i++) {
                const row = (y0 + i) * width * 4
                for (let j = 0; j < img_width; j++) {
                    const current = row + (x0 + j) * 4;
                    const brightness = (data[current] + data[current + 1] + data[current + 2]) / 3;
                    if (brightness > 150) {
                        image.setPixelColor(0x00000000, j, i);
                    }
                    else {
                        const color = Jimp.rgbaToInt(0, 0, 255, brightness);
                        image.setPixelColor(color, j, i);
                    }
                }
            }
            image.getBuffer('image/png', (err, buffer) => {
                if (err) {
                    reject(err)
                }
                resolve(buffer)
            })
        })
    })
}

const extractImage = async (file) => {
    const { buffer, mimetype } = file
    const pixels = await getPixels(buffer, mimetype);
    const data_arr = await extraxtTextImageData(buffer)
    const image_arr = []
    for (let data_item of data_arr) {
        const image = await getImage(data_item.box, pixels)
        image_arr.push({ image, baseline : data_item.baseline - data_item.box.x0, ...data_item })
    }
    return image_arr;
}

module.exports = extractImage
