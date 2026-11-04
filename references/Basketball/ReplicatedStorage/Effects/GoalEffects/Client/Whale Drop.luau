 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: SfxManager (copy), Knit (copy), Debris (copy), VfxManager (copy), CameraShaker (copy)
    SfxManager:playSound({
        Sound = "WhaleDropSFX",
        Parent = workspace
    });
    local Controller = Knit.GetController("CameraController");
    local u3 = script.Model:Clone();
    u3.Parent = Debris;
    local _, v4, _ = p2.CFrame:ToOrientation();
    u3:PivotTo(CFrame.new(p2.CFrame.Position.X, 1, p2.CFrame.Position.Z) * CFrame.fromOrientation(0, v4 + 1.5707963267948966, 0));
    u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    VfxManager.BetterEmit(u3.Fall);
    task.delay(0.75, function() -- Line: 26
        -- upvalues: Controller (copy), CameraShaker (ref), VfxManager (ref), u3 (copy)
        Controller.CamShake:Shake(CameraShaker.Presets.Dunk);
        VfxManager.Emit(u3.Slam);
    end);
    task.delay(1.7333333333333334, function() -- Line: 32
        -- upvalues: u3 (copy)
        u3.Mesh_0:Destroy();
    end);
    VfxManager.DestroyEffect(u3, 8);
end;