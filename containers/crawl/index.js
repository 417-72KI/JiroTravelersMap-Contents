const client = require('cheerio-httpcli')
const fs = require('fs')

const url = 'https://ramen-jiro.site/';

if (process.argv.length < 3) {
    console.error('outputDir required');
    return 1;
}

let outputDir = process.argv[2];

try {
    let stat = fs.statSync(outputDir)
    if (stat.isFile()) {
        console.error(outputDir + ' is file!')
        return 1;        
    }
} catch {
    fs.mkdirSync(outputDir);
}

client.set('headers', { 'Accept-Language': 'ja' });

(async () => {
    let res = await client.fetch(url)
    if (res.error || !res.response || res.response.statusCode !== 200) {
        console.log(res.error);
        return
    }
    res.$('#gnavi .menu-item-1758 .sub-menu li a')
        .each((idx, element) => {
            try {
                execute(idx + 1, element.attribs.href)
            } catch (e) {
                console.error(e);
                return;
            }
        }
    );
})()

async function execute(id, url) {
    let res = await client.fetch(url)
    if (res.error || !res.response || res.response.statusCode !== 200) {
        console.log(res.error);
        return
    }
    let $ = res.$
    let name = $('#mainEntity .entry-title').text()
    let mapContent = await parseMapContentFromURL($('#mainEntity .i-video iframe').attr('src'))
    let address = parseAddressFromMapContent(mapContent)
    let location = parseLocationFromMapContent(mapContent)
    let other = $('#mainEntity p:not(.meta):not(.vcard)')
        .filter ((_, el) => $(el).find('script').length == 0)
        .filter ((_, el) => $(el).find('a.external').length == 0)
        .get()
        .map(el => $(el).text()
            .split("\n")
            .map(v => v.trim())
            .filter(v => v.length > 0)
            )
        .filter(v => v.length > 0)
        .join("\n");
    let obj = {
        id: id,
        name: name,
        address: address,
        location: location,
        other: other
    };
    let fileName = id + '-' + name + '.json'
    fs.writeFileSync(outputDir + '/' + fileName, JSON.stringify(obj, null, '    '))
}

function parseAddressFromMapContent(body) {
    return body.match(/(?<=")〒.*?(?=")/g).slice(-1).pop()
}

function parseLocationFromMapContent(body) {
    let match = /\[(\d+\.\d+),(\d+\.\d+)\]/g.exec(body)
    let lat = match[1];
    let lng = match[2];
    return {
        lat: lat,
        lng: lng
    }
}

async function parseMapContentFromURL(url) {
    let res = await client.fetch(url)
    if (res.error || !res.response || res.response.statusCode !== 200) {
        console.log(res.error);
        return null;
    }
    return res.$('body').text()
}