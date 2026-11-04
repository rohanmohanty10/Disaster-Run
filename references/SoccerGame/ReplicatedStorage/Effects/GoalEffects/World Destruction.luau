  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local u1 = ReplicatedStorage.Assets.GoalEffects:WaitForChild("World Destruction");
local Animation = Instance.new("Animation");
Animation.AnimationId = "rbxassetid://101489242184751";

local function getTargetParent() -- Line: 15
    -- upvalues: RunService (copy)
    if RunService:IsRunning() then
        return workspace:FindFirstChild("Debris") or workspace;
    end;

    return workspace.CurrentCamera or workspace;
end;

return function(p2) -- Line: 22
    -- upvalues: u1 (copy), RunService (copy), Animation (copy), VfxManager (copy)
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
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.CastShadow = false;
        end;
    end;

    local GoalVFXReference = u3:FindFirstChild("GoalVFXReference");
    local v5;

    if GoalVFXReference then
        v5 = GoalVFXReference:FindFirstChild("PivotPart");
    else
        v5 = GoalVFXReference;
    end;

    if v5 then
        v5.Transparency = 1;
        v5.Anchored = true;
    end;

    local WORLDELDELDED = u3:FindFirstChild("WORLDELDELDED");

    if WORLDELDELDED then
        WORLDELDELDED = WORLDELDELDED:FindFirstChildOfClass("AnimationController");
    end;

    if WORLDELDELDED then
        local u6 = WORLDELDELDED:FindFirstChildOfClass("Animator");

        if not u6 then
            u6 = Instance.new("Animator");
            u6.Parent = WORLDELDELDED;
        end;

        local success, result = pcall(function() -- Line: 52
            -- upvalues: u6 (ref), Animation (ref)
            return u6:LoadAnimation(Animation);
        end);

        if success and result then
            result.Priority = Enum.AnimationPriority.Action;
            result.Looped = false;
            result:Play();
            result.Stopped:Once(function() -- Line: 59
                -- upvalues: u3 (copy)
                if u3.Parent then
                    u3:Destroy();
                end;
            end);
        else
            warn((`Failed to load World Destruction animation: {result}`));
        end;
    end;

    if GoalVFXReference then
        local Startup = GoalVFXReference:FindFirstChild("Startup");

        if Startup then
            VfxManager.Emit(Startup);
        end;

        task.delay(1, function() -- Line: 74
            -- upvalues: GoalVFXReference (copy), VfxManager (ref)
            local Piece1 = GoalVFXReference:FindFirstChild("Piece1");

            if Piece1 and Piece1.Parent then
                VfxManager.Emit(Piece1);
            end;
        end);
    end;

    task.delay(8, function() -- Line: 82
        -- upvalues: u3 (copy)
        if u3.Parent then
            u3:Destroy();
        end;
    end);
end;