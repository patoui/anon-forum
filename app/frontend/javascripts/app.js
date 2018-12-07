window.onload = function () {
  let addNewTopic = document.querySelector('#add_new_topic');
  let newTopic = document.querySelector('#new_topic');
  let topics = document.querySelector('#topics');

  if (addNewTopic && newTopic && topics) {
    newTopic.addEventListener('keyup', function (e) {
      e.target.value = e.target.value.replace(/\s/g, '');
    });
    addNewTopic.addEventListener('click', function (e) {
      const topicContainer = document.createElement('button');
      topicContainer.type = 'button';
      topicContainer.textContent = newTopic.value;
      topicContainer.id = `topics[${newTopic.value}]`;
      topicContainer.classList.add(
        'btn',
        'btn-outline-secondary',
        'btn-sm',
        'mr-2'
      );
      const topic = document.createElement('input');
      topic.name = 'topics[]';
      topic.type = 'hidden';
      topic.value = newTopic.value;
      topicContainer.append(topic);
      topics.append(topicContainer);
      newTopic.value = '';
    });
    topics.addEventListener('click', function (e) {
      if (e.target.type === 'button') {
        e.target.remove();
      }
    });
  }
};
