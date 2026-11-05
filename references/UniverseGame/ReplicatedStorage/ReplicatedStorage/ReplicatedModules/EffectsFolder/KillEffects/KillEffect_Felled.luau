  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Petal = _G.Petal;
Petal("New");
Petal("Util");
Petal("Extensions");

local function Lerp(p1, p2, p3) -- Line: 14
    if typeof(p1) == "number" then
        return p1 + (p2 - p1) * p3;
    end;

    return p1:Lerp(p2, p3);
end;

local function GetValue(p4, p5, p6) -- Line: 22
    -- upvalues: TweenService (copy)
    return TweenService:GetValue(p6, Enum.EasingStyle[p4], Enum.EasingDirection[p5]);
end;

local function ConvertToOffset(p7) -- Line: 26
    local AbsoluteSize = p7.Parent.AbsoluteSize;
    local _ = p7.Parent.AbsolutePosition;
    local v8 = UDim2.fromOffset(AbsoluteSize.X * p7.Size.X.Scale, AbsoluteSize.Y * p7.Size.Y.Scale);
    p7.Position = UDim2.fromOffset(AbsoluteSize.X * p7.Position.X.Scale, AbsoluteSize.Y * p7.Position.Y.Scale);
    p7.Size = v8;
end;

local u9 = { "you died" };
local u10 = {
    [150000] = "Great Enemy Felled",
    [500000] = "Legend Felled"
};
local u11 = { Color3.fromRGB(176, 35, 38), Color3.fromRGB(197, 146, 50) };

