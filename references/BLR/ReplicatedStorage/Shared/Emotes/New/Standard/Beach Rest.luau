  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Trove = require(ReplicatedStorage.Packages.Trove);
local CFrame_new_ret = CFrame.new(0, -0.476, 0);

local function attachBench(p1, p2) -- Line: 12
    -- upvalues: CFrame_new_ret (copy)
    local HumanoidRootPart = p1.HumanoidRootPart;
    local v3 = script.Bench:Clone();

    for _, descendant in v3:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = false;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.Massless = true;
        end;
    end;

    local Motor6D = Instance.new("Motor6D");
    Motor6D.Name = "Part";
    Motor6D.Part0 = HumanoidRootPart;
    Motor6D.Part1 = v3.Part;
    Motor6D.C0 = CFrame_new_ret;
    Motor6D.Parent = HumanoidRootPart;
    v3.Parent = p1;
    p2:Add(v3);
    p2:Add(Motor6D);
end;

return {
    animationId = "rbxassetid://83413042452714",
    meta = {
        rarity = "Limited"
    },

    play = function(u4, p5) -- Line: 37, Name: play
        -- upvalues: Trove (copy), attachBench (copy), RunService (copy)
        local Humanoid = u4:FindFirstChild("Humanoid");
        local HumanoidRootPart = u4:FindFirstChild("HumanoidRootPart");
        local v6;

        if Humanoid then
            v6 = Humanoid:FindFirstChild("Animator");
        else
            v6 = Humanoid;
        end;

        if not (Humanoid and (HumanoidRootPart and v6)) then
            return nil;
        end;

        local v7 = Trove.new();
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://83413042452714";
        local u8 = v6:LoadAnimation(Animation);
        u8.Looped = true;
        u8.Priority = Enum.AnimationPriority.Action4;
        v7:Add(u8, "Stop");

        if p5 == "VisualUI" then
            u8:Play();

            return v7:WrapClean();
        end;

        attachBench(u4, v7);
        local Animation2 = Instance.new("Animation");
        Animation2.AnimationId = "rbxassetid://94552456559279";
        local u9 = v6:LoadAnimation(Animation2);
        u9.Looped = false;
        u9.Priority = Enum.AnimationPriority.Action4;
        v7:Add(u9, "Stop");
        u9:Play();
        v7:Add(task.spawn(function() -- Line: 69
            -- upvalues: u9 (copy), u8 (copy)
            while u9.Length == 0 do
                task.wait();
            end;

            local v10 = u9.Length * 0.5;
            task.wait(u9.Length * 0.5);
            u8:Play(v10);
            u9:Stop(v10);
        end));
        local u11 = v7:WrapClean();

        if p5 == "Game" then
            local Position = HumanoidRootPart.Position;
            local os_clock_ret = os.clock();
            v7:Add(RunService.Heartbeat:Connect(function() -- Line: 84
                -- upvalues: u4 (copy), u11 (copy), os_clock_ret (copy), Humanoid (copy), HumanoidRootPart (copy), Position (copy)
                if not u4.Parent then
                    u11();

                    return;
                end;

                if os.clock() - os_clock_ret < 0.35 then
                    return;
                end;

                if Humanoid.MoveDirection.Magnitude > 0.1 or (Humanoid.Jump or Humanoid:GetState() == Enum.HumanoidStateType.Jumping or (HumanoidRootPart.Position - Position).Magnitude > 10) then
                    u11();
                end;
            end));
        end;

        return u11;
    end
};