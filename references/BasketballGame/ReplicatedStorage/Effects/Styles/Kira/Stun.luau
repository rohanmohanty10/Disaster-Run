 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local DarkScreenEffect = require(script.Parent.Parent.ScreenEffects.DarkScreenEffect);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 13
    -- upvalues: Debris (copy), VfxManager (copy), LocalPlayer (copy), DarkScreenEffect (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Enemy = p2.Enemy;
    local HumanoidRootPart = Enemy:FindFirstChild("HumanoidRootPart");

    if Enemy and HumanoidRootPart then
        local v3 = script.Impact:Clone();
        v3.CFrame = CFrame.new(HumanoidRootPart.Position.X, 1, HumanoidRootPart.Position.Z);
        v3.Parent = Debris;
        VfxManager.DestroyEffect(v3, 2);
        shared.vfx.emit(v3);

        if LocalPlayer.Character == Enemy then
            DarkScreenEffect();
        end;
    end;
end;