return function(p12) -- Line: 51
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy), LocalPlayer (copy), u11 (copy), ConvertToOffset (copy), u9 (copy), u10 (copy), TweenService (copy), RunService (copy)
    local TargetCharacter = p12.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;

    if not HumanoidRootPart then
        return;
    end;

    local v13 = HumanoidRootPart.Size.Y / 2;
    local v14 = { "Head", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Torso" };
    local v15 = AssetHandler.GetAsset(p12.Name .. "/Aura", {
        AbilityName = "KillEffects"
    });

    for i = 1, #v14 do
        local v16 = TargetCharacter:FindFirstChild(v14[i]);

        if v16 then
            for _, child in v15:GetChildren() do
                local u17 = Instance.fromExisting(child);

                if v13 ~= 1 then
                    ParticleHandler.ScaleParticle(u17, v13);
                end;

                u17.Parent = v16;
                u17.Enabled = true;
                task.delay(2, function() -- Line: 80
                    -- upvalues: u17 (copy)
                    u17.Enabled = false;
                end);
            end;
        end;
    end;

    EffectsHandler.CallEffect("Emit Particle V3", {
        AbilityName = "KillEffects",
        AttachTo = {
            Part = HumanoidRootPart
        },
        Scale = 2.1 * v13,
        Path = p12.Name .. "/Burst"
    });
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/Startup", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    task.wait(0.35);
    task.spawn(function() -- Line: 100
        -- upvalues: TargetCharacter (copy)
        local v18 = next;
        local v19, v20 = TargetCharacter:GetDescendants();

        for _, v in v18, v19, v20 do
            if v:IsA("Part") or (v:IsA("Decal") or v:IsA("Texture")) then
                game.TweenService:Create(v, TweenInfo.new(2.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                    Transparency = 1
                }):Play();
            end;
        end;
    end);
    task.wait(0.7);
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    local v21 = p12.TargetPlayer == LocalPlayer and 1 or (p12.KillerPlayer == LocalPlayer and 2 or nil);

    if v21 then
        local v22 = AssetHandler.CloneAsset(p12.Name .. "/Screen", {
            AbilityName = "KillEffects"
        });
        v22.Parent = LocalPlayer.PlayerGui.Core;
        v22.Visible = true;
        local Holder = v22.Holder;
        local DeathMessage = v22.DeathMessage;
        local Vignette = v22.Vignette;
        DeathMessage.TextColor3 = u11[v21];
        ConvertToOffset(Holder);
        ConvertToOffset(DeathMessage);
        local v23 = v21 ~= 1 and "Enemy Felled" or u9[math.random(1, #u9)];

        if v21 == 2 then
            local v24 = p12.Bounty or 0;
            local v25 = 0;

            if v24 > 0 then
                for i, v in u10 do
                    if i < v24 and v25 <= i then
                        v23 = v;
                        v25 = i;
                    end;
                end;
            end;

            v23 = TargetCharacter:GetAttribute("IsBossNPC") and "Great Enemy Felled" or v23;

            if p12.TargetPlayer and (p12.TargetPlayer.Data and AssetHandler.GetAbilityData(p12.TargetPlayer).SkinName == "Mohg") then
                v23 = "Demigod Felled";
            end;
        elseif v21 == 1 and math.random(1, 25) == 1 then
            v23 = "Skill Issue";
        end;

        DeathMessage.Text = string.upper(v23);
        local AbsoluteSize = DeathMessage.AbsoluteSize;
        local AbsoluteSize2 = Holder.AbsoluteSize;
        local BackgroundTransparency = Holder.BackgroundTransparency;
        local v26 = 0;
        local v27 = {};
        local v28 = false;

        while v26 <= 2.25 do
            local v29 = TweenService:GetValue(math.min(1, v26 / 0.75), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
            local v30;

            if typeof(BackgroundTransparency) == "number" then
                v30 = BackgroundTransparency + (0.4 - BackgroundTransparency) * v29;
            else
                v30 = BackgroundTransparency:Lerp(0.4, v29);
            end;

            Holder.BackgroundTransparency = v30;
            Vignette.ImageTransparency = 1 + -0.7 * TweenService:GetValue(math.min(1, v26 / 1.5), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
            local v31 = UDim2.new(0, AbsoluteSize2.X, 0, AbsoluteSize2.Y);
            local v32 = UDim2.new(0, AbsoluteSize2.X, 0, AbsoluteSize2.Y * 1.75);
            local v33 = TweenService:GetValue(math.min(1, v26 / 3.375), Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            local v34;

            if typeof(v31) == "number" then
                v34 = v31 + (v32 - v31) * v33;
            else
                v34 = v31:Lerp(v32, v33);
            end;

            Holder.Size = v34;
            local TextTransparency = DeathMessage.TextTransparency;
            local v35 = TweenService:GetValue(math.min(1, v26 / 1.2162162162162162), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
            local v36;

            if typeof(TextTransparency) == "number" then
                v36 = TextTransparency + (0.125 - TextTransparency) * v35;
            else
                v36 = TextTransparency:Lerp(0.125, v35);
            end;

            DeathMessage.TextTransparency = v36;

            if v26 >= 1.5 then
                local TextTransparency2 = DeathMessage.TextTransparency;
                local v37 = TweenService:GetValue(math.min(1, (v26 - 1.5) / 0.30000000000000004), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
                local v38;

                if typeof(TextTransparency2) == "number" then
                    v38 = TextTransparency2 + (1 - TextTransparency2) * v37;
                else
                    v38 = TextTransparency2:Lerp(1, v37);
                end;

                DeathMessage.TextTransparency = v38;
                local BackgroundTransparency2 = Holder.BackgroundTransparency;
                local v39 = TweenService:GetValue(math.min(1, (v26 - 1.5) / 0.75), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
                local v40;

                if typeof(BackgroundTransparency2) == "number" then
                    v40 = BackgroundTransparency2 + (1 - BackgroundTransparency2) * v39;
                else
                    v40 = BackgroundTransparency2:Lerp(1, v39);
                end;

                Holder.BackgroundTransparency = v40;
                Vignette.ImageTransparency = 0.3 + 0.7 * TweenService:GetValue(math.min(1, (v26 - 1.5) / 0.75), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
            end;

            if #v27 > 0 then
                for i = 1, #v27 do
                    local v41 = v27[i];
                    local v42 = 0.4 + 0.4 * math.min(1, i + 1 / #v27);
                    local v43 = math.min(1, (v26 - 0.28125) / 1.3854166666666665);
                    local v44;

                    if typeof(v42) == "number" then
                        v44 = v42 + (1 - v42) * v43;
                    else
                        v44 = v42:Lerp(1, v43);
                    end;

                    v41.TextTransparency = v44;
                    local v45 = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y);
                    local v46 = UDim2.new(0, AbsoluteSize.X + i * 1.15, 0, AbsoluteSize.Y + i * 1.15);
                    local v47 = math.min(1, (v26 - 0.28125) / 1.2704741379310345);
                    local v48;

                    if typeof(v45) == "number" then
                        v48 = v45 + (v46 - v45) * v47;
                    else
                        v48 = v45:Lerp(v46, v47);
                    end;

                    v41.Size = v48;
                end;
            end;

            if v26 >= 0.28125 and not v28 then
                v28 = true;

                for i = 1, 20 do
                    local v49 = Instance.fromExisting(DeathMessage);
                    v49.Parent = DeathMessage.Parent;
                    v49.Name = "DeathMessageDuplicate_" .. i;
                    v49.TextTransparency = 1;
                    table.insert(v27, v49);
                end;
            end;

            v26 = v26 + RunService.Heartbeat:Wait();
        end;

        table.clear(v27);
        v22:Destroy();
    end;
end;