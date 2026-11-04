 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: Debris (copy), Essentials (copy), VfxManager (copy), ReplicatedStorage (copy), SfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if Character:GetAttribute("Invis") then
        return;
    end;

    local v4 = script.Teleport:Clone();
    v4.Parent = Debris;
    v4.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(v4, HumanoidRootPart);
    VfxManager.BetterEmit(v4);
    VfxManager.DestroyEffect(v4, 2);

    if p2.ZoneColor then
        local ZoneColor = p2.ZoneColor;
        local v5 = ZoneColor == "" and Color3.fromHSV(1, 0, 1) or Color3.fromHex(ZoneColor);

        for _, descendant in v4:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Color = ColorSequence.new(v5);
            end;
        end;
    end;

    local v6 = ReplicatedStorage.Assets.SFX.Zones:FindFirstChild("ShadowDribble" .. p2.DribblesDone);

    if not v6 then
        local v7 = {};

        for _, child in ReplicatedStorage.Assets.SFX.Zones:GetChildren() do
            if string.find(child.Name, "ShadowDribble") then
                table.insert(v7, child);
            end;
        end;

        v6 = v7[math.random(1, #v7)];
    end;

    SfxManager:playSound({
        Sound = v6.Name,
        Parent = v4
    });
    local v8 = Essentials:CreateClone(Character);
    VfxManager.DestroyEffect(v8, 0.5);
    local u9 = { Character:FindFirstChild("BALL", true), Character:FindFirstChild("PlrBall") };
    Essentials:HideCharacter(Character, u9);
    task.delay(0.2 - v3, function() -- Line: 59
        -- upvalues: Essentials (ref), Character (copy), u9 (copy)
        Essentials:UnhideCharacter(Character, u9);
    end);
end;