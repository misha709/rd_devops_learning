namespace ChatApi.Models;

public class AskRequest
{
    public string Question { get; set; } = string.Empty;
}

public class AskResponse
{
    public string Answer { get; set; } = string.Empty;
}
