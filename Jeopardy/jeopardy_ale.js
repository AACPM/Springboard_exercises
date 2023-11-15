let categories = [];

function getCategoryIds() {
  return new Promise((resolve, reject) => {
    $.ajax({
      url: "https://jservice.io/api/categories",
      data: { count: 100 },
      method: "GET",
      success: function (response) {
        const categoryIds = response.map(category => category.id);
        resolve(categoryIds);
      },
      error: function (error) {
        reject(error);
      }
    });
  });
}

function handleCategoryIds(categoryIds) {
  categories = categoryIds.slice(0, 6);
}

async function getCategory(catId) {
  return new Promise((resolve, reject) => {
    $.ajax({
      url: `https://jservice.io/api/category?id=${catId}`,
      method: "GET",
      success: function (response) {
        const category = response;
        const clues = category.clues.map(clue => ({
          question: clue.question,
          answer: clue.answer,
          showing: null
        }));
        resolve({ title: category.title, clues });
      },
      error: function (error) {
        reject(error);
      }
    });
  });
}

async function fillTable() {
  const table = document.getElementById('jeopardy');
  const thead = document.createElement('thead');
  const tbody = document.createElement('tbody');

  try {
    const categoryIds = await getCategoryIds();
    const categoriesData = await Promise.all(categoryIds.slice(0, 6).map(getCategory));

    const headerRow = document.createElement('tr');
    categoriesData.forEach(category => {
      const th = document.createElement('th');
      th.textContent = category.title;
      headerRow.appendChild(th);
    });
    thead.appendChild(headerRow);
    table.appendChild(thead);

    for (let i = 0; i < 5; i++) {
      const row = document.createElement('tr');
      categoriesData.forEach(category => {
        const td = document.createElement('td');
        const clue = category.clues[i];
        td.textContent = '?';
        td.addEventListener('click', () => handleClick(td, clue));
        row.appendChild(td);
      });
      tbody.appendChild(row);
    }
    table.appendChild(tbody);
  } catch (error) {
    console.error('Error filling the table:', error);
  }
}

function handleClick(td, clue) {
  if (clue.showing === null) {
    $(td).text(clue.question);
    clue.showing = 'question';
  } else if (clue.showing === 'question') {
    $(td).text(clue.answer);
    clue.showing = 'answer';
  }
}

function showLoadingView() {
  $('#spin-container').show();
  $('#start').prop('disabled', true);
}

function hideLoadingView() {
  $('#spin-container').hide();
  $('#start').prop('disabled', false);
}

async function setupAndStart() {
  showLoadingView();

  try {
    const table = document.getElementById('jeopardy');
    await fillTable();
    hideLoadingView();

    $('#start').on('click', function () {
      showLoadingView();
      hideLoadingView();
    });
  } catch (error) {
    console.error('Error setting up the game:', error);
    hideLoadingView();
  }
}

$(document).ready(function () {
  $('table#jeopardy td').on('click', function () {
    const td = $(this);
    const clue = td.data('clue');
    handleClick(td, clue);
  });
});

$(document).ready(function () {
  $('#start').on('click', setupAndStart);
});
