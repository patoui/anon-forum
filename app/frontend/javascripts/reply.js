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
    document.querySelector('[name=body]').value = replyElement.innerText;
    let suggestionList = document.querySelector('#suggestion_list');
    suggestionList ? suggestionList.remove() : null;
    let symbol = e.target.innerHTML.match(/@\w+$/);
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
              replyElement.innerHTML = replyElement.innerHTML.replace(symbol[0], `<a class="reply-symbol" href="#${replyName.replace('@', '')}" style="cursor: pointer;">${replyName}</a>`);
              console.log(replyElement.innerText);
              document.querySelector('[name=body]').value = replyElement.innerText;
              document.querySelector('#suggestion_list').remove();
              replyElement.focus();
              let range = document.createRange();
              let sel = window.getSelection();
              range.setStart(reply.childNodes[reply.childNodes.length - 1], 1);
              range.collapse(true);
              sel.removeAllRanges();
              sel.addRange(range);
              replyElement.focus();
            });
          });
          document.querySelector('#reply_body_container').appendChild(list);
        }).catch(() => { console.log('error occured') });
    }
  });
  reply.addEventListener('click', (e) => {
    if (e.target.classList.contains('reply-symbol')) {
      window.location.href = `${window.location.pathname}#${e.target.innerText.replace('@', '')}`;
    }
  });
}

