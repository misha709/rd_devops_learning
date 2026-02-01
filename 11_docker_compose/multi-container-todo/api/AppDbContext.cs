using Api;
using Api.Models;
using Microsoft.EntityFrameworkCore;

namespace Api;

public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
{
    public DbSet<Todo> Todos { get; set; }
}