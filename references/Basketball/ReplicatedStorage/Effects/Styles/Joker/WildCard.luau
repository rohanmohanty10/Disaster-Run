 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: Players (copy), Debris (copy), VfxManager (copy), SfxManager (copy), Essentials (copy), Effects (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local u4 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task == "Smoke Trick Start" then
        task.delay(0.65 - v3, function() -- Line: 25
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref), SfxManager (ref), Essentials (ref), Character (copy)
            local v5 = script.Smoke1:Clone();
            v5.Parent = Debris;
            v5.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, -1.5, 0);
            VfxManager.Emit(v5);
            VfxManager.DestroyEffect(v5, 2);
            SfxManager:playSound({
                Sound = "BBZ Joker Smoke Trick Start",
                Parent = v5
            });
            Essentials:HideCharacter(Character, {});
            task.delay(2, function() -- Line: 36
                -- upvalues: Essentials (ref), Character (ref)
                Essentials:UnhideCharacter(Character, {});
            end);
        end);

        return;
    end;

    if p2.Task ~= "Smoke Trick End" then
        if p2.Task == "Wild Card" then
            local Highlight = Instance.new("Highlight", Character);
            Highlight.Name = script.Name .. "Highlight";
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.FillColor = Color3.fromRGB(0, 0, 0);
            Highlight.OutlineColor = Color3.fromRGB(155, 0, 255);
            Highlight.OutlineTransparency = 0;
            Highlight.FillTransparency = 1;
            VfxManager.DestroyEffect(Highlight, 1 - v3);
            task.delay(1 - v3, function() -- Line: 60
                -- upvalues: BALL (copy), Effects (ref), u4 (copy), Debris (ref), Essentials (ref), VfxManager (ref), SfxManager (ref), HumanoidRootPart (copy)
                if BALL then
                    Effects:SubtitleV2({
                        { u4, "You really thought you could keep that?", 2 }
                    });
                    local v6 = script.Ball:Clone();
                    v6.Parent = Debris;
                    v6.CFrame = BALL.CFrame;
                    Essentials:Weld(v6, BALL);
                    VfxManager.Emit(v6);
                    VfxManager.DestroyEffect(v6, 2);
                    SfxManager:playSound({
                        Sound = "BBZ Joker Wild Card",
                        Parent = v6
                    });
                    SfxManager:playSound({
                        Sound = "BBZ Joker Wild Card Voice",
                        Parent = HumanoidRootPart
                    });
                end;
            end);
        end;

        return;
    end;

    local v7 = script.Smoke2:Clone();
    v7.Parent = Debris;
    v7.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, -1.5, 0);
    VfxManager.Emit(v7);
    VfxManager.DestroyEffect(v7, 2);
    SfxManager:playSound({
        Sound = "BBZ Joker Smoke Trick End",
        Parent = v7
    });
    Essentials:UnhideCharacter(Character, {});
end;