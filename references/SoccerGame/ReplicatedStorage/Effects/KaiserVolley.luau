  

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

return function(p3) -- Line: 70
    if p3.Task ~= "Start" then
        if p3.Task == "End" then
            local u4 = script.End:Clone();
            u4.Parent = workspace;
            u4.CFrame = p3.CF;
            Emit_All_With_Duration(u4);
            task.delay(3, function() -- Line: 92
                -- upvalues: u4 (copy)
                u4:Destroy();
            end);
        end;

        return;
    end;

    local u5 = script.Start:Clone();
    u5.Parent = workspace;
    u5.CFrame = p3.Char.HumanoidRootPart.CFrame * CFrame.new(1.1409072875976562, -1.701096534729004, -1.9618148803710938) * CFrame.fromEulerAnglesYXZ(-2.980232594040899e-8, 3.1415927410125732, -2.220445519854721e-16);
    Emit_All_With_Duration(u5);
    task.delay(3, function() -- Line: 80
        -- upvalues: u5 (copy)
        u5:Destroy();
    end);
end;