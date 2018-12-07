let upvote = document.querySelector('.upvote');
let upvoteUrl = upvote ? upvote.dataset.url : undefined;
let upvoteCount = upvote ? upvote.querySelector('.vote-count') : undefined;
let downvote = document.querySelector('.downvote');
let downvoteUrl = downvote ? downvote.dataset.url : undefined;
let downvoteCount = downvote ? downvote.querySelector('.vote-count') : undefined;
console.log('file loaded');

if (upvote && upvoteUrl && upvoteCount && downvote && downvoteUrl && downvoteCount) {
  console.log('event listeners bound');
  upvote.addEventListener('click', (e) => {
    axios.post(upvoteUrl)
      .then(() => { upvoteCount.textContent = parseInt(upvoteCount.textContent) + 1 })
      .catch(() => { console.log('error occured') });
  });

  downvote.addEventListener('click', (e) => {
    axios.post(downvoteUrl)
      .then(() => { downvoteCount.textContent = parseInt(downvoteCount.textContent) + 1 })
      .catch(() => { console.log('error occured') });
  });
}

