  

 

local TweenService = game:GetService("TweenService");
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);

return function(u1, p2) -- Line: 7
    -- upvalues: TweenService (copy), EffectsHandler (copy)
    local v3 = p2 or 0.2;
    local CFrame2 = u1.HumanoidRootPart.CFrame;
    local v4 = script.Plank:Clone();
    v4.Parent = workspace.Effects;
    v4.CFrame = CFrame2 * CFrame.new(0, 8, 0);
    local v5 = TweenService:Create(v4, TweenInfo.new(v3, Enum.EasingStyle.Linear), {
        CFrame = CFrame2 * CFrame.new(0, -3, 0)
    });
    v5:Play();
    v5.Completed:Connect(function() -- Line: 19
        -- upvalues: EffectsHandler (ref), CFrame2 (copy), u1 (copy)
        EffectsHandler.CallEffect("Slam Effect", {
            Radius = 7,
            Origin = CFrame2,
            Character = u1
        });
    end);
    task.delay(v3 * 4, v4.Destroy, v4);
end;