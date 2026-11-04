  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ContentProvider = game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local u1 = ReplicatedStorage.Assets.GoalEffects:WaitForChild("Eagle Roar");
local Animation = u1:WaitForChild("Animation");
task.spawn(function() -- Line: 13
    -- upvalues: ContentProvider (copy), u1 (copy)
    local success, result = pcall(function() -- Line: 14
        -- upvalues: ContentProvider (ref), u1 (ref)
        ContentProvider:PreloadAsync({ u1 });
    end);

    if not success then
        warn("[Eagle Roar] Could not preload assets:", result);
    end;
end);

return function(p2) -- Line: 22
    -- upvalues: u1 (copy), RunService (copy), Animation (copy), EmitModule (copy)
    if p2 and typeof(p2.Pos) == "CFrame" then
        local u3 = u1.GE:Clone();

        if p2.IsPodiumPreview then
            u3:ScaleTo(u3:GetScale() * 0.08);

            for _, descendant in u3.Scene1:GetDescendants() do
                if descendant:HasTag("CameraShake") then
                    descendant:Destroy();
                end;
            end;
        end;

        u3:PivotTo(p2.Pos);
        local v4;

        if p2.IsPodiumPreview then
            v4 = p2.Parent;
        elseif RunService:IsRunning() then
            v4 = workspace:FindFirstChild("Debris") or workspace;
        else
            v4 = workspace.CurrentCamera or workspace;
        end;

        u3.Parent = v4;
        task.delay(12, function() -- Line: 41
            -- upvalues: u3 (copy)
            u3:Destroy();
        end);
        local Phoenix = u3.Phoenix;
        task.delay(5, function() -- Line: 46
            -- upvalues: Phoenix (copy)
            Phoenix:Destroy();
        end);
        local Animator = Phoenix.AnimationController.Animator;
        local success, result = pcall(function() -- Line: 51
            -- upvalues: Animator (copy), Animation (ref)
            return Animator:LoadAnimation(Animation);
        end);

        if success then
            result.Looped = false;
            result.Priority = Enum.AnimationPriority.Action;
            result.Stopped:Once(function() -- Line: 58
                -- upvalues: Phoenix (copy)
                Phoenix:Destroy();
            end);
            result:Play(0);
        else
            warn("[Eagle Roar] Could not load phoenix animation:", result);
        end;

        EmitModule.emit(u3.Scene1);

        return u3;
    end;
end;