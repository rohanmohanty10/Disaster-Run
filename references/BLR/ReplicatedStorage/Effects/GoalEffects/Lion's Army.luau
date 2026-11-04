  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 9
    -- upvalues: VfxManager (copy), TweenService (copy)
    local v2 = script.GoalExplosion:Clone();
    local v3 = script.MainModel:Clone();
    v3.Parent = workspace.Debris;
    v2.Parent = workspace.Debris;
    v2:PivotTo(p1.Pos * CFrame.new(0, 10, 0));
    VfxManager.Emit(v2);
    v3:PivotTo(p1.Pos * CFrame.new(40, 10, 0) * CFrame.Angles(0, 1.5707963267948966, 0));
    local Children = v3:GetChildren();

    for _, descendant in v3:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1;
            TweenService:Create(descendant, TweenInfo.new(0.3), {
                Transparency = 0
            }):Play();
            task.delay(1.8, function() -- Line: 24
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant, TweenInfo.new(0.3), {
                    Transparency = 1
                }):Play();
            end);
        end;
    end;

    for _, v in Children do
        local v4 = v:FindFirstChildOfClass("AnimationController"):LoadAnimation((v:FindFirstChildOfClass("Animation")));
        v4:Play();
        v4:AdjustSpeed(0.5);
    end;

    task.wait(5);
    v2:Destroy();
    v3:Destroy();
end;