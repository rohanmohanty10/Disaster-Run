 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Lighting");
game:GetService("TweenService");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 12
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy)
    if not p2.Preview then
        SfxManager:playSound({
            Sound = "Super SlamSFX",
            Parent = workspace
        });
        local u3 = script.Model:Clone();
        u3.Parent = Debris;
        u3:PivotTo(p2.CFrame);
        u3.Chrollo.AnimationController.Animator:LoadAnimation(script.ChrolloAnimation):Play();
        u3.Tatlis.AnimationController.Animator:LoadAnimation(script.TatlisAnimation):Play();
        VfxManager.BetterEmit(u3.Jump.Appear);
        task.delay(0.6666666666666666, function() -- Line: 25
            -- upvalues: VfxManager (ref), u3 (copy)
            VfxManager.BetterEmit(u3.Jump);
        end);
        task.delay(1.8666666666666667, function() -- Line: 29
            -- upvalues: VfxManager (ref), u3 (copy)
            VfxManager.BetterEmit(u3.Fool);
        end);
        task.delay(2.316666666666667, function() -- Line: 33
            -- upvalues: u3 (copy)
            u3.Chrollo:Destroy();
            u3.Tatlis:Destroy();
        end);
        VfxManager.DestroyEffect(u3, 6);

        return;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Parent = workspace.Terrain;
    Attachment.WorldPosition = p2.CFrame.Position;
    SfxManager:playSound({
        Sound = "Super SlamSFX",
        Parent = Attachment
    }).Ended:Once(function() -- Line: 45
        -- upvalues: Attachment (copy)
        Attachment:Destroy();
    end);
    local u4 = script.Model:Clone();
    u4.Parent = workspace.Debris;
    u4:PivotTo(p2.CFrame * CFrame.Angles(0, -1.5707963267948966, 0));
    u4:ScaleTo(0.3333333333333333);
    u4.Chrollo.AnimationController.Animator:LoadAnimation(script.ChrolloAnimation):Play();
    u4.Tatlis.AnimationController.Animator:LoadAnimation(script.TatlisAnimation):Play();
    task.delay(0.6666666666666666, function() -- Line: 57
        -- upvalues: VfxManager (ref), u4 (copy)
        VfxManager.BetterEmit(u4.Jump);
    end);
    task.delay(1.8666666666666667, function() -- Line: 61
        -- upvalues: VfxManager (ref), u4 (copy)
        VfxManager.BetterEmit(u4.Fool);
    end);
    task.delay(2.316666666666667, function() -- Line: 65
        -- upvalues: u4 (copy)
        u4.Chrollo:Destroy();
        u4.Tatlis:Destroy();
    end);
    VfxManager.DestroyEffect(u4, 6);
end;