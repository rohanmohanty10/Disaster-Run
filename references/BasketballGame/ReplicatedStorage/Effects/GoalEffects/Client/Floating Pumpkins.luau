 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy)
    SfxManager:playSound({
        Sound = "Floating PumpkinsSFX",
        Parent = workspace
    });
    local u3 = script.Pumpkins:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame);
    u3["1"].AnimationController.Animator:LoadAnimation(script["1"]):Play();
    u3["2"].AnimationController.Animator:LoadAnimation(script["2"]):Play();
    u3["3"].AnimationController.Animator:LoadAnimation(script["3"]):Play();
    VfxManager.Emit(u3.Score);
    VfxManager.Enable(u3.Portal, true);
    task.delay(2.7, function() -- Line: 25
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Emit(u3.Portal.Despawn);
        VfxManager.Enable(u3.Portal, false);
        u3["1"]:Destroy();
        u3["2"]:Destroy();
        u3["3"]:Destroy();
    end);
    VfxManager.DestroyEffect(u3, 6);
end;