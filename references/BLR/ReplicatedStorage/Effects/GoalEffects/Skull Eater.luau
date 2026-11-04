  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local u1 = not RunService:IsRunning() and workspace.CurrentCamera or workspace.Debris;

return function(p2) -- Line: 8
    -- upvalues: u1 (copy), EmitModule (copy)
    local u3 = script.SkullRig:Clone();
    u3.Parent = u1;
    u3:PivotTo(p2.Pos * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(0, 0, 10));

    for _, descendant in u3:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.Anchored = false;
            descendant.Massless = true;
        end;
    end;

    u3.PrimaryPart.Anchored = true;
    local u4 = script.SkullVFX:Clone();
    u4.Parent = u1;
    u4.CFrame = u3.PrimaryPart.CFrame * script.SkullRig.PrimaryPart.CFrame:ToObjectSpace(script.SkullVFX.CFrame);
    u4.Anchored = true;
    u4.CanCollide = false;
    u4.Transparency = 1;
    EmitModule.emit(u4);
    local v5 = u3:FindFirstChildWhichIsA("AnimationController");

    if v5 then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://76050134584996";
        local v6 = v5:LoadAnimation(Animation);
        v6.Looped = false;
        v6:Play();
        v6.Stopped:Once(function() -- Line: 39
            -- upvalues: u3 (copy)
            u3:Destroy();
        end);
    else
        task.delay(8, function() -- Line: 43
            -- upvalues: u3 (copy)
            u3:Destroy();
        end);
    end;

    task.delay(8, function() -- Line: 48
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;