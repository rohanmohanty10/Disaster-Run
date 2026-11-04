 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 12
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy)
    if not p2.Preview then
        SfxManager:playSound({
            Sound = "GoatSFX",
            Parent = workspace
        });
        local u3 = script.Model:Clone();
        u3.Parent = Debris;
        u3:PivotTo(p2.CFrame * CFrame.Angles(0, 1.5707963267948966, 0));
        u3.Goat.AnimationController.Animator:LoadAnimation(script.Animation):Play();
        VfxManager.BetterEmit(u3.Score);
        task.delay(1.5, function() -- Line: 23
            -- upvalues: VfxManager (ref), u3 (copy)
            VfxManager.BetterEmit(u3.Goat);
        end);
        VfxManager.DestroyEffect(u3.Goat, 3.1);
        VfxManager.DestroyEffect(u3, 8);

        return;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Parent = workspace.Terrain;
    Attachment.WorldPosition = p2.CFrame.Position;
    SfxManager:playSound({
        Sound = "GoatSFX",
        Parent = Attachment
    }).Ended:Once(function() -- Line: 35
        -- upvalues: Attachment (copy)
        Attachment:Destroy();
    end);
    local u4 = script.Model:Clone();
    u4.Parent = Debris;
    u4:PivotTo(p2.CFrame);
    u4:ScaleTo(0.2);
    u4.Goat.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    VfxManager.BetterEmit(u4.Score);
    task.delay(1.5, function() -- Line: 47
        -- upvalues: VfxManager (ref), u4 (copy)
        VfxManager.BetterEmit(u4.Goat);
    end);
    VfxManager.DestroyEffect(u4.Goat, 3.1);
    VfxManager.DestroyEffect(u4, 8);
end;