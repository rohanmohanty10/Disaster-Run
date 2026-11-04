 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local Module = require(script.Parent.Mesh.Module);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy), Players (copy), Module (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Head = Character:FindFirstChild("Head");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task == "SleepShot" or p2.Task == "AuraShot" then
        SfxManager:playSound({
            Sound = `BBZ Goat {p2.Task == "SleepShot" and "Sleep" or (p2.Task == "AuraShot" and "Aura" or false)} Shot`,
            Parent = HumanoidRootPart
        }).TimePosition = 0.25;

        if p2.Task == "AuraShot" then
            task.delay(0.5 - v3, function() -- Line: 31
                -- upvalues: Debris (ref), HumanoidRootPart (copy), Essentials (ref), VfxManager (ref)
                local v4 = script.Teleport:Clone();
                v4.Parent = Debris;
                v4.CFrame = HumanoidRootPart.CFrame;
                Essentials:Weld(v4, HumanoidRootPart);
                VfxManager.BetterEmit(v4);
                VfxManager.DestroyEffect(v4, 2);
            end);
        end;

        task.delay((p2.Task == "SleepShot" and 0.9833333333333333 or (p2.Task == "AuraShot" and 0.5833333333333334 or false)) - v3, function() -- Line: 41
            -- upvalues: Players (ref), Character (copy), HumanoidRootPart (copy), BALL (copy), Debris (ref), VfxManager (ref), Module (ref)
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(Character);

            if PlayerFromCharacter and PlayerFromCharacter.Team ~= game.Teams.Visitor then
                local _, v5, _ = CFrame.new(HumanoidRootPart.Position, workspace.Hoops[PlayerFromCharacter.Team.Name].Hoop.Position):ToOrientation();
                local v6 = script.Shoot:Clone();
                v6:PivotTo(CFrame.new(BALL.Position) * CFrame.fromOrientation(-1.0471975511965976, v5, 0));
                v6.Parent = Debris;
                VfxManager.BetterEmit(v6);
                VfxManager.DestroyEffect(v6, 4);
                Module(CFrame.new(HumanoidRootPart.Position) * CFrame.fromOrientation(0, v5, 0) * CFrame.new(0, -2.139, 4.513) * CFrame.fromOrientation(0.3267256359733385, 0, 0.06461208890883008), Debris);
            end;
        end);
        task.delay((p2.Task == "SleepShot" and 2.433333333333333 or 2.3) - v3, function() -- Line: 56
            -- upvalues: Head (copy), Debris (ref), Essentials (ref), VfxManager (ref)
            local v7 = script.Sleep:Clone();
            v7:PivotTo(Head.CFrame * CFrame.new(0.513, -0.439, 0.702) * CFrame.fromOrientation(-1.1004999065525045, 0, 0.0633729051399141));
            v7.Parent = Debris;
            Essentials:Weld(v7, Head);
            VfxManager.BetterEmit(v7);
            VfxManager.DestroyEffect(v7, 2);
        end);
    end;
end;