  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);

return function(p1) -- Line: 11
    -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
    local v2 = ReplicatedStorage.Assets.Vfx.RingsWind:Clone();
    v2.Parent = p1.Char;
    v2.CFrame = p1.Char.HumanoidRootPart.CFrame;
    Essentials:Weld(v2, p1.Char.HumanoidRootPart);
    local FireFootL = v2.FireFootL;
    local FireFootR = v2.FireFootR;
    local L = v2.L;
    local R = v2.R;
    v2.FireFootL.Parent = p1.Char["Right Leg"];
    v2.FireFootR.Parent = p1.Char["Left Leg"];
    v2.L.Parent = p1.Char.Head;
    v2.R.Parent = p1.Char.Head;
    task.wait(0.3);
    VfxManager.Enable(v2, false);
    VfxManager.Enable(FireFootL, false);
    VfxManager.Enable(FireFootR, false);
    VfxManager.Enable(L, false);
    VfxManager.Enable(R, false);
    task.wait(1);
    L:Destroy();
    R:Destroy();
    v2:Destroy();
    FireFootL:Destroy();
    FireFootR:Destroy();
    table.clear(p1);
end;