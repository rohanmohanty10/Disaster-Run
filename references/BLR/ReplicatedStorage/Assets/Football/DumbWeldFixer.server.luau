  

game:GetService("RunService");
local script_Parent = script.Parent;

local function fix() -- Line: 6
    -- upvalues: script_Parent (copy)
    local v1 = script_Parent:FindFirstChild("BallAnims") and script_Parent.BallAnims:FindFirstChild("RootPart") and script_Parent.BallAnims.RootPart:FindFirstChild("WeldConstraint");
    local v2 = script_Parent:FindFirstChild("Hitbox") and script_Parent.Hitbox:FindFirstChild("WeldConstraint");

    if v1 and (v1.Part0 and (v1.Part1 and (v1.Part0.CFrame * v1.Part1.CFrame:Inverse()).Position.Magnitude > 1)) then
        v1.Enabled = false;
        task.wait();
        v1.Parent.CFrame = script_Parent.CFrame;
        v1.Enabled = true;
        print("had to correct ball RootPart weld constraint");
    end;

    if v2 and (v2.Part0 and (v2.Part1 and (v2.Part0.CFrame * v2.Part1.CFrame:Inverse()).Position.Magnitude > 1)) then
        v2.Enabled = false;
        task.wait();
        v2.Parent.CFrame = script_Parent.CFrame;
        v2.Enabled = true;
        print("had to correct ball Hitbox weld constraint");
    end;
end;

task.spawn(function() -- Line: 39
    -- upvalues: fix (copy)
    while script.Parent do
        fix();
        task.wait(0.1);
    end;
end);