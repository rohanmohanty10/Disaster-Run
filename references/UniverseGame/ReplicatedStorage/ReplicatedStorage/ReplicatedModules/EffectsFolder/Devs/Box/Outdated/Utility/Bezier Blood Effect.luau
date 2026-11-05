  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local BezierCreator = require(ReplicatedStorage.ReplicatedModules.BezierCreator);
local Vampire = ReplicatedStorage["Client Assets"].Vampire;

return function(p1, p2) -- Line: 6
    -- upvalues: BezierCreator (copy), Vampire (copy)
    if not p1 then
        return;
    end;

    local v3 = p1:FindFirstChild("HumanoidRootPart") or p1.PrimaryPart;

    if not v3 then
        return;
    end;

    local v4 = p2.Pivot or v3;

    if typeof(v4) == "string" and p1:FindFirstChild(v4) then
        v4 = p1[v4];
    end;

    local v5 = p2.EndPivot or v3;
    local v6 = p2.Segments or 15;
    local v7 = {
        { v4.CFrame, v4.CFrame * CFrame.new(3, 10, -10), v5.CFrame },
        { v4.CFrame, v4.CFrame * CFrame.new(3, 10, 10), v5.CFrame },
        { v4.CFrame, v4.CFrame * CFrame.new(-10, 10, 3), v5.CFrame },
        { v4.CFrame, v4.CFrame * CFrame.new(10, 3, 10), v5.CFrame },
        { v4.CFrame, v4.CFrame * CFrame.new(-10, 3, -10), v5.CFrame },
        { v4.CFrame, v4.CFrame * CFrame.new(10, 3, -10), v5.CFrame }
    };

    for i = 1, #v7 do
        local u8 = BezierCreator(v7[i][1], v7[i][2], v7[i][3], v6);
        local u9 = Vampire["Life Drain"].BloodTrail:Clone();
        u9.CFrame = v4.CFrame;
        u9.Parent = workspace.Effects;

        for _, descendant in pairs(u9:GetDescendants()) do
            if descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        task.spawn(function() -- Line: 67
            -- upvalues: u8 (copy), u9 (copy)
            if not u8 then
                return;
            end;

            for i2 = 1, #u8 do
                if u8[i2 + 1] then
                    local v10 = u8[i2];
                    local v11 = u8[i2 + 1];
                    local _ = (v11 - v10).Magnitude;
                    u9:PivotTo(CFrame.new(v10, v11));
                    task.wait();
                end;
            end;

            for _, descendant in pairs(u9:GetDescendants()) do
                if descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(2.5, u9.Destroy, u9);
        end);
        task.wait(0.025);
    end;
end;