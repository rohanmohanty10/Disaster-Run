  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local u1 = require(Core.ReplicatedLibraries.Classes.Handler).new();
u1.Root = script;

if u1.Root.Parent:IsA("Tool") then
    u1.Tool = u1.Root.Parent;

    if u1.Tool.Parent:IsA("Model") then
        u1.Character = u1.Tool.Parent;
        u1.Player = game.Players.LocalPlayer or game.Players:GetPlayerFromCharacter(u1.Character);
    elseif u1.Tool.Parent:IsA("Backpack") then
        u1.Player = game.Players.LocalPlayer or u1.Tool.Parent.Parent;
        u1.Character = u1.Player.Character or u1.Player.CharacterAdded:Wait();
    end;
else
    u1.Player = game.Players.LocalPlayer or game.Players:GetPlayerFromCharacter(u1.Root.Parent);
    local v2;

    if u1.Player then
        v2 = u1.Player.Character or u1.Player.CharacterAdded:Wait();
    else
        v2 = u1.Root.Parent;
    end;

    u1.Character = v2;
end;

if u1.Player then
    local u3 = nil;
    u3 = u1.Collector:Add(u1.Player.CharacterAdded:Connect(function(p4) -- Line: 22
        -- upvalues: u1 (copy), u3 (ref)
        if p4 ~= u1.Character then
            u1:Destroy();

            if u3 then
                u3:Disconnect();
            end;
        end;
    end));
end;

if u1.Character then
    u1.Humanoid = u1.Character:WaitForChild("Humanoid");
    u1.RootPart = u1.Character:WaitForChild("HumanoidRootPart");
end;

u1.Tags = u1.Player and u1.Player:WaitForChild("Tags") or u1.Character:WaitForChild("Tags");
u1.Event = u1.Root:WaitForChild("Event");
u1.Remote = u1.Event:WaitForChild("Remote");

while not u1.Root:IsDescendantOf(game) do
    task.wait();
end;

u1.Collector:AttachToInstance(script);
u1:Add(u1.Root.Functions);

return u1;