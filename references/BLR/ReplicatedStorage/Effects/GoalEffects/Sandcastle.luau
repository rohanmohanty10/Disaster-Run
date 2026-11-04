  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local u1 = not RunService:IsRunning() and workspace.CurrentCamera or workspace.Debris;
Random.new(os.clock());

return function(p2) -- Line: 17
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
    local SandCastle = script:FindFirstChild("SandCastle");

    if SandCastle then
        local u4 = SandCastle:Clone();
        local v5 = u4:FindFirstChildOfClass("Humanoid");

        if v5 then
            v5:Destroy();
        end;

        local v6 = u4:FindFirstChildOfClass("AnimationController");

        if not v6 then
            v6 = Instance.new("AnimationController");
            v6.Parent = u4;
        end;

        local v7 = v6:FindFirstChildOfClass("Animator");

        if not v7 then
            v7 = Instance.new("Animator");
            v7.Parent = v6;
        end;

        u4:PivotTo(u3:GetPivot() * Pivot:ToObjectSpace(SandCastle:GetPivot()));
        u4.Parent = u1;

        for _, descendant in u4:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.Massless = true;
            end;
        end;

        if u4.PrimaryPart then
            u4.PrimaryPart.Anchored = true;
        end;

        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://118921968893234";
        local v8 = v7:LoadAnimation(Animation);
        v8.Looped = false;
        v8:Play();
        v8.Stopped:Once(function() -- Line: 72
            -- upvalues: u4 (copy)
            if u4 then
                u4:Destroy();
            end;
        end);
        task.delay(10, function() -- Line: 76
            -- upvalues: u4 (copy)
            if u4 then
                u4:Destroy();
            end;
        end);
    end;

    task.delay(8, function() -- Line: 81
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
end;