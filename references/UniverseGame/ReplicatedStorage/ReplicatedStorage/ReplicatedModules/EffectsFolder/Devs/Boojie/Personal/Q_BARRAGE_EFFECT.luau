  

 

local u1 = Random.new();

local function Create(...) -- Line: 2
    return game:GetService("TweenService"):Create(...);
end;

local function GetOffset(p2) -- Line: 6
    -- upvalues: u1 (copy)
    return CFrame.new(u1:NextNumber(-0.5, 1) * (p2 and -1 or 1), u1:NextNumber(-1, 1), u1:NextNumber(0.5, 1));
end;

local function Run(p3, p4, p5) -- Line: 11
    -- upvalues: Run (copy), u1 (copy), Create (copy)
    if p5 then
        for _ = 1, p5 do
            task.spawn(Run, p3, p4);
        end;
    end;

    if typeof(p3) == "Instance" then
        p3 = p3.CFrame;
    elseif typeof(p3) == "table" then
        p3 = p3[1].CFrame * p3[2];
    end;

    local u6 = p3 * CFrame.new(0, 0, 0.5);
    local u7 = (p4 or script.Effect):Clone();
    u7:PivotTo(u6 * CFrame.Angles(0, 3.141592653589793, 0));
    local u8 = TweenInfo.new(0.07, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local u9 = u1:NextInteger(1, 3);
    task.spawn(function() -- Line: 33
        -- upvalues: u9 (copy), u1 (ref), u7 (ref), u6 (ref), Create (ref), u8 (copy)
        if u9 == 1 then
            task.wait(u1:NextNumber(0.025, 0.05));
        end;

        local LeftArm = u7.LeftArm;
        LeftArm.CFrame = LeftArm.CFrame * CFrame.new(u1:NextNumber(-0.5, 1) * 1, u1:NextNumber(-1, 1), u1:NextNumber(0.5, 1));
        u7.LeftArm.CFrame = CFrame.lookAt(u7.LeftArm.Position, u6.p) * CFrame.Angles(0, -1.0471975511965976, 0);
        u7.LeftArm.Transparency = 0;

        for _, child in pairs(u7.LeftArm:GetChildren()) do
            if child:IsA("BasePart") then
                child.Transparency = 0;
            end;
        end;

        local LeftArm2 = u7.LeftArm;
        local v10 = {};
        local v11 = u7.LeftArm.CFrame * CFrame.new(0.5, 0, u1:NextNumber(0, 1));
        local Angles = CFrame.Angles;
        local v12 = u1:NextNumber(-25, -60);
        v10.CFrame = v11 * Angles(0, math.rad(v12), 0) * CFrame.new(0, 0, u1:NextNumber(1.5, 3));
        local v13 = Create(LeftArm2, u8, v10);
        v13:Play();
        v13.Completed:Wait();
        u7.LeftArm.Transparency = 1;

        for _, child in pairs(u7.LeftArm:GetChildren()) do
            if child:IsA("BasePart") then
                child.Transparency = 1;
            end;
        end;
    end);
    task.spawn(function() -- Line: 56
        -- upvalues: u9 (copy), u1 (ref), u7 (ref), u6 (ref), Create (ref), u8 (copy)
        if u9 == 2 then
            task.wait(u1:NextNumber(0.025, 0.05));
        end;

        local RightArm = u7.RightArm;
        RightArm.CFrame = RightArm.CFrame * CFrame.new(u1:NextNumber(-0.5, 1) * -1, u1:NextNumber(-1, 1), u1:NextNumber(0.5, 1));
        u7.RightArm.CFrame = CFrame.lookAt(u7.RightArm.Position, u6.p) * CFrame.Angles(0, 1.0471975511965976, 0);
        u7.RightArm.Transparency = 0;

        for _, child in pairs(u7.RightArm:GetChildren()) do
            if child:IsA("BasePart") then
                child.Transparency = 0;
            end;
        end;

        local RightArm2 = u7.RightArm;
        local v14 = {};
        local v15 = u7.RightArm.CFrame * CFrame.new(-0.5, 0, u1:NextNumber(0, 1));
        local Angles = CFrame.Angles;
        local v16 = u1:NextNumber(25, 60);
        v14.CFrame = v15 * Angles(0, math.rad(v16), 0) * CFrame.new(0, 0, u1:NextNumber(1.5, 3));
        local v17 = Create(RightArm2, u8, v14);
        v17:Play();
        v17.Completed:Wait();
        u7.RightArm.Transparency = 1;

        for _, child in pairs(u7.RightArm:GetChildren()) do
            if child:IsA("BasePart") then
                child.Transparency = 1;
            end;
        end;
    end);
    u7.Parent = game.Workspace.CurrentCamera;
    task.wait(0.25);
    u7:Destroy();
end;

return Run;