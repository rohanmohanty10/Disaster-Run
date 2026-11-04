 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if Character:GetAttribute("Invis") then
        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Perfection V2 Teleport",
        Parent = HumanoidRootPart
    });
    local v3 = script.Teleport:Clone();
    v3.Parent = Debris;
    v3.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(v3, HumanoidRootPart);
    VfxManager.BetterEmit(v3);
    VfxManager.DestroyEffect(v3, 2);

    if p2.ZoneColor then
        local ZoneColor = p2.ZoneColor;
        local v4 = ZoneColor == "" and Color3.fromHSV(1, 0, 1) or Color3.fromHex(ZoneColor);

        for _, descendant in v3:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Color = ColorSequence.new(v4);
            end;
        end;
    end;
end;