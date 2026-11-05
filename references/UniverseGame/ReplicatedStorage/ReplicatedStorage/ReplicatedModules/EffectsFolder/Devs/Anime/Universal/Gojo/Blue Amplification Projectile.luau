  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local u1 = ReplicatedStorage["Client Assets"];
local _ = u1.Gojo;

return function(p2, p3, p4) -- Line: 7
    -- upvalues: u1 (copy), TweenService (copy)
    if not (p2 and p3) then
        return;
    end;

    local u5 = u1.Gojo.BlueAmplification:Clone();
    u5.Anchored = true;
    u5.CFrame = p2.Parent.HumanoidRootPart.CFrame;
    u5.Parent = workspace.Effects;
    local u6 = TweenService:Create(u5, TweenInfo.new(p4 or 3, Enum.EasingStyle.Linear), {
        CFrame = p3
    });
    u6:Play();
    p2.AncestryChanged:Connect(function(p7, p8) -- Line: 22
        -- upvalues: u5 (copy), u6 (copy)
        if not p8 then
            task.delay(2, u5.Destroy, u5);

            if u6 and u5:IsDescendantOf(workspace.Effects) then
                u6:Pause();
            end;

            u5.Transparency = 1;
            local v9 = next;
            local v10, v11 = u5:GetChildren();

            for _, v in v9, v10, v11 do
                if v:IsA("Trail") then
                    v.Enabled = false;
                end;
            end;

            local v12 = next;
            local v13, v14 = u5.FX:GetChildren();

            for _, v in v12, v13, v14 do
                v.Enabled = true;
            end;

            task.delay(1, function() -- Line: 39
                -- upvalues: u5 (ref)
                for _, descendant in pairs(u5:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end);
        end;
    end);

    if not p2:IsDescendantOf(game) then
        u5:Destroy();
    end;
end;