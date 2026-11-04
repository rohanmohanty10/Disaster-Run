 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);

return function(p1, p2) -- Line: 9
    -- upvalues: SfxManager (copy), VfxManager (copy)
    SfxManager:playSound({
        Sound = "ErrorSFX",
        Parent = workspace
    });
    local v3 = script.Model:Clone();
    v3.Parent = workspace.Debris;
    v3:PivotTo(p2.CFrame * CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0));
    VfxManager.BetterEmit(v3);
    VfxManager.DestroyEffect(v3, 4);
end;