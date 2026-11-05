  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local Debris = game:GetService("Debris");

local function CreateInstance(p2, p3) -- Line: 6
    local function CheckProperty(p4, p5) -- Line: 8
        local _ = p4[p5];
    end;

    local u6 = Instance.new(p2);

    for i, v in pairs(p3) do
        if pcall(function() -- Line: 15
            -- upvalues: u6 (copy), i (copy)
            local _ = u6[i];
        end) then
            u6[i] = v;
        end;
    end;

    return u6;
end;

return function(u7) -- Line: 24
    -- upvalues: u1 (copy), CreateInstance (copy), TweenService (copy), CollectionService (copy), Debris (copy)
    local u8;

    if u7 then
        u8 = u7:FindFirstChild("HumanoidRootPart") or u7.PrimaryPart;
        u7:FindFirstChild("Humanoid");
    else
        u8 = nil;
    end;

    local v9 = u1["Mero Mero"]["Meshes/Heart"]:Clone();
    local Size = v9.Size;
    v9.CanCollide = false;
    v9.Massless = true;
    v9.Transparency = 0;
    v9.Size = Vector3.new(0, 0, 0);
    v9.CFrame = u8.CFrame * CFrame.new(0, 0, -6);
    v9.Parent = workspace.Effects;
    local v10 = u1["Mero Mero"].HeartShoot:Clone();
    v10.CFrame = u8.CFrame * CFrame.new(0, 0, -8);
    v10.Parent = workspace.Effects;
    CreateInstance("WeldConstraint", {
        Part0 = u8,
        Part1 = v10,
        Parent = v10
    });
    local u11 = true;

    for _, child in pairs(v10.RootAttachment:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            coroutine.wrap(function() -- Line: 50
                -- upvalues: child (copy)
                child.Enabled = true;
                task.wait(0.1);
                child.Enabled = false;
            end)();
        end;
    end;

    local v12 = os.clock();
    TweenService:Create(v9, TweenInfo.new(0.25, Enum.EasingStyle.Cubic), {
        Size = Vector3.new(Size.X, Size.Y, 0)
    }):Play();
    CreateInstance("WeldConstraint", {
        Part0 = u8,
        Part1 = v9,
        Parent = v9
    });

    repeat
        task.wait();
    until CollectionService:HasTag(u7, "MGK") or os.clock() - v12 > 0.35;

    TweenService:Create(v9, TweenInfo.new(1.75, Enum.EasingStyle.Elastic), {
        Size = Size
    }):Play();

    for _, child in pairs(v10.RootAttachment:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            coroutine.wrap(function() -- Line: 71
                -- upvalues: child (copy)
                child.Enabled = true;
                task.wait(0.1);
                child.Enabled = false;
            end)();
        end;
    end;

    Debris:AddItem(v10, 2.5);
    coroutine.wrap(function() -- Line: 80
        -- upvalues: u11 (ref), u1 (ref), u8 (ref), Debris (ref), TweenService (ref), u7 (copy)
        wait(0.85);
        u11 = true;

        repeat
            local u13 = u1["Mero Mero"].Line:Clone();
            u13.CFrame = u8.CFrame * CFrame.new(0, 0.5, -8) * CFrame.Angles(0, 0, math.random(-45, 45));
            u13.Parent = workspace.Effects;
            Debris:AddItem(u13, 1.1);
            TweenService:Create(u13, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                CFrame = u13.CFrame * CFrame.new(0, 7, 0)
            }):Play();
            TweenService:Create(u13, TweenInfo.new(0.15), {
                Size = Vector3.new(0.08, 2.79, 0.08)
            }):Play();
            coroutine.wrap(function() -- Line: 93
                -- upvalues: TweenService (ref), u13 (copy)
                wait(0.1);
                TweenService:Create(u13, TweenInfo.new(0.15), {
                    Size = Vector3.new(0.08, 0.79, 0.08)
                }):Play();
                TweenService:Create(u13, TweenInfo.new(0.25), {
                    Transparency = 1
                }):Play();
            end)();
            local u14 = u1["Mero Mero"].Ball:Clone();
            u14.CFrame = u8.CFrame * CFrame.new(math.random(-1, 1), 0.5, -8) * CFrame.Angles(0, 0, math.random(-360, 360));
            u14.Parent = workspace.Effects;
            Debris:AddItem(u14, 1.1);
            TweenService:Create(u14, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                CFrame = u14.CFrame * CFrame.new(0, 3.5, 0)
            }):Play();
            TweenService:Create(u14, TweenInfo.new(0.4), {
                Size = Vector3.new(0.05, 0.05, 0.05)
            }):Play();
            coroutine.wrap(function() -- Line: 107
                -- upvalues: TweenService (ref), u14 (copy)
                wait(0.1);
                TweenService:Create(u14, TweenInfo.new(0.2), {
                    Transparency = 1
                }):Play();
            end)();
            task.wait(0.0075);
        until not u11 or (u7.Humanoid.Health <= 0 or u7 == nil);
    end)();
    task.wait(2.15);
    u11 = false;
    TweenService:Create(v9, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Size = Vector3.new()
    }):Play();
    task.wait(0.5);
    v9:Destroy();
end;