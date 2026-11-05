  

 

local wrap = coroutine.wrap;
local Angles = CFrame.Angles;
local rad = math.rad;
local ran = math.ran;
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local ReplicatedStorage = game.ReplicatedStorage;
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = EffectsHandler.GetEffect("tweendeb");
local u2 = EffectsHandler.GetEffect("ranNum");
local LocalPlayer = game.Players.LocalPlayer;
local u3 = EffectsHandler.GetEffect("Init");
local u4 = EffectsHandler.GetEffect("CameraShake");
local CameraShaker = require(game.ReplicatedStorage.ClientModules:WaitForChild("CameraShaker"));

return function(p5, p6, p7, p8, p9, p10, p11) -- Line: 14
    -- upvalues: wrap (copy), Angles (copy), ran (copy), rad (copy), TweenService (copy), u1 (copy), Debris (copy), ReplicatedStorage (copy), u2 (copy), LocalPlayer (copy), u3 (copy), CameraShaker (copy), u4 (copy)
    local function hitsmthidk(u12, p13, p14, u15) -- Line: 16
        -- upvalues: wrap (ref), Angles (ref), ran (ref), rad (ref), TweenService (ref), u1 (ref)
        local u16 = p14 or Color3.fromRGB(255, 119, 8);
        local v17 = game.ReplicatedStorage["Client Assets"]["Hit Effects"];
        local u18 = v17.Hit:Clone();
        local v19 = v17.Hit2:Clone();
        v19.Transparency = u15 and 1 or v19.Transparency;
        local u20 = p13 or 1;

        for _ = 1, 10 do
            wrap(function() -- Line: 25
                -- upvalues: Angles (ref), ran (ref), rad (ref), u12 (copy), u18 (copy), u16 (copy), u20 (copy), u15 (copy), TweenService (ref), u1 (ref)
                local v21 = u12 * Angles(rad((ran(360))), 0, (rad((ran(360)))));
                local v22 = u18:Clone();
                v22.Color = u16;
                local v23 = ran(3) / 10 * u20;
                local v24 = ran(10, 30) / 10 * u20;
                local v25 = ran(3) / 10 * u20;
                v22.Size = Vector3.new(v23, v24, v25) * 1.5;
                v22.CFrame = v21 * CFrame.new(0, u15 and 8 * u20 or v22.Size.Y / 2, 0);
                v22.Parent = workspace.Effects;
                v22.Transparency = u15 and 1 or 0;
                u1(TweenService:Create(v22, TweenInfo.new(u15 and 0.25 or 0.5, u15 and Enum.EasingStyle.Quint or Enum.EasingStyle.Quad, u15 and Enum.EasingDirection.In or Enum.EasingDirection.Out), {
                    Size = Vector3.new(0, 0, 0),
                    CFrame = v22.CFrame * CFrame.new(0, u15 and -(u15 - v22.Position).Magnitude or ran(3, 8) * u20, 0),
                    Transparency = u15 and 0 or 1
                }), v22);
            end)();
        end;

        v19.Color = u16;
        v19.CFrame = u12 * CFrame.Angles(rad((ran(360))), rad((ran(360))), (rad((ran(360)))));
        v19.Parent = workspace.Effects;
        v19.Size = v19.Size * u20;
        local v26 = TweenService:Create(v19, TweenInfo.new(0.3), {
            Transparency = 1,
            Size = v19.Size * 1.5
        });
        wrap(u1)(v26, v19);
    end;

    local u27 = p10 or 1;

    if p6:IsA("Model") then
        p6 = p6.Humanoid or p6;
    end;

    local v28;

    if p6:IsA("Attachment") then
        v28 = Instance.new("Part");
        v28.Name = "%KQBOMBTARGET";
        v28.Position = p6.WorldPosition;
        v28.Transparency = 1;
        v28.Anchored = true;
        v28.Size = Vector3.new();
        v28.CanCollide = false;
        v28.Parent = workspace.Effects;
        Debris:AddItem(v28, 4);
    else
        v28 = p6;
    end;

    local v29 = v28:IsA("Humanoid") and v28.Parent.PrimaryPart.Position or v28.Position;
    local v30 = p11 or (v28:IsA("Humanoid") and v28.Parent.PrimaryPart.CFrame or CFrame.new(v28.Position));
    local u31 = game.ReplicatedStorage["Client Assets"]["Killer Queen"].ExplosionTest:Clone();
    u31.Parent = workspace;
    u31:SetPrimaryPartCFrame(v30);
    game.Debris:AddItem(u31, 1.4);
    u31.Shock.Transparency = 1;

    if p7 then
        p7:Play();
    end;

    if not p9 then
        hitsmthidk(p5.Character.Stand["Stand Right Arm"].CFrame * CFrame.new(0, -1.25, 0), 0.25);
        hitsmthidk(v30, 2, nil, v29);
        wait(0.25);
    end;

    u31:SetPrimaryPartCFrame(v30);

    if p8 then
        local v32 = p8:Clone();

        if v28:IsA("Humanoid") then
            v28 = v28.Parent.PrimaryPart or v28;
        end;

        v32.Parent = v28;
        v32.PlayOnRemove = true;
        v32:Destroy();
    end;

    for _ = 1, 30 do
        local v33 = ReplicatedStorage["Client Assets"]["Killer Queen"].SparkParticle:Clone();
        v33.Position = v30.p;
        local v34 = u2(0, 60);
        local v35 = u2(0, 360);
        v33.Orientation = Vector3.new(v34, v35, 0);
        v33.Parent = workspace.Effects;
        v33.Velocity = v33.CFrame.LookVector * 80;
        Debris:AddItem(v33, u2(1, 2));
    end;

    local v36 = ReplicatedStorage["Client Assets"]["Killer Queen"].Explosion:Clone();
    v36.Parent = workspace.Effects;
    v36.CFrame = v30;
    local v37 = 0;

    for _, child in pairs(v36.Attachment:GetChildren()) do
        if v37 < child.Lifetime.Max then
            v37 = child.Lifetime.Max or v37;
        end;

        child.Enabled = true;
        task.spawn(function() -- Line: 105
            -- upvalues: child (copy)
            task.wait(0.05);
            child.Enabled = false;
        end);
    end;

    Debris:AddItem(v36, v37 + 0.1);
    TweenService:Create(v36.PointLight, TweenInfo.new(1, Enum.EasingStyle.Sine), {
        Brightness = 0,
        Range = 80 * u27
    }):Play();

    for _, child in pairs(u31:GetChildren()) do
        if child.Name == "Shock" then
            child.Transparency = 0;
            local v38 = math.random(-180, 180);
            local v39 = math.random(-180, 180);
            child.Orientation = Vector3.new(v38, v39, math.random(-180, 180));
            local v40 = TweenInfo.new(1);
            local v41 = {
                Transparency = 1,
                Size = child.Size + Vector3.new(80, 80, 80) * u27
            };
            local Orientation = child.Orientation;
            local v42 = math.random(-15, 15);
            local v43 = math.random(-15, 15);
            v41.Orientation = Orientation + Vector3.new(v42, v43, math.random(-15, 15));
            TweenService:Create(child, v40, v41):Play();
        end;
    end;

    u31.Parent = workspace;
    coroutine.wrap(function() -- Line: 125
        -- upvalues: u31 (copy), TweenService (ref), u27 (copy)
        for _ = 1, 3 do
            coroutine.wrap(function() -- Line: 127
                -- upvalues: u31 (ref), TweenService (ref), u27 (ref)
                local v44 = u31.Shock:Clone();
                game.Debris:AddItem(v44, 1.1);
                v44.Transparency = 0;
                v44.Parent = workspace;
                v44.Size = Vector3.new(0, 0, 0);
                local v45 = math.random(-180, 180);
                local v46 = math.random(-180, 180);
                v44.Orientation = Vector3.new(v45, v46, math.random(-180, 180));
                local v47 = TweenInfo.new(1);
                local v48 = {
                    Transparency = 1,
                    Size = v44.Size + Vector3.new(180, 180, 180) * u27
                };
                local Orientation = v44.Orientation;
                local v49 = math.random(-15, 15);
                local v50 = math.random(-15, 15);
                v48.Orientation = Orientation + Vector3.new(v49, v50, math.random(-15, 15));
                TweenService:Create(v44, v47, v48):Play();
            end)();
            wait(0.3);
        end;

        u31:Destroy();
    end)();

    if LocalPlayer.Settings.CameraShake.Value then
        local Magnitude = (LocalPlayer.Character.PrimaryPart.Position - v29).Magnitude;

        if Magnitude < 15 then
            u3:Shake(CameraShaker.Presets.IntenseExplosion);

            return;
        end;

        if Magnitude < 50 then
            u3:Shake(CameraShaker.Presets.Explosion2);

            return;
        end;

        coroutine.wrap(u4)("Bump");
        wait(0.5);
        coroutine.wrap(u4)("OldBump");
    end;
end;