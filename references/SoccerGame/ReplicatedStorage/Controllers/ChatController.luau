  

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TextChatService = game:GetService("TextChatService");
require(ReplicatedStorage.Shared.ReplicaService);
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Packages.Signal);
local v1 = Knit.CreateController({
    Name = "ChatController"
});
local u2 = nil;

function v1.KnitInit(p3) -- Line: 15
    -- upvalues: u2 (ref), Knit (copy), TextChatService (copy)
    u2 = Knit.GetService("ChatService");
    u2.NotifyChat:Connect(function(p4, p5) -- Line: 18
        -- upvalues: TextChatService (ref)
        TextChatService.TextChannels.RBXSystem:DisplaySystemMessage(p4, p5);
    end);
end;

return v1;