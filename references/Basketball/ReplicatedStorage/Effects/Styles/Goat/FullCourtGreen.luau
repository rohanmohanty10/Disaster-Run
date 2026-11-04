 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local Module = require(script.Parent.Mesh.Module);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: SfxManager (copy), Players (copy), Debris (copy), VfxManager (copy), Module (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);
    task.delay(0.6833333333333333, function() -- Line: 25
        -- upvalues: SfxManager (ref), HumanoidRootPart (copy)
        SfxManager:playSound({
            Sound = "BBZ Goat Full Court Green",
            Parent = HumanoidRootPart
        });
    end);
    task.delay(0.9333333333333333 - v3, function() -- Line: 29
        -- upvalues: Players (ref), Character (copy), HumanoidRootPart (copy), BALL (copy), Debris (ref), VfxManager (ref), Module (ref)
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(Character);

        if PlayerFromCharacter and PlayerFromCharacter.Team ~= game.Teams.Visitor then
            local _, v4, _ = CFrame.new(HumanoidRootPart.Position, workspace.Hoops[PlayerFromCharacter.Team.Name].Hoop.Position):ToOrientation();
            local v5 = script.Shoot:Clone();
            v5:PivotTo(CFrame.new(BALL.Position) * CFrame.fromOrientation(-1.0471975511965976, v4, 0));
            v5.Parent = Debris;
            VfxManager.BetterEmit(v5);
            VfxManager.DestroyEffect(v5, 4);
            Module(CFrame.new(HumanoidRootPart.Position) * CFrame.fromOrientation(0, v4, 0) * CFrame.new(0, -2.139, 4.513) * CFrame.fromOrientation(0.3267256359733385, 0, 0.06461208890883008), Debris);
        end;
    end);
end;