using Microsoft.Extensions.Caching.Distributed;
using System.Text;

namespace Api.Services;

public interface IInstanceNameService
{
    Task<string> GetInstanceNameAsync();
}

public class InstanceNameService : IInstanceNameService
{
    private readonly IDistributedCache _cache;
    private readonly ILogger<InstanceNameService> _logger;
    private string? _instanceName;
    private readonly SemaphoreSlim _semaphore = new(1, 1);
    private const string RedisCounterKey = "instance:counter";
    private const string RedisInstancePrefix = "api-instance-";

    public InstanceNameService(IDistributedCache cache, ILogger<InstanceNameService> logger)
    {
        _cache = cache;
        _logger = logger;
    }

    public async Task<string> GetInstanceNameAsync()
    {
        if (!string.IsNullOrEmpty(_instanceName))
        {
            return _instanceName;
        }

        await _semaphore.WaitAsync();
        try
        {
            if (!string.IsNullOrEmpty(_instanceName))
            {
                return _instanceName;
            }

            var instanceNumber = await GetNextInstanceNumberAsync();
            _instanceName = $"{RedisInstancePrefix}{instanceNumber}";
            
            _logger.LogInformation("Assigned instance name: {InstanceName}", _instanceName);
            
            return _instanceName;
        }
        finally
        {
            _semaphore.Release();
        }
    }

    private async Task<int> GetNextInstanceNumberAsync()
    {
        const int maxRetries = 10;
        
        for (int i = 0; i < maxRetries; i++)
        {
            var counterBytes = await _cache.GetAsync(RedisCounterKey);
            int currentValue = 0;
            
            if (counterBytes != null)
            {
                var counterStr = Encoding.UTF8.GetString(counterBytes);
                currentValue = int.Parse(counterStr);
            }
            
            int newValue = currentValue + 1;
            var newValueBytes = Encoding.UTF8.GetBytes(newValue.ToString());
            
            await _cache.SetAsync(RedisCounterKey, newValueBytes);
            
            if (i > 0)
            {
                await Task.Delay(50 * i);
            }
            
            return newValue;
        }
        
        throw new Exception("Failed to get instance number after retries");
    }
}
