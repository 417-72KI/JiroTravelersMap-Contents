window.onload = async () => {
    const origin = await (await fetch('origin.json')).json();
    const data = origin.find(element => element.id == new URLSearchParams(window.location.search).get('id'));
    var shopName = data.name
    if (data.status == 'closed') {
        shopName += ' (閉店)';
    }
    document.getElementById('shop-name').innerText = shopName;
    document.title = shopName;
    const address = prefectures[data.prefecture] + data.address + ` (${data.location.lat}, ${data.location.lng})`;
    if (data.google_map) {
        document.getElementById('address').innerHTML = `<a href="${data.google_map}" target="_blank">${address}</a>`;
    } else {
        document.getElementById('address').innerText = address;
    }
    const holiday = data.regular_holiday.map(e => dayOfWeek[e]).join('、');
    document.getElementById('holiday').innerText = holiday;
    days.forEach(e => {
        const dayInfo = data.opening_hours[e];
        if (dayInfo && dayInfo.length) {
            const li = document.createElement('li');
            const innerUl = document.createElement('ul');
            dayInfo.map(e => {
                const li = document.createElement('li');
                li.innerText += `${e.start}〜${e.end}`;
                return li;
            })
            .forEach(e => innerUl.appendChild(e));
            li.innerText = dayOfWeek[e];
            li.appendChild(innerUl);
            document.getElementById('business-hours').appendChild(li);
        }
    });
    const lastUpdate = data.last_update;
    if (lastUpdate) {
      document.getElementById('last-update').innerText = `最終更新: ${lastUpdate}`;
    }
};
