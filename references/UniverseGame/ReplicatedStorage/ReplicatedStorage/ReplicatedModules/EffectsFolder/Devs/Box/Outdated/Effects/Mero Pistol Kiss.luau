  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local Debris = game:GetService("Debris");
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

return function(p7) -- Line: 23
    -- upvalues: u1 (copy), CreateInstance (copy), Debris (copy), TweenService (copy)
    local v8;

    if p7 then
        v8 = p7:FindFirstChild("HumanoidRootPart") or p7.PrimaryPart;
        p7:FindFirstChild("Humanoid");
    else
        v8 = nil;
    end;

    local v9 = u1.Projectiles.Heart:Clone();
    v9.Anchored = false;
    v9.Massless = true;
    v9.CanCollide = false;
    local v10 = CreateInstance("Weld", {
        Part0 = p7["Right Arm"],
        Part1 = v9,
        Parent = v9
    });
    v10.C0 = v10.C0 * CFrame.new(0, -1.15, 0) * CFrame.Angles(0, 3.141592653589793, 0);
    v9.Parent = workspace.Effects;
    task.wait(0.558);
    v9:Destroy();

    for _ = 1, 14 do
        local u11 = u1["Mero Mero"].Line:Clone();
        u11.CFrame = v8.CFrame * CFrame.new(1.45, 0, -2) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
        u11.Parent = workspace.Effects;
        Debris:AddItem(u11, 1.1);
        TweenService:Create(u11, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = u11.CFrame * CFrame.new(0, 4, 0)
        }):Play();
        TweenService:Create(u11, TweenInfo.new(0.15), {
            Size = Vector3.new(0.08, 2.79, 0.08)
        }):Play();
        coroutine.wrap(function() -- Line: 53
            -- upvalues: TweenService (ref), u11 (copy)
            wait(0.1);
            TweenService:Create(u11, TweenInfo.new(0.15), {
                Size = Vector3.new(0.08, 0.79, 0.08)
            }):Play();
            TweenService:Create(u11, TweenInfo.new(0.25), {
                Transparency = 1
            }):Play();
        end)();
        local u12 = u1["Mero Mero"].Ball:Clone();
        u12.CFrame = v8.CFrame * CFrame.new(1.45, 0, -2) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
        u12.Parent = workspace.Effects;
        Debris:AddItem(u12, 1.1);
        TweenService:Create(u12, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = u12.CFrame * CFrame.new(0, 3.5, 0)
        }):Play();
        TweenService:Create(u12, TweenInfo.new(0.4), {
            Size = Vector3.new(0.05, 0.05, 0.05)
        }):Play();
        coroutine.wrap(function() -- Line: 67
            -- upvalues: TweenService (ref), u12 (copy)
            wait(0.1);
            TweenService:Create(u12, TweenInfo.new(0.2), {
                Transparency = 1
            }):Play();
        end)();
    end;
end;