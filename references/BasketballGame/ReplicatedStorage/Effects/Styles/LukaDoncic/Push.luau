 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 12
    -- upvalues: Debris (copy), Essentials (copy), VfxManager (copy), SfxManager (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Enemy = p2.Enemy;
    local HumanoidRootPart = p2.Character:FindFirstChild("HumanoidRootPart");
    local v3 = script.Push:Clone();
    v3.Parent = Debris;
    v3.CFrame = CFrame.lookAt(Enemy.HumanoidRootPart.Position, HumanoidRootPart.Position) * CFrame.new(0, 0, -1) * CFrame.Angles(0, 3.141592653589793, 0);
    Essentials:Weld(v3, Enemy.HumanoidRootPart);
    VfxManager.Emit(v3);
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

    SfxManager:playSound({
        Sound = "BBZ LukaDoncic Push",
        Parent = v3
    });
end;