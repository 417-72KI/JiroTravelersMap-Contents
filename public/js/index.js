window.onload = async () => {
  const origin = await (await fetch('origin.json')).json();
  origin.forEach(e => {
    var shopName = e.name;
    if (e.status == 'closed') {
      shopName += ' (閉店)';
    }
    document.getElementById('shop-list').innerHTML += `<li class="list-group-item"><a href="detail.html?id=${e.id}">${shopName}</a></li>`;
  });
  const lastUpdate = await (await fetch('last_update.json')).json();

  const formatDate = (date) => {
    const options = {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit'
    };
    return new Intl.DateTimeFormat('ja-JP', options).format(new Date(date))
  };
  document.getElementById('last-update').innerText = `最終更新: ${formatDate(lastUpdate.last_update)}`;
};
