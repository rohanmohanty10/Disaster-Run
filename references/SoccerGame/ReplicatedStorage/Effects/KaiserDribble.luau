  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

function Emit_All_With_Duration(p1)
    local function emit(u2) -- Line: 13
        if u2:IsA("ParticleEmitter") or (u2:IsA("Beam") or u2:IsA("Trail")) then
            local Attribute = u2:GetAttribute("EmitDuration");
            local Attribute2 = u2:GetAttribute("EmitDelay");
            local Attribute3 = u2:GetAttribute("EmitCount");

            if Attribute and Attribute ~= 0 then
                if Attribute2 and Attribute2 ~= 0 then
                    task.delay(Attribute2, function() -- Line: 21
                        -- upvalues: u2 (copy), Attribute (copy)
                        u2.Enabled = true;
                        task.delay(Attribute, function() -- Line: 24
                            -- upvalues: u2 (ref)
                            u2.Enabled = false;
                        end);
                    end);

                    return;
                end;

                u2.Enabled = true;
                task.delay(Attribute, function() -- Line: 31
                    -- upvalues: u2 (copy)
                    u2.Enabled = false;
                end);

                return;
            end;

            if Attribute3 and Attribute3 ~= 0 then
                if Attribute2 and Attribute2 ~= 0 then
                    task.delay(Attribute2, function() -- Line: 38
                        -- upvalues: u2 (copy), Attribute3 (copy)
                        u2:Emit(Attribute3);
                    end);

                    return;
                end;

                u2:Emit(Attribute3);
            end;
        end;
    end;

    if typeof(p1) == "table" then
        for _, v in p1 do
            if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
                emit(v);
            else
                for _, descendant in v:GetDescendants() do
                    emit(descendant);
                end;
            end;
        end;

        return;
    end;

    if p1:IsA("ParticleEmitter") or (p1:IsA("Beam") or p1:IsA("Trail")) then
        emit(p1);

        return;
    end;

    for _, descendant in p1:GetDescendants() do
        emit(descendant);
    end;
end;

local function Weld(p3, p4) -- Line: 70
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p3;
    WeldConstraint.Part1 = p4;
    WeldConstraint.Parent = p3;

    return WeldConstraint;
end;

return function(p5) -- Line: 77
    warn("ARGS ARE", p5);

    if p5.Task ~= "Dribble" then
        if p5.Task == "Shoot" then
            local u6 = script.Move2Shoot:Clone();
            u6.Parent = workspace;
            u6.CFrame = p5.Char.HumanoidRootPart.CFrame * CFrame.new(1.1409072875976562, -0.3678882122039795, -1.9618148803710938) * CFrame.fromEulerAnglesYXZ(-2.980232594040899e-8, 3.1415927410125732, -2.220445519854721e-16);
            Emit_All_With_Duration(u6);
            local HumanoidRootPart = p5.Char.HumanoidRootPart;
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = u6;
            WeldConstraint.Part1 = HumanoidRootPart;
            WeldConstraint.Parent = u6;
            task.delay(5, function() -- Line: 98
                -- upvalues: u6 (copy)
                u6:Destroy();
            end);
        end;

        return;
    end;

    local u7 = script.Move2:Clone();
    u7.Parent = workspace;
    u7.CFrame = p5.Char.HumanoidRootPart.CFrame * CFrame.new(1.1409072875976562, -0.3678882122039795, -1.9618148803710938) * CFrame.fromEulerAnglesYXZ(-2.980232594040899e-8, 3.1415927410125732, -2.220445519854721e-16);
    local HumanoidRootPart = p5.Char.HumanoidRootPart;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = u7;
    WeldConstraint.Part1 = HumanoidRootPart;
    WeldConstraint.Parent = u7;
    Emit_All_With_Duration(u7);
    task.delay(3, function() -- Line: 87
        -- upvalues: u7 (copy)
        u7:Destroy();
    end);
end;