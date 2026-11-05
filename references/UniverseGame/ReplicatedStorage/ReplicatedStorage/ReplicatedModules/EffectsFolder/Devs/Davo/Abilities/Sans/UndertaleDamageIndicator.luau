  

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(PathShortcuts.KnitPath.Knit);
local LocalPlayer = Players.LocalPlayer;
local u1 = TweenInfo.new(0.35, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
local u2 = TweenInfo.new(0.425, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.05);

return function(p3) -- Line: 15
    -- upvalues: LocalPlayer (copy), EffectsHandler (copy), TweenService (copy), u1 (copy), u2 (copy)
    p3.Stats = p3.Stats or {};
    local Target = p3.Target;
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not (Character and (Target and (Target:IsDescendantOf(workspace) and Target.PrimaryPart))) then
        return;
    end;

    Target:FindFirstChild("Humanoid");
    local v4 = Target:FindFirstChild("HumanoidRootPart") or (Target.PrimaryPart or Target:FindFirstChildWhichIsA("BasePart"));

    if p3.PartName then
        v4 = Target:FindFirstChild(p3.PartName);
    end;

    if not v4 or (Character.CFrame.Position - v4.CFrame.Position).Magnitude > 325 then
        return;
    end;

    local Position = v4.Position;
    local v5 = p3.Damage or p3.Stats.Damage;
    local u6 = script.Holder:Clone();
    script["Giga Damage"]:Clone();
    script["Heavy Damage"]:Clone();
    script.Damage:Clone();
    local DamageUI = u6.DamageUI;
    local v7 = p3.Shake or (p3.Stats.Shake or v5 >= 100);
    local v8;

    if v5 > 10000000000 then
        v8 = "9999999999";
    else
        local v9 = math.round(v5);
        v8 = tostring(v9);
    end;

    local v10 = nil;

    for _, v in { {
            Threshold = 10000000000,
            Sound = "Giga Damage"
        }, {
            Threshold = 100,
            Sound = "Heavy Damage"
        }, {
            Threshold = 0,
            Sound = "Damage"
        } } do
        if v.Threshold <= v5 then
            v10 = v;
            break;
        end;
    end;

    if v10 then
        local v11 = script[v10.Sound];
        EffectsHandler.CallEffect("Play Sound At", {
            Object = v11:Clone(),
            Origin = v4.CFrame,
            Volume = 5 * v11.Volume
        });
    end;

    for i = 1, #v8 do
        local v12 = DamageUI.Holder.Template:Clone();
        v12.Parent = DamageUI.Holder;
        local Number = v12.Number;
        local fromScale = UDim2.fromScale;
        local v13 = string.sub(v8, i, i);
        Number.Position = fromScale(-tonumber(v13), -(p3.NoOutline and 0 or 1));
        v12.Visible = true;

        if i >= 7 then
            break;
        end;
    end;

    DamageUI.Holder.Template:Destroy();
    u6.Parent = workspace.Effects;
    u6.Position = Position;
    local u14;

    if v7 then
        u14 = task.spawn(function() -- Line: 84
            -- upvalues: EffectsHandler (ref), DamageUI (copy)
            local v15 = Random.new();

            while true do
                EffectsHandler.Wait(0.03);
                DamageUI.Holder.Position = UDim2.fromOffset(v15:NextNumber(-6, 6), v15:NextNumber(-6, 6));
            end;
        end);
    else
        u14 = nil;
    end;

    local u16 = TweenService:Create(DamageUI, u1, {
        StudsOffsetWorldSpace = Vector3.new(0, 2, 0)
    });
    local u17 = TweenService:Create(DamageUI, u2, {
        StudsOffsetWorldSpace = Vector3.new(0, 0, 0)
    });
    local u18 = task.spawn(function() -- Line: 100
        -- upvalues: EffectsHandler (ref), u6 (copy)
        EffectsHandler.Wait(5);

        if u6 then
            u6:Destroy();
        end;
    end);
    u16:Play();
    u16.Completed:Once(function() -- Line: 107
        -- upvalues: u16 (copy), u17 (copy), u18 (copy), u14 (ref), u6 (copy)
        u16:Destroy();
        u17:Play();
        u17.Completed:Once(function() -- Line: 110
            -- upvalues: u18 (ref), u14 (ref), u17 (ref), u6 (ref)
            pcall(task.cancel, u18);

            if u14 then
                pcall(task.cancel, u14);
            end;

            u17:Destroy();
            u6:Destroy();
        end);
    end);
end;