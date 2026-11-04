 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local SilverScreenEffect = require(script.Parent.Parent.ScreenEffects.SilverScreenEffect);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 18
    -- upvalues: Players (copy), SfxManager (copy), Debris (copy), VfxManager (copy), LocalPlayer (copy), SilverScreenEffect (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Torso");

    if p2.Task == "Dunk" then
        SfxManager:playSound({
            Sound = "BBZ Silver Titan Smash",
            Parent = HumanoidRootPart
        });
        local v4 = script.TitanSmash.Dash:Clone();
        v4.Parent = Debris;
        v4:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v4, 2);
        shared.vfx.emit(v4);
        task.delay((0.6 - v3) / 1.5, function() -- Line: 38
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            local v5 = script.TitanSmash.Land:Clone();
            v5.Parent = Debris;
            v5:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v5, 2);
            shared.vfx.emit(v5);
        end);
        task.delay((0.8333333333333334 - v3) / 1.5, function() -- Line: 47
            -- upvalues: LocalPlayer (ref), Character (copy), SilverScreenEffect (ref), Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            if LocalPlayer.Character == Character then
                SilverScreenEffect();
            end;

            local v6 = script.TitanSmash.Jump:Clone();
            v6.Parent = Debris;
            v6:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v6, 2);
            shared.vfx.emit(v6);
        end);

        return;
    end;

    if p2.Task ~= "Shove" then
        if p2.Task == "Shoved" then
            SfxManager:playSound({
                Sound = "BBZ Silver Dirty Shove Hit",
                Parent = HumanoidRootPart
            });

            if LocalPlayer.Character == Character then
                SilverScreenEffect();
            end;
        end;

        return;
    end;

    local Character2 = p2.Character;
    local HumanoidRootPart2 = Character2:FindFirstChild("HumanoidRootPart");
    SfxManager:playSound({
        Sound = "BBZ Silver Dirty Shove",
        Parent = HumanoidRootPart2
    });
    local Highlight = Instance.new("Highlight", Character2);
    Highlight.Name = script.Name .. "Highlight";
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(47, 255, 116);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    VfxManager.DestroyEffect(Highlight, 0.5 - v3);
    task.wait(0.25 - v3);
    local v7 = script.DirtyShove.Shove:Clone();
    v7.Parent = Debris;
    v7:PivotTo(HumanoidRootPart2.CFrame);
    VfxManager.DestroyEffect(v7, 2);
    shared.vfx.emit(v7);
end;