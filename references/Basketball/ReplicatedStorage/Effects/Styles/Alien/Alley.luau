 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 17
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), Players (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("BALL", true);
    SfxManager:playSound({
        Sound = "BBZ Alien Alley",
        Parent = HumanoidRootPart
    });
    local v4 = script.Jump:Clone();
    v4.Parent = Debris;
    v4.CFrame = CFrame.new(HumanoidRootPart.Position.X, 1.1, HumanoidRootPart.Position.Z);
    VfxManager.BetterEmit(v4);
    VfxManager.DestroyEffect(v4, 4);
    task.delay(1.35 - v3, function() -- Line: 34
        -- upvalues: Players (ref), Character (copy), Debris (ref), VfxManager (ref)
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(Character);

        if PlayerFromCharacter and PlayerFromCharacter.Team ~= game.Teams.Visitor then
            local v5 = script.Shoot:Clone();
            v5.Parent = Debris;
            v5.CFrame = CFrame.new(workspace.Hoops[PlayerFromCharacter.Team.Name].Hoop.Position);
            VfxManager.Emit(v5);
            VfxManager.DestroyEffect(v5, 6);
        end;
    end);
end;