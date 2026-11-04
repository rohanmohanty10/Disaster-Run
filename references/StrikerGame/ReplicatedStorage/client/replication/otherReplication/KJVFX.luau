 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
require(ReplicatedStorage.util.UwUEffects);
local trove = require(ReplicatedStorage.forum.trove);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
require(ReplicatedStorage.client.replication.BezierCurve);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.util.animationUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
require(ReplicatedStorage.util.Util);
require(ReplicatedStorage.VfxHandler);
require(ReplicatedStorage.wiki.styles);
require(ReplicatedStorage.util.animationUtil);
local LocalPlayer = Players.LocalPlayer;
local BackgroundHighlight = require(script.Parent.Parent.BackgroundHighlight);

function mainreplication.characterImage(p1) -- Line: 34
    -- upvalues: BackgroundHighlight (copy)
    BackgroundHighlight(p1);
end;

local ClockTime = Lighting.ClockTime;

return {
    KJPassing = function(u2) -- Line: 44, Name: KJPassing
        -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), SoundService (copy), RunService (copy), LocalPlayer (copy), mainreplication (copy), Lighting (copy), TekrinnDialogue (copy), TweenService (copy)
        local KJ = vfxUtil.getResources():WaitForChild("KJ");
        local u3 = trove.new();
        u3:AttachToInstance(u2);
        local v4 = KJ["Just Passing By"];
        local Root = vfxUtil.getRoot(u2);
        soundUtil:play(v4.Sound, SoundService);
        local u5 = u3:Add(v4.VFX:Clone());
        u5.Parent = workspace.Effects;
        u5.Core.CFrame = Root.CFrame;
        u3:Add(RunService.PreRender:Connect(function() -- Line: 58
            -- upvalues: Root (copy), u5 (copy)
            if Root and u5 then
                local CFrame_new_ret = CFrame.new(Root.Position, Root.Position + Vector3.new(Root.CFrame.LookVector.X, 0, Root.CFrame.LookVector.Z));
                u5.Core.CFrame = CFrame_new_ret;
            end;
        end));
        local u6 = u3:Add(v4.Vignette:Clone());
        u6.Parent = LocalPlayer.PlayerGui;
        mainreplication.sceneEnabled(true);
        local u7 = {};
        local u8 = {};

        for _, child in Lighting:GetChildren() do
            if child:IsA("Atmosphere") or (child:IsA("Sky") or (child:IsA("BloomEffect") or (child:IsA("BlurEffect") or (child:IsA("ColorCorrectionEffect") or (child:IsA("DepthOfFieldEffect") or child:IsA("SunRaysEffect")))))) then
                table.insert(u7, child);
                child.Parent = workspace;
            end;
        end;

        for _, child in v4.Lighting:GetChildren() do
            local v9 = child:Clone();
            v9.Parent = Lighting;
            u8[v9.ClassName] = v9;
        end;

        local u10 = {};
        u3:Add(function() -- Line: 89
            -- upvalues: mainreplication (ref), u10 (copy), u5 (copy), u7 (copy), Lighting (ref), u8 (copy)
            mainreplication.sceneEnabled(false);

            for _, v in u10 do
                pcall(game.Destroy, v);
            end;

            pcall(game.Destroy, u5);

            for _, v in u7 do
                pcall(function() -- Line: 96
                    -- upvalues: v (copy), Lighting (ref)
                    v.Parent = Lighting;
                end);
            end;

            for _, v in u8 do
                pcall(game.Destroy, v);
            end;
        end);

        if u2:FindFirstChild("Right Leg") then
            for _, child in v4.leg:GetChildren() do
                local v11 = u3:Add(child:Clone());
                v11.Parent = u2:FindFirstChild("Right Leg");
                table.insert(u10, v11);
            end;
        end;

        mainreplication.cutsceneBlender(Root, v4.Camera, v4.FOV, nil, nil, CFrame.new(0, -3, 0));
        u3:Add(task.delay(3.11, function() -- Line: 116
            -- upvalues: vfxUtil (ref), u2 (copy)
            vfxUtil.forge.emit(u2:FindFirstChild("Right Leg"));
        end));
        u3:Add(task.delay(4.08, function() -- Line: 121
            -- upvalues: vfxUtil (ref), u5 (copy)
            vfxUtil.forge.emit(u5.FirstStep, u5.stepaura);
        end));
        u3:Add(task.delay(11, function() -- Line: 129
            -- upvalues: vfxUtil (ref), u5 (copy)
            vfxUtil.forge.emit(u5.kjspeedlines);
        end));
        u3:Add(task.delay(11.11, function() -- Line: 136
            -- upvalues: vfxUtil (ref), u5 (copy)
            vfxUtil.forge.emit(u5.kjspeedlines);
        end));
        u3:Add(task.delay(11.15, function() -- Line: 143
            -- upvalues: vfxUtil (ref), u5 (copy)
            vfxUtil.forge.emit(u5.kjspeedlines);
        end));
        u3:Add(task.delay(11.29, function() -- Line: 150
            -- upvalues: vfxUtil (ref), u5 (copy)
            vfxUtil.forge.emit(u5.heatline);
        end));
        u3:Add(task.delay(11.22, function() -- Line: 156
            -- upvalues: mainreplication (ref), u2 (copy)
            mainreplication.characterImage({
                Speed = 0.8,
                Brightness = 1,
                countSpeed = 0.01,
                Count = 75,
                Whitelist = { u2 },
                Color = Color3.fromRGB(255, 255, 255),
                Color2 = Color3.fromRGB(255, 255, 255)
            });
        end));
        u3:Add(task.delay(12, function() -- Line: 168
            -- upvalues: u5 (copy)
            for _, descendant in pairs(u5.heatline:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Clear();
                end;
            end;
        end));
        u3:Add(task.delay(12.07, function() -- Line: 178
            -- upvalues: vfxUtil (ref), u5 (copy)
            vfxUtil.forge.emit(u5.heatline, u5.windblitz);
        end));
        u3:Add(task.delay(2.07341, function() -- Line: 186
            -- upvalues: TekrinnDialogue (ref), u2 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Text = "*sigh*",
                    Italic = true,
                    Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            }, 3, nil, nil, true);
        end));
        u3:Add(task.delay(11.4, function() -- Line: 202
            -- upvalues: TekrinnDialogue (ref), u2 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Text = "Allow me to pass through for a moment.",
                    Italic = true,
                    Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            }, 4, nil, nil, true);
        end));
        u3:Add(task.spawn(function() -- Line: 218
            -- upvalues: Lighting (ref), RunService (ref)
            local u12 = Lighting;

            for _, v in {
                ClockTime = { {
                        time = 3.48,
                        changes = {
                            ClockTime = 14.5
                        }
                    }, {
                        time = 0.69,
                        changes = {
                            ClockTime = 21
                        }
                    }, {
                        time = 5.4399999999999995,
                        changes = {
                            ClockTime = 21
                        }
                    }, {
                        time = 0.01,
                        changes = {
                            ClockTime = 14.5
                        }
                    } }
            } do
                coroutine.wrap(function() -- Line: 230
                    -- upvalues: v (copy), u12 (copy), RunService (ref)
                    for _, v2 in v do
                        local v13 = tick();
                        local v14 = v2;
                        local v15 = {};

                        for i, _ in v2.changes do
                            v15[i] = u12[i];
                        end;

                        local v16;

                        repeat
                            RunService.PreRender:Wait();
                            local v17 = (tick() - v13) / v14.time;
                            v16 = v17 > 1 and 1 or v17;

                            for i, v3 in v14.changes do
                                if typeof(v3) == "number" then
                                    u12[i] = math.lerp(v15[i], v3, v16);
                                elseif typeof(v3) == "Color3" then
                                    u12[i] = v15[i]:Lerp(v3, v16);
                                end;
                            end;
                        until v16 >= 1;
                    end;
                end)();
            end;
        end));
        u3:Add(task.spawn(function() -- Line: 255
            -- upvalues: u8 (copy), RunService (ref)
            local BlurEffect = u8.BlurEffect;

            for _, v in {
                ClockTime = { {
                        time = 1.11,
                        changes = {
                            Size = 5
                        }
                    }, {
                        time = 3,
                        changes = {
                            Size = 5
                        }
                    }, {
                        time = 0.10999999999999943,
                        changes = {
                            Size = 24
                        }
                    }, {
                        time = 0.8700000000000001,
                        changes = {
                            Size = 5
                        }
                    }, {
                        time = 1.29,
                        changes = {
                            Size = 12
                        }
                    }, {
                        time = 1.71,
                        changes = {
                            Size = 5
                        }
                    }, {
                        time = 0.33999999999999986,
                        changes = {
                            Size = 12
                        }
                    }, {
                        time = 1.0899999999999999,
                        changes = {
                            Size = 5
                        }
                    }, {
                        time = 1.790000000000001,
                        changes = {
                            Size = 5
                        }
                    }, {
                        time = 0.02,
                        changes = {
                            Size = 16
                        }
                    }, {
                        time = 0.7699999999999996,
                        changes = {
                            Size = 5
                        }
                    }, {
                        time = 0.019999999999999574,
                        changes = {
                            Size = 5
                        }
                    }, {
                        time = 0.02000000000000135,
                        changes = {
                            Size = 16
                        }
                    }, {
                        time = 0.02000000000000135,
                        changes = {
                            Size = 16
                        }
                    }, {
                        time = 0.3699999999999992,
                        changes = {
                            Size = 5
                        }
                    } }
            } do
                coroutine.wrap(function() -- Line: 278
                    -- upvalues: v (copy), BlurEffect (copy), RunService (ref)
                    for _, v2 in v do
                        local v18 = tick();
                        local v19 = v2;
                        local v20 = {};

                        for i, _ in v2.changes do
                            v20[i] = BlurEffect[i];
                        end;

                        local v21;

                        repeat
                            RunService.PreRender:Wait();
                            local v22 = (tick() - v18) / v19.time;
                            v21 = v22 > 1 and 1 or v22;

                            for i, v3 in v19.changes do
                                if typeof(v3) == "number" then
                                    BlurEffect[i] = math.lerp(v20[i], v3, v21);
                                elseif typeof(v3) == "Color3" then
                                    BlurEffect[i] = v20[i]:Lerp(v3, v21);
                                end;
                            end;
                        until v21 >= 1;
                    end;
                end)();
            end;
        end));
        u3:Add(task.spawn(function() -- Line: 303
            -- upvalues: u8 (copy), RunService (ref)
            local v23 = {
                ClockTime = {
                    {
                        time = 2.24,
                        changes = {
                            Density = 0.3,
                            Offset = 0.25,
                            Haze = 0,
                            Glare = 0,
                            Color = Color3.fromRGB(199, 199, 199),
                            Decay = Color3.fromRGB(106, 112, 125)
                        }
                    },
                    {
                        time = 1.7999999999999998,
                        changes = {
                            Density = 1,
                            Offset = 0.25,
                            Haze = 7,
                            Glare = 4,
                            Color = Color3.fromRGB(0, 0, 0),
                            Decay = Color3.fromRGB(113, 0, 0)
                        }
                    },
                    {
                        time = 1.0700000000000003,
                        changes = {
                            Decay = Color3.fromRGB(194, 0, 0)
                        }
                    },
                    {
                        time = 4.739999999999999,
                        changes = {
                            Density = 1,
                            Offset = 0.25,
                            Haze = 7,
                            Glare = 4,
                            Color = Color3.fromRGB(0, 0, 0),
                            Decay = Color3.fromRGB(113, 0, 0)
                        }
                    },
                    {
                        time = 0.01,
                        changes = {
                            Density = 0.3,
                            Offset = 0.25,
                            Haze = 0,
                            Glare = 0,
                            Color = Color3.fromRGB(199, 199, 199),
                            Decay = Color3.fromRGB(106, 112, 125)
                        }
                    }
                }
            };
            local Atmosphere = u8.Atmosphere;

            for _, v in v23 do
                coroutine.wrap(function() -- Line: 345
                    -- upvalues: v (copy), Atmosphere (copy), RunService (ref)
                    for _, v2 in v do
                        local v24 = tick();
                        local v25 = v2;
                        local v26 = {};

                        for i, _ in v2.changes do
                            v26[i] = Atmosphere[i];
                        end;

                        local v27;

                        repeat
                            RunService.PreRender:Wait();
                            local v28 = (tick() - v24) / v25.time;
                            v27 = v28 > 1 and 1 or v28;

                            for i, v3 in v25.changes do
                                if typeof(v3) == "number" then
                                    Atmosphere[i] = math.lerp(v26[i], v3, v27);
                                elseif typeof(v3) == "Color3" then
                                    Atmosphere[i] = v26[i]:Lerp(v3, v27);
                                end;
                            end;
                        until v27 >= 1;
                    end;
                end)();
            end;
        end));
        u3:Add(task.spawn(function() -- Line: 371
            -- upvalues: u8 (copy), RunService (ref)
            local DepthOfFieldEffect = u8.DepthOfFieldEffect;
            DepthOfFieldEffect.FocusDistance = 0.05;
            DepthOfFieldEffect.InFocusRadius = 30;
            DepthOfFieldEffect.FarIntensity = 1;
            DepthOfFieldEffect.NearIntensity = 0.75;

            for _, v in {
                ClockTime = { {
                        time = 5.41,
                        changes = {
                            InFocusRadius = 2
                        }
                    }, {
                        time = 4.119999999999999,
                        changes = {
                            InFocusRadius = 2
                        }
                    }, {
                        time = 1.5899999999999999,
                        changes = {
                            InFocusRadius = 2
                        }
                    }, {
                        time = 0.28000000000000114,
                        changes = {
                            InFocusRadius = 0
                        }
                    }, {
                        time = 0.6999999999999993,
                        changes = {
                            InFocusRadius = 0.594
                        }
                    }, {
                        time = 0.05,
                        changes = {
                            InFocusRadius = 25
                        }
                    } }
            } do
                coroutine.wrap(function() -- Line: 402
                    -- upvalues: v (copy), DepthOfFieldEffect (copy), RunService (ref)
                    for _, v2 in v do
                        local v29 = tick();
                        local v30 = v2;
                        local v31 = {};

                        for i, _ in v2.changes do
                            v31[i] = DepthOfFieldEffect[i];
                        end;

                        local v32;

                        repeat
                            RunService.PreRender:Wait();
                            local v33 = (tick() - v29) / v30.time;
                            v32 = v33 > 1 and 1 or v33;

                            for i, v3 in v30.changes do
                                if typeof(v3) == "number" then
                                    DepthOfFieldEffect[i] = math.lerp(v31[i], v3, v32);
                                elseif typeof(v3) == "Color3" then
                                    DepthOfFieldEffect[i] = v31[i]:Lerp(v3, v32);
                                end;
                            end;
                        until v32 >= 1;
                    end;
                end)();
            end;
        end));
        u3:Add(task.spawn(function() -- Line: 427
            -- upvalues: u8 (copy), TweenService (ref), RunService (ref)
            local ColorCorrectionEffect = u8.ColorCorrectionEffect;
            ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
            ColorCorrectionEffect.Brightness = 0;
            ColorCorrectionEffect.Contrast = 0;
            ColorCorrectionEffect.Saturation = -0.3;

            for _, v in {
                ClockTime = {
                    {
                        time = 4.07,
                        changes = {
                            Brightness = 0,
                            Contrast = 0,
                            Saturation = -0.3,
                            TintColor = Color3.fromRGB(255, 255, 255)
                        }
                    },
                    {
                        time = 0.01,
                        changes = {
                            Brightness = -0.2,
                            Contrast = 0,
                            Saturation = -0.7,
                            TintColor = Color3.fromRGB(99, 178, 255)
                        }
                    },
                    {
                        time = 0.3899999999999997,
                        changes = {
                            Brightness = 0
                        }
                    },
                    {
                        time = 5.4399999999999995,
                        changes = {
                            Brightness = 0,
                            Contrast = 0,
                            Saturation = -0.7,
                            TintColor = Color3.fromRGB(99, 178, 255)
                        }
                    },
                    {
                        time = 0.01,
                        changes = {
                            Brightness = 0,
                            Contrast = 0,
                            Saturation = -0.3,
                            TintColor = Color3.fromRGB(255, 255, 255)
                        }
                    },
                    {
                        time = 2.539999999999999,

                        changes = function() -- Line: 463, Name: changes
                            -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
                            coroutine.wrap(function() -- Line: 464
                                -- upvalues: TweenService (ref), ColorCorrectionEffect (ref)
                                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.02, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                                    Contrast = 10,
                                    Saturation = -1
                                }):Play();
                                task.delay(0.04, function() -- Line: 466
                                    -- upvalues: TweenService (ref), ColorCorrectionEffect (ref)
                                    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.01, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                                        Contrast = 0,
                                        Saturation = -0.3
                                    }):Play();
                                end);
                                local v34 = tick();
                                local v35 = {
                                    ["1"] = 1,
                                    ["2"] = 0,
                                    ["3"] = 0,
                                    ["4"] = -1,
                                    ["5"] = -2,
                                    ["6"] = -1,
                                    ["7"] = 0
                                };

                                for i = 1, 7 do
                                    repeat
                                        task.wait();
                                    until tick() - v34 >= 0.01;

                                    ColorCorrectionEffect.Brightness = v35[tostring(i)];
                                end;
                            end);
                        end
                    }
                }
            } do
                coroutine.wrap(function() -- Line: 493
                    -- upvalues: v (copy), ColorCorrectionEffect (copy), RunService (ref)
                    for _, v2 in v do
                        local v36 = tick();
                        local v37 = v2;
                        local v38 = {};

                        for i, _ in v2.changes do
                            v38[i] = ColorCorrectionEffect[i];
                        end;

                        if typeof(v37.changes) == "table" then
                            local v39;

                            repeat
                                RunService.PreRender:Wait();
                                local v40 = (tick() - v36) / v37.time;
                                v39 = v40 > 1 and 1 or v40;

                                for i, v3 in v37.changes do
                                    if typeof(v3) == "number" then
                                        ColorCorrectionEffect[i] = math.lerp(v38[i], v3, v39);
                                    elseif typeof(v3) == "Color3" then
                                        ColorCorrectionEffect[i] = v38[i]:Lerp(v3, v39);
                                    end;
                                end;
                            until v39 >= 1;
                        end;

                        if typeof(v37.changes) == "function" then
                            v37.changes();
                        end;
                    end;
                end)();
            end;
        end));
        u3:Add(task.spawn(function() -- Line: 524
            -- upvalues: u6 (copy), RunService (ref)
            local u41 = u6;

            for _, v in {
                ImageTransparency = { {
                        time = 2.28,
                        changes = {
                            ImageTransparency = 0.5
                        }
                    }, {
                        time = 1.73,
                        changes = {
                            ImageTransparency = 0
                        }
                    }, {
                        time = 1.38,
                        changes = {
                            ImageTransparency = 0.5
                        }
                    }, {
                        time = 5.86,
                        changes = {
                            ImageTransparency = 0.5
                        }
                    }, {
                        time = 0.10999999999999943,
                        changes = {
                            ImageTransparency = 0
                        }
                    }, {
                        time = 0.21000000000000085,
                        changes = {
                            ImageTransparency = 0.5
                        }
                    }, {
                        time = 0.5700000000000003,
                        changes = {
                            ImageTransparency = 0.5
                        }
                    }, {
                        time = 0.07000000000000028,
                        changes = {
                            ImageTransparency = 0
                        }
                    } }
            } do
                coroutine.wrap(function() -- Line: 541
                    -- upvalues: v (copy), u41 (copy), RunService (ref)
                    for _, v2 in v do
                        local v42 = tick();
                        local v43 = v2;
                        local v44 = {};

                        for i, _ in v2.changes do
                            v44[i] = u41.Vignette[i];
                        end;

                        local v45;

                        repeat
                            RunService.PreRender:Wait();
                            local v46 = (tick() - v42) / v43.time;
                            v45 = v46 > 1 and 1 or v46;

                            for i, v3 in v43.changes do
                                local v47 = i;
                                local v48 = v3;

                                for _, descendant in u41:GetDescendants() do
                                    if descendant:IsA("ImageLabel") then
                                        if typeof(v48) == "number" then
                                            descendant[v47] = math.lerp(v44[v47], v48, v45);
                                        elseif typeof(v48) == "Color3" then
                                            descendant[v47] = v44[v47]:Lerp(v48, v45);
                                        end;
                                    end;
                                end;
                            end;
                        until v45 >= 1;
                    end;
                end)();
            end;
        end));
        u3:Add(task.delay(13.58, function() -- Line: 571
            -- upvalues: u3 (copy)
            u3:Destroy();
        end));
    end,

    KJOffBallAwk = function(u49) -- Line: 579, Name: KJOffBallAwk
        -- upvalues: vfxUtil (copy), trove (copy), LocalPlayer (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), RunService (copy), Lighting (copy), TekrinnDialogue (copy)
        local KJ = vfxUtil.getResources():WaitForChild("KJ");
        local u50 = trove.new();
        u50:AttachToInstance(u49);
        local v51 = KJ["Off Ball Flow"];
        local Root = vfxUtil.getRoot(u49);
        local forge = vfxUtil.forge;
        local u52 = u50:Add(v51.Vignette:Clone());
        u52.Parent = LocalPlayer.PlayerGui;
        mainreplication.sceneEnabled(true);
        soundUtil:play(v51.Sound, SoundService);
        local u53 = u50:Add(v51.Folder:Clone());
        u53.Parent = workspace.Effects;
        mainreplication.EnableMapLights(false);
        u50:Add(RunService.PreRender:Connect(function() -- Line: 603
            -- upvalues: u53 (copy), Root (copy)
            u53.PrimaryPart.CFrame = Root.CFrame * CFrame.new(-0.1210629865527153, 0.9350347518920898, 0);
        end));
        local u54 = {};
        local u55 = {};

        for _, child in Lighting:GetChildren() do
            if child:IsA("Atmosphere") or (child:IsA("Sky") or (child:IsA("BloomEffect") or (child:IsA("BlurEffect") or (child:IsA("ColorCorrectionEffect") or (child:IsA("DepthOfFieldEffect") or child:IsA("SunRaysEffect")))))) then
                table.insert(u54, child);
                child.Parent = workspace;
            end;
        end;

        for _, child in v51.Lighting:GetChildren() do
            local v56 = child:Clone();
            v56.Parent = Lighting;
            u55[v56.ClassName] = v56;
        end;

        local u57 = {};

        for _, child in v51.VFXPARTS:GetChildren() do
            if u49:FindFirstChild(child.Name) then
                local v58 = child;

                for _, child2 in child:GetChildren() do
                    local v59 = u50:Add(child2:Clone());
                    table.insert(u57, v59);
                    v59.Parent = u49:FindFirstChild(v58.Name);
                end;
            end;
        end;

        u50:Add(task.delay(1.29, function() -- Line: 636
            -- upvalues: TekrinnDialogue (ref), u49 (copy)
            TekrinnDialogue.Speak(u49, {
                {
                    Text = "I\'m getting really sick of this...",
                    Italic = true,
                    Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            }, 3, nil, nil, true);
        end));
        u50:Add(task.delay(5.3085, function() -- Line: 651
            -- upvalues: TekrinnDialogue (ref), u49 (copy)
            TekrinnDialogue.Speak(u49, {
                {
                    Text = "Come at me.",
                    Italic = true,
                    Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            }, 4, nil, nil, true);
        end));
        u50:Add(task.spawn(function() -- Line: 667
            -- upvalues: forge (copy), u49 (copy)
            forge.emit(u49["Left Leg"].leftfootstepvfx);
        end));
        u50:Add(task.delay(0.3, function() -- Line: 673
            -- upvalues: forge (copy), u49 (copy)
            forge.emit(u49["Right Leg"].rightfootstepvfx);
        end));
        u50:Add(task.delay(0.44, function() -- Line: 678
            -- upvalues: forge (copy), u49 (copy)
            forge.emit(u49["Left Leg"].leftfootstepvfx);
        end));
        u50:Add(task.delay(1.1, function() -- Line: 684
            -- upvalues: forge (copy), u49 (copy)
            forge.emit(u49["Right Leg"].rightfootstepvfx);
        end));
        u50:Add(task.delay(2.12, function() -- Line: 689
            -- upvalues: forge (copy), u49 (copy)
            forge.emit(u49["Right Arm"]);
        end));
        u50:Add(task.delay(2.51, function() -- Line: 694
            -- upvalues: forge (copy), u53 (copy)
            forge.emit(u53.pressureonhead.ball, u53.othervfxkj);
        end));
        u50:Add(task.delay(5, function() -- Line: 700
            -- upvalues: u50 (copy), RunService (ref), u53 (copy), forge (copy), u49 (copy)
            u50:Add(RunService.PreRender:Connect(function() -- Line: 702
                -- upvalues: u53 (ref)
                u53.ScreenPart2.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -1.5);
            end));
            forge.emit(u53.ScreenPart2, u53.BackgroundStatic, u49.Head, u53.pressureonhead);
        end));
        u50:Add(function() -- Line: 717
            -- upvalues: mainreplication (ref), u52 (copy), u57 (copy), u54 (copy), Lighting (ref), u55 (copy)
            mainreplication.EnableMapLights(true);
            mainreplication.ultFlash();
            mainreplication.sceneEnabled(false);
            pcall(game.Destroy, u52);

            for _, v in u57 do
                pcall(game.Destroy, v);
            end;

            for _, v in u54 do
                pcall(function() -- Line: 726
                    -- upvalues: v (copy), Lighting (ref)
                    v.Parent = Lighting;
                end);
            end;

            for _, v in u55 do
                pcall(game.Destroy, v);
            end;
        end);
        mainreplication.cutsceneBlender(Root, v51.Camera, v51.FOV, nil, nil, CFrame.new(0, -3, 0));
        u50:Add(task.spawn(function() -- Line: 737
            -- upvalues: u55 (copy), RunService (ref)
            local BlurEffect = u55.BlurEffect;
            BlurEffect.Size = 24;

            for _, v in {
                ClockTime = { {
                        time = 0.59,
                        changes = {
                            Size = 5
                        }
                    }, {
                        time = 0.6900000000000001,
                        changes = {
                            Size = 5
                        }
                    }, {
                        time = 0.16999999999999993,
                        changes = {
                            Size = 12
                        }
                    }, {
                        time = 0.8200000000000001,
                        changes = {
                            Size = 5
                        }
                    }, {
                        time = 0.1299999999999999,
                        changes = {
                            Size = 24
                        }
                    }, {
                        time = 1.6199999999999997,
                        changes = {
                            Size = 5
                        }
                    }, {
                        time = 0.5500000000000007,
                        changes = {
                            Size = 5
                        }
                    }, {
                        time = 0.019999999999999574,
                        changes = {
                            Size = 24
                        }
                    }, {
                        time = 1.4800000000000004,
                        changes = {
                            Size = 4
                        }
                    }, {
                        time = 0.3700000000000001,
                        changes = {
                            Size = 4
                        }
                    }, {
                        time = 0.6399999999999997,
                        changes = {
                            Size = 12
                        }
                    }, {
                        time = 0.5099999999999998,
                        changes = {
                            Size = 4
                        }
                    } }
            } do
                coroutine.wrap(function() -- Line: 760
                    -- upvalues: v (copy), BlurEffect (copy), RunService (ref)
                    for _, v2 in v do
                        local v60 = tick();
                        local v61 = v2;
                        local v62 = {};

                        for i, _ in v2.changes do
                            v62[i] = BlurEffect[i];
                        end;

                        local v63;

                        repeat
                            RunService.PreRender:Wait();
                            local v64 = (tick() - v60) / v61.time;
                            v63 = v64 > 1 and 1 or v64;

                            for i, v3 in v61.changes do
                                if typeof(v3) == "number" then
                                    BlurEffect[i] = math.lerp(v62[i], v3, v63);
                                elseif typeof(v3) == "Color3" then
                                    BlurEffect[i] = v62[i]:Lerp(v3, v63);
                                end;
                            end;
                        until v63 >= 1;
                    end;
                end)();
            end;
        end));
        u50:Add(task.spawn(function() -- Line: 785
            -- upvalues: u55 (copy), RunService (ref)
            local v65 = {
                ClockTime = {
                    {
                        time = 1.15,
                        changes = {
                            Density = 1,
                            Offset = 0.25,
                            Color = Color3.fromRGB(0, 0, 0),
                            Decay = Color3.fromRGB(0, 0, 0)
                        }
                    },
                    {
                        time = 0.19000000000000017,
                        changes = {
                            Density = 1,
                            Offset = 0.25,
                            Color = Color3.fromRGB(0, 0, 0),
                            Decay = Color3.fromRGB(113, 0, 0)
                        }
                    },
                    {
                        time = 1.0199999999999998,
                        changes = {
                            Density = 1,
                            Offset = 0.25,
                            Color = Color3.fromRGB(255, 15, 15),
                            Decay = Color3.fromRGB(0, 0, 0)
                        }
                    },
                    {
                        time = 0.7400000000000002,
                        changes = {}
                    },
                    {
                        time = 1.4899999999999998,
                        changes = {
                            Density = 1,
                            Offset = 0.25,
                            Color = Color3.fromRGB(255, 15, 15),
                            Decay = Color3.fromRGB(0, 0, 0)
                        }
                    },
                    {
                        time = 0.4299999999999997,
                        changes = {
                            Density = 1,
                            Offset = 0.25,
                            Color = Color3.fromRGB(0, 0, 0),
                            Decay = Color3.fromRGB(0, 0, 0)
                        }
                    }
                },
                haze_and_glare = { {
                        time = 1.15,
                        changes = {
                            Haze = 3,
                            Glare = 4
                        }
                    }, {
                        time = 0.19000000000000017,
                        changes = {
                            Haze = 7,
                            Glare = 4
                        }
                    }, {
                        time = 1.0199999999999998,
                        changes = {
                            Haze = 5,
                            Glare = 4
                        }
                    }, {
                        time = 0.7400000000000002,
                        changes = {
                            Haze = 3,
                            Glare = 1
                        }
                    }, {
                        time = 1.4899999999999998,
                        changes = {
                            Haze = 3,
                            Glare = 1
                        }
                    }, {
                        time = 0.4299999999999997,
                        changes = {
                            Haze = 3,
                            Glare = 4
                        }
                    } }
            };
            local Atmosphere = u55.Atmosphere;

            for _, v in v65 do
                coroutine.wrap(function() -- Line: 866
                    -- upvalues: v (copy), Atmosphere (copy), RunService (ref)
                    for _, v2 in v do
                        local v66 = tick();
                        local v67 = v2;
                        local v68 = {};

                        for i, _ in v2.changes do
                            v68[i] = Atmosphere[i];
                        end;

                        local v69;

                        repeat
                            RunService.PreRender:Wait();
                            local v70 = (tick() - v66) / v67.time;
                            v69 = v70 > 1 and 1 or v70;

                            for i, v3 in v67.changes do
                                if typeof(v3) == "number" then
                                    Atmosphere[i] = math.lerp(v68[i], v3, v69);
                                elseif typeof(v3) == "Color3" then
                                    Atmosphere[i] = v68[i]:Lerp(v3, v69);
                                end;
                            end;
                        until v69 >= 1;
                    end;
                end)();
            end;
        end));
        u50:Add(task.spawn(function() -- Line: 892
            -- upvalues: u55 (copy), RunService (ref)
            local DepthOfFieldEffect = u55.DepthOfFieldEffect;
            DepthOfFieldEffect.FocusDistance = 0.05;
            DepthOfFieldEffect.InFocusRadius = 5;
            DepthOfFieldEffect.FarIntensity = 1;
            DepthOfFieldEffect.NearIntensity = 0.75;

            for _, v in {
                NearIntensity = { {
                        time = 2.06,
                        changes = {
                            NearIntensity = 0.75
                        }
                    }, {
                        time = 0.20999999999999996,
                        changes = {
                            NearIntensity = 1
                        }
                    } },
                InFocusRadius = { {
                        time = 1.3,
                        changes = {
                            InFocusRadius = 0
                        }
                    }, {
                        time = 0.29000000000000004,
                        changes = {
                            InFocusRadius = 1
                        }
                    }, {
                        time = 0.6799999999999999,
                        changes = {
                            InFocusRadius = 0
                        }
                    }, {
                        time = 0.14000000000000012,
                        changes = {
                            InFocusRadius = 0
                        }
                    }, {
                        time = 0.08000000000000007,
                        changes = {
                            InFocusRadius = 0
                        }
                    }, {
                        time = 0.06999999999999984,
                        changes = {
                            InFocusRadius = 4
                        }
                    } },
                FocusDistance = { {
                        time = 1.51,
                        changes = {
                            FocusDistance = 0.05
                        }
                    }, {
                        time = 0.76,
                        changes = {
                            FocusDistance = 2
                        }
                    } }
            } do
                coroutine.wrap(function() -- Line: 940
                    -- upvalues: v (copy), DepthOfFieldEffect (copy), RunService (ref)
                    for _, v2 in v do
                        local v71 = tick();
                        local v72 = v2;
                        local v73 = {};

                        for i, _ in v2.changes do
                            v73[i] = DepthOfFieldEffect[i];
                        end;

                        local v74;

                        repeat
                            RunService.PreRender:Wait();
                            local v75 = (tick() - v71) / v72.time;
                            v74 = v75 > 1 and 1 or v75;

                            for i, v3 in v72.changes do
                                if typeof(v3) == "number" then
                                    DepthOfFieldEffect[i] = math.lerp(v73[i], v3, v74);
                                elseif typeof(v3) == "Color3" then
                                    DepthOfFieldEffect[i] = v73[i]:Lerp(v3, v74);
                                end;
                            end;
                        until v74 >= 1;
                    end;
                end)();
            end;
        end));
        u50:Add(task.spawn(function() -- Line: 967
            -- upvalues: u52 (copy), RunService (ref)
            local v76 = {
                ImageTransparency = { {
                        time = 1.04,
                        changes = {
                            ImageTransparency = 0.5
                        }
                    }, {
                        time = 1.4699999999999998,
                        changes = {
                            ImageTransparency = 0
                        }
                    }, {
                        time = 1.8100000000000005,
                        changes = {
                            ImageTransparency = 0.5
                        }
                    }, {
                        time = 0.7299999999999995,
                        changes = {
                            ImageTransparency = 0
                        }
                    } },
                ImageColor3 = {
                    {
                        time = 1.08,
                        changes = {
                            ImageColor3 = Color3.fromRGB(0, 0, 0)
                        }
                    },
                    {
                        time = 1.4100000000000001,
                        changes = {
                            ImageColor3 = Color3.fromRGB(138, 0, 0)
                        }
                    },
                    {
                        time = 0.07999999999999963,
                        changes = {
                            ImageColor3 = Color3.fromRGB(255, 0, 0)
                        }
                    },
                    {
                        time = 1.6200000000000006,
                        changes = {
                            ImageColor3 = Color3.fromRGB(138, 0, 0)
                        }
                    },
                    {
                        time = 0.1999999999999993,
                        changes = {
                            ImageColor3 = Color3.fromRGB(59, 0, 0)
                        }
                    },
                    {
                        time = 0.1900000000000004,
                        changes = {
                            ImageColor3 = Color3.fromRGB(0, 0, 0)
                        }
                    }
                }
            };
            local u77 = u52;

            for _, descendant in u77:GetDescendants() do
                if descendant:IsA("ImageLabel") then
                    descendant.ImageTransparency = 0;
                end;
            end;

            for _, v in v76 do
                coroutine.wrap(function() -- Line: 997
                    -- upvalues: v (copy), u77 (copy), RunService (ref)
                    for _, v2 in v do
                        local v78 = tick();
                        local v79 = v2;
                        local v80 = {};

                        for i, _ in v2.changes do
                            v80[i] = u77.Vignette[i];
                        end;

                        local v81;

                        repeat
                            RunService.PreRender:Wait();
                            local v82 = (tick() - v78) / v79.time;
                            v81 = v82 > 1 and 1 or v82;

                            for i, v3 in v79.changes do
                                local v83 = i;
                                local v84 = v3;

                                for _, descendant in u77:GetDescendants() do
                                    if descendant:IsA("ImageLabel") then
                                        if typeof(v84) == "number" then
                                            descendant[v83] = math.lerp(v80[v83], v84, v81);
                                        elseif typeof(v84) == "Color3" then
                                            descendant[v83] = v80[v83]:Lerp(v84, v81);
                                        end;
                                    end;
                                end;
                            end;
                        until v81 >= 1;
                    end;
                end)();
            end;
        end));
        u50:Add(task.delay(7.98, function() -- Line: 1027
            -- upvalues: u50 (copy)
            u50:Destroy();
        end));
    end,

    KJUnlimitedFlexworks = function(u85) -- Line: 1034, Name: KJUnlimitedFlexworks
        -- upvalues: vfxUtil (copy), trove (copy), Lighting (copy), mainreplication (copy), TekrinnDialogue (copy), soundUtil (copy), SoundService (copy), ClockTime (copy), MoonPropertyAnimator (copy), RunService (copy)
        local KJ = vfxUtil.getResources():WaitForChild("KJ");
        local u86 = trove.new();
        u86:AttachToInstance(u85);
        local u87 = KJ["Unlimited Flexworks"];
        local Root = vfxUtil.getRoot(u85);
        Root.Anchored = true;
        local v88 = u86:Add(vfxUtil.getMoonEffects());
        local v89 = u86:Construct(u87.aura);
        vfxUtil.setupAura(u85, v89, true);
        v89.Parent = workspace.Effects;
        local u90 = u86:Clone(u87.Earth);
        local u91 = u86:Clone(u87.AnimatedNet);
        local u92 = u86:Add(vfxUtil.highlight(u87, {
            Name = "CharacterHighlight",
            Enabled = true,
            FillTransparency = 50,
            OutlineTransparency = 0,
            DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
            FillColor = Color3.new(0.101960793, 0.34117648, 1),
            OutlineColor = Color3.new(0, 0, 0)
        }));
        local v93 = u86:Add(vfxUtil.highlight(u85:FindFirstChild("Ball") or u85, {
            Name = "BallHighlight",
            Enabled = true,
            FillTransparency = 1,
            OutlineTransparency = 1,
            DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
            FillColor = Color3.new(1, 1, 1),
            OutlineColor = Color3.new(1, 1, 1)
        }));
        local u94 = {};
        local v95 = {};

        for _, child in Lighting:GetChildren() do
            if u87.Lighting:FindFirstChildWhichIsA(child.ClassName) then
                table.insert(u94, child);
                child.Parent = workspace;
            end;
        end;

        for _, child in u87.Lighting:GetChildren() do
            local v96 = u86:Clone(child);
            v96.Parent = Lighting;
            v95[v96.Name] = v96;
            print(v96.Name, v96);
        end;

        u90.Parent = workspace.Effects;
        u91.Parent = workspace.Effects;
        local v97 = u86:Add(Instance.new("Motor6D"));
        v97.Parent = Root;
        v97.C0 = CFrame.new(
            -16.7061291,
            0,
            -17.6928635,
            -0.970295727,
            -1.65284464e-24,
            -0.241921812,
            2.13163553e-13,
            1,
            -8.5495261e-13,
            0.241921812,
            2.64337727e-12,
            -0.970295727
        );
        v97.Part0 = Root;
        v97.Part1 = u91.root;
        mainreplication.sceneEnabled(true);
        mainreplication.EnableMapLights(false);
        local u98 = mainreplication.kuronaCamToAll(Root, u87.Cam, u87.FOV);
        local u99 = u87.VFX:Clone();
        u99:PivotTo(CFrame.new(Root.Position, Root.Position - Root.CFrame.LookVector));
        u99.Parent = workspace.Effects;
        local v100 = u86:Add(u99.HandVFX);
        v100.Parent = workspace.Effects;
        local Weld = Instance.new("Weld");

        if u85:FindFirstChild("Right Arm") then
            Weld.Parent = u85:FindFirstChild("Right Arm");
            Weld.Part0 = Weld.Parent;
            Weld.Part1 = v100;
        end;

        local CFrame2 = Root.CFrame;
        u86:Add(task.delay(11.283333333333333, function() -- Line: 1118
            -- upvalues: Root (copy)
            Root.CFrame = Root.CFrame + Vector3.new(0, 1750, 0);
        end));
        u86:Add(task.delay(28.633333333333333, function() -- Line: 1122
            -- upvalues: u92 (copy), u85 (copy)
            if u92 then
                u92.Parent = u85;
            end;
        end));
        u86:Add(task.delay(0.94, function() -- Line: 1129
            -- upvalues: TekrinnDialogue (ref), u85 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Text = "You\'re sounding awfully cocky...",
                    Italic = true,
                    TypeSpeed = 0.005,
                    Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            }, 3, nil, nil, true);
        end));
        u86:Add(task.delay(4.487, function() -- Line: 1146
            -- upvalues: TekrinnDialogue (ref), u85 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Text = "But...",
                    Italic = true,
                    TypeSpeed = 0.015,
                    Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            }, 3, nil, nil, true);
        end));
        u86:Add(task.delay(5.26, function() -- Line: 1163
            -- upvalues: TekrinnDialogue (ref), u85 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Text = "With this,",
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 3
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            }, 3, nil, nil, true);
        end));
        u86:Add(task.delay(6.727, function() -- Line: 1181
            -- upvalues: TekrinnDialogue (ref), u85 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Text = "IT\'S OVER!",
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 0, 0)),
                    Shake = {
                        Enabled = true,
                        Intensity = 15,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            }, 2, nil, nil, true);
        end));
        u86:Add(task.delay(9.845, function() -- Line: 1198
            -- upvalues: TekrinnDialogue (ref), u85 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Text = "KJ\'S...",
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 1
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            }, 2, nil, nil, true);
        end));
        u86:Add(task.delay(11.1447, function() -- Line: 1215
            -- upvalues: TekrinnDialogue (ref), u85 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Text = "21 SERIES.",
                    Italic = true,
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 0, 0)),
                    Shake = {
                        Enabled = true,
                        Intensity = 10,
                        Lifetime = 1
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            }, 2, nil, nil, true);
        end));
        u86:Add(task.delay(19.4, function() -- Line: 1232
            -- upvalues: TekrinnDialogue (ref), u85 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Text = "You know...",
                    Italic = true,
                    Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            }, 2, nil, nil, true);
        end));
        u86:Add(task.delay(20.31, function() -- Line: 1248
            -- upvalues: TekrinnDialogue (ref), u85 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Text = "Sometimes I imagine what I\'d be doing",
                    Italic = true,
                    TypeSpeed = 0.04,
                    Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            }, 3, nil, nil, true);
        end));
        u86:Add(task.delay(22.3, function() -- Line: 1265
            -- upvalues: TekrinnDialogue (ref), u85 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Text = "If that day never happened...",
                    Italic = true,
                    TypeSpeed = 0.005,
                    Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 1)),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 2
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            }, 5, nil, nil, true);
        end));
        u86:Add(task.delay(26.388, function() -- Line: 1282
            -- upvalues: TekrinnDialogue (ref), u85 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Text = "HAAAAAAAAAAAA-A-A--A-AA-A-AAHH!!!",
                    Italic = true,
                    Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 0, 0)),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 5
                    },
                    TextStrokeColor = Color3.new(0, 0, 0)
                }
            }, 4, nil, nil, true);
        end));
        soundUtil:play(u87.Sound, SoundService);
        u86:Add(task.spawn(function() -- Line: 1303
            -- upvalues: u90 (copy), u87 (copy), u91 (copy)
            u90.AnimationController.Animator:LoadAnimation(u87.EarthaNIM):Play(0);
            u91.AnimationController.Animator:LoadAnimation(u87.Net):Play(0);
        end));
        u86:Add(function() -- Line: 1310
            -- upvalues: u98 (copy), mainreplication (ref), u99 (copy), Lighting (ref), ClockTime (ref), u94 (copy), Root (copy), CFrame2 (copy)
            if u98 then
                pcall(game.Destroy, u98);
            end;

            mainreplication.sceneEnabled(false);
            mainreplication.EnableMapLights(true);
            task.delay(3, function() -- Line: 1318
                -- upvalues: u99 (ref)
                pcall(game.Destroy, u99);
            end);
            Lighting.ClockTime = ClockTime;

            for _, v in u94 do
                pcall(function() -- Line: 1323
                    -- upvalues: v (copy), Lighting (ref)
                    v.Parent = Lighting;
                end);
            end;

            if Root then
                Root.CFrame = CFrame2;
                Root.Anchored = false;
            end;
        end);
        local Compile = require(u87.Compile);

        for _, v in ipairs(Compile) do
            u86:Add(task.delay(v[1] / 60, v[2], u99, v89, v95, v100));
        end;

        u86:Add(task.delay(31, function() -- Line: 1338
            -- upvalues: u86 (copy)
            u86:Destroy();
        end));
        local v101 = {
            aaa = v89,
            VFX = u99,
            Vignette = v88.Vignette,
            ColorCorrection = v95.ColorCorrection,
            Atmosphere = v95.Atmosphere,
            ["Ball.Highlight"] = v93
        };
        local v102 = u86:Construct(MoonPropertyAnimator);
        v102:LoadSave(u87.Moon, MoonPropertyAnimator.ConvertSave(u87.Moon, v101));
        v102:SetRoot(Root);
        v102:SetOriginalRoot(u87.OG.Value);
        u86:Add(RunService.PreRender:Connect(function() -- Line: 1358
            -- upvalues: u99 (copy), Root (copy), u90 (copy)
            u99:PivotTo(CFrame.new(Root.Position, Root.Position - Root.CFrame.LookVector));
            u90.PrimaryPart.CFrame = CFrame.new(Root.Position, Root.Position - Root.CFrame.LookVector);
        end));
        v102:PlayAll();
    end,

    KJDropkick = function(u103, p104) -- Line: 1627, Name: KJDropkick
        -- upvalues: vfxUtil (copy), trove (copy), TweenService (copy), soundUtil (copy), BackgroundHighlight (copy), RunService (copy)
        local KJ = vfxUtil.getResources():WaitForChild("KJ");
        local u105 = trove.new();
        u105:AttachToInstance(p104);
        local v106 = KJ["20-20-20 Dropkick"];
        local Root = vfxUtil.getRoot(u103);
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 10;
        TweenService:Create(NumberValue, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Value = 350
        }):Play();
        u105:Add(NumberValue);
        soundUtil:play(v106.DropkickUse, Root);
        u105:Add(task.delay(1, function() -- Line: 1643
            -- upvalues: BackgroundHighlight (ref), u103 (copy), u105 (copy), RunService (ref), Root (copy), NumberValue (copy)
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.MaxForce = Vector3.new(350000, 0, 350000);
            BodyVelocity.P = 13500;
            BackgroundHighlight({
                Speed = 0.3,
                CFrames = true,
                Brightness = 1,
                countSpeed = 0.05,
                ImageTransparency = 0.8,
                Count = 107,
                Whitelist = { u103 },
                Color = Color3.fromRGB(255, 255, 255),
                Color2 = Color3.fromRGB(255, 255, 255)
            });
            u105:Add(RunService.PreRender:Connect(function() -- Line: 1661
                -- upvalues: BodyVelocity (copy), Root (ref), NumberValue (ref)
                BodyVelocity.Velocity = Root.CFrame.LookVector * NumberValue.Value;
            end));
            BodyVelocity.Parent = Root;
            u105:Add(BodyVelocity);
        end));
        u105:Add(task.delay(5.6, function() -- Line: 1669
            -- upvalues: TweenService (ref), NumberValue (copy)
            TweenService:Create(NumberValue, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Value = 15
            }):Play();
            task.wait(0.45);

            if NumberValue then
                TweenService:Create(NumberValue, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Value = 0
                }):Play();
            end;
        end));
        u105:Add(task.delay(6.97, function() -- Line: 1678
            -- upvalues: u105 (copy)
            u105:Destroy();
        end));
    end,

    KJDropkickHit = function(p107, p108) -- Line: 1684, Name: KJDropkickHit
        -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), RunService (copy), ReplicatedStorage (copy)
        local KJ = vfxUtil.getResources():WaitForChild("KJ");
        local u109 = trove.new();
        u109:AttachToInstance(p107);
        local v110 = KJ["20-20-20 Dropkick"];
        local Root = vfxUtil.getRoot(p107);

        if Root:FindFirstChild("DropkickUse") then
            pcall(game.Destroy, Root:FindFirstChild("DropkickUse"));
        end;

        local Compiled = require(v110.Compiled);
        local v111 = u109:Construct(v110.Aura);
        vfxUtil.setupAura(p107, v111, true);
        mainreplication.sceneEnabled(true);
        u109:Add(function() -- Line: 1704
            -- upvalues: mainreplication (ref)
            mainreplication.sceneEnabled(false);
        end);
        soundUtil:play(v110.DropkickLand, SoundService);
        local u112 = u109:Add(vfxUtil.highlight(p108, {
            Name = "Highlight",
            Enabled = false,
            FillTransparency = 50,
            OutlineTransparency = 0,
            DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
            FillColor = Color3.new(0.0901960805, 0.650980413, 1),
            OutlineColor = Color3.new(0, 0, 0)
        }));
        local u113 = u109:Add(vfxUtil.highlight(p107, {
            Name = "Highlight",
            Enabled = false,
            FillTransparency = 50,
            OutlineTransparency = 0,
            DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
            FillColor = Color3.new(0.0901960805, 0.650980413, 1),
            OutlineColor = Color3.new(0, 0, 0)
        }));
        local u114 = u109:Clone(v110.VFXCutscene);
        u114.Parent = workspace.Effects;

        for _, v in ipairs(Compiled) do
            u109:Add(task.delay(v[1] / 60, v[2], u114));
        end;

        u109:Add(RunService.RenderStepped:Connect(function() -- Line: 1737
            -- upvalues: u114 (copy), Root (copy)
            u114:PivotTo(CFrame.new(Root.Position, Root.Position + Vector3.new(Root.CFrame.LookVector.X, 0, Root.CFrame.LookVector.Z)));
        end));
        u109:Add(task.spawn(function() -- Line: 1741
            -- upvalues: u112 (copy), u113 (copy)
            local v115 = tick();

            repeat
                task.wait();
            until tick() - v115 >= 8.04;

            if u112 then
                u112.Enabled = true;
            end;

            if u113 then
                u113.Enabled = true;
            end;
        end));
        local v116 = u109:Clone(ReplicatedStorage.Resources.Ball);
        v116.Parent = p107;
        v116.ball.Part0 = Root;
        v116.CanCollide = false;
        v116.Attachment:Destroy();
        v116.position:Destroy();
        u109:Add((mainreplication.kuronaCam(Root, nil, v110.FOV)));
        u109:Add(task.delay(13.01, function() -- Line: 1762
            -- upvalues: u109 (copy), mainreplication (ref)
            u109:Destroy();
            mainreplication.fov(false, 20, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        end));
    end,

    KJCounter = function(p117) -- Line: 1770, Name: KJCounter
        -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy)
        local KJ = vfxUtil.getResources():WaitForChild("KJ");
        local u118 = trove.new();
        u118:AttachToInstance(p117);
        local v119 = KJ["Important Matters"];
        local Root = vfxUtil.getRoot(p117);
        soundUtil:play(v119.CounterUse, Root);
        local u120 = p117:FindFirstChild("KJ Phone");
        local u121 = u118:Construct(v119.Aura);
        vfxUtil.setupAura(p117, u121, true);
        local u122 = vfxUtil.build_highlights(u118:Clone(v119.Highlights.STARTUP), u118, "_KJHighlightProperties");
        u122.Parent = p117;
        u118:Add(task.spawn(function() -- Line: 1789
            -- upvalues: u120 (copy), u121 (copy), u122 (copy)
            shared.vfx.emit(u120.Parts.Screen.STARTUP, u121.Torso.STARTUP, u122);
        end));
        u118:Add(task.delay(1.5, function() -- Line: 1792
            -- upvalues: u118 (copy)
            u118:Destroy();
        end));
    end,

    KJCounterHit = function(p123, p124) -- Line: 1798, Name: KJCounterHit
        -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), RunService (copy), Lighting (copy), LocalPlayer (copy)
        local KJ = vfxUtil.getResources():WaitForChild("KJ");
        local u125 = trove.new();
        u125:AttachToInstance(p123);
        local u126 = KJ["Important Matters"];
        local Root = vfxUtil.getRoot(p123);
        local Root2 = vfxUtil.getRoot(p124);
        p123:FindFirstChild("KJ Phone");
        local v127 = u125:Construct(u126.Aura);
        local u128 = u125:Construct(u126.MeshVFX);
        u128.Parent = workspace.Effects;
        v127.Parent = workspace.Effects;
        vfxUtil.setupAura(p123, v127, true);
        soundUtil:play(u126.Hit, Root);
        u125:Add(RunService.PreRender:Connect(function() -- Line: 1819
            -- upvalues: u128 (copy), Root (copy)
            u128.PrimaryPart.CFrame = Root.CFrame;
        end));
        local u129 = vfxUtil.build_highlights(u125:Clone(u126.Highlights.HIT), u125, "_KJHighlightProperties");
        u129.Parent = p123;
        local u130 = {};
        local u131 = {};

        for _, child in u126.Lighting:GetChildren() do
            local v132 = u125:Clone(child);
            u130[child.Name] = v132;
            v132.Parent = Lighting;
        end;

        for _, child in u126.UI:GetChildren() do
            local v133 = u125:Clone(child);
            u131[child.Name] = v133;
            v133.Parent = LocalPlayer.PlayerGui;
        end;

        u125:Add(task.spawn(function() -- Line: 1841
            -- upvalues: u128 (copy)
            shared.vfx.emit(u128.slide);
        end));
        u125:Add(task.delay(0.41, function() -- Line: 1845
            -- upvalues: u128 (copy), u130 (copy), u131 (copy), Root2 (copy), soundUtil (ref), u126 (copy), Root (copy)
            shared.vfx.emit(u128.vfx1);
            shared.vfx.emit(u130.KJBLUR);
            shared.vfx.emit(u131.ScreenGui);

            if Root2 then
                soundUtil:play(u126.Victim, Root);
            end;
        end));
        u125:Add(task.delay(1.41, function() -- Line: 1856
            -- upvalues: u128 (copy), u130 (copy)
            shared.vfx.emit(u128.spin);
            shared.vfx.emit(u130.KJSPIN);
        end));
        u125:Add(task.delay(2.18, function() -- Line: 1861
            -- upvalues: u128 (copy), u130 (copy), u131 (copy), u129 (copy)
            shared.vfx.emit(u128.vfx2);
            shared.vfx.emit(u130.KJHIT);
            shared.vfx.emit(u131.KJHIT);
            shared.vfx.emit(u129);
        end));
        u125:Add(task.delay(4, function() -- Line: 1870
            -- upvalues: u125 (copy)
            u125:Destroy();
        end));
    end,

    KJRare = function(p134) -- Line: 1875, Name: KJRare
        -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), SoundService (copy), mainreplication (copy)
        local KJ = vfxUtil.getResources():WaitForChild("KJ");
        local u135 = trove.new();
        u135:AttachToInstance(p134);
        local v136 = KJ["Important Matters"];
        local Root = vfxUtil.getRoot(p134);
        soundUtil:play(v136.kayjayrare, SoundService);
        local _, u137 = mainreplication.cutsceneCamRigWithLetterBox(Root, v136.Shhhhh_Camera, v136.FOV, nil, CFrame.new(0, -3, 0) * CFrame.fromEulerAnglesYXZ(0, 3.141592653589793, 0));
        u135:Add(task.delay(5.83, function() -- Line: 1887
            -- upvalues: u135 (copy), u137 (copy)
            u135:Destroy();

            if u137 then
                u137();
            end;
        end));
    end,

    KJStoicBomb = function(p138) -- Line: 1895, Name: KJStoicBomb
        -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), SoundService (copy), mainreplication (copy), Lighting (copy), RunService (copy), LocalPlayer (copy), MoonPropertyAnimator (copy)
        local KJ = vfxUtil.getResources():WaitForChild("KJ");
        local u139 = trove.new();
        u139:AttachToInstance(p138);
        local v140 = KJ["Stoic Bomb"];
        local Root = vfxUtil.getRoot(p138);
        local Ball = p138:WaitForChild("Ball");
        local Compile = require(v140.Compile);
        local v141 = u139:Construct(v140.Effects);
        vfxUtil.setupAura(p138, v141, true);
        v141.Parent = workspace.Effects;
        soundUtil:play(v140.Usage, SoundService);
        mainreplication.sceneEnabled(true);
        local u142 = {};
        u139:Add(function() -- Line: 1918
            -- upvalues: mainreplication (ref), u142 (copy), Lighting (ref)
            mainreplication.sceneEnabled(false);

            for _, v in u142 do
                pcall(function() -- Line: 1921
                    -- upvalues: v (copy), Lighting (ref)
                    v.Parent = Lighting;
                end);
            end;
        end);
        local v143 = {};

        for _, child in Lighting:GetChildren() do
            print(v140.Lighting:FindFirstChildWhichIsA(child.ClassName));

            if v140.Lighting:FindFirstChildWhichIsA(child.ClassName) then
                table.insert(u142, child);
                child.Parent = workspace;
            end;
        end;

        for _, child in v140.Lighting:GetChildren() do
            local v144 = u139:Clone(child);
            v144.Parent = Lighting;
            v143[v144.Name] = v144;
            print(v144.Name, v144);
        end;

        for _, child in v140.Ball:GetChildren() do
            u139:Clone(child).Parent = Ball;
        end;

        u139:Add(vfxUtil.highlight(Ball, {
            Name = "Highlight",
            Enabled = false,
            FillTransparency = 0,
            OutlineTransparency = 1,
            DepthMode = Enum.HighlightDepthMode.Occluded,
            FillColor = Color3.new(1, 0.466666698, 0),
            OutlineColor = Color3.new(1, 1, 1)
        }));
        local u145 = u139:Clone(v140.ballui);
        u145.ViewportFrame.CurrentCamera = workspace.CurrentCamera;
        u139:Add(RunService.PreRender:Connect(function() -- Line: 1959
            -- upvalues: Ball (copy), u145 (copy)
            if Ball and (u145 and (u145:FindFirstChild("ViewportFrame") and u145.ViewportFrame:FindFirstChild("dummy_ball"))) then
                u145.ViewportFrame.dummy_ball.CFrame = Ball.CFrame;
            end;
        end));
        u145.Parent = LocalPlayer.PlayerGui;
        local u146 = u139:Clone(v140.kj);
        u146.Parent = workspace.Effects;

        for _, v in ipairs(Compile) do
            u139:Add(task.delay(v[1] / 60, v[2], u146, v141, Ball, u145));
        end;

        u139:Add(RunService.RenderStepped:Connect(function() -- Line: 1974
            -- upvalues: u146 (copy), Root (copy)
            u146:PivotTo(CFrame.new(Root.Position, Root.Position + Vector3.new(Root.CFrame.LookVector.X, 0, Root.CFrame.LookVector.Z)));
        end));
        u139:Add((mainreplication.kuronaCam(Root, nil, v140.FOV)));
        u139:Add(task.delay(3.1, function() -- Line: 1981
            -- upvalues: u139 (copy)
            u139:Destroy();
        end));
        local v147 = u139:Construct(MoonPropertyAnimator);
        v147:LoadSave(v140.Moon, MoonPropertyAnimator.ConvertSave(v140.Moon, {
            ColorCorrection = v143.ColorCorrection
        }));
        v147:PlayAll();
    end,

    KJHandball = function(p148) -- Line: 1992, Name: KJHandball
        -- upvalues: vfxUtil (copy), trove (copy), mainreplication (copy)
        local KJ = vfxUtil.getResources():WaitForChild("KJ");
        local v149 = trove.new();
        v149:AttachToInstance(p148);
        local Pass = KJ.Pass;
        local Root = vfxUtil.getRoot(p148);
        mainreplication.cameraShake(25, 0.8, 7);
        local v150 = v149:Clone(Pass.Blast);
        v150.CFrame = CFrame.new(Root.Position, Root.Position + Vector3.new(Root.CFrame.LookVector.X, 0, Root.CFrame.LookVector.Z)) * CFrame.new(0, 2.4, 15 - v150.Size.Z);
        shared.vfx.emit(v150);
        v149:Add(task.delay(3, v149.Destroy, v149));
        mainreplication.fov(false, 50, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end,

    KJHandballShotCounter = function(p151, p152) -- Line: 2014, Name: KJHandballShotCounter
        -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy)
        local v153 = vfxUtil.getResources():WaitForChild("KJ")["Shot Counter"];
        local v154 = vfxUtil.character_trove(p151);
        local Root = vfxUtil.getRoot(p151);

        if not Root then
            return;
        end;

        mainreplication.sceneEnabled(true);
        v154:Add(function() -- Line: 2026
            -- upvalues: mainreplication (ref), vfxUtil (ref)
            mainreplication.sceneEnabled(false);
            vfxUtil.restore_lighting();
        end);
        local v155 = vfxUtil.build_highlights(v154:Clone(v153.VFX), v154, "_KJHighlightProperties");
        v155:PivotTo(Root.CFrame);
        v155.Parent = workspace.Effects;
        local v156 = vfxUtil.build_highlights(v154:Clone(v153.KJHighlight), v154, "_KJHighlightProperties");
        v156.Parent = p151;
        vfxUtil.build_highlights(v154:Clone(v153.VictimHighlight), v154, "_KJHighlightProperties").Parent = p152;
        v154:Add((vfxUtil.buildFromRig(p151, v153.Aura)));
        local _, v157 = mainreplication.cutsceneCamRigWithLetterBox(Root, v153.Animations.Camera, v153.FOV, nil, nil, v153.CamRig, "Camera");
        v154:Add(v157);
        soundUtil:play(v153.SFX, "default");
        vfxUtil.contain_lighting(v154, {}, v153.Lighting);
        vfxUtil.execute_compiled(v153.Compiled, v154, p151, v155, game.Lighting, p152, v156);
        v154:Add(task.delay(6.19, v154.Destroy, v154));
    end,

    KJSignatureDribble = function(p158) -- Line: 2061, Name: KJSignatureDribble
        -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), RunService (copy), mainreplication (copy)
        local KJ = vfxUtil.getResources():WaitForChild("KJ");
        local u159 = trove.new();
        u159:AttachToInstance(p158);
        local v160 = KJ["Signature Dribble"];
        local Root = vfxUtil.getRoot(p158);
        local u161 = u159:Clone(v160.VFX);
        u161.Parent = workspace.Effects;
        soundUtil:play(v160.Sound, Root);
        local Compile = require(v160.Compile);
        local v162 = u159:Construct(v160.Aura);
        vfxUtil.setupAura(p158, v162, true);
        v162.Parent = workspace.Effects;

        for _, v in ipairs(Compile) do
            u159:Add(task.delay(v[1] / 60, v[2], v162, u161.mesh, u161.mesh2, u161.mesh3));
        end;

        u159:Add(RunService.RenderStepped:Connect(function() -- Line: 2084
            -- upvalues: u161 (copy), Root (copy)
            u161:PivotTo(CFrame.new(Root.Position, Root.Position + Vector3.new(Root.CFrame.LookVector.X, 0, Root.CFrame.LookVector.Z)));
        end));
        u159:Add(task.delay(5, function() -- Line: 2088
            -- upvalues: u159 (copy)
            u159:Destroy();
        end));
        u159:Add(task.spawn(function() -- Line: 2092
            -- upvalues: mainreplication (ref), Root (copy)
            mainreplication.bodyVelocity(Root, 60, 3, nil, nil, nil);
        end));
        u159:Add(task.delay(1.65, function() -- Line: 2095
            -- upvalues: mainreplication (ref), Root (copy)
            mainreplication.bodyVelocity(Root, 65, 3, nil, nil, nil);
        end));
        u159:Add(task.delay(3.3, function() -- Line: 2098
            -- upvalues: mainreplication (ref), Root (copy)
            mainreplication.bodyVelocity(Root, 140, 1.4, nil, nil, nil);
        end));
    end
};