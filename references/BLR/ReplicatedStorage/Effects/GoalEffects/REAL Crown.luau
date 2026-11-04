  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local u1 = not RunService:IsRunning() and workspace.CurrentCamera or workspace.Debris;

return function(p2) -- Line: 8
    -- upvalues: u1 (copy), EmitModule (copy)
    if not (p2 and p2.Pos) then
        return;
    end;

    local v3 = p2.Pos * CFrame.new(0, -5, 5);
    local u4 = script.Crown:Clone();
    local HumanoidRootPart = u4:FindFirstChild("HumanoidRootPart");

    for _, descendant in u4:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = descendant == HumanoidRootPart;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
        end;
    end;

    if HumanoidRootPart then
        u4.PrimaryPart = HumanoidRootPart;
    end;

    u4:PivotTo(v3);
    u4.Parent = u1;
    local v5 = u4:FindFirstChildOfClass("Humanoid");
    local v6;

    if v5 then
        v6 = v5:FindFirstChildOfClass("Animator") or Instance.new("Animator");
    else
        v6 = v5;
    end;

    if v6 and v5 then
        v6.Parent = v5;
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://76135130705463";
        local v7 = v6:LoadAnimation(Animation);
        v7.Looped = false;
        v7:Play();
        v7.Stopped:Once(function() -- Line: 37
            -- upvalues: u4 (copy)
            if u4 then
                u4:Destroy();
            end;
        end);
    end;

    task.delay(12, function() -- Line: 39
        -- upvalues: u4 (copy)
        if u4 then
            u4:Destroy();
        end;
    end);
    local u8 = script.GE:Clone();

    for _, descendant in u8:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
        end;
    end;

    for _, child in u8:GetChildren() do
        if child:IsA("BasePart") then
            child.Transparency = 1;
        end;
    end;

    u8:PivotTo(v3);
    u8.Parent = u1;
    pcall(function() -- Line: 55
        -- upvalues: EmitModule (ref), u8 (copy)
        EmitModule.emit(u8);
    end);
    task.delay(8, function() -- Line: 56
        -- upvalues: u8 (copy)
        if u8 then
            u8:Destroy();
        end;
    end);
end;