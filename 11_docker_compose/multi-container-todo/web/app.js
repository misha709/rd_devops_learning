const API_URL = 'http://localhost:8082/api/todos';

$(document).ready(function() {
    loadTodos();
    
    $('#addBtn').click(addTodo);
    $('#todoInput').keypress(function(e) {
        if (e.which === 13) addTodo();
    });
});

function showStatus(message, type = 'success') {
    const $status = $('#status');
    const bulmaClass = type === 'error' ? 'is-danger' : 'is-success';
    $status.removeClass('is-danger is-success is-hidden').addClass(bulmaClass).text(message);
    setTimeout(() => $status.addClass('is-hidden'), 3000);
}

function loadTodos() {
    $.ajax({
        url: API_URL,
        method: 'GET',
        success: function(todos) {
            console.log(todos.lastUpdated);
            renderTodos(todos.items);
        },
        error: function() {
            showStatus('Failed to load todos', 'error');
        }
    });
}

function renderTodos(todos) {
    const $list = $('#todoList');
    $list.empty();
    
    if (!todos || todos.length === 0) {
        $list.html('<div class="empty-state">No todos yet. Add one above!</div>');
        return;
    }
    
    todos.forEach(todo => {
        const $item = $(`
            <li class="todo-item ${todo.completed ? 'completed' : ''}" data-id="${todo.id}">
                <span class="todo-text">${$('<div>').text(todo.title).html()}</span>
                <button class="button is-small is-success toggle-btn">${todo.completed ? 'Undo' : 'Complete'}</button>
                <button class="button is-small is-danger delete-btn">Delete</button>
            </li>
        `);
        
        $item.find('.toggle-btn').click(() => toggleTodo(todo.id, !todo.completed));
        $item.find('.delete-btn').click(() => deleteTodo(todo.id));
        
        $list.append($item);
    });
}

function addTodo() {
    const title = $('#todoInput').val().trim();
    if (!title) return;
    
    $.ajax({
        url: API_URL,
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ title: title }),
        success: function() {
            $('#todoInput').val('');
            showStatus('Todo added successfully');
            loadTodos();
        },
        error: function() {
            showStatus('Failed to add todo', 'error');
        }
    });
}

function toggleTodo(id, completed) {
    $.ajax({
        url: `${API_URL}/${id}`,
        method: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify({ completed: completed }),
        success: function() {
            showStatus('Todo updated');
            loadTodos();
        },
        error: function() {
            showStatus('Failed to update todo', 'error');
        }
    });
}

function deleteTodo(id) {
    if (!confirm('Delete this todo?')) return;
    
    $.ajax({
        url: `${API_URL}/${id}`,
        method: 'DELETE',
        success: function() {
            showStatus('Todo deleted');
            loadTodos();
        },
        error: function() {
            showStatus('Failed to delete todo', 'error');
        }
    });
}
