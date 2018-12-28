let addNewTag = document.querySelector('#add_new_tag');
let newTag = document.querySelector('#new_tag');
let tags = document.querySelector('#tags');

if (addNewTag && newTag && tags) {
  newTag.addEventListener('keyup', (e) => {
    e.target.value = e.target.value.replace(/[^0-9a-z]/g, '');
  });
  addNewTag.addEventListener('click', (e) => {
    const tagContainer = document.createElement('button');
    tagContainer.type = 'button';
    tagContainer.textContent = `#${newTag.value}`;
    tagContainer.id = `tags[${newTag.value}]`;
    tagContainer.classList.add(
      'btn',
      'btn-outline-secondary',
      'btn-sm',
      'mr-2'
    );
    const tag = document.createElement('input');
    tag.name = 'tags[]';
    tag.type = 'hidden';
    tag.value = newTag.value;
    tagContainer.append(tag);
    tags.append(tagContainer);
    newTag.value = '';
  });
  tags.addEventListener('click', (e) => {
    if (e.target.type === 'button') {
      e.target.remove();
    }
  });
}
