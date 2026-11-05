  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = ReplicatedStorage["Client Assets"];
local Debris = game:GetService("Debris");

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

return function(p7, p8, p9) -- Line: 24
    -- upvalues: u1 (copy), Debris (copy), ReplicatedStorage (copy), CreateInstance (copy)
    local u10;

    if p7 then
        u10 = p7:FindFirstChild("HumanoidRootPart") or p7.PrimaryPart;
        p7:FindFirstChild("Humanoid");
    else
        u10 = nil;
    end;

    local v11 = u1["Gold Experience"].ground:Clone();
    v11.CFrame = u10.CFrame * CFrame.new(0, -2.5, 2.5);
    v11.Parent = workspace.Effects;
    Debris:AddItem(v11, 2.5);

    for _, descendant in pairs(v11:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            coroutine.wrap(function() -- Line: 39
                -- upvalues: descendant (copy)
                descendant.Enabled = true;
                wait(0.1);
                descendant.Enabled = false;
            end)();
        end;
    end;

    local v12 = ReplicatedStorage["Client Assets"]["Gold Experience"].RippleEffect:Clone();
    v12.PrimaryPart.CFrame = p9[1] * CFrame.new(0, -2.5, 0);
    v12.Parent = workspace.Effects;
    Debris:AddItem(v12, 10);
    coroutine.wrap(function() -- Line: 52
        -- upvalues: CreateInstance (ref), u10 (ref), Debris (ref)
        task.wait(0.15);
        Debris:AddItem(CreateInstance("BodyVelocity", {
            MaxForce = Vector3.new(inf, inf, inf),
            Velocity = u10.CFrame.UpVector * 75,
            Parent = u10
        }), 0.1);
    end)();
end;