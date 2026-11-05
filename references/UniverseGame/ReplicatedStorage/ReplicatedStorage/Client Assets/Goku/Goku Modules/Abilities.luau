  

 

game:GetService("RunService");
local Funcs = require(game.ReplicatedStorage["Client Assets"].Goku["Goku Modules"].Funcs);
local Thread = Funcs.Thread;
local Wait = Funcs.Wait;
local Tween = Funcs.Tween;
local Raycast = Funcs.Raycast;
local GetFloor = Funcs.GetFloor;
local new = CFrame.new;
local new2 = Vector3.new;
local _ = Instance.new;
local _ = Region3.new;
local _ = Color3.new;
local _ = Vector2.new;
local _ = UDim2.new;
local Angles = CFrame.Angles;
local _ = math.rad;
local _ = math.cos;
local _ = math.sin;
local _ = math.tan;
local _ = BrickColor.new;
local fromRGB = Color3.fromRGB;
local RNG = Funcs.RNG;
local _ = Funcs.Glue;
local _ = Funcs.XYZ;
local _ = Funcs.Sequence;
local CreateSound = Funcs.CreateSound;
local DivideColor = Funcs.DivideColor;

local function ForEach(p1, p2) -- Line: 14
    for i, v in pairs(p1) do
        p2(i, v);
    end;
end;

