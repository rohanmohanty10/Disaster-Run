 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 13
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), TweenService (copy)
    if p2.Preview then
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = workspace.Terrain;
        Attachment.WorldPosition = p2.CFrame.Position;
        SfxManager:playSound({
            Sound = "UFO GoalSFX",
            Parent = Attachment
        }).Ended:Once(function() -- Line: 20
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
    else
        SfxManager:playSound({
            Sound = "UFO GoalSFX",
            Parent = workspace
        });
    end;

    local u3 = script.UFO:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame);

    if p2.Preview then
        u3:ScaleTo(0.3333333333333333);
    end;

    u3.Humanoid:LoadAnimation(script.Animation):Play();
    VfxManager.Emit(u3.Score);
    task.delay(1.4, function() -- Line: 40
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3.Dash, true);
        VfxManager.Emit(u3.lastground, true);
    end);
    task.delay(2.3666666666666667, function() -- Line: 45
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3.Dash, false);
        VfxManager.Emit(u3.lastground, false);
    end);
    task.delay(4.166666666666667, function() -- Line: 50
        -- upvalues: TweenService (ref), u3 (copy), VfxManager (ref)
        TweenService:Create(u3.UFO, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        TweenService:Create(u3.Capsule, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        task.wait(0.25);
        VfxManager.Enable(u3.UFO, false);
    end);
    VfxManager.DestroyEffect(u3, 6);
end;