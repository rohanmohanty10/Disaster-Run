  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");

return function(p2) -- Line: 5
    -- upvalues: u1 (copy), Debris (copy), TweenService (copy)
    local v3;

    if p2 then
        v3 = p2:FindFirstChild("HumanoidRootPart") or p2.PrimaryPart;
        p2:FindFirstChild("Humanoid");
    else
        v3 = nil;
    end;

    local v4 = u1["Mero Mero"].HitEffect.mero:Clone();
    v4.Parent = v3;
    Debris:AddItem(v4, 3);

    for _, child in pairs(v4:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            coroutine.wrap(function() -- Line: 18
                -- upvalues: child (copy)
                child.Enabled = true;
                task.wait(0.1);
                child.Enabled = false;
            end)();
        end;
    end;

    for _ = 1, 14 do
        local u5 = u1["Mero Mero"].Line:Clone();
        u5.CFrame = v3.CFrame * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
        u5.Parent = workspace.Effects;
        Debris:AddItem(u5, 1.1);
        TweenService:Create(u5, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = u5.CFrame * CFrame.new(0, 6, 0)
        }):Play();
        TweenService:Create(u5, TweenInfo.new(0.15), {
            Size = Vector3.new(0.08, 2.79, 0.08)
        }):Play();
        coroutine.wrap(function() -- Line: 35
            -- upvalues: TweenService (ref), u5 (copy)
            wait(0.1);
            TweenService:Create(u5, TweenInfo.new(0.15), {
                Size = Vector3.new(0.08, 0.79, 0.08)
            }):Play();
            TweenService:Create(u5, TweenInfo.new(0.25), {
                Transparency = 1
            }):Play();
        end)();
        local u6 = u1["Mero Mero"].Ball:Clone();
        u6.CFrame = v3.CFrame * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
        u6.Parent = workspace.Effects;
        Debris:AddItem(u6, 1.1);
        TweenService:Create(u6, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = u6.CFrame * CFrame.new(0, 3.5, 0)
        }):Play();
        TweenService:Create(u6, TweenInfo.new(0.4), {
            Size = Vector3.new(0.05, 0.05, 0.05)
        }):Play();
        coroutine.wrap(function() -- Line: 49
            -- upvalues: TweenService (ref), u6 (copy)
            wait(0.1);
            TweenService:Create(u6, TweenInfo.new(0.2), {
                Transparency = 1
            }):Play();
        end)();
    end;
end;