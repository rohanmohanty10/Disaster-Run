  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = ReplicatedStorage["Client Assets"];
local ReplicatedModules = ReplicatedStorage.ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local Trove = require(ReplicatedModules.KnitPackage.Trove);
local HollowPurple = u1.Gojo.HollowPurple;

return function(p2, p3) -- Line: 11
    -- upvalues: Trove (copy), u1 (copy), HollowPurple (copy), TweenService (copy), EffectsHandler (copy)
    if not p2 then
        return;
    end;

    local v4 = 0.5 * (p3 or 1);
    local HumanoidRootPart = p2.HumanoidRootPart;
    local v5 = Trove.new();
    v5:AttachToInstance(p2);
    task.delay(2.6, v5.Destroy, v5);
    local v6 = v5:Add(Instance.new("Model"));
    local v7 = v5:Clone(u1.Gojo.HollowPurple.PurpleOrb);
    v7.Weld.Part1 = HumanoidRootPart;
    v7.Parent = v6;
    local v8 = {};
    local v9 = HollowPurple.BlueOrb:Clone();
    v9.Weld.Part1 = HumanoidRootPart;
    v9.Parent = v6;
    table.insert(v8, v9);
    local v10 = HollowPurple.RedOrb:Clone();
    v10.Weld.Part1 = HumanoidRootPart;
    v10.Parent = v6;
    table.insert(v8, v10);
    v6.Parent = workspace.Effects;

    for _, v in ipairs(v8) do
        local _ = v.Name;

        if not (v:IsDescendantOf(game) and p2:IsDescendantOf(game)) then
            break;
        end;

        v.Attachment.Bits_Small.Enabled = true;
        TweenService:Create(v, TweenInfo.new(v4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Size = Vector3.new(3, 3, 3),
            Transparency = 0
        }):Play();
        TweenService:Create(v.PointLight, TweenInfo.new(v4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Range = 6
        }):Play();
        task.wait(v4);

        if not (v:IsDescendantOf(game) and p2:IsDescendantOf(game)) then
            break;
        end;

        local v11 = next;
        local v12, v13 = v:GetDescendants();

        for _, v2 in v11, v12, v13 do
            if v2:IsA("ParticleEmitter") then
                v2.Enabled = true;
            end;
        end;

        local v14 = v:Clone();
        v14.PointLight:Destroy();
        v14.Weld:Destroy();
        v14.Anchored = true;
        v14.Parent = v;
        TweenService:Create(v14, TweenInfo.new(v4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = v14.Size * 2
        }):Play();
    end;

    task.spawn(EffectsHandler.CallEffect, "Hollow Purple", v7, 1);
    task.wait(v4);

    for _, v in ipairs(v8) do
        if v:IsDescendantOf(game) then
            TweenService:Create(v.Weld, TweenInfo.new(v4 * 4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                C0 = v.Weld.C0 * CFrame.new(v.Name == "BlueOrb" and 3 or -3, 0, 0)
            }):Play();
            TweenService:Create(v, TweenInfo.new(v4 * 4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Transparency = 1
            }):Play();
        end;
    end;

    task.wait(v4);

    if not v6:IsDescendantOf(game) then
        return;
    end;

    TweenService:Create(v7, TweenInfo.new(p3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Size = Vector3.new(9, 9, 9),
        Transparency = 0
    }):Play();
    TweenService:Create(v7.PointLight, TweenInfo.new(p3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Range = 12
    }):Play();
    task.wait(v4);

    if not v6:IsDescendantOf(game) then
        return;
    end;

    local v15 = next;
    local v16, v17 = v6:GetDescendants();

    for _, v in v15, v16, v17 do
        if v:IsA("ParticleEmitter") then
            v.Enabled = v:IsDescendantOf(v7);
        end;
    end;
end;