const upvotes = document.querySelectorAll('.upvote');
const downvotes = document.querySelectorAll('.downvote');
const reply = document.querySelector('#reply_body');
const replies = document.querySelectorAll('.reply');

if (upvotes && downvotes && replies) {
  upvotes.forEach((upvote) => {
    upvote.addEventListener('click', (e) => {
      axios.post(upvote.dataset.url)
        .then(() => {
          upvote
            .querySelector('.vote-count')
            .textContent = parseInt(upvote.querySelector('.vote-count').textContent) + 1
        })
        .catch(() => { console.log('error occured') });
    });
  });

  downvotes.forEach((downvote) => {
    downvote.addEventListener('click', (e) => {
      axios.post(downvote.dataset.url)
        .then(() => {
          downvote
            .querySelector('.vote-count')
            .textContent = parseInt(downvote.querySelector('.vote-count').textContent) + 1
        })
        .catch(() => { console.log('error occured') });
    });
  });

  replies.forEach((reply) => {
    reply.addEventListener('click', (e) => {
      window.location.hash = 'reply_body';
      document.querySelector('#reply_body').value = '@' + reply.dataset.replySlug + '\n';
    });
  });
}

if (reply) {
  reply.addEventListener('keyup', (e) => {
    let replyElement = e.target;
    let suggestionList = document.querySelector('#suggestion_list');
    suggestionList ? suggestionList.remove() : null;
    let symbol = e.target.value.match(/@\w+$/);
    if (symbol) {
      axios.get(e.target.dataset.replySuggestionUrl, { params: { q: symbol[0] } })
        .then((response) => {
          let list = document.createElement('ul');
          list.id = 'suggestion_list';
          list.classList.add('list-group');
          list.style.position = 'absolute';
          list.style.zIndex = 999;
          response.data.forEach((suggestion) => {
            let item = document.createElement('li');
            item.classList.add('list-group-item');
            item.style.color = '#3490dc';
            item.style.cursor = 'pointer';
            let suggestionText = document.createTextNode(`@${suggestion}`);
            item.appendChild(suggestionText);
            list.appendChild(item);
            item.addEventListener('click', (e) => {
              let replyName = e.target.innerText;
              replyElement.value = replyElement.value.replace(symbol[0], replyName);
              document.querySelector('#suggestion_list').remove();
              replyElement.focus();
              replyElement.setSelectionRange(replyElement.value.length ,replyElement.value.length);
            });
          });
          document.querySelector('#reply_body_container').appendChild(list);
        }).catch(() => { console.log('error occured') });
    }
  });
}

