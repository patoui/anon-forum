let upvotes = document.querySelectorAll('.upvote');
let downvotes = document.querySelectorAll('.downvote');

if (upvotes && downvotes) {
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
}

