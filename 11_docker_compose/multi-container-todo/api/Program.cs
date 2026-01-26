using System.Text.Json;
using Api;
using Api.Models;
using Api.Extensions;
using Api.Services;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Distributed;

var builder = WebApplication.CreateBuilder(args);

Console.WriteLine($"Database Provider: {builder.Configuration.GetConnectionString("Default")}");

builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("Default")));

builder.Services.AddStackExchangeRedisCache(options =>
{
    options.Configuration = builder.Configuration.GetConnectionString("Redis");
    options.InstanceName = "api_cache_";
});

builder.Services.AddSingleton<IInstanceNameService, InstanceNameService>();

builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

var app = builder.Build();

app.UseCors();
app.EnsureDatabaseCreated();

app.MapGet("/", () => "Todo API");

app.MapGet("/api/instance", async (IInstanceNameService instanceNameService) =>
{
    var instanceName = await instanceNameService.GetInstanceNameAsync();
    return Results.Ok(new { InstanceName = instanceName });
});

app.MapGet("/api/todos", async (AppDbContext db, IDistributedCache cache, IInstanceNameService instanceNameService, CancellationToken cancellationToken) =>
{
    var instanceName = await instanceNameService.GetInstanceNameAsync();
    var cachedTodosJson = await cache.GetStringAsync(AppConstants.TodoCacheKey, cancellationToken);
    if (!string.IsNullOrEmpty(cachedTodosJson))
    {
        var todosFromCache = JsonSerializer.Deserialize<TodoList>(cachedTodosJson);
        return Results.Ok(todosFromCache with { InstanceName = instanceName });
    }
    var todos = await db.Todos.ToListAsync();
    var todosList = new TodoList(DateTime.UtcNow, todos, instanceName);
    
    var todosJson = JsonSerializer.Serialize(todosList);
    await cache.SetStringAsync(AppConstants.TodoCacheKey, todosJson, cancellationToken);
    
   return Results.Ok(todosList);
});

app.MapGet("/api/todos/{id}", async (int id, AppDbContext db) =>
    await db.Todos.FindAsync(id) is Todo todo
        ? Results.Ok(todo)
        : Results.NotFound());

app.MapPost("/api/todos", async (Todo todo, AppDbContext db, IDistributedCache cache) =>
{
    db.Todos.Add(todo);
    await db.SaveChangesAsync();
    
    cache.Remove(AppConstants.TodoCacheKey);
    return Results.Created($"/api/todos/{todo.Id}", todo);
});

app.MapPut("/api/todos/{id}", async (int id, Todo inputTodo, AppDbContext db, IDistributedCache cache) =>
{
    var todo = await db.Todos.FindAsync(id);
    if (todo is null) return Results.NotFound();

    todo.Title = inputTodo.Title;
    todo.Completed = inputTodo.Completed;

    await db.SaveChangesAsync();
    cache.Remove(AppConstants.TodoCacheKey);
    return Results.Ok(todo);
});

app.MapDelete("/api/todos/{id}", async (int id, AppDbContext db, IDistributedCache cache) =>
{
    var todo = await db.Todos.FindAsync(id);
    if (todo is null) return Results.NotFound();

    db.Todos.Remove(todo);
    await db.SaveChangesAsync();
    
    cache.Remove(AppConstants.TodoCacheKey);
    return Results.NoContent();
});

app.Run();