  

 

return {
    host = "http://localhost",
    port = 3667,
    startAutomatically = false,
    logLevel = "INFO",
    include = {
        game:GetService("Workspace"),
        game:GetService("Players"),
        game:GetService("Lighting"),
        game:GetService("ReplicatedFirst"),
        game:GetService("ReplicatedStorage"),
        game:GetService("ServerScriptService"),
        game:GetService("ServerStorage"),
        game:GetService("StarterGui"),
        game:GetService("StarterPack"),
        game:GetService("StarterPlayer"),
        game:GetService("SoundService"),
        game:GetService("Chat"),
        game:GetService("LocalizationService"),
        game:GetService("TestService")
    }
};