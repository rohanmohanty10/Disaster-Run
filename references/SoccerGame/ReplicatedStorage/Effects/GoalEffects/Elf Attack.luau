  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(u1) -- Line: 7
    -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
    local u2 = ReplicatedStorage.Assets.GoalEffects["Elf Attack"].ElfAttackGoalEffect:Clone();
    u2.Parent = workspace;
    u2:PivotTo(u1.Pos * CFrame.Angles(0, 1.5707963267948966, 0) + Vector3.new(20, 10, 0));
    VfxManager.Emit(u2);
    local u3 = ReplicatedStorage.Assets.GoalEffects["Elf Attack"].Present:Clone();
    u3.Parent = workspace;
    u3:PivotTo(u1.Pos * CFrame.Angles(0, -1.5707963267948966, 0) + Vector3.new(15, 1, 0));
    local u4 = {};

    for _, child in u3:GetChildren() do
        local Anim = child:FindFirstChild("Anim");

        if Anim then
            local Animator = child:FindFirstChild("Animator", true);

            if Animator then
                local u5 = Animator:LoadAnimation(Anim);
                u5:Play();
                u4[u5] = u5:GetMarkerReachedSignal("Freeze"):Once(function() -- Line: 33
                    -- upvalues: u5 (copy)
                    u5:AdjustSpeed(0);
                end);
            end;
        end;
    end;

    task.delay(8, function() -- Line: 38
        -- upvalues: u2 (copy), u3 (copy), u4 (copy)
        u2:Destroy();
        u3:Destroy();

        for i, v in u4 do
            v:Disconnect();
            u4[i] = nil;
        end;
    end);
    task.delay(12, function() -- Line: 48
        -- upvalues: u1 (ref)
        table.clear(u1);
        u1 = nil;
    end);
end;