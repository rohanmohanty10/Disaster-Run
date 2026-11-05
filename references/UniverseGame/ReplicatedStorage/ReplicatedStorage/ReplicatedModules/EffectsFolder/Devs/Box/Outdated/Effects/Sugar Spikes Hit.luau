  

 

local Debris = game:GetService("Debris");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local TweenService = game:GetService("TweenService");

local function CreateInstance(p2, p3) -- Line: 5
    local function CheckProperty(p4, p5) -- Line: 7
        local _ = p4[p5];
    end;

    local u6 = Instance.new(p2);

    for i, v in pairs(p3) do
        if pcall(function() -- Line: 14
            -- upvalues: u6 (copy), i (copy)
            local _ = u6[i];
        end) then
            u6[i] = v;
        end;
    end;

    return u6;
end;

return function(p7, p8) -- Line: 23
    -- upvalues: u1 (copy), Debris (copy), CreateInstance (copy), TweenService (copy)
    local v9;

    if p7 then
        v9 = p7:FindFirstChild("HumanoidRootPart") or p7.PrimaryPart;
        p7:FindFirstChild("Humanoid");
    else
        v9 = nil;
    end;

    local v10 = u1["Candy Cutlass"].CandySpike["explosion 4 cnady spike"]:Clone();
    v10.Parent = v9;
    Debris:AddItem(v10, 1);

    for _, child in pairs(v10:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            coroutine.wrap(function() -- Line: 36
                -- upvalues: child (copy)
                child.Enabled = true;
                task.wait(0.1);
                child.Enabled = false;
            end)();
        end;
    end;

    if not p7:FindFirstChild("Goop") then
        local u11 = u1["Candy Cutlass"].Goop:Clone();
        local HeadGoop = u11.HeadGoop;
        local TorsoGoop1 = u11.TorsoGoop1;
        local TorsoGoop2 = u11.TorsoGoop2;
        HeadGoop.CFrame = p7.Head.CFrame;
        TorsoGoop1.CFrame = p7.Torso.CFrame;
        TorsoGoop2.CFrame = p7.Torso.CFrame;
        CreateInstance("Weld", {
            Part0 = p7.Head,
            Part1 = HeadGoop,
            Parent = HeadGoop
        }).C1 = CFrame.new(-0.38, -0.22, 0.035);
        CreateInstance("Weld", {
            Part0 = p7.Torso,
            Part1 = TorsoGoop1,
            Parent = TorsoGoop1
        }).C1 = CFrame.new(-0.75, -0.68, -0.0055);
        CreateInstance("Weld", {
            Part0 = p7.Torso,
            Part1 = TorsoGoop2,
            Parent = TorsoGoop2
        }).C1 = CFrame.new(0.68, -0.61, -0.0055);
        u11.Parent = p7;
        coroutine.wrap(function() -- Line: 76
            -- upvalues: u11 (copy), TweenService (ref)
            task.wait(5);

            for _, descendant in pairs(u11:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    TweenService:Create(descendant, TweenInfo.new(0.5), {
                        Transparency = 1
                    }):Play();
                end;
            end;

            task.wait(0.5);
            u11:Destroy();
        end)();
    end;
end;