  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local u1 = not RunService:IsRunning() and workspace.CurrentCamera or workspace.Debris;
Random.new(os.clock());
local u2 = {
    ["1"] = "rbxassetid://137689343418309",
    ["2"] = "rbxassetid://103027087511911",
    ["3"] = "rbxassetid://103027087511911",
    ["4"] = "rbxassetid://101687044110224"
};

return function(p3) -- Line: 21
    -- upvalues: u1 (copy), EmitModule (copy), u2 (copy)
    local _ = game.Players.LocalPlayer;
    local u4 = script.GE:Clone();
    u4.Parent = u1;
    u4:PivotTo(p3.Pos);

    for _, child in u4:GetChildren() do
        if child:IsA("BasePart") then
            child.Anchored = true;
            child.CanCollide = false;
            child.Transparency = 1;
        end;
    end;

    EmitModule.emit(u4);
    task.delay(8, function() -- Line: 37
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
    local Goals = workspace:FindFirstChild("Goals");

    local function goalLineOf(p5) -- Line: 44
        -- upvalues: Goals (copy)
        local v6 = Goals and Goals:FindFirstChild(p5);

        if v6 then
            v6 = v6:FindFirstChild("GoalLine");
        end;

        return v6;
    end;

    local v7;

    if Goals then
        v7 = Goals:FindFirstChild("Goal");
    else
        v7 = Goals;
    end;

    if v7 then
        v7 = v7:FindFirstChild("GoalLine");
    end;

    if Goals then
        Goals = Goals:FindFirstChild("Goal2");
    end;

    if Goals then
        Goals = Goals:FindFirstChild("GoalLine");
    end;

    local Position = p3.Pos.Position;

    if v7 and Goals then
        if (v7.Position - Position).Magnitude <= (Goals.Position - Position).Magnitude then
            Goals = v7 or Goals;
        end;
    else
        Goals = v7 or Goals;
    end;

    local Chains = script:FindFirstChild("Chains");

    if Goals and Chains then
        for _, child in Chains:GetChildren() do
            local v8 = u2[child.Name];

            if v8 then
                local u9 = child:Clone();
                u9.Parent = u1;

                for _, descendant in u9:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        descendant.Anchored = true;
                        descendant.CanCollide = false;
                        descendant.Massless = true;
                    end;
                end;

                u9:PivotTo(Goals.CFrame);
                local v10 = u9:FindFirstChildWhichIsA("AnimationController");

                if v10 then
                    v10 = v10:FindFirstChildWhichIsA("Animator");
                end;

                if v10 then
                    local Animation = Instance.new("Animation");
                    Animation.AnimationId = v8;
                    local v11 = v10:LoadAnimation(Animation);
                    v11.Looped = false;
                    v11.Priority = Enum.AnimationPriority.Action4;
                    v11:Play();
                    v11.Stopped:Once(function() -- Line: 85
                        -- upvalues: u9 (copy)
                        u9:Destroy();
                    end);
                end;

                task.delay(8, function() -- Line: 90
                    -- upvalues: u9 (copy)
                    if u9.Parent then
                        u9:Destroy();
                    end;
                end);
            end;
        end;
    end;
end;