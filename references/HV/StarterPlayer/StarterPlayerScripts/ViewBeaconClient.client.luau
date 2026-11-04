 

 

local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));

if not (FFlags.ClientBots and FFlags.ServerHits) then
    return;
end;

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local ViewBeacon = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Bots"):WaitForChild("ViewBeacon");
local u1 = 0;
local u3 = RunService.Heartbeat:Connect(function(p2) -- Line: 18
    -- upvalues: u1 (ref), LocalPlayer (copy), ViewBeacon (copy)
    u1 = u1 + p2;

    if u1 < 0.25 then
        return;
    end;

    u1 = 0;
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local AssemblyLinearVelocity = Character.AssemblyLinearVelocity;

    if AssemblyLinearVelocity.X * AssemblyLinearVelocity.X + AssemblyLinearVelocity.Z * AssemblyLinearVelocity.Z >= 100 then
        ViewBeacon:FireServer(workspace:GetServerTimeNow(), Character.Position);
    end;
end);
script.Destroying:Connect(function() -- Line: 34
    -- upvalues: u3 (copy)
    u3:Disconnect();
end);