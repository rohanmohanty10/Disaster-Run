  

 

local TweenService = game:GetService("TweenService");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local Debris = game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");

return function(u2) -- Line: 6
    -- upvalues: u1 (copy), Debris (copy), TweenService (copy), CollectionService (copy)
    local u3;

    if u2 then
        u3 = u2:FindFirstChild("HumanoidRootPart") or u2.PrimaryPart;
        u2:FindFirstChild("Humanoid");
    else
        u3 = nil;
    end;

    coroutine.wrap(function() -- Line: 13
        -- upvalues: u1 (ref), u3 (ref), Debris (ref), TweenService (ref), u2 (copy), CollectionService (ref)
        repeat
            local u4 = u1["Mero Mero"].Line:Clone();
            u4.CFrame = u3.CFrame * CFrame.new(0, 0.5, -2.05) * CFrame.Angles(0, 0, math.random(-45, 45));
            u4.Parent = workspace.Effects;
            Debris:AddItem(u4, 1.1);
            TweenService:Create(u4, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                CFrame = u4.CFrame * CFrame.new(0, 7, 0)
            }):Play();
            TweenService:Create(u4, TweenInfo.new(0.15), {
                Size = Vector3.new(0.08, 2.79, 0.08)
            }):Play();
            coroutine.wrap(function() -- Line: 23
                -- upvalues: TweenService (ref), u4 (copy)
                wait(0.1);
                TweenService:Create(u4, TweenInfo.new(0.15), {
                    Size = Vector3.new(0.08, 0.79, 0.08)
                }):Play();
                TweenService:Create(u4, TweenInfo.new(0.25), {
                    Transparency = 1
                }):Play();
            end)();
            local u5 = u1["Mero Mero"].Ball:Clone();
            u5.CFrame = u3.CFrame * CFrame.new(math.random(-1, 1), 0.5, -2.05) * CFrame.Angles(0, 0, math.random(-360, 360));
            u5.Parent = workspace.Effects;
            Debris:AddItem(u5, 1.1);
            TweenService:Create(u5, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                CFrame = u5.CFrame * CFrame.new(0, 3.5, 0)
            }):Play();
            TweenService:Create(u5, TweenInfo.new(0.4), {
                Size = Vector3.new(0.05, 0.05, 0.05)
            }):Play();
            coroutine.wrap(function() -- Line: 37
                -- upvalues: TweenService (ref), u5 (copy)
                wait(0.1);
                TweenService:Create(u5, TweenInfo.new(0.2), {
                    Transparency = 1
                }):Play();
            end)();
            task.wait(0.0075);
        until not (u2.Parent and CollectionService:HasTag(u2, "Hardening Sin"));
    end)();

    repeat
        coroutine.wrap(function() -- Line: 46
            -- upvalues: u1 (ref), u3 (ref), Debris (ref), TweenService (ref)
            local v6 = u1["Mero Mero"].MeroHeartBeam:Clone();
            v6.CFrame = u3.CFrame * CFrame.new(0, 0.5, -2.05);
            v6.Parent = workspace.Effects;
            Debris:AddItem(v6, 1);
            TweenService:Create(v6, TweenInfo.new(0.55), {
                CFrame = v6.CFrame * CFrame.new(0, 0, -20)
            }):Play();
            TweenService:Create(v6, TweenInfo.new(0.55), {
                Size = Vector3.new(17, 15, 0.172)
            }):Play();
            task.wait(0.2);
            TweenService:Create(v6, TweenInfo.new(0.25), {
                Transparency = 1
            }):Play();
        end)();
        task.wait(0.1);
    until not (u2.Parent and CollectionService:HasTag(u2, "Hardening Sin"));
end;