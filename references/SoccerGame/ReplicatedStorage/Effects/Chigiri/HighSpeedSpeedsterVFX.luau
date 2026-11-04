  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Players = game:GetService("Players");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 15
    -- upvalues: Players (copy), SoundManager (copy), RunService (copy), VfxManager (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Char);
    local Team = PlayerFromCharacter.Team;
    SoundManager.SpawnSound("High-speed speedster", 0.9, Char.HumanoidRootPart, 130, false);
    local u2 = script.EnabledRunVFX:Clone();
    u2.Parent = workspace.Debris;
    local Folder = Instance.new("Folder");
    Folder.Name = "ChigiriHighlight";
    Folder.Parent = Char;
    local u3 = nil;
    u3 = RunService.Heartbeat:Connect(function() -- Line: 33
        -- upvalues: u2 (copy), HumanoidRootPart (copy), PlayerFromCharacter (copy), Team (copy), u3 (ref)
        u2:PivotTo(HumanoidRootPart.CFrame);

        if PlayerFromCharacter.Team ~= Team then
            u3:Disconnect();
            u2:Destroy();
        end;
    end);
    task.wait(4.5);
    Folder:Destroy();

    if u3 then
        u3:Disconnect();
    end;

    VfxManager.Enable(u2, false);
    task.wait(1);

    if u2 then
        u2:Destroy();
    end;
end;