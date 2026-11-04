  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local u1 = not RunService:IsRunning() and workspace.CurrentCamera or workspace.Debris;
Random.new(os.clock());

return function(p2) -- Line: 16
    -- upvalues: u1 (copy), EmitModule (copy)
    local _ = game.Players.LocalPlayer;
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
    local bear = script:FindFirstChild("bear");

    if bear then
        local u4 = bear:Clone();
        u4:PivotTo(p2.Pos * Pivot:ToObjectSpace(bear:GetPivot()));
        u4.Parent = u1;

        for _, descendant in u4:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false;
                descendant.CanQuery = false;
            end;
        end;

        if u4.PrimaryPart then
            u4.PrimaryPart.Anchored = true;
        end;

        local v5 = u4:FindFirstChildOfClass("AnimationController");
        local v6;

        if v5 then
            local v7 = v5:FindFirstChildOfClass("Animator") or Instance.new("Animator");
            v7.Parent = v5;
            local Animation = Instance.new("Animation");
            Animation.AnimationId = "rbxassetid://87233172031714";
            v6 = v7:LoadAnimation(Animation);
            v6.Looped = false;
            v6:Play();
        else
            v6 = nil;
        end;

        if v6 then
            v6.Stopped:Once(function() -- Line: 67
                -- upvalues: u4 (copy)
                if u4 then
                    u4:Destroy();
                end;
            end);
        else
            task.delay(8, function() -- Line: 71
                -- upvalues: u4 (copy)
                if u4 then
                    u4:Destroy();
                end;
            end);
        end;
    end;

    task.delay(8, function() -- Line: 77
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
end;