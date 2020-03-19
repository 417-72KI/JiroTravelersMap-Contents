const client = require('cheerio-httpcli')
const fs = require('fs')
const yaml = require('js-yaml')
const prefecture = require('./lib/prefecture')
const day = require('./lib/day')
const util = require('./lib/util')

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
    let p = res.$('#gnavi .menu-item-1758 .sub-menu li a')
        .map((idx, element) => execute(idx + 1, element.attribs.href))
        .get()
    await Promise.all(p)
})()

async function execute(id, url) {
    console.debug(url);
    let res = await client.fetch(url)
    if (res.error || !res.response || res.response.statusCode !== 200) {
        console.error(res.error);
        console.error(id)
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
    let regularHoliday = parseRegularHolidayFromContent(other);
    let openingHours = parseOpeningHoursFromContent(other);
    let obj = {
        id: id,
        name: name,
        prefecture: prefecture[address.prefecture],
        address: address.address,
        location: location,
        regularHoliday: regularHoliday, 
        openingHours: openingHours,
        other: other
    };
    let fileName = id + '-' + name + '.yml';
    fs.writeFileSync(outputDir + '/' + fileName, yaml.dump(obj));
}

function parseAddressFromMapContent(body) {
    let address = body.match(/(?<=")〒.*?(?=")/g).slice(-1).pop()
    let match = /〒(\d{3}-\d{4})\s*(.*?[都道府県])(.*)/g.exec(address)
    return {
        prefecture: match[2],
        address: match[3].replace(/丁目|−/g, '-')
        .replace(/[Ａ-Ｚａ-ｚ０-９]/g, (s) => String.fromCharCode(s.charCodeAt(0) - 0xFEE0))
    }
}

function parseLocationFromMapContent(body) {
    let match = /\[(\d+\.\d+),(\d+\.\d+)\]/g.exec(body)
    let lat = match[1];
    let lng = match[2];
    return {
        lat: parseFloat(lat),
        lng: parseFloat(lng)
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

function parseRegularHolidayFromContent(content) {
    let keys = Object.keys(day).join('');
    let match = content.split('\n')[0]
        .replace(/定休日/g, '')
        .match(new RegExp(`[${keys}]`, 'g'));
    if (!match) { return []; }
    return match.map(e => day[e]);
}

function parseOpeningHoursFromContent(content) {
    let match = /(\d{1,2}：\d{1,2}(?:[^～]*?))～(\d{1,2}：\d{1,2}(?:[^\s\n].*?)).*?(\d{1,2}：\d{1,2}(?:[^～]*?))～(\d{1,2}：\d{1,2}(?:[^\s\n].*?))*/g.exec(content)
        .slice(1)
        .map(e => {
            let match = /(\d{1,2})：(\d{1,2})/g.exec(e);
            return `${match[1]}:${match[2]}`
        });
    return util.split(match, 2)
        .map(e => { return { start: e[0], end: e[1] } });
}