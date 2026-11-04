  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local u1 = not RunService:IsRunning() and workspace.CurrentCamera or workspace.Debris;
Random.new(os.clock());

return function(p2) -- Line: 14
    -- upvalues: u1 (copy), EmitModule (copy)
    local Pivot = script.GE:GetPivot();
    local u3 = script.GE:Clone();
    u3.Parent = u1;
    u3:PivotTo(p2.Pos);

    for _, child in u3:GetChildren() do
        if child:IsA("BasePart") then
            child.Anchored = true;
            child.CanCollide = false;
            child.Transparency = 1;
        end;
    end;

    EmitModule.emit(u3);
    local u4 = script.bigflowers:Clone();
    u4:PivotTo(p2.Pos * Pivot:ToObjectSpace(script.bigflowers:GetPivot()));
    u4.Parent = u1;

    for _, descendant in u4:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
        end;
    end;

    local v5 = u4:FindFirstChildOfClass("AnimationController");
    local v6;

    if v5 then
        local v7 = v5:FindFirstChildOfClass("Animator") or Instance.new("Animator");
        v7.Parent = v5;
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://112758133677340";
        v6 = v7:LoadAnimation(Animation);
        v6.Looped = false;
        v6:Play();
    else
        v6 = nil;
    end;

    if v6 then
        v6.Stopped:Once(function() -- Line: 53
            -- upvalues: u4 (ref)
            if u4 then
                u4:Destroy();
                u4 = nil;
            end;
        end);
    else
        task.delay(8, function() -- Line: 57
            -- upvalues: u4 (ref)
            if u4 then
                u4:Destroy();
                u4 = nil;
            end;
        end);
    end;

    task.delay(8, function() -- Line: 62
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
end;