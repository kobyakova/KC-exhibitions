using UnityEngine;

public static class Logger
{
    public static void Log(string methodName, string description)
    {
        Debug.Log($"<{methodName}> [{description}]\n");
    }
}
