window.onload = async () => {
    const origin = await (await fetch('origin.json')).json();
    origin.forEach(e => {
        var shopName = e.name;
        if (e.status == 'closed') {
            shopName += ' (閉店)';
        }
        document.getElementById('shop-list').innerHTML += `<li class="list-group-item"><a href="detail.html?id=${e.id}">${shopName}</a></li>`;
    });
};
