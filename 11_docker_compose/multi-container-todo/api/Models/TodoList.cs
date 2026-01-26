namespace Api.Models;

public record TodoList(DateTime LastUpdated, List<Todo> Items);