return {
    Barrage = function(u3, u4, u5, p6, p7, p8, u9, p10) -- Line: 21
        -- upvalues: Wait (copy), Thread (copy)
        local u11 = u4[3];
        local u12 = u4[2];
        local v13 = u5[u3.Name].Abilities[u12];

        if v13 == nil then
            if p10 ~= true then
                tick();
                u5[u3.Name].Abilities[u12] = tick();
            end;
        elseif v13 ~= nil then
            if tick() - v13 < u4[1](u4[2], u3.Character.GokuAssets.Form.Value) then
                return;
            end;

            u5[u3.Name].Abilities[u12] = tick();
        end;

        if p10 ~= true then
            u9:FireClient(u3, {
                Type = "Creation",
                Title = "Air Rush",
                Duration = u4[1](u4[2], u4[3]),
                Timestamp = tick()
            });
        end;

        if p10 == true then
            u5[u3.Name].Abilities[u12] = 0;
        end;

        local Character = u3.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local v14 = Character:FindFirstChildOfClass("Humanoid");
        local Value = u3.Character.GokuAssets.DamageMultiplication.Value;

        for _ = 1, 16 do
            p8({
                Size = Vector3.new(4, 4, 4),
                BypassFF = false,
                DamageType = "Default",
                Stun = true,
                StunTime = 0.5,
                HitTime = 0.115,
                KnockbackTime = 0.05,
                CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2.5),
                Amount = math.random(2, 4) * Value,
                HitCFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2.5),
                Knockback = HumanoidRootPart.CFrame.lookVector * 6 + Vector3.new(0, 0.75, 0)
            }, u3);

            if v14.Health < 0.001 then
                break;
            end;

            Wait(0.025);
        end;

        Wait(0.1);
        p8({
            Size = Vector3.new(5.5, 5.5, 5.5),
            BypassFF = false,
            DamageType = "Knock",
            Stun = true,
            StunTime = 0.75,
            HitTime = 0.2,
            KnockbackTime = 0.6,
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2.75),
            Amount = math.random(7, 15) * Value,
            HitCFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2.75),
            Knockback = HumanoidRootPart.CFrame.lookVector * 35
        }, u3);
        Thread(function() -- Line: 84
            -- upvalues: u11 (ref), u5 (copy), u3 (copy), u9 (copy), u4 (copy), u12 (copy)
            while true do
                game:GetService("RunService").Heartbeat:Wait();

                if u11 ~= u5[u3.Name].Form then
                    u9:FireClient(u3, {
                        Type = "Creation",
                        Title = "Air Rush",
                        Duration = u4[1](u4[2], u5[u3.Name].Form) - (tick() - u5[u3.Name].Abilities[u12]),
                        Timestamp = tick()
                    });
                    u11 = u5[u3.Name].Form;
                end;

                if tick() - u5[u3.Name].Abilities[u12] >= u4[1](u4[2], u5[u3.Name].Form) then
                    u9:FireClient(u3, {
                        Type = "Cooldown",
                        CooldownTable = "Moves",
                        CooldownValue = false,
                        CooldownName = u12
                    });

                    return;
                end;
            end;
        end);
    end,

    Blink = function(u15, u16, u17, p18, p19, p20, u21, p22) -- Line: 105
        -- upvalues: Angles (copy), new (copy), fromRGB (copy), RNG (copy), new2 (copy), Wait (copy), Thread (copy)
        local u23 = u16[3];
        local u24 = u16[2];
        local v25 = u17[u15.Name].Abilities[u24];

        if v25 == nil then
            if p22 ~= true then
                tick();
                u17[u15.Name].Abilities[u24] = tick();
            end;
        elseif v25 ~= nil then
            if tick() - v25 < u16[1](u16[2], u15.Character.GokuAssets.Form.Value) then
                return;
            end;

            u17[u15.Name].Abilities[u24] = tick();
        end;

        if p22 ~= true then
            u21:FireClient(u15, {
                Type = "Creation",
                Title = "Dead in an Eyesight",
                Duration = u16[1](u16[2], u16[3]),
                Timestamp = tick()
            });
        end;

        if p22 == true then
            u17[u15.Name].Abilities.Blink = 0;
        end;

        local Character = u15.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;
        Character:FindFirstChildOfClass("Humanoid");
        local Value = u15.Character.GokuAssets.DamageMultiplication.Value;
        p19:FireAllClients("Mood", {
            Type = "3D",
            Duration = 0.4,
            Pos = { HumanoidRootPart.CFrame * Angles(0, 1.5707963267948966, 0) * new(-5, 0, -3), HumanoidRootPart.CFrame * Angles(0, 1.5707963267948966, 0) * new(-9, 0.5, -4) },
            Object = p18.waveLeft,
            objectProperties = {
                Material = "Neon"
            },
            Transparency = { 0, 1 },
            Size = { Vector3.new(10, 5, 2), Vector3.new(21, 5, 2) },
            Color = { fromRGB(255, 255, 255), fromRGB(255, 255, 255) },
            tweenProperties = {
                Direction = "InOut",
                Style = "Quad"
            },
            Parent = Character.Effects
        });
        p19:FireAllClients("Mood", {
            Type = "3D",
            Duration = 0.4,
            Pos = { HumanoidRootPart.CFrame * Angles(0, 1.5707963267948966, 0) * new(-5, 0, 3), HumanoidRootPart.CFrame * Angles(0, 1.5707963267948966, 0) * new(-9, 0.5, 4) },
            Object = p18.waveRight,
            objectProperties = {
                Material = "Neon"
            },
            Transparency = { 0, 1 },
            Size = { Vector3.new(10, 5, 2), Vector3.new(21, 5, 2) },
            Color = { fromRGB(255, 255, 255), fromRGB(255, 255, 255) },
            tweenProperties = {
                Direction = "InOut",
                Style = "Quad"
            },
            Parent = Character.Effects
        });

        for _ = 1, RNG(12, 20) do
            local v26 = RNG(10, 20, true);
            local v27 = HumanoidRootPart.CFrame * new(RNG(-5, 5, true), RNG(-5, 5, true), RNG(-5, 5, true)) * new(0, 0, RNG(-20, 20));
            local v28 = v27 * new(0, 0, -RNG(80, 96, true));
            p19:FireAllClients("Mood", {
                Type = "3D",
                Duration = RNG(0.25, 0.5, true),
                Pos = { v27, v28 },
                Object = p18.BOX,
                objectProperties = {
                    Material = "Neon"
                },
                Transparency = { 0, 1 },
                Size = { new2(0.2, 0.2, v26), (new2(0.15, 0.15, v26 * 1.35)) },
                Color = { fromRGB(255, 255, 255), fromRGB(255, 255, 255) },
                tweenProperties = {
                    Direction = "InOut",
                    Style = "Quad"
                },
                Parent = Character.Effects
            });
        end;

        p19:FireAllClients("Mood", {
            Type = "3D",
            Duration = 1,
            Pos = { HumanoidRootPart.CFrame:Lerp(HumanoidRootPart.CFrame * new(0, 0, -80), 0.5), HumanoidRootPart.CFrame:Lerp(HumanoidRootPart.CFrame * new(0, 0, -80), 0.5) },
            Object = p18.BOX,
            objectProperties = {
                Material = "Neon"
            },
            Transparency = { 0, 1 },
            Size = { Vector3.new(1.2, 1.2, 80), Vector3.new(0.35, 0.35, 80) },
            Color = { fromRGB(255, 255, 255), fromRGB(255, 255, 255) },
            tweenProperties = {
                Direction = "InOut",
                Style = "Quad"
            },
            Parent = Character.Effects
        });
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -80);
        HumanoidRootPart.Anchored = true;

        if #p20({
            Size = Vector3.new(7, 7, 80),
            Amount = 0,
            HitCFrame = nil,
            BypassFF = false,
            DamageType = "nil",
            Stun = false,
            StunTime = nil,
            HitTime = 0.2,
            Knockback = nil,
            KnockbackTime = nil,
            ReturnTargets = true,
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, 40)
        }, u15) > 0 then
            u21:FireClient(u15, {
                Type = "Blink",
                Bool = true
            });
            p20({
                Size = Vector3.new(7, 7, 80),
                HitCFrame = nil,
                BypassFF = false,
                DamageType = "Rush",
                Stun = true,
                StunTime = 3,
                HitTime = 0.2,
                Knockback = Vector3.new(0, -5, 0),
                KnockbackTime = 0.25,
                CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, 40),
                Amount = { 1 * (Value / 1.75), 4 * (Value / 1.75) }
            }, u15);
            Wait(1.75);
        end;

        Wait(0.75);
        HumanoidRootPart.Anchored = false;
        u21:FireClient(u15, {
            Type = "Blink",
            Bool = false
        });
        Thread(function() -- Line: 251
            -- upvalues: u15 (copy), u23 (ref), u21 (copy), u16 (copy), u17 (copy), u24 (copy)
            while true do
                game:GetService("RunService").Heartbeat:Wait();

                if u15.Character and (u15.Character:FindFirstChild("GokuAssets") and u23 ~= u15.Character.GokuAssets.Form.Value) then
                    u21:FireClient(u15, {
                        Type = "Creation",
                        Title = "Dead in an eyesight",
                        Duration = u16[1](u16[2], u15.Character.GokuAssets.Form.Value) - (tick() - u17[u15.Name].Abilities[u24]),
                        Timestamp = tick()
                    });
                    u23 = u15.Character.GokuAssets.Form.Value;
                end;

                if tick() - u17[u15.Name].Abilities[u24] >= u16[1](u16[2], u15.Character.GokuAssets.Form.Value) then
                    u21:FireClient(u15, {
                        Type = "Cooldown",
                        CooldownTable = "Moves",
                        CooldownValue = false,
                        CooldownName = u24
                    });

                    return;
                end;
            end;
        end);
    end,

    Charge = function(u29, u30, u31, p32, u33, p34, u35, p36) -- Line: 271
        -- upvalues: ForEach (copy), Thread (copy), GetFloor (copy), Wait (copy)
        local u37 = u30[3];
        local u38 = u30[2];
        local Character = u29.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local u39 = Character:FindFirstChildOfClass("Humanoid");
        local Value = u29.Character.GokuAssets.DamageMultiplication.Value;
        Character.GokuAssets.Charging.Value = true;
        local v40 = u35.Parent.Assets.Models.BigAuras[Character.GokuAssets.Form.Value]:GetChildren();

        local function _(p41, u42) -- Line: 278
            -- upvalues: HumanoidRootPart (copy), Character (copy)
            local v43 = u42:GetChildren();

            local function v47(p44, p45) -- Line: 279
                -- upvalues: u42 (copy), HumanoidRootPart (ref), Character (ref)
                if p45:IsA("ParticleEmitter") then
                    local v46 = p45:Clone();
                    v46.Enabled = true;
                    v46.Name = "BigAuraParticle";

                    if u42.Name == "Torso" then
                        v46.Parent = HumanoidRootPart;

                        return;
                    end;

                    if u42.Name == "Limbs" then
                        v46:Clone().Parent = Character["Left Arm"];
                        v46:Clone().Parent = Character["Right Arm"];
                        v46:Clone().Parent = Character["Left Leg"];
                        v46:Clone().Parent = Character["Right Leg"];
                        v46:Clone().Parent = Character.Head;

                        return;
                    end;

                    if u42.Name == "Body" then
                        v46.Parent = Character.BodyBox;
                    end;
                end;
            end;

            for i, v in pairs(v43) do
                v47(i, v);
            end;
        end;

        for _, v in pairs(v40) do
            ForEach(v:GetChildren(), function(p48, p49) -- Line: 279
                -- upvalues: v (copy), HumanoidRootPart (copy), Character (copy)
                if p49:IsA("ParticleEmitter") then
                    local v50 = p49:Clone();
                    v50.Enabled = true;
                    v50.Name = "BigAuraParticle";

                    if v.Name == "Torso" then
                        v50.Parent = HumanoidRootPart;

                        return;
                    end;

                    if v.Name == "Limbs" then
                        v50:Clone().Parent = Character["Left Arm"];
                        v50:Clone().Parent = Character["Right Arm"];
                        v50:Clone().Parent = Character["Left Leg"];
                        v50:Clone().Parent = Character["Right Leg"];
                        v50:Clone().Parent = Character.Head;

                        return;
                    end;

                    if v.Name == "Body" then
                        v50.Parent = Character.BodyBox;
                    end;
                end;
            end);
        end;

        Thread(function() -- Line: 299
            -- upvalues: Character (copy), GetFloor (ref), HumanoidRootPart (copy), Wait (ref), u39 (copy), u33 (copy)
            local v51 = Character:GetChildren();
            local v52 = nil;

            for i = 1, #v51 do
                if v51[i]:IsA("BasePart") and (string.find(v51[i].Name, "Hair") or string.match(v51[i].Name, "Hair")) and v51[i].Transparency == 0 then
                    v52 = v51[i];
                end;
            end;

            local v53 = GetFloor(Character, HumanoidRootPart);

            while true do
                Wait(0.02);

                if u39.Health < u39.MaxHealth then
                    u39.Health = u39.Health + 2.5;
                else
                    u39.Health = u39.MaxHealth;
                end;

                local v54 = HumanoidRootPart.CFrame * CFrame.new(math.random(-50, 50) / 10, math.random(-35, 0) / 10, math.random(-50, 50) / 10);
                u33:FireAllClients("Cube", {
                    Transparency = 0,
                    Time = 1,
                    CFrame = v54,
                    Color = v53.Color,
                    Size = Vector3.new(1, 1, 1) * math.random(3, 10) / 10,
                    Material = v53.Material,
                    Style = Enum.EasingStyle.Sine,
                    Direction = Enum.EasingDirection.Out,
                    Properties = {
                        Transparency = 1,
                        CFrame = v54 * CFrame.new(0, 5, 0)
                    }
                });
                local v55 = HumanoidRootPart.CFrame * CFrame.new(math.random(-25, 25) / 10 * math.random(7, 25) / 10, math.random(-20, 20) / 10, math.random(-25, 25) / 10 * math.random(7, 25) / 10);
                u33:FireAllClients("Sphere", {
                    Transparency = 0,
                    Size = Vector3.new(0.21, 1.45, 0.33),
                    Time = 0.2,
                    CFrame = v55,
                    Color = v52.Color,
                    Material = Enum.Material.Neon,
                    Style = Enum.EasingStyle.Sine,
                    Direction = Enum.EasingDirection.InOut,
                    Properties = {
                        Transparency = 1,
                        CFrame = v55 * CFrame.new(0, math.random(5, 25) / 10, 0)
                    }
                });

                if not u39 or (not Character or Character.GokuAssets.Charging.Value == false) then
                    return;
                end;
            end;
        end);

        repeat
            Wait(0.1);
            u33:FireAllClients("Shake", {
                FadeIn = 0.069,
                FadeOut = 0.25,
                Magnitude = 1 + Value / 15,
                Roughness = 0.7 + Value / 11
            });
            local v56 = math.random(-45, 45) * math.random(5, 45) / 35;
            local v57 = {
                WaveType = 6,
                Transparency = 0,
                StartSize = Vector3.new(5, 1, 5),
                Time = 0.4,
                CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -1.5, 0),
                Color = Color3.fromRGB(255, 255, 255),
                Style = Enum.EasingStyle.Sine,
                Direction = Enum.EasingDirection.InOut
            };
            local v58 = {
                Transparency = 1
            };
            local v59 = HumanoidRootPart.CFrame * CFrame.new(0, -1.25, 0);
            local Angles2 = CFrame.Angles;
            local v60 = math.random(-45, 45) * math.random(5, 45) / 10;
            v58.CFrame = v59 * Angles2(0, math.rad(v60), 0);
            v58.Size = Vector3.new(v56 / 2 + 25, v56 / 4 + 5, v56 / 2 + 25);
            v57.Properties = v58;
            u33:FireAllClients("Wave", v57);
            local v61 = {
                Type = 1,
                Transparency = 0.25,
                Size = Vector3.new(2, 2, 2),
                Time = 0.25,
                CFrame = HumanoidRootPart.CFrame,
                Color = Color3.fromRGB(255, 255, 255),
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Sine,
                Direction = Enum.EasingDirection.InOut
            };
            local v62 = {
                Size = Vector3.new(8, 8, 8),
                Transparency = 1
            };
            local CFrame2 = HumanoidRootPart.CFrame;
            local Angles3 = CFrame.Angles;
            local v63 = math.random(60, 180);
            v62.CFrame = CFrame2 * Angles3(0, math.rad(v63), 0);
            v61.Properties = v62;
            u33:FireAllClients("Swirl", v61);
        until not u39 or (not Character or Character.GokuAssets.Charging.Value == false);

        local v64 = Character:GetDescendants();

        local function _(p65, p66) -- Line: 392
            if p66:IsA("ParticleEmitter") and p66.Name == "BigAuraParticle" then
                p66.Enabled = false;
                game:GetService("Debris"):AddItem(p66, 2);
            end;
        end;

        for _, v in pairs(v64) do
            if v:IsA("ParticleEmitter") and v.Name == "BigAuraParticle" then
                v.Enabled = false;
                game:GetService("Debris"):AddItem(v, 2);
            end;
        end;

        Wait(0.15);
        u33:FireAllClients("Circle", {
            Transparency = 0,
            Size = Vector3.new(1, 1, 0.065),
            Time = 0.6,
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.1, 0) * CFrame.Angles(1.5707963267948966, 0, 0),
            Color = Color3.fromRGB(255, 255, 255),
            Style = Enum.EasingStyle.Cubic,
            Direction = Enum.EasingDirection.Out,
            PartProperties = {
                Size = Vector3.new(25, 25, 0.2),
                Transparency = 1
            },
            MeshProperties = {
                Scale = Vector3.new(25, 25, 0.2)
            }
        });
        local v67 = {
            WaveType = 6,
            Transparency = 0,
            StartSize = Vector3.new(5, 1, 5),
            Time = 0.75,
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -1.5, 0),
            Color = Color3.fromRGB(255, 255, 255),
            Style = Enum.EasingStyle.Sine,
            Direction = Enum.EasingDirection.InOut
        };
        local v68 = {
            Size = Vector3.new(25, 10, 25),
            Transparency = 1
        };
        local v69 = HumanoidRootPart.CFrame * CFrame.new(0, -1.25, 0);
        local Angles2 = CFrame.Angles;
        local v70 = math.random(-45, 45) * math.random(5, 45) / 10;
        v68.CFrame = v69 * Angles2(0, math.rad(v70), 0);
        v67.Properties = v68;
        u33:FireAllClients("Wave", v67);
        u33:FireAllClients("TransformShake");
        local v71 = u31[u29.Name].Abilities[u38];

        if v71 == nil then
            if p36 ~= true then
                tick();
                u31[u29.Name].Abilities[u38] = tick();
            end;
        elseif v71 ~= nil then
            if tick() - v71 < u30[1](u30[2], u29.Character.GokuAssets.Form.Value) then
                return;
            end;

            u31[u29.Name].Abilities[u38] = tick();
        end;

        if p36 ~= true then
            u35:FireClient(u29, {
                Type = "Creation",
                Title = "Charge",
                Duration = u30[1](u30[2], u30[3]),
                Timestamp = tick()
            });
        end;

        if p36 == true then
            u31[u29.Name].Abilities[u38] = 0;
        end;

        Thread(function() -- Line: 455
            -- upvalues: u37 (ref), u31 (copy), u29 (copy), u35 (copy), u30 (copy), u38 (copy)
            while true do
                game:GetService("RunService").Heartbeat:Wait();

                if u37 ~= u31[u29.Name].Form then
                    u35:FireClient(u29, {
                        Type = "Creation",
                        Title = "Charge",
                        Duration = u30[1](u30[2], u31[u29.Name].Form) - (tick() - u31[u29.Name].Abilities[u38]),
                        Timestamp = tick()
                    });
                    u37 = u31[u29.Name].Form;
                end;

                if tick() - u31[u29.Name].Abilities[u38] >= u30[1](u30[2], u31[u29.Name].Form) then
                    u35:FireClient(u29, {
                        Type = "Cooldown",
                        CooldownTable = "Moves",
                        CooldownValue = false,
                        CooldownName = u38
                    });

                    return;
                end;
            end;
        end);
    end,

    DragonFist = function(u72, u73, u74, p75, p76, u77, u78, p79) -- Line: 476
        -- upvalues: Thread (copy), Wait (copy)
        local u80 = u73[3];
        local u81 = u73[2];
        local v82 = u74[u72.Name].Abilities[u81];

        if v82 == nil then
            if p79 ~= true then
                tick();
                u74[u72.Name].Abilities[u81] = tick();
            end;
        elseif v82 ~= nil then
            if tick() - v82 < u73[1](u73[2], u72.Character.GokuAssets.Form.Value) then
                return;
            end;

            u74[u72.Name].Abilities[u81] = tick();
        end;

        if p79 ~= true then
            u78:FireClient(u72, {
                Type = "Creation",
                Title = "Dragon Fist",
                Duration = u73[1](u73[2], u73[3]),
                Timestamp = tick()
            });
        end;

        if p79 == true then
            u74[u72.Name].Abilities.DragonFist = 0;
        end;

        local Character = u72.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local v83 = Character:FindFirstChildOfClass("Humanoid");
        local Value = u72.Character.GokuAssets.DamageMultiplication.Value;

        for _ = 1, 8 do
            Thread(function() -- Line: 507
                -- upvalues: u77 (copy), HumanoidRootPart (copy), Value (copy), u72 (copy)
                u77({
                    Size = Vector3.new(9, 9, 9),
                    BypassFF = false,
                    DamageType = "DragonFist",
                    Stun = true,
                    StunTime = 3,
                    HitTime = 1.5,
                    KnockbackTime = 0.1,
                    CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2.75),
                    Amount = math.random(70, 150) * Value,
                    HitCFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -5),
                    Knockback = HumanoidRootPart.CFrame.lookVector * 50
                }, u72);
            end);

            if v83.Health < 0.001 then
                break;
            end;

            Wait(0.1);
        end;

        u77({
            Size = Vector3.new(15, 15, 15),
            BypassFF = false,
            DamageType = "DragonFist",
            Stun = true,
            StunTime = 3.5,
            HitTime = 0.7,
            KnockbackTime = 0.1,
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2.75),
            Amount = math.random(100, 180) * Value,
            HitCFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -6),
            Knockback = HumanoidRootPart.CFrame.lookVector * 80
        }, u72);
        Thread(function() -- Line: 540
            -- upvalues: u80 (ref), u74 (copy), u72 (copy), u78 (copy), u73 (copy), u81 (copy)
            while true do
                game:GetService("RunService").Heartbeat:Wait();

                if u80 ~= u74[u72.Name].Form then
                    u78:FireClient(u72, {
                        Type = "Creation",
                        Title = "Dragon Fist",
                        Duration = u73[1](u73[2], u74[u72.Name].Form) - (tick() - u74[u72.Name].Abilities[u81]),
                        Timestamp = tick()
                    });
                    u80 = u74[u72.Name].Form;
                end;

                if tick() - u74[u72.Name].Abilities[u81] >= u73[1](u73[2], u74[u72.Name].Form) then
                    u78:FireClient(u72, {
                        Type = "Cooldown",
                        CooldownTable = "Moves",
                        CooldownValue = false,
                        CooldownName = u81
                    });

                    return;
                end;
            end;
        end);
    end,

    Feint = function(u84, u85, u86, p87, p88, u89, u90, p91) -- Line: 560
        -- upvalues: Thread (copy)
        local u92 = u85[3];
        local u93 = u85[2];
        local v94 = u86[u84.Name].Abilities[u93];

        if v94 == nil then
            if p91 ~= true then
                tick();
                u86[u84.Name].Abilities[u93] = tick();
            end;
        elseif v94 ~= nil then
            if tick() - v94 < u85[1](u85[2], u84.Character.GokuAssets.Form.Value) then
                return;
            end;

            u86[u84.Name].Abilities[u93] = tick();
        end;

        local HumanoidRootPart = u84.Character.HumanoidRootPart;
        local Value = u84.Character.GokuAssets.DamageMultiplication.Value;

        if p91 ~= true then
            u90:FireClient(u84, {
                Type = "Creation",
                Title = u93,
                Duration = u85[1](u85[2], u85[3]),
                Timestamp = tick()
            });
        end;

        if p91 == true then
            u86[u84.Name].Abilities.Feint = 0;
        end;

        pcall(function() -- Line: 589
            -- upvalues: u89 (copy), HumanoidRootPart (copy), Value (copy), u84 (copy)
            u89({
                Size = Vector3.new(4, 4, 4),
                BypassFF = false,
                DamageType = "Feint",
                Stun = true,
                StunTime = 2.5,
                HitTime = 0.5,
                KnockbackTime = 0.1,
                CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2.5),
                Amount = math.random(50, 70) * Value,
                HitCFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2.5),
                Knockback = HumanoidRootPart.CFrame.lookVector * 5 + Vector3.new(0, 5, 0)
            }, u84);
        end);
        Thread(function() -- Line: 604
            -- upvalues: u92 (ref), u86 (copy), u84 (copy), u90 (copy), u85 (copy), u93 (copy)
            while true do
                game:GetService("RunService").Heartbeat:Wait();

                if u92 ~= u86[u84.Name].Form then
                    u90:FireClient(u84, {
                        Type = "Creation",
                        Title = "Feint",
                        Duration = u85[1](u85[2], u86[u84.Name].Form) - (tick() - u86[u84.Name].Abilities[u93]),
                        Timestamp = tick()
                    });
                    u92 = u86[u84.Name].Form;
                end;

                if tick() - u86[u84.Name].Abilities[u93] >= u85[1](u85[2], u86[u84.Name].Form) then
                    u90:FireClient(u84, {
                        Type = "Cooldown",
                        CooldownTable = "Moves",
                        CooldownValue = false,
                        CooldownName = u93
                    });

                    return;
                end;
            end;
        end);
    end,

    Genkidama = function(u95, u96, u97, u98, u99, u100, u101, p102) -- Line: 624
        -- upvalues: new (copy), Tween (copy), CreateSound (copy), Thread (copy), fromRGB (copy), RNG (copy), new2 (copy), Angles (copy), Wait (copy), Raycast (copy)
        local _ = u96[3];
        local u103 = u96[2];
        local v104 = u97[u95.Name].Abilities[u103];

        if v104 == nil then
            if p102 ~= true then
                tick();
                u97[u95.Name].Abilities[u103] = tick();
            end;
        elseif v104 ~= nil then
            if tick() - v104 < u96[1](u96[2], u95.Character.GokuAssets.Form.Value) then
                return;
            end;

            u97[u95.Name].Abilities[u103] = tick();
        end;

        if p102 == true then
            u97[u95.Name].Abilities.Genkidama = 0;
        end;

        local Character = u95.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local u105 = Character:FindFirstChildOfClass("Humanoid");
        local Value = u95.Character.GokuAssets.DamageMultiplication.Value;
        local u106 = HumanoidRootPart.CFrame * new(0, 40, 0);
        local p = u106.p;
        local Effects = Character.Effects;
        local _ = Character.GokuAssets.Form.Value;
        local v107 = game:GetService("Players"):GetPlayers();
        local v108 = {};

        for i = 1, #v107 do
            table.insert(v108, v107[i].Character);
        end;

        table.insert(v108, Effects);
        local u109 = false;
        local u110 = u98.Genkidama:Clone();
        local PrimaryPart = u110.PrimaryPart;
        u110.Core.CFrame = u106 * new(0, 5, 0);
        u110.Parent = Effects;
        local v111 = Tween(PrimaryPart, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
            Transparency = 0,
            CFrame = u106
        });
        Tween(u110.outerSphere, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
            Transparency = 0.2
        }, true);
        Tween(u110.innerSphere, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
            Transparency = 0
        }, true);
        v111:Play();
        local u112 = false;
        local u113 = { Color3.fromRGB(21, 216, 255), Color3.fromRGB(255, 255, 255) };
        v111.Completed:Wait();
        CreateSound(u110.Core, 919429799, 4, 0.95, 0, 4.1);
        Thread(function() -- Line: 696
            -- upvalues: u105 (copy), u109 (ref), CreateSound (ref), u110 (copy), u99 (copy), u106 (ref), u98 (copy), fromRGB (ref), Effects (copy), RNG (ref), new (ref), p (copy), new2 (ref), Angles (ref), u113 (copy), Wait (ref), u112 (ref)
            while u105.Parent ~= nil and u105.Health ~= 0 do
                local v114 = RNG(1, 2);
                local v115 = RNG(1.5, 2.5, true);
                local v116 = new(p + new2(RNG(-60, 60, true), RNG(-60, 60, true), RNG(-60, 60, true)), p);
                u99:FireAllClients("Mood", {
                    Type = "3D",
                    Duration = RNG(0.3, 0.7, true),
                    Pos = { v116, new(p, v116.p) * Angles(3.141592653589793, 0, 0) },
                    Object = u98.Sphere,
                    objectProperties = {
                        Material = "Neon"
                    },
                    Transparency = { 1, 0.3 },
                    Size = { new2(v115, v115, v115 / 2.5), (new2(v115 / 2, v115 / 2, 10)) },
                    Color = { u113[v114], u113[v114] },
                    tweenProperties = {
                        Direction = "InOut",
                        Style = "Quad"
                    },
                    Parent = Effects
                });
                Wait();

                if u112 then
                    return;
                end;
            end;

            u109 = true;
            CreateSound(u110.Core, 185702591, 10, 0.95, 0, 4.1);
            u99:FireAllClients("Mood", {
                Type = "3D",
                Duration = 0.4,
                Pos = { u106, u106 },
                Object = u98.Sphere,
                objectProperties = {
                    Material = "Neon"
                },
                Transparency = { 0.45, 1 },
                Size = { Vector3.new(0, 0, 0), Vector3.new(100, 100, 100) },
                Color = { fromRGB(0, 0, 0), fromRGB(255, 0, 0) },
                tweenProperties = {
                    Direction = "InOut",
                    Style = "Quad"
                },
                Parent = Effects
            });
        end);
        local v117 = Tween(PrimaryPart, 4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
            Size = Vector3.new(30, 30, 30)
        });
        Tween(u110.outerSphere, 4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
            Size = Vector3.new(53.042, 53.042, 53.042)
        }, true);
        Tween(u110.innerSphere, 4.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
            Size = Vector3.new(50.39, 50.39, 50.39)
        }, true);
        v117:Play();
        v117.Completed:Wait();

        if u109 then
            u101:FireClient(u95, {
                Type = "Genkidama",
                Bool = true
            });
            local v118 = next;
            local v119, v120 = u110:GetChildren();

            for i, v in v118, v119, v120 do
                Tween(v, 0.4 + i / 10, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
                    Size = Vector3.new(1, 1, 1),
                    Transparency = 1
                }, true);
            end;

            Tween(PrimaryPart.PointLight, 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
                Range = 0
            }, true);
            Thread(function() -- Line: 911
                -- upvalues: Wait (ref), u110 (copy)
                Wait(4);
                u110:Destroy();
            end);
        else
            u106 = HumanoidRootPart.CFrame * new(0, 40, 0);
            local v121, v122 = Raycast(p, (u106 * Angles(-0.49741883681838395, 0, 0)).lookVector, 500, v108);
            local v123 = Tween(PrimaryPart, 4, Enum.EasingStyle.Sine, Enum.EasingDirection.In, {
                Position = v122
            });
            u112 = true;
            v123:Play();
            v123.Completed:Wait();
            u101:FireClient(u95, {
                Type = "Genkidama",
                Bool = true
            });
            local u124 = 200 * Value;

            if v121 == nil then
                local v125 = next;
                local v126, v127 = u110:GetChildren();

                for i, v in v125, v126, v127 do
                    Tween(v, 0.4 + i / 10, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
                        Size = Vector3.new(1, 1, 1),
                        Transparency = 1
                    }, true);
                end;

                CreateSound(u110.Core, 185702591, 4, 0.95, 0, 4.1);
                Tween(PrimaryPart.PointLight, 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
                    Range = 0
                }, true);
                Thread(function() -- Line: 784
                    -- upvalues: Wait (ref), u110 (copy)
                    Wait(4);
                    u110:Destroy();
                end);
            elseif v121:IsA("BasePart") then
                local u128 = CreateSound(u110.Core, 638861091, 10, 0.53, 0, 4);
                Thread(function() -- Line: 792
                    -- upvalues: Wait (ref), Tween (ref), u128 (copy)
                    Wait(3);
                    Tween(u128, 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
                        Volume = 0
                    }, true);
                end);
                local v129 = next;
                local v130, v131 = u110:GetChildren();

                for i, v in v129, v130, v131 do
                    Tween(v, 0.4 + i / 10, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
                        Size = Vector3.new(1, 1, 1),
                        Transparency = 1
                    }, true);
                end;

                Tween(PrimaryPart.PointLight, 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
                    Range = 0
                }, true);
                u99:FireAllClients("Mood", {
                    Type = "3D",
                    Duration = 2,
                    Pos = { new(v122) * Angles(0, 0, 0), new(v122) * Angles(0, 0, 0) },
                    Object = u98.RING,
                    objectProperties = {
                        Material = "Neon"
                    },
                    Transparency = { 0.4, 1 },
                    Size = { Vector3.new(0, 2, 0), (new2(u124 * 2.5, 1, u124 * 2.5)) },
                    Color = { u113[2], u113[2] },
                    tweenProperties = {
                        Direction = "InOut",
                        Style = "Quad"
                    },
                    Parent = Effects
                });
                u99:FireAllClients("Mood", {
                    Type = "3D",
                    Duration = 1.5,
                    Pos = { new(v122) * Angles(0, 0, 0), new(v122) * Angles(0, 3.141592653589793, 0) },
                    Object = u98.Wave,
                    objectProperties = {
                        Material = "Neon"
                    },
                    Transparency = { 0.2, 1 },
                    Size = { Vector3.new(0, 20, 0), (new2(u124, 8, u124)) },
                    Color = { u113[2], u113[2] },
                    tweenProperties = {
                        Direction = "InOut",
                        Style = "Quad"
                    },
                    Parent = Effects
                });
                u99:FireAllClients("Mood", {
                    Type = "3D",
                    Duration = 2.5,
                    Pos = { new(v122) * Angles(0, 0, 0), new(v122) * Angles(0, 3.141592653589793, 0) },
                    Object = u98.Sphere,
                    objectProperties = {
                        Material = "Neon"
                    },
                    Transparency = { 0.2, 1 },
                    Size = { Vector3.new(0, 0, 0), (new2(u124, u124, u124)) },
                    Color = { u113[2], u113[2] },
                    tweenProperties = {
                        Direction = "InOut",
                        Style = "Quad"
                    },
                    Parent = Effects
                });
                u99:FireAllClients("Mood", {
                    Type = "3D",
                    Duration = 2.8,
                    Pos = { new(v122) * Angles(0, 0, 0), new(v122) * Angles(0, 3.141592653589793, 0) },
                    Object = u98.Sphere,
                    objectProperties = {
                        Material = "Neon"
                    },
                    Transparency = { 0.6, 1 },
                    Size = { Vector3.new(0, 0, 0), (new2(u124 * 1.3, u124 * 1.3, u124 * 1.3)) },
                    Color = { u113[1], u113[1] },
                    tweenProperties = {
                        Direction = "InOut",
                        Style = "Quad"
                    },
                    Parent = Effects
                });
                CreateSound(PrimaryPart, 863810402, 10, 0.9, 0.5, 2);
                Thread(function() -- Line: 876
                    -- upvalues: Wait (ref), u100 (copy), u124 (copy), new2 (ref), PrimaryPart (copy), Value (copy), u95 (copy), u110 (copy)
                    Wait(0.2);
                    u100({
                        HitCFrame = nil,
                        BypassFF = false,
                        DamageType = "Kameha",
                        Stun = true,
                        StunTime = 4.5,
                        HitTime = 0.285,
                        Knockback = nil,
                        KnockbackTime = 0.05,
                        Size = new2(u124, u124, u124),
                        CFrame = PrimaryPart.CFrame,
                        Amount = 500 * Value,
                        WeldTo = PrimaryPart
                    }, u95);
                    Wait(4);
                    u110:Destroy();
                end);
            end;
        end;

        if p102 ~= true then
            u101:FireClient(u95, {
                Type = "Creation",
                Title = u103,
                Duration = u96[1](u96[2], u96[3]),
                Timestamp = tick()
            });
        end;

        Thread(function() -- Line: 924
            -- upvalues: u97 (copy), u95 (copy), u103 (copy), u96 (copy), u101 (copy)
            repeat
                game:GetService("RunService").Heartbeat:Wait();
            until tick() - u97[u95.Name].Abilities[u103] >= u96[1](u96[2], u96[3]);

            u101:FireClient(u95, {
                Type = "Cooldown",
                CooldownTable = "Moves",
                CooldownValue = false,
                CooldownName = u103
            });
        end);
    end,

    Heavy = function(u132, u133, u134, p135, p136, p137, u138, p139) -- Line: 936
        -- upvalues: Thread (copy)
        local u140 = u133[3];
        local u141 = u133[2];
        local v142 = u134[u132.Name].Abilities[u141];

        if v142 == nil then
            if p139 ~= true then
                tick();
                u134[u132.Name].Abilities[u141] = tick();
            end;
        elseif v142 ~= nil then
            if tick() - v142 < u133[1](u133[2], u133[3]) then
                return;
            end;

            u134[u132.Name].Abilities[u141] = tick();
        end;

        if p139 ~= true then
            u138:FireClient(u132, {
                Type = "Creation",
                Title = "Stun Punch",
                Duration = u133[1](u133[2], u133[3]),
                Timestamp = tick()
            });
        end;

        if p139 == true then
            u134[u132.Name].Abilities.Heavy = 0;
        end;

        local HumanoidRootPart = u132.Character.HumanoidRootPart;
        local Value = u132.Character.GokuAssets.DamageMultiplication.Value;
        p137({
            Size = Vector3.new(4, 4, 4),
            BypassFF = false,
            DamageType = "Strong",
            Stun = true,
            StunTime = 1.75,
            HitTime = 0.5,
            KnockbackTime = 0.1,
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2.5),
            Amount = math.random(9, 15) * Value,
            HitCFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2.5),
            Knockback = HumanoidRootPart.CFrame.lookVector * 5 + Vector3.new(0, 5, 0)
        }, u132);
        Thread(function() -- Line: 978
            -- upvalues: u140 (ref), u134 (copy), u132 (copy), u138 (copy), u133 (copy), u141 (copy)
            while true do
                game:GetService("RunService").Heartbeat:Wait();

                if u140 ~= u134[u132.Name].Form then
                    u138:FireClient(u132, {
                        Type = "Creation",
                        Title = "Stun Punch",
                        Duration = u133[1](u133[2], u134[u132.Name].Form) - (tick() - u134[u132.Name].Abilities[u141]),
                        Timestamp = tick()
                    });
                    u140 = u134[u132.Name].Form;
                end;

                if tick() - u134[u132.Name].Abilities[u141] >= u133[1](u133[2], u134[u132.Name].Form) then
                    u138:FireClient(u132, {
                        Type = "Cooldown",
                        CooldownTable = "Moves",
                        CooldownValue = false,
                        CooldownName = u141
                    });

                    return;
                end;
            end;
        end);
    end,

    InstantTransmission = function(u143, u144, u145, p146, p147, p148, u149, p150, p151) -- Line: 998
        -- upvalues: Wait (copy), Thread (copy)
        if not p150 then
            u149:FireClient(u143, {
                Type = "Cooldown",
                CooldownTable = "Moves",
                CooldownName = "IT",
                CooldownValue = false
            });

            return;
        end;

        local u152 = u144[3];
        local u153 = u144[2];
        local v154 = u145[u143.Name].Abilities[u153];

        if v154 == nil then
            if p151 ~= true then
                tick();
                u145[u143.Name].Abilities[u153] = tick();
            end;
        elseif v154 ~= nil then
            if tick() - v154 < u144[1](u144[2], u143.Character.GokuAssets.Form.Value) then
                return;
            end;

            u145[u143.Name].Abilities[u153] = tick();
        end;

        if p151 ~= true then
            u149:FireClient(u143, {
                Type = "Creation",
                Title = "Instant Transmission",
                Duration = u144[1](u144[2], u144[3]),
                Timestamp = tick()
            });
        end;

        if p151 == true then
            u145[u143.Name].Abilities.IT = 0;
        end;

        local HumanoidRootPart = u143.Character.HumanoidRootPart;

        for _ = 1, math.random(4, 7) do
            local v155 = HumanoidRootPart.CFrame * CFrame.new(math.random(-40, 40) / 10, math.random(-15, 8) / 10, math.random(-40, 40) / 10);
            p147:FireAllClients("Sphere", {
                Transparency = 0,
                Size = Vector3.new(0.21, 1.45, 0.33),
                Time = 0.4,
                CFrame = v155,
                Color = Color3.fromRGB(17, 17, 17),
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Cubic,
                Direction = Enum.EasingDirection.Out,
                Properties = {
                    Transparency = 1,
                    CFrame = v155 * CFrame.new(0, math.random(3, 7), 0)
                }
            });
        end;

        Wait(u144[1](u144[2], u144[3]) / 8.5);

        for _ = 1, math.random(4, 7) do
            local v156 = HumanoidRootPart.CFrame * CFrame.new(math.random(-40, 40) / 10, math.random(-15, 8) / 10, math.random(-40, 40) / 10);
            p147:FireAllClients("Sphere", {
                Transparency = 0,
                Size = Vector3.new(0.21, 1.45, 0.33),
                Time = 0.4,
                CFrame = v156,
                Color = Color3.fromRGB(17, 17, 17),
                Material = Enum.Material.Neon,
                Style = Enum.EasingStyle.Cubic,
                Direction = Enum.EasingDirection.Out,
                Properties = {
                    Transparency = 1,
                    CFrame = v156 * CFrame.new(0, math.random(3, 7), 0)
                }
            });
        end;

        for _ = 1, math.random(2, 5) do
            local v157 = HumanoidRootPart.CFrame * CFrame.new(math.random(-45, 45) / 10, math.random(-10, 7) / 10, math.random(-45, 45) / 10);
            p147:FireAllClients("Sphere", {
                Transparency = 0.51,
                Size = Vector3.new(0.25, 6, 0.25),
                CFrame = v157,
                Color = Color3.fromRGB(255, 255, 255),
                Time = math.random(4, 6) / 10,
                Material = Enum.Material.Glass,
                Style = Enum.EasingStyle.Quad,
                Direction = Enum.EasingDirection.InOut,
                Properties = {
                    Transparency = 1,
                    CFrame = v157 * CFrame.new(0, math.random(4, 7), 0)
                }
            });
        end;

        HumanoidRootPart.InstantTransmission:Play();

        if p151 == true then
            u149:FireClient(u143, {
                Type = "Cooldown",
                CooldownTable = "Moves",
                CooldownValue = false,
                CooldownName = u153
            });
        else
            Thread(function() -- Line: 1082
                -- upvalues: u152 (ref), u145 (copy), u143 (copy), u149 (copy), u144 (copy), u153 (copy)
                while true do
                    game:GetService("RunService").Heartbeat:Wait();

                    if u152 ~= u145[u143.Name].Form then
                        u149:FireClient(u143, {
                            Type = "Creation",
                            Title = "Instant Transmission",
                            Duration = u144[1](u144[2], u145[u143.Name].Form) - (tick() - u145[u143.Name].Abilities[u153]),
                            Timestamp = tick()
                        });
                        u152 = u145[u143.Name].Form;
                    end;

                    if tick() - u145[u143.Name].Abilities[u153] >= u144[1](u144[2], u145[u143.Name].Form) then
                        u149:FireClient(u143, {
                            Type = "Cooldown",
                            CooldownTable = "Moves",
                            CooldownValue = false,
                            CooldownName = u153
                        });

                        return;
                    end;
                end;
            end);
        end;
    end,

    Kamehameha = function(u158, u159, u160, u161, u162, u163, u164, p165, p166) -- Line: 1118
        -- upvalues: DivideColor (copy), Thread (copy), Wait (copy), new2 (copy), fromRGB (copy), new (copy), RNG (copy), Tween (copy)
        local u167 = u159[3];
        local u168 = u159[2];
        local v169 = u160[u158.Name].Abilities[u168];

        if v169 == nil then
            if p165 ~= true then
                tick();
                u160[u158.Name].Abilities[u168] = tick();
            end;
        elseif v169 ~= nil then
            if tick() - v169 < u159[1](u159[2], u158.Character.GokuAssets.Form.Value) then
                return;
            end;

            u160[u158.Name].Abilities[u168] = tick();
        end;

        local Value = u158.Character.GokuAssets.Form.Value;
        local Character = u158.Character;
        local v170 = Character:FindFirstChildOfClass("Humanoid");
        local HumanoidRootPart = Character.HumanoidRootPart;
        local Value2 = u158.Character.GokuAssets.DamageMultiplication.Value;
        local v171 = {
            WS = v170.WalkSpeed,
            JP = v170.JumpPower
        };
        v170.WalkSpeed = 0;
        v170.JumpPower = 0;
        Character.GokuAssets.KamehamehaFired.Value = false;
        local u172 = Value == "SSJ4" and 7.5 or 5;
        local u173 = Value == "SSJ4" and Value2 * 1.65 or Value2 / 2.5;
        local v174 = Color3.fromRGB(255, 255, 255);
        local v175 = Color3.fromRGB(21, 216, 255);

        if Value == "SSJ4" then
            v174 = Color3.fromRGB(255, 149, 151);
            v175 = Color3.fromRGB(255, 0, 4);
        end;

        local u176 = { v174, v175 };
        local Kamehameha = HumanoidRootPart.Kamehameha;

        if Character.GokuAssets.ChargingKamehameha.Value == true then
            u158:Kick(p166[math.random(1, #p166)] .. " [Kameha Spam]");
        end;

        Character.GokuAssets.ChargingKamehameha.Value = true;
        local u177 = u161.Core:Clone();
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.Transparency = 1;
        Part.Size = Vector3.new(1, 1, 1);
        Part.Parent = HumanoidRootPart;
        local Attachment = u177.Attachment;
        Attachment.ParticleEmitter.Color = ColorSequence.new(DivideColor(v175, 1.25));
        Attachment.Rays_Thick.Color = ColorSequence.new(v175);
        Attachment.Rays_Thin.Color = ColorSequence.new(v175);
        Attachment.Vortex.Color = ColorSequence.new(DivideColor(v175, 1.1));
        Attachment.Vortex2.Color = ColorSequence.new(DivideColor(v175, 0.9));
        Kamehameha:Play();
        u162:FireAllClients("Mood", {
            Type = "3D",
            Duration = 0.35,
            Pos = { HumanoidRootPart.CFrame * CFrame.new(1.5, -1.25, 1.25), HumanoidRootPart.CFrame * CFrame.new(1.5, -1.25, 1.25) },
            Object = u161.Sphere,
            objectProperties = {
                Material = "Neon"
            },
            Transparency = { 1, 0 },
            Size = { Vector3.new(8, 8, 8), Vector3.new(0, 0, 0) },
            Color = { v175, v174 },
            tweenProperties = {
                Direction = "InOut",
                Style = "Quad"
            },
            Parent = Character.Effects
        });
        HumanoidRootPart.KamehaCharge:Play();
        u177.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.5, -1.25, 1.25);
        u177.Parent = Character.Effects;
        Thread(function() -- Line: 1197
            -- upvalues: Wait (ref), u177 (copy), HumanoidRootPart (copy), u176 (copy), u162 (copy), Kamehameha (copy), u158 (copy)
            while true do
                Wait(0.1);
                u177.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.5, -1.25, 1.25);
                local v178, v179;

                if math.random(1, 2) == 1 then
                    v178 = u176[1];
                    v179 = u176[2];
                else
                    v178 = u176[2];
                    v179 = u176[1];
                end;

                u162:FireAllClients("Sphere", {
                    Transparency = 1,
                    Size = Vector3.new(0.5, 0.5, 0.5),
                    Time = 0.2,
                    CFrame = HumanoidRootPart.CFrame * CFrame.new(1.5, -1.2, 1.25) * CFrame.new(math.random(-25, 25) / 10, math.random(-25, 25) / 10, math.random(-25, 25) / 10),
                    Color = v178,
                    Material = Enum.Material.Neon,
                    Style = Enum.EasingStyle.Cubic,
                    Direction = Enum.EasingDirection.Out,
                    Properties = {
                        Transparency = 0,
                        CFrame = HumanoidRootPart.CFrame * CFrame.new(1.5, -1.2, 1.25),
                        Color = v179
                    }
                });
                u162:FireAllClients("Sphere", {
                    Transparency = 1,
                    Size = Vector3.new(0.5, 0.5, 0.5),
                    Time = 0.125,
                    TweenAgain = true,
                    Time2 = 0.04,
                    TimeBetween = 0,
                    CFrame = HumanoidRootPart.CFrame * CFrame.new(1.5, -1.25, 1.25),
                    Color = v178,
                    Material = Enum.Material.Neon,
                    Style = Enum.EasingStyle.Cubic,
                    Direction = Enum.EasingDirection.Out,
                    Properties = {
                        Size = Vector3.new(1.3, 1.3, 1.3),
                        Transparency = 0
                    },
                    Properties2 = {
                        Transparency = 1
                    }
                });
                u162:FireAllClients("Sphere", {
                    Transparency = 1,
                    Size = Vector3.new(0.6, 0.6, 0.6),
                    Time = 0.125,
                    TweenAgain = true,
                    Time2 = 0.04,
                    TimeBetween = 0,
                    CFrame = HumanoidRootPart.CFrame * CFrame.new(1.5, -1.25, 1.25),
                    Color = v179,
                    Material = Enum.Material.Neon,
                    Style = Enum.EasingStyle.Cubic,
                    Direction = Enum.EasingDirection.Out,
                    Properties = {
                        Size = Vector3.new(1.4, 1.4, 1.4),
                        Transparency = 0.5
                    },
                    Properties2 = {
                        Transparency = 1
                    }
                });

                if Kamehameha.TimePosition >= 1.1 or u158.Character.GokuAssets.KamehamehaFired.Value == true then
                    return;
                end;
            end;
        end);

        repeat
            Wait();
            u172 = u172 + 0.5;
        until Kamehameha.TimePosition >= 1.25 or u158.Character.GokuAssets.KamehamehaFired.Value == true;

        u158.Character.GokuAssets.KamehamehaFired.Value = true;
        HumanoidRootPart.KamehaCharge:Stop();
        Kamehameha.TimePosition = 1.35;
        local u180 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -(5 + u173)) * CFrame.Angles(1.5707963267948966, 0, 0);
        local u181 = Value == "Egg" and 1350 or u172 * 4 * (Value2 / 3.5);
        local v182 = next;
        local v183, v184 = u177.Attachment:GetChildren();

        for _, v in v182, v183, v184 do
            v.Enabled = false;
        end;

        Wait(0.15);
        u162:FireAllClients("Mood", {
            Type = "3D",
            Duration = 1,
            Pos = { u180, u180 },
            Object = u161.RING,
            objectProperties = {
                Material = "Neon"
            },
            Transparency = { 0, 1 },
            Size = { Vector3.new(0, 0, 0), (new2(10 + u173 * 1.5, 0.1, 10 + u173 * 1.5)) },
            Color = { fromRGB(255, 255, 255), fromRGB(255, 255, 255) },
            tweenProperties = {
                Direction = "InOut",
                Style = "Quad"
            },
            Parent = Character.Effects
        });
        Thread(function() -- Line: 1299
            -- upvalues: HumanoidRootPart (copy), u162 (copy), u161 (copy), new2 (ref), fromRGB (ref), Character (copy)
            local v185 = HumanoidRootPart.CFrame * CFrame.new(0, 0.25, -0.75) * CFrame.Angles(1.5707963267948966, 0, 0);
            local v186 = math.random(-70, 70) * math.random(-25, 25) / 10;
            math.rad(v186);

            for i = 1, 4 do
                u162:FireAllClients("Mood", {
                    Type = "3D",
                    Duration = i / 4 + 0.5,
                    Pos = { v185, v185 * CFrame.new(0, i / 2 * -10, 0) },
                    Object = u161.RING,
                    objectProperties = {
                        Material = "Neon"
                    },
                    Transparency = { 0, 1 },
                    Size = { Vector3.new(0, 0, 0), (new2(i * 1.5 + 15, 0.1, i * 1.5 + 15)) },
                    Color = { fromRGB(255, 255, 255), fromRGB(255, 255, 255) },
                    tweenProperties = {
                        Direction = "InOut",
                        Style = "Quad"
                    },
                    Parent = Character.Effects
                });
            end;
        end);
        Thread(function() -- Line: 1346
            -- upvalues: Value (copy), u180 (copy), u181 (ref), Wait (ref), u163 (copy), u173 (copy), Value2 (copy), u172 (ref), Character (copy), Part (copy), u158 (copy)
            if Value == "SSJ4" then
                local v187 = u180 * CFrame.new(0, -(u181 / 2 - 5), 0);
                Wait(0.15);
                local v188 = 1;

                repeat
                    Wait(0.15);
                    u163({
                        HitCFrame = nil,
                        BypassFF = false,
                        DamageType = "Kameha",
                        Stun = true,
                        StunTime = 0.5,
                        HitTime = 0.06,
                        KnockbackTime = 0.01,
                        Size = Vector3.new(3.5 + u173, u181 + 10, 3.5 + u173),
                        CFrame = v187,
                        Amount = (math.random(4, 8) * Value2 / 2 + u172 / 10) * 1.35,
                        Knockback = Character.HumanoidRootPart.CFrame.lookVector * (2.5 * Value2),
                        WeldTo = Part
                    }, u158);
                    v188 = v188 + 1;
                until v188 > 11;
            else
                local v189 = u180 * CFrame.new(0, -(u181 / 2 - 3), 0);
                Wait(0.15);
                local v190 = 1;

                repeat
                    Wait(0.2);
                    u163({
                        HitCFrame = nil,
                        BypassFF = false,
                        DamageType = "Kameha",
                        Stun = true,
                        StunTime = 0.5,
                        HitTime = 0.06,
                        KnockbackTime = 0.01,
                        Size = Vector3.new(3.5 + u173, u181 + 8, 3.5 + u173),
                        CFrame = v189,
                        Amount = (math.random(4, 8) * Value2 / 2 + u172 / 10) * 1.5,
                        Knockback = Character.HumanoidRootPart.CFrame.lookVector * (2.5 * Value2),
                        WeldTo = Part
                    }, u158);
                    v190 = v190 + 1;
                until v190 > 9;
            end;
        end);
        local u191 = HumanoidRootPart.CFrame * CFrame.new(0, 0.25, -0.75) * CFrame.Angles(1.5707963267948966, 0, 0);
        Thread(function() -- Line: 1393
            -- upvalues: Wait (ref), u176 (copy), u191 (copy), new (ref), RNG (ref), u162 (copy), u181 (ref), u161 (copy), Character (copy)
            local v192 = 1;

            repeat
                Wait(0.05);
                v192 = v192 + 1;
                local v193 = math.random(1, 2);
                local v194 = v193 == 1 and u176[1] or u176[2];
                local v195 = v193 == 1 and u176[2] or u176[1];
                local v196 = u191 * new(RNG(-5, 5, true), 0, RNG(-5, 5, true));
                u162:FireAllClients("Mood", {
                    Type = "3D",
                    Duration = RNG(0.3, 0.8, true),
                    Pos = { v196, v196 * new(0, -u181, 0) },
                    Object = u161.Sphere,
                    objectProperties = {
                        Material = "Neon"
                    },
                    Transparency = { 0, 1 },
                    Size = { Vector3.new(0.3, 3.5, 0.3), Vector3.new(0.05, 5, 0.05) },
                    Color = { v194, v195 },
                    tweenProperties = {
                        Direction = "InOut",
                        Style = "Quad"
                    },
                    Parent = Character.Effects
                });
            until v192 > 40;
        end);
        Thread(function() -- Line: 1420
            -- upvalues: Wait (ref), u176 (copy), u162 (copy), u180 (copy)
            Wait(2.8);
            local v197 = 1;

            while true do
                Wait(0.05);
                local v198, v199;

                if math.random(1, 2) == 1 then
                    v198 = u176[1];
                    v199 = u176[2];
                else
                    v198 = u176[2];
                    v199 = u176[1];
                end;

                v197 = v197 + 1;
                u162:FireAllClients("Sphere", {
                    Transparency = 1,
                    Size = Vector3.new(0, 0, 0),
                    Time = 0.2,
                    TweenAgain = true,
                    Time2 = 0.175,
                    TimeBetween = 0,
                    CFrame = u180 * CFrame.new(0, 0.25, 0),
                    Color = v198,
                    Material = Enum.Material.Neon,
                    Style = Enum.EasingStyle.Sine,
                    Direction = Enum.EasingDirection.InOut,
                    Properties = {
                        Size = Vector3.new(0.5, 0.5, 0.5),
                        Transparency = 0.45,
                        CFrame = u180 * CFrame.new(0, 0.25, 0) * CFrame.new(math.random(-40, 40) / 10, math.random(-40, 40) / 10, math.random(-40, 40) / 10),
                        Color = v199
                    },
                    Properties2 = {
                        Size = Vector3.new(0.2, 0.2, 0.2),
                        Transparency = 1,
                        Color = v199
                    }
                });

                if v197 > 20 then
                    return;
                end;
            end;
        end);
        u162:FireAllClients("Sphere", {
            Transparency = 0.5,
            Size = Vector3.new(0.5, 0.5, 0.5),
            Time = 0.125,
            TweenAgain = true,
            Time2 = 2,
            TimeBetween = 3,
            CFrame = u180 * CFrame.new(0, 0.25, 0),
            Color = v174,
            Material = Enum.Material.Neon,
            Style = Enum.EasingStyle.Cubic,
            Direction = Enum.EasingDirection.Out,
            Properties = {
                Transparency = 0,
                Size = Vector3.new(4 + u173 * 1.5, 4 + u173 * 1.5, 4 + u173 * 1.5)
            },
            Properties2 = {
                Size = Vector3.new(0.5, 0.5, 0.5),
                Transparency = 1,
                Color = v175
            }
        });
        u162:FireAllClients("Sphere", {
            Transparency = 1,
            Size = Vector3.new(0.5, 0.5, 0.5),
            Time = 0.125,
            TweenAgain = true,
            Time2 = 2,
            TimeBetween = 3,
            CFrame = u180 * CFrame.new(0, 0.25, 0),
            Color = v175,
            Material = Enum.Material.Neon,
            Style = Enum.EasingStyle.Cubic,
            Direction = Enum.EasingDirection.Out,
            Properties = {
                Transparency = 0.5,
                Size = Vector3.new(5 + u173 * 1.5, 5 + u173 * 1.5, 5 + u173 * 1.5)
            },
            Properties2 = {
                Size = Vector3.new(1, 1, 1),
                Transparency = 1,
                Color = v174
            }
        });
        u162:FireAllClients("Cylinder", {
            Transparency = 0,
            Size = Vector3.new(2, 2, 2),
            Time = 1.5,
            TweenAgain = true,
            Time2 = 1,
            TimeBetween = 1.5,
            CFrame = u180,
            Color = v174,
            Material = Enum.Material.Neon,
            Style = Enum.EasingStyle.Sine,
            Direction = Enum.EasingDirection.Out,
            Properties = {
                CFrame = u180 * CFrame.new(0, -u181 / 2, 0),
                Size = Vector3.new(3 + u173, u181, 3 + u173)
            },
            Properties2 = {
                Transparency = 1,
                Size = Vector3.new(0.4, u181, 0.4),
                Color = v175
            }
        });
        u162:FireAllClients("Cylinder", {
            Transparency = 0.5,
            Size = Vector3.new(2, 2, 2),
            Time = 1.5,
            TweenAgain = true,
            Time2 = 1,
            TimeBetween = 1.5,
            CFrame = u180,
            Color = v175,
            Material = Enum.Material.Neon,
            Style = Enum.EasingStyle.Sine,
            Direction = Enum.EasingDirection.Out,
            Properties = {
                CFrame = u180 * CFrame.new(0, -u181 / 2, 0),
                Size = Vector3.new(4 + u173, u181, 4 + u173)
            },
            Properties2 = {
                Transparency = 1,
                Size = Vector3.new(0.7, u181, 0.7),
                Color = v174
            }
        });

        if table.find({ "Base", "SSJ", "SSJ2", "SSJ3", "SSJ4" }, Character.GokuAssets.Form.Value) then
            HumanoidRootPart.KamehaFire:Play();
        else
            HumanoidRootPart.KamehaFireALT.Volume = 4;
            HumanoidRootPart.KamehaFireALT:Play();
            Thread(function() -- Line: 1560
                -- upvalues: Wait (ref), Tween (ref), HumanoidRootPart (copy)
                Wait(2.5);
                Tween(HumanoidRootPart.KamehaFireALT, 3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, {
                    Volume = 0
                });
            end);
        end;

        u162:FireAllClients("TransformShake");
        Wait(5);
        Part:Destroy();
        u177:Destroy();
        pcall(function() -- Line: 1573
            -- upvalues: Character (copy), Wait (ref), u158 (copy)
            Character.GokuAssets.ChargingKamehameha.Value = false;
            Wait();
            u158.Character.GokuAssets.KamehamehaFired.Value = false;
        end);
        Kamehameha.TimePosition = 0;
        u164:FireClient(u158, {
            Type = "KamehamehaFinish"
        });
        v170.WalkSpeed = v171.WS;
        v170.JumpPower = v171.JP;

        if p165 ~= true then
            u164:FireClient(u158, {
                Type = "Creation",
                Title = u168,
                Duration = u159[1](u159[2], u159[3]),
                Timestamp = tick()
            });
            u160[u158.Name].Abilities.KaMeHa = tick();
        end;

        if p165 == true then
            u160[u158.Name].Abilities.KaMeHa = 0;
            u164:FireClient(u158, {
                Type = "Cooldown",
                CooldownTable = "Moves",
                CooldownValue = false,
                CooldownName = u168
            });
        end;

        if p165 ~= true then
            Thread(function() -- Line: 1601
                -- upvalues: u167 (ref), u160 (copy), u158 (copy), u164 (copy), u159 (copy), u168 (copy)
                while true do
                    game:GetService("RunService").Heartbeat:Wait();

                    if u167 ~= u160[u158.Name].Form then
                        u164:FireClient(u158, {
                            Type = "Creation",
                            Title = "Kamehameha",
                            Duration = u159[1](u159[2], u160[u158.Name].Form) - (tick() - u160[u158.Name].Abilities[u168]),
                            Timestamp = tick()
                        });
                        u167 = u160[u158.Name].Form;
                    end;

                    if tick() - u160[u158.Name].Abilities[u168] >= u159[1](u159[2], u160[u158.Name].Form) then
                        u164:FireClient(u158, {
                            Type = "Cooldown",
                            CooldownTable = "Moves",
                            CooldownValue = false,
                            CooldownName = u168
                        });

                        return;
                    end;
                end;
            end);
        end;
    end,

    Kick = function(u200, u201, u202, p203, p204, p205, u206, p207) -- Line: 1622
        -- upvalues: Thread (copy)
        local u208 = u201[3];
        local u209 = u201[2];
        local v210 = u202[u200.Name].Abilities[u209];

        if v210 == nil then
            if p207 ~= true then
                tick();
                u202[u200.Name].Abilities[u209] = tick();
            end;
        elseif v210 ~= nil then
            if tick() - v210 < u201[1](u201[2], u200.Character.GokuAssets.Form.Value) then
                return;
            end;

            u202[u200.Name].Abilities[u209] = tick();
        end;

        if p207 ~= true then
            u206:FireClient(u200, {
                Type = "Creation",
                Title = "Knockback Kick",
                Duration = u201[1](u201[2], u201[3]),
                Timestamp = tick()
            });
        end;

        if p207 == true then
            u202[u200.Name].Abilities.Kick = 0;
        end;

        local Character = u200.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local Value = u200.Character.GokuAssets.DamageMultiplication.Value;
        p205({
            Size = Vector3.new(4, 4, 4),
            BypassFF = false,
            DamageType = "Knock",
            Stun = true,
            StunTime = 1,
            HitTime = 0.5,
            KnockbackTime = 0.035,
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2.5),
            Amount = math.random(9, 15) * Value,
            HitCFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2.5),
            Knockback = Character.HumanoidRootPart.CFrame.lookVector * (150 * Value / 10) + Vector3.new(0, 15 * Value / 10, 0)
        }, u200);
        Thread(function() -- Line: 1666
            -- upvalues: u208 (ref), u202 (copy), u200 (copy), u206 (copy), u201 (copy), u209 (copy)
            while true do
                game:GetService("RunService").Heartbeat:Wait();

                if u208 ~= u202[u200.Name].Form then
                    u206:FireClient(u200, {
                        Type = "Creation",
                        Title = "Knockback Kick",
                        Duration = u201[1](u201[2], u202[u200.Name].Form) - (tick() - u202[u200.Name].Abilities[u209]),
                        Timestamp = tick()
                    });
                    u208 = u202[u200.Name].Form;
                end;

                if tick() - u202[u200.Name].Abilities[u209] >= u201[1](u201[2], u202[u200.Name].Form) then
                    u206:FireClient(u200, {
                        Type = "Cooldown",
                        CooldownTable = "Moves",
                        CooldownValue = false,
                        CooldownName = u209
                    });

                    return;
                end;
            end;
        end);
    end,

    Meteor = function(u211, u212, u213, p214, p215, u216, u217, p218) -- Line: 1687
        -- upvalues: Wait (copy), Thread (copy), Tween (copy)
        local u219 = u212[3];
        local u220 = u212[2];
        local v221 = u213[u211.Name].Abilities[u220];

        if v221 == nil then
            if p218 ~= true then
                tick();
                u213[u211.Name].Abilities[u220] = tick();
            end;
        elseif v221 ~= nil then
            if tick() - v221 < u212[1](u212[2], u211.Character.GokuAssets.Form.Value) then
                return;
            end;

            u213[u211.Name].Abilities[u220] = tick();
        end;

        if p218 ~= true then
            u217:FireClient(u211, {
                Type = "Creation",
                Title = "Meteor Strike",
                Duration = u212[1](u212[2], u212[3]),
                Timestamp = tick()
            });
        end;

        if p218 == true then
            u213[u211.Name].Abilities.Meteor = 0;
        end;

        local Character = u211.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local v222 = Character:FindFirstChildOfClass("Humanoid");
        local Value = u211.Character.GokuAssets.DamageMultiplication.Value;
        local v223 = u216({
            Size = Vector3.new(5.5, 5.5, 5.5),
            Amount = 0,
            HitCFrame = nil,
            BypassFF = false,
            DamageType = "nil",
            Stun = false,
            StunTime = nil,
            HitTime = 0.2,
            Knockback = nil,
            KnockbackTime = nil,
            ReturnTargets = true,
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2.75)
        }, u211);

        if #v223 > 0 then
            u217:FireClient(u211, {
                Type = "Meteor",
                Bool = true
            });

            local function _(p224, p225) -- Line: 1737
                -- upvalues: HumanoidRootPart (copy)
                if p225.Parent and p225.Parent:FindFirstChild("HumanoidRootPart") then
                    p225.Parent.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -5);
                end;
            end;

            for _, v in pairs(v223) do
                if v.Parent and v.Parent:FindFirstChild("HumanoidRootPart") then
                    v.Parent.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -5);
                end;
            end;

            local u226 = {};
            local v227 = false;

            for i = 1, 3 do
                HumanoidRootPart.Anchored = true;

                local function v230(p228, p229) -- Line: 1747
                    -- upvalues: u226 (copy)
                    if not (p229 and p229.Parent or table.find(u226, "Egg" .. #u226)) then
                        table.insert(u226, "Egg" .. #u226);
                    end;

                    if p229.Parent and p229.Parent:FindFirstChild("HumanoidRootPart") then
                        p229.Parent.HumanoidRootPart.Anchored = true;
                        p229.Parent.HumanoidRootPart.CFrame = p229.Parent.HumanoidRootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0);

                        if p229.Health == 0 and not table.find(u226, p229) then
                            table.insert(u226, p229);
                        end;
                    end;
                end;

                for i2, v in pairs(v223) do
                    v230(i2, v);
                end;

                if v222:FindFirstChild("Stunned") then
                    for _ = 1, #v223 do
                        table.insert(u226, "Egg");
                    end;
                end;

                if #u226 >= #v223 or (v222.Parent == nil or (v222:FindFirstChild("Stunned") or v222.Health == 0)) then
                    v227 = true;

                    if v222.Parent and (v222:FindFirstChild("Stunned") or v222.Health == 0) then
                        for _, v in next, v223 do
                            if v.Parent and v.Parent:FindFirstChild("HumanoidRootPart") then
                                v.Parent:FindFirstChild("HumanoidRootPart").Anchored = false;
                            end;
                        end;
                    elseif not v222.Parent then
                        for _, v in next, v223 do
                            if v.Parent and v.Parent:FindFirstChild("HumanoidRootPart") then
                                v.Parent:FindFirstChild("HumanoidRootPart").Anchored = false;
                            end;
                        end;
                    end;

                    break;
                end;

                u217:FireClient(u211, {
                    Type = "MeteorStrike",
                    Action = "Animation"
                });
                pcall(function() -- Line: 1789
                    -- upvalues: u216 (copy), HumanoidRootPart (copy), Value (copy), u211 (copy)
                    u216({
                        Size = Vector3.new(5, 5, 5),
                        BypassFF = false,
                        DamageType = "Knock",
                        Stun = true,
                        StunTime = 3,
                        HitTime = 0.2,
                        Knockback = nil,
                        KnockbackTime = 0,
                        CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -3),
                        Amount = math.random(11, 15) * Value,
                        HitCFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                    }, u211);
                end);
                Wait(0.3);

                local function _(p231, u232) -- Line: 1805
                    -- upvalues: Thread (ref), HumanoidRootPart (copy), Tween (ref)
                    if u232.Parent and u232.Parent:FindFirstChild("HumanoidRootPart") then
                        Thread(function() -- Line: 1807
                            -- upvalues: HumanoidRootPart (ref), Tween (ref), u232 (copy)
                            local v233 = HumanoidRootPart.CFrame * CFrame.new(0, 15, -35) * CFrame.Angles(0, 3.141592653589793, 0);
                            Tween(u232.Parent.HumanoidRootPart, 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
                                CFrame = v233
                            });
                        end);
                    end;
                end;

                for _, v in pairs(v223) do
                    if v.Parent and v.Parent:FindFirstChild("HumanoidRootPart") then
                        Thread(function() -- Line: 1807
                            -- upvalues: HumanoidRootPart (copy), Tween (ref), v (copy)
                            local v234 = HumanoidRootPart.CFrame * CFrame.new(0, 15, -35) * CFrame.Angles(0, 3.141592653589793, 0);
                            Tween(v.Parent.HumanoidRootPart, 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
                                CFrame = v234
                            });
                        end);
                    end;
                end;

                Wait(0.205);

                for _ = 1, math.random(4, 7) do
                    local v235 = HumanoidRootPart.CFrame * CFrame.new(math.random(-40, 40) / 10, math.random(-15, 8) / 10, math.random(-40, 40) / 10);
                    p215:FireAllClients("Sphere", {
                        Transparency = 0,
                        Size = Vector3.new(0.21, 1.45, 0.33),
                        Time = 0.4,
                        CFrame = v235,
                        Color = Color3.fromRGB(17, 17, 17),
                        Material = Enum.Material.Neon,
                        Style = Enum.EasingStyle.Cubic,
                        Direction = Enum.EasingDirection.Out,
                        Properties = {
                            Transparency = 1,
                            CFrame = v235 * CFrame.new(0, math.random(3, 7), 0)
                        }
                    });
                end;

                if i ~= 3 then
                    for _, v in next, v223 do
                        if v.Parent and v.Parent:FindFirstChild("HumanoidRootPart") then
                            Character:SetPrimaryPartCFrame(v.Parent.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4) * CFrame.Angles(0, 0, 0));
                        end;
                    end;

                    u217:FireClient(u211, {
                        Type = "MeteorStrike",
                        Action = "Sound"
                    });
                end;

                Wait();

                for _ = 1, math.random(4, 7) do
                    local v236 = HumanoidRootPart.CFrame * CFrame.new(math.random(-40, 40) / 10, math.random(-15, 8) / 10, math.random(-40, 40) / 10);
                    p215:FireAllClients("Sphere", {
                        Transparency = 0,
                        Size = Vector3.new(0.21, 1.45, 0.33),
                        Time = 0.4,
                        CFrame = v236,
                        Color = Color3.fromRGB(17, 17, 17),
                        Material = Enum.Material.Neon,
                        Style = Enum.EasingStyle.Cubic,
                        Direction = Enum.EasingDirection.Out,
                        Properties = {
                            Transparency = 1,
                            CFrame = v236 * CFrame.new(0, math.random(3, 7), 0)
                        }
                    });
                end;

                for _ = 1, math.random(2, 5) do
                    local v237 = HumanoidRootPart.CFrame * CFrame.new(math.random(-45, 45) / 10, math.random(-10, 7) / 10, math.random(-45, 45) / 10);
                    p215:FireAllClients("Sphere", {
                        Transparency = 0.51,
                        Size = Vector3.new(0.25, 6, 0.25),
                        CFrame = v237,
                        Color = Color3.fromRGB(255, 255, 255),
                        Time = math.random(4, 6) / 10,
                        Material = Enum.Material.Glass,
                        Style = Enum.EasingStyle.Quad,
                        Direction = Enum.EasingDirection.InOut,
                        Properties = {
                            Transparency = 1,
                            CFrame = v237 * CFrame.new(0, math.random(4, 7), 0)
                        }
                    });
                end;

                if v222:FindFirstChild("Stunned") then
                    for _ = 1, #v223 do
                        table.insert(u226, "Egg");
                    end;
                end;

                if #u226 >= #v223 or (v222.Parent == nil or (v222:FindFirstChild("Stunned") or v222.Health == 0)) then
                    v227 = true;

                    if v222.Parent and (v222:FindFirstChild("Stunned") or v222.Health == 0) then
                        for _, v in next, v223 do
                            if v.Parent and v.Parent:FindFirstChild("HumanoidRootPart") then
                                v.Parent:FindFirstChild("HumanoidRootPart").Anchored = false;
                            end;
                        end;
                    elseif not v222.Parent then
                        for _, v in next, v223 do
                            if v.Parent and v.Parent:FindFirstChild("HumanoidRootPart") then
                                v.Parent:FindFirstChild("HumanoidRootPart").Anchored = false;
                            end;
                        end;
                    end;

                    break;
                end;
            end;

            local function v240(p238, p239) -- Line: 1900
                -- upvalues: u226 (copy)
                if not (p239 and p239.Parent or table.find(u226, "Egg" .. #u226)) then
                    table.insert(u226, "Egg" .. #u226);
                end;

                if p239.Parent and p239.Parent:FindFirstChild("HumanoidRootPart") then
                    p239.Parent.HumanoidRootPart.Anchored = true;
                    p239.Parent.HumanoidRootPart.CFrame = p239.Parent.HumanoidRootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0);

                    if p239.Health == 0 and not table.find(u226, p239) then
                        table.insert(u226, p239);
                    end;
                end;
            end;

            for i, v in pairs(v223) do
                v240(i, v);
            end;

            if #u226 >= #v223 or (v222.Parent == nil or (v222:FindFirstChild("Stunned") or v222.Health == 0)) then
                v227 = true;

                if v222.Parent and (v222:FindFirstChild("Stunned") or v222.Health == 0) then
                    for _, v in next, v223 do
                        if v.Parent and v.Parent:FindFirstChild("HumanoidRootPart") then
                            v.Parent:FindFirstChild("HumanoidRootPart").Anchored = false;
                        end;
                    end;
                elseif not v222.Parent then
                    for _, v in next, v223 do
                        if v.Parent and v.Parent:FindFirstChild("HumanoidRootPart") then
                            v.Parent:FindFirstChild("HumanoidRootPart").Anchored = false;
                        end;
                    end;
                end;
            end;

            if v227 == false then
                local function v243(p241, p242) -- Line: 1933
                    -- upvalues: Character (copy)
                    if p242.Parent and p242.Parent:FindFirstChild("HumanoidRootPart") then
                        Character:SetPrimaryPartCFrame(p242.Parent.HumanoidRootPart.CFrame * CFrame.new(0, 5.5, 3) * CFrame.Angles(0, 0, 0));
                    end;
                end;

                for i, v in pairs(v223) do
                    v243(i, v);
                end;

                u217:FireClient(u211, {
                    Type = "MeteorStrike",
                    Action = "Sound"
                });
                Wait(0.05);
                u217:FireClient(u211, {
                    Type = "MeteorStrike",
                    Action = "Animation2"
                });

                local function _(p244, p245) -- Line: 1947
                    if p245.Parent and p245.Parent:FindFirstChild("HumanoidRootPart") then
                        p245.Parent.HumanoidRootPart.Anchored = false;
                    end;
                end;

                for _, v in pairs(v223) do
                    if v.Parent and v.Parent:FindFirstChild("HumanoidRootPart") then
                        v.Parent.HumanoidRootPart.Anchored = false;
                    end;
                end;

                Wait(0.05);
                HumanoidRootPart.Strong5:Play();
                u216({
                    Size = Vector3.new(6, 6, 6),
                    BypassFF = false,
                    DamageType = "Knock",
                    Stun = true,
                    StunTime = 3,
                    HitTime = 0.2,
                    Knockback = Vector3.new(0, -65, 0),
                    KnockbackTime = 0.05,
                    CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0),
                    Amount = math.random(20, 25) * Value,
                    HitCFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0)
                }, u211);
            end;

            Wait(0.25);
            HumanoidRootPart.Anchored = false;
        end;

        u217:FireClient(u211, {
            Type = "Meteor",
            Bool = false
        });
        Thread(function() -- Line: 1975
            -- upvalues: u219 (ref), u213 (copy), u211 (copy), u217 (copy), u212 (copy), u220 (copy)
            while true do
                game:GetService("RunService").Heartbeat:Wait();

                if u219 ~= u213[u211.Name].Form then
                    u217:FireClient(u211, {
                        Type = "Creation",
                        Title = "Meteor Strike",
                        Duration = u212[1](u212[2], u213[u211.Name].Form) - (tick() - u213[u211.Name].Abilities[u220]),
                        Timestamp = tick()
                    });
                    u219 = u213[u211.Name].Form;
                end;

                if tick() - u213[u211.Name].Abilities[u220] >= u212[1](u212[2], u213[u211.Name].Form) then
                    u217:FireClient(u211, {
                        Type = "Cooldown",
                        CooldownTable = "Moves",
                        CooldownValue = false,
                        CooldownName = u220
                    });

                    return;
                end;
            end;
        end);
    end,

    Punch = function(u246, u247, u248, p249, p250, p251, u252, p253) -- Line: 1995
        -- upvalues: Thread (copy)
        local u254 = u247[3];
        local u255 = u247[2];
        local v256 = u248[u246.Name].Abilities[u255];

        if v256 == nil then
            if p253 ~= true then
                tick();
                u248[u246.Name].Abilities[u255] = tick();
            end;
        elseif v256 ~= nil then
            if tick() - v256 < u247[1](u247[2], u247[3]) then
                return;
            end;

            u248[u246.Name].Abilities[u255] = tick();
        end;

        if p253 ~= true then
            u252:FireClient(u246, {
                Type = "Creation",
                Title = "Normal Punch",
                Duration = u247[1](u247[2], u247[3]),
                Timestamp = os.time()
            });
        end;

        if p253 == true then
            u248[u246.Name].Abilities.Punch = 0;
        end;

        local HumanoidRootPart = u246.Character.HumanoidRootPart;
        local Value = u246.Character.GokuAssets.DamageMultiplication.Value;
        p251({
            Size = Vector3.new(4, 4, 4),
            BypassFF = false,
            DamageType = "Default",
            Stun = false,
            StunTime = 0,
            HitTime = 0.2,
            Knockback = nil,
            KnockbackTime = 0.05,
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2.5),
            Amount = math.random(4, 8) * Value,
            HitCFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2.5)
        }, u246);
        Thread(function() -- Line: 2039
            -- upvalues: u254 (ref), u248 (copy), u246 (copy), u252 (copy), u247 (copy), u255 (copy)
            while true do
                game:GetService("RunService").Heartbeat:Wait();

                if u254 ~= u248[u246.Name].Form then
                    u252:FireClient(u246, {
                        Type = "Creation",
                        Title = "Punch",
                        Duration = u247[1](u247[2], u248[u246.Name].Form) - (tick() - u248[u246.Name].Abilities[u255]),
                        Timestamp = tick()
                    });
                    u254 = u248[u246.Name].Form;
                end;

                if tick() - u248[u246.Name].Abilities[u255] >= u247[1](u247[2], u248[u246.Name].Form) then
                    u252:FireClient(u246, {
                        Type = "Cooldown",
                        CooldownTable = "Moves",
                        CooldownValue = false,
                        CooldownName = u255
                    });

                    return;
                end;
            end;
        end);
    end
};