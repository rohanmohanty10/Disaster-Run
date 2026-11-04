 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 15
    -- upvalues: LocalPlayer (copy), Debris (copy), VfxManager (copy)
    local CFrame = p2.CFrame;
    local _ = game.Lighting;
    LocalPlayer:FindFirstChild("PlayerGui");
    local v3 = script.FireWorks:Clone();
    v3:PivotTo(CFrame);
    v3.Parent = Debris;
    VfxManager.Emit(v3);
    VfxManager.DestroyEffect(v3, 5);

    if p2.Preview then
        v3:ScaleTo(0.3333333333333333);
    end;
end;