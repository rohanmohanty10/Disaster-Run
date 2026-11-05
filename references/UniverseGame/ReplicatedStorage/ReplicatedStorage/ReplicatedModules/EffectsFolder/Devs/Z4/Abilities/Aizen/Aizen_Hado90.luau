  

 

local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local u1 = Random.new();
local LocalPlayer = Players.LocalPlayer;

local function getRandomBorderPosition(p2, p3) -- Line: 11
    local v4 = p3 / 2;
    local v5 = math.random() * (4 * p3);

    if v5 <= p3 then
        return Vector3.new(p2.X - v4 + v5, p2.Y, p2.Z - v4);
    end;

    if v5 <= 2 * p3 then
        return Vector3.new(p2.X + v4, p2.Y, p2.Z - v4 + (v5 - p3));
    end;

    if v5 <= 3 * p3 then
        return Vector3.new(p2.X + v4 - (v5 - 2 * p3), p2.Y, p2.Z + v4);
    end;

    return Vector3.new(p2.X - v4, p2.Y, p2.Z + v4 - (v5 - 3 * p3));
end;

return function(p6) -- Line: 40
    -- upvalues: TweenService (copy), EffectsHandler (copy), ParticleHandler (copy), u1 (copy), getRandomBorderPosition (copy), LocalPlayer (copy), AssetHandler (copy)
    local u7 = CFrame.new(p6.HumanoidRootPart.Position - Vector3.new(0, 2.5, 0));
    local Model = Instance.new("Model");
    Model.Name = "Kurohitsugi Kill Effect " .. p6.Name;
    Model.Parent = workspace.Effects;
    local u8 = { Model };
    task.delay(6, function() -- Line: 60
        -- upvalues: u8 (copy), TweenService (ref), EffectsHandler (ref)
        for _, v in u8 do
            if v:IsA("BasePart") then
                TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            else
                EffectsHandler.CallEffect("SK_VANISH", {
                    Transparency = 1,
                    AffectStands = true,
                    Character = v,
                    TweenInfo = { 1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out }
                });
            end;

            task.delay(1, v.Destroy, v);
        end;
    end);

    for i = 1, 2 do
        local v9 = i == 1 and CFrame.identity or CFrame.new(0, 15, 0);
        local v10 = script.Effects.Square:Clone();
        v10.PrimaryPart.CFrame = u7 * v9;
        v10.Parent = workspace.Effects;

        for _, child in v10:GetChildren() do
            child.Transparency = 1;
            TweenService:Create(child, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, i == 2 and 1.4 or 0), {
                Transparency = 0
            }):Play();
        end;

        table.insert(u8, v10);
    end;

    local u11 = script.Effects.Main:Clone();
    u11.CFrame = u7 * CFrame.new(0, 7.5, 0);
    u11.Parent = workspace.Effects;
    ParticleHandler.EnableAllParticles(u11, true);
    TweenService:Create(u11, TweenInfo.new(1.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Size = u11.Size + Vector3.new(0, 15, 0),
        Position = u11.Position + Vector3.new(0, 7.5, 0)
    });
    task.spawn(EffectsHandler.CallEffect, "LM_COLOR_CORRECTION", {
        Brightness = 0.25,
        Contrast = 1,
        Saturation = -0.25,
        TweenTime = 0.5166666666666667,
        Time = 2.9,
        Origin = u11,
        TintColor = Color3.fromRGB(114, 112, 141),
        EndInfo = { 0.1 }
    });
    task.delay(1.5, function() -- Line: 120
        -- upvalues: u11 (copy)
        u11.Transparency = 0;
    end);
    table.insert(u8, u11);

    for i = 1, 4 do
        local v12 = CFrame.Angles(0, math.rad(i * 90), 0);
        local v13 = script.Effects.Outline:Clone();
        v13.Size = v13.Size * Vector3.new(1, 0, 1);
        v13.Transparency = 1;
        v13.CFrame = u7 * v12 * CFrame.new(-5.25, 0, -5.25);
        v13.Parent = workspace.Effects;
        TweenService:Create(v13, TweenInfo.new(0.75, Enum.EasingStyle.Linear), {
            Transparency = 0,
            Size = v13.Size + Vector3.new(0, 15, 0),
            Position = v13.Position + Vector3.new(0, 7.5, 0)
        }):Play();
        table.insert(u8, v13);

        for i2 = 0, 8 do
            local v14 = i2 / 8 * 10 + -5.5;
            local u15 = script.Effects.Box:Clone();
            u15.Size = Vector3.new(1.25, 0, u15.Size.Z);
            u15.Transparency = 1;
            u15.CFrame = u7 * v12 * CFrame.new(v14, 0, -5.5);
            u15.Parent = Model;

            if i2 == 0 or i2 == 8 then
                u15.CFrame = u15.CFrame * CFrame.new(u15.Size.X * (v14 > 0 and -0.5 or 0.5), 0, 0);
            end;

            TweenService:Create(u15, TweenInfo.new(u1:NextNumber(1.2, 1.5), Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Transparency = 0,
                Size = u15.Size + Vector3.new(0, 15, 0),
                Position = u15.Position + Vector3.new(0, 7.5, 0)
            }):Play();
            task.delay(1.55, function() -- Line: 162
                -- upvalues: u15 (copy)
                u15:Destroy();
            end);
        end;
    end;

    task.delay(1.35, function() -- Line: 170
        -- upvalues: ParticleHandler (ref), u11 (copy), u7 (copy), u1 (ref), getRandomBorderPosition (ref), u8 (copy), TweenService (ref), LocalPlayer (ref), AssetHandler (ref)
        ParticleHandler.EnableAllParticles(u11, false);

        for _ = 1, 24 do
            local Position = u7.Position;
            local v16 = u1:NextNumber(12, 14.625);
            local u17 = Position + Vector3.new(0, v16, 0);
            local u18 = script.Effects.Sword:Clone();
            u18.Transparency = 1;
            local v19 = u1:NextNumber(0.3, 0.4);
            local v20 = u1:NextNumber(1.9, 2.25);
            u18.Size = Vector3.new(v19, v20, u1:NextNumber(7.35, 9)) * u1:NextNumber(1, 1.5);
            local v21 = getRandomBorderPosition(u7, 35);
            local v22 = u1:NextNumber(9.75, 14.25);
            u18.Position = v21 + Vector3.new(0, v22, 0);
            u18.CFrame = CFrame.new(u18.Position, u17);
            u18.Parent = workspace.Effects;
            table.insert(u8, u18);
            local v23 = TweenService:Create(u18, TweenInfo.new(0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 0
            });
            v23:Play();
            v23.Completed:Connect(function() -- Line: 191
                -- upvalues: TweenService (ref), u18 (copy), u17 (copy), u1 (ref), ParticleHandler (ref), getRandomBorderPosition (ref), u7 (ref)
                local v24 = TweenService:Create(u18, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Transparency = 0,
                    CFrame = u18.CFrame * CFrame.new(0, 0, (u17 - u18.Position).Magnitude * -1 * u1:NextNumber(0.75, 0.95))
                });
                v24:Play();
                ParticleHandler.Emit(u18, ParticleHandler.GenerateEmitInfo(u18));
                v24.Completed:Connect(function() -- Line: 201
                    -- upvalues: u1 (ref), getRandomBorderPosition (ref), u7 (ref), TweenService (ref), u18 (ref)
                    for _ = 1, 3 do
                        local u25 = script.Effects.Spike:Clone();
                        u25.Size = u25.Size * u1:NextNumber(1.8, 2.5);
                        local new = CFrame.new;
                        local v26 = getRandomBorderPosition(u7, 10);
                        local v27 = u1:NextNumber(0.075, 0.95) * 15;
                        local v28 = new(v26 + Vector3.new(0, v27, 0));
                        local Angles = CFrame.Angles;
                        local v29 = 90 * math.random(1, 4);
                        u25.CFrame = v28 * Angles(-1.5707963267948966, 0, (math.rad(v29)));
                        u25.Parent = workspace.Effects;
                        local Size = u25.Size;
                        u25.Size = u25.Size * Vector3.new(1, 0, 1);
                        local u30 = Size.Y / u1:NextNumber(1.85, 2.4);
                        TweenService:Create(u25, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                            Size = Size,
                            CFrame = u25.CFrame * CFrame.new(0, u30, 0)
                        }):Play();
                        task.delay(u1:NextNumber(0.9, 1.3), function() -- Line: 218
                            -- upvalues: TweenService (ref), u25 (copy), u30 (copy)
                            local v31 = TweenService:Create(u25, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                CFrame = u25.CFrame * CFrame.new(0, -u30 * 1.3, 0),
                                Size = u25.Size * Vector3.new(1, 0, 1)
                            });
                            v31.Completed:Connect(function() -- Line: 223
                                -- upvalues: u25 (ref)
                                u25:Destroy();
                            end);
                            v31:Play();
                        end);
                    end;

                    task.wait(1.5);
                    TweenService:Create(u18, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                        Transparency = 1
                    }):Play();
                end);
            end);
        end;

        task.delay(1.5, function() -- Line: 239
            -- upvalues: ParticleHandler (ref), u11 (ref), LocalPlayer (ref), u7 (ref), AssetHandler (ref)
            ParticleHandler.Emit(u11, ParticleHandler.GenerateEmitInfo(u11));

            if not (LocalPlayer and LocalPlayer.Character) then
                return;
            end;

            local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;

            if HumanoidRootPart and (HumanoidRootPart.Position - u7.Position).Magnitude < 50 then
                local u32 = {};

                for _, child in game.Lighting:GetChildren() do
                    if child:IsA("ColorCorrectionEffect") then
                        u32[child] = child.Enabled;
                        child.Enabled = false;
                    end;
                end;

                local u33 = AssetHandler.GetAsset("Particles/Mes/Invert", {
                    AbilityName = "Ope"
                }):Clone();
                u33.Parent = game.Lighting;
                task.delay(0.08, function() -- Line: 261
                    -- upvalues: u33 (copy), u32 (copy)
                    u33:Destroy();

                    for i, v in u32 do
                        if i:IsDescendantOf(game) and i.Enabled ~= v then
                            i.Enabled = v;
                        end;
                    end;
                end);
            end;
        end);
    end);
end;