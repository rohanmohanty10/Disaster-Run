  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local u1 = ReplicatedStorage.Assets.GoalEffects:WaitForChild("World Trophy GE");

local function getTargetParent() -- Line: 11
    -- upvalues: RunService (copy)
    if RunService:IsRunning() then
        return workspace:FindFirstChild("Debris") or workspace;
    end;

    return workspace.CurrentCamera or workspace;
end;

return function(p2) -- Line: 19
    -- upvalues: u1 (copy), RunService (copy), EmitModule (copy)
    local u3 = u1.GE:Clone();
    local v4;

    if RunService:IsRunning() then
        v4 = workspace:FindFirstChild("Debris") or workspace;
    else
        v4 = workspace.CurrentCamera or workspace;
    end;

    u3.Parent = v4;
    u3:PivotTo(p2.Pos);

    for _, descendant in u3:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.CastShadow = false;
        end;
    end;

    local VFX = u3.VFX;

    for _, child in VFX:GetChildren() do
        if child:IsA("BasePart") then
            child.Anchored = true;
            child.Transparency = 1;
        end;
    end;

    EmitModule.emit(VFX);
    local u5 = u3.Trophy:FindFirstChildOfClass("Humanoid");

    if u5 then
        u5 = u5:FindFirstChildOfClass("Animator");
    end;

    if u5 then
        local success, result = pcall(function() -- Line: 48
            -- upvalues: u5 (copy), u1 (ref)
            return u5:LoadAnimation(u1.TrophyAnimation);
        end);

        if success and result then
            result.Priority = Enum.AnimationPriority.Action;
            result.Looped = true;
            result:Play();
        else
            warn((`Failed to load World Trophy GE trophy animation: {result}`));
        end;
    end;

    task.delay(8, function() -- Line: 61
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
end;