 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 12
    -- upvalues: Debris (copy), VfxManager (copy), TweenService (copy)
    local u3 = script.Model:Clone();
    u3.Parent = Debris;

    if p2.Preview then
        u3:PivotTo(p2.CFrame);
        u3:ScaleTo(0.3333333333333333);
    else
        u3:PivotTo(p2.CFrame * CFrame.fromOrientation(0, 1.5707963267948966, 0));
    end;

    u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    VfxManager.Emit(u3.Score);
    task.delay(1.25, function() -- Line: 27
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Emit(u3.Hit);
    end);
    task.delay(1.9333333333333333, function() -- Line: 31
        -- upvalues: u3 (copy), TweenService (ref)
        for _, descendant in u3:GetDescendants() do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end;
    end);
    VfxManager.DestroyEffect(u3, 4);
end;