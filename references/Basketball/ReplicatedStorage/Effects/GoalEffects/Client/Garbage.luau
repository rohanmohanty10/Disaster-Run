 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 12
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), TweenService (copy)
    local CFrame2 = p2.CFrame;
    SfxManager:playSound({
        Sound = "BBZ Trash Goal Effect",
        Parent = workspace
    });
    local v3 = script.HoopEmitFX:Clone();
    v3.CFrame = CFrame2;
    v3.Parent = Debris;
    VfxManager.Emit(v3);
    VfxManager.DestroyEffect(v3, 3);
    local v4 = script.GarbageAura:Clone();
    v4.CFrame = CFrame2 * CFrame.new(0, 80, 0);
    v4.Parent = Debris;
    VfxManager.Enable(v4, true);
    local v5 = script.GarbageDissapearFX:Clone();
    v5.CFrame = CFrame2 * CFrame.new(0, 80, 0);
    v5.Parent = Debris;
    VfxManager.Emit(v5);
    VfxManager.DestroyEffect(v5, 3);
    TweenService:Create(v4, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
        CFrame = CFrame2 * CFrame.new(0, 3, 0)
    }):Play();
    task.wait(2);
    local v6 = script.GarbageDissapearFX:Clone();
    v6.CFrame = CFrame2 * CFrame.new(0, 3, 0);
    v6.Parent = Debris;
    VfxManager.Emit(v6);
    VfxManager.DestroyEffect(v6, 3);
    VfxManager.Enable(v4, false);
    VfxManager.DestroyEffect(v4, 3);
    v4.Transparency = 1;
end;