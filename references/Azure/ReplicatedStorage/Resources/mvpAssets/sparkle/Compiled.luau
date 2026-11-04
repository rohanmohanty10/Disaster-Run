 

 

return {
    { 0, function(p1, p2, p3) -- Line: 3
            shared.vfx.emit(p2.PointLightsveryimportantbtwww.PointL1);
            shared.vfx.emit(p2.CamVFX.smth.ColorBeam);
        end },
    { 16, function(p4, p5, p6) -- Line: 9
            require(game.ReplicatedStorage.mvputils.RobbsVFXModule).Emit(p6.CameraLines);
        end },
    { 35, function(p7, p8, p9) -- Line: 18
            shared.vfx.emit(p8.Spin);

            local function toggleTrails(p10, p11) -- Line: 23
                for _, descendant in ipairs(p10:GetDescendants()) do
                    if descendant:IsA("Trail") then
                        descendant.Enabled = p11;
                    end;
                end;
            end;

            local FirePart = p7["Right Arm"]["Sparkle Gun"].FirePart;
            toggleTrails(FirePart, true);
            task.wait(0.55);
            toggleTrails(FirePart, false);
        end },
    { 39, function(p12, p13, p14) -- Line: 40
            local RunService = game:GetService("RunService");
            local TweenService = game:GetService("TweenService");
            local Spin1 = p13.Spin1;
            Spin1.Transparency = 1;
            local CFrame2 = Spin1.CFrame;
            TweenService:Create(Spin1, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 0.97
            }):Play();
            local u15 = tick();
            local u16 = 0;
            local u17 = nil;
            u17 = RunService.RenderStepped:Connect(function(p18) -- Line: 66
                -- upvalues: u15 (copy), u16 (ref), Spin1 (copy), CFrame2 (copy), u17 (ref)
                local v19 = tick() - u15;
                local math_clamp_ret = math.clamp((v19 - 0.12) / 0.25, 0, 1);
                local v20 = (math.exp(math_clamp_ret * -3) * 1200 + math_clamp_ret * 500) * p18;
                u16 = u16 + math.rad(v20);
                Spin1.CFrame = CFrame2 * CFrame.Angles(0, u16, 0);

                if v19 >= 0.37 then
                    u17:Disconnect();
                end;
            end);
            task.wait(0.12);
            TweenService:Create(Spin1, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Transparency = 1
            }):Play();
        end },
    { 55, function(p21, p22, p23) -- Line: 88
            local RunService = game:GetService("RunService");
            local TweenService = game:GetService("TweenService");
            local Spin2 = p22.Spin2;
            Spin2.Transparency = 1;
            local CFrame2 = Spin2.CFrame;
            TweenService:Create(Spin2, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 0.97
            }):Play();
            local u24 = tick();
            local u25 = 0;
            local u26 = nil;
            u26 = RunService.RenderStepped:Connect(function(p27) -- Line: 114
                -- upvalues: u24 (copy), u25 (ref), Spin2 (copy), CFrame2 (copy), u26 (ref)
                local v28 = tick() - u24;
                local math_clamp_ret = math.clamp((v28 - 0.12) / 0.25, 0, 1);
                local v29 = (math.exp(math_clamp_ret * -3) * 1200 + math_clamp_ret * 500) * p27;
                u25 = u25 + math.rad(v29);
                Spin2.CFrame = CFrame2 * CFrame.Angles(0, u25, 0);

                if v28 >= 0.37 then
                    u26:Disconnect();
                end;
            end);
            task.wait(0.12);
            TweenService:Create(Spin2, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Transparency = 1
            }):Play();
        end },
    { 74, function(p30, p31, p32) -- Line: 136
            require(game.ReplicatedStorage.mvputils.RobbsVFXModule).Emit(p30["Right Arm"]["Sparkle Gun"].FirePart.Shine);
        end },
    { 110, function(p33, p34, p35) -- Line: 145
            require(game.ReplicatedStorage.mvputils.RobbsVFXModule).Emit(p33["Right Arm"]["Sparkle Gun"].FirePart.Fire);
        end },
    { 209, function(p36, p37, p38) -- Line: 154
            require(game.ReplicatedStorage.mvputils.RobbsVFXModule).EnableParticles(p37.SpeedLines, {
                Duration = 0.35
            });
        end },
    { 229, function(p39, p40, p41) -- Line: 165
            require(game.ReplicatedStorage.mvputils.RobbsVFXModule).EnableParticles(p40.SpeedLines2, {
                Duration = 0.1
            });
        end },
    { 230, function(p42, p43, p44) -- Line: 176
            local function v47(p45, p46) -- Line: 180
                for _, descendant in ipairs(p45:GetDescendants()) do
                    if descendant:IsA("Trail") then
                        descendant.Enabled = p46;
                    end;
                end;
            end;

            local Head = p42.Head;
            v47(Head, true);
            task.wait(1.5);
            v47(Head, false);
        end },
    { 239, function(p48, p49, p50) -- Line: 197
            shared.vfx.emit(p49.beamslash);
            local RunService = game:GetService("RunService");
            local TweenService = game:GetService("TweenService");
            local Spin3 = p49.Spin3;
            Spin3.Transparency = 1;
            local CFrame2 = Spin3.CFrame;
            TweenService:Create(Spin3, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 0.97
            }):Play();
            local u51 = tick();
            local u52 = 0;
            local u53 = nil;
            u53 = RunService.RenderStepped:Connect(function(p54) -- Line: 224
                -- upvalues: u51 (copy), u52 (ref), Spin3 (copy), CFrame2 (copy), u53 (ref)
                local v55 = tick() - u51;
                local math_clamp_ret = math.clamp((v55 - 0.12) / 0.25, 0, 1);
                local v56 = (math.exp(math_clamp_ret * -3) * 1200 + math_clamp_ret * 500) * p54;
                u52 = u52 + math.rad(v56);
                Spin3.CFrame = CFrame2 * CFrame.Angles(0, u52, 0);

                if v55 >= 0.37 then
                    u53:Disconnect();
                end;
            end);
            task.wait(0.12);
            TweenService:Create(Spin3, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Transparency = 1
            }):Play();
        end },
    { 252, function(p57, p58, p59) -- Line: 246
            shared.vfx.emit(p58.PointLightsveryimportantbtwww.PointL2);
            shared.vfx.emit(p58.CamVFX.smth.ColorBeam2);
            require(game.ReplicatedStorage.mvputils.RobbsVFXModule).Emit(p59.CameraLines);
        end },
    { 275, function(p60, p61, p62) -- Line: 257
            require(game.ReplicatedStorage.mvputils.RobbsVFXModule).Emit(p60["Right Arm"]["Sparkle Gun"].FirePart);
        end },
    { 294, function(p63, p64, p65) -- Line: 266
            require(game.ReplicatedStorage.mvputils.RobbsVFXModule).EnableParticles(p64.SpeedLines4, {
                Duration = 0.35
            });
        end },
    { 317, function(p66, p67, p68) -- Line: 277
            require(game.ReplicatedStorage.mvputils.RobbsVFXModule).Emit(p68.CameraLines);
        end },
    { 318, function(p69, p70, p71) -- Line: 286
            shared.vfx.emit(p70.PointLightsveryimportantbtwww.PointL3);
            shared.vfx.emit(p70.CamVFX.smth.ColorBeam3);
            require(game.ReplicatedStorage.mvputils.RobbsVFXModule).EnableParticles(p70.SpeedLines3, {
                Duration = 0.1
            });
        end },
    { 319, function(p72, p73, p74) -- Line: 299
            local RunService = game:GetService("RunService");
            local TweenService = game:GetService("TweenService");
            local Spin5 = p73.Spin5;
            Spin5.Transparency = 1;
            local CFrame2 = Spin5.CFrame;
            TweenService:Create(Spin5, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 0.95
            }):Play();
            local u75 = tick();
            local u76 = 0;
            local u77 = nil;
            u77 = RunService.RenderStepped:Connect(function(p78) -- Line: 325
                -- upvalues: u75 (copy), u76 (ref), Spin5 (copy), CFrame2 (copy), u77 (ref)
                local v79 = tick() - u75;
                local math_clamp_ret = math.clamp((v79 - 0.12) / 0.25, 0, 1);
                local v80 = (math.exp(math_clamp_ret * -3) * 1200 + math_clamp_ret * 500) * p78;
                u76 = u76 + math.rad(v80);
                Spin5.CFrame = CFrame2 * CFrame.Angles(0, u76, 0);

                if v79 >= 0.37 then
                    u77:Disconnect();
                end;
            end);
            task.wait(0.12);
            TweenService:Create(Spin5, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Transparency = 1
            }):Play();
        end },
    { 327, function(p81, p82, p83) -- Line: 347
            shared.vfx.emit(p82.SmokeGround);
        end },
    { 384, function(p84, p85, p86) -- Line: 352
            local function v89(p87, p88) -- Line: 356
                for _, descendant in ipairs(p87:GetDescendants()) do
                    if descendant:IsA("Trail") then
                        descendant.Enabled = p88;
                    end;
                end;
            end;

            local Head = p84.Head;
            v89(Head, true);
            task.wait(1);
            v89(Head, false);
        end },
    { 385, function(p90, p91, p92) -- Line: 373
            local RunService = game:GetService("RunService");
            local TweenService = game:GetService("TweenService");
            local Spin4 = p91.Spin4;
            Spin4.Transparency = 1;
            local CFrame2 = Spin4.CFrame;
            TweenService:Create(Spin4, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 0.97
            }):Play();
            local u93 = tick();
            local u94 = 0;
            local u95 = nil;
            u95 = RunService.RenderStepped:Connect(function(p96) -- Line: 399
                -- upvalues: u93 (copy), u94 (ref), Spin4 (copy), CFrame2 (copy), u95 (ref)
                local v97 = tick() - u93;
                local math_clamp_ret = math.clamp((v97 - 0.12) / 0.7, 0, 1);
                local v98 = (math.exp(math_clamp_ret * -3) * -1200 + math_clamp_ret * -700) * p96;
                u94 = u94 + math.rad(v98);
                Spin4.CFrame = CFrame2 * CFrame.Angles(0, u94, 0);

                if v97 >= 0.82 then
                    u95:Disconnect();
                end;
            end);
            task.wait(0.12);
            TweenService:Create(Spin4, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Transparency = 1
            }):Play();
        end },
    { 417, function(p99, p100, p101) -- Line: 421
            shared.vfx.emit(p100.SlashTrail1);
            require(game.ReplicatedStorage.mvputils.RobbsVFXModule).Emit(p100.KickSwing);
        end },
    { 418, function(p102, p103, p104) -- Line: 431
            local RunService = game:GetService("RunService");
            local TweenService = game:GetService("TweenService");
            local Spin4 = p103.Spin4;
            Spin4.Transparency = 1;
            local CFrame2 = Spin4.CFrame;
            TweenService:Create(Spin4, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 0.97
            }):Play();
            local u105 = tick();
            local u106 = 0;
            local u107 = nil;
            u107 = RunService.RenderStepped:Connect(function(p108) -- Line: 457
                -- upvalues: u105 (copy), u106 (ref), Spin4 (copy), CFrame2 (copy), u107 (ref)
                local v109 = tick() - u105;
                local math_clamp_ret = math.clamp((v109 - 0.12) / 0.4, 0, 1);
                local v110 = (math.exp(math_clamp_ret * -3) * -1500 + math_clamp_ret * -500) * p108;
                u106 = u106 + math.rad(v110);
                Spin4.CFrame = CFrame2 * CFrame.Angles(0, u106, 0);

                if v109 >= 0.52 then
                    u107:Disconnect();
                end;
            end);
            task.wait(0.12);
            TweenService:Create(Spin4, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Transparency = 1
            }):Play();
        end },
    { 461, function(p111, p112, p113) -- Line: 479
            shared.vfx.emit(p112.PointLightsveryimportantbtwww.PointL4);
            shared.vfx.emit(p112.SlashTrail);
            shared.vfx.emit(p112.wheelthing);
            shared.vfx.emit(p112.CamVFX.smth["ColorBeam3.5"]);
            require(game.ReplicatedStorage.mvputils.RobbsVFXModule).Emit(p113.CameraLines);
        end },
    { 587, function(p114, p115, p116) -- Line: 492
            require(game.ReplicatedStorage.mvputils.RobbsVFXModule).Emit(p116.CameraLines);
        end },
    { 588, function(p117, p118, p119) -- Line: 501
            shared.vfx.emit(p118.CamVFX.smth.ColorBeam4);
            shared.vfx.emit(p118.PointLightsveryimportantbtwww.PointL5);
            shared.vfx.emit(p118.Smoke);
            shared.vfx.emit(p118.wheelthing2);
            local PointLight = p118:WaitForChild("Light"):WaitForChild("PointLight");
            local Color3_fromRGB_ret = Color3.fromRGB(255, 57, 67);
            local Color3_fromRGB_ret2 = Color3.fromRGB(255, 114, 140);
            local Color3_fromRGB_ret3 = Color3.fromRGB(134, 235, 255);
            local u120 = {};

            local function findScreens(p121) -- Line: 522
                -- upvalues: PointLight (copy), u120 (copy), findScreens (copy)
                for _, child in ipairs(p121:GetChildren()) do
                    if child:IsA("BasePart") and child.Name == "Screen" then
                        local ScreenDecal = child:FindFirstChild("ScreenDecal");

                        if ScreenDecal and ScreenDecal:IsA("Decal") then
                            local PointLight2 = child:FindFirstChild("PointLight");

                            if not PointLight2 then
                                PointLight2 = PointLight:Clone();
                                PointLight2.Parent = child;
                            end;

                            table.insert(u120, {
                                Part = child,
                                Decal = ScreenDecal,
                                Light = PointLight2
                            });
                        end;
                    end;

                    findScreens(child);
                end;
            end;

            repeat
                table.clear(u120);
                findScreens(p118);
                task.wait(0.1);
            until #u120 > 0;

            local function setScreens(p122, p123) -- Line: 553
                -- upvalues: u120 (copy)
                for _, v in ipairs(u120) do
                    v.Part.Color = p123;
                    v.Decal.Texture = p122;
                    v.Light.Color = p123;
                end;
            end;

            (function() -- Line: 561, Name: powerOn
                -- upvalues: u120 (copy)
                for _, v in ipairs(u120) do
                    v.Decal.Texture = "";
                    v.Part.Material = Enum.Material.Neon;
                    v.Part.Color = Color3.new(1, 1, 1);
                    v.Light.Color = Color3.new(1, 1, 1);
                end;

                task.wait(0.04);

                for _, v in ipairs(u120) do
                    v.Part.Color = Color3.new(0, 0, 0);
                    v.Light.Color = Color3.new(0, 0, 0);
                end;

                task.wait(0.02);
            end)();
            local v124 = tick();

            local function powerOff() -- Line: 579
                -- upvalues: u120 (copy)
                for _, v in ipairs(u120) do
                    v.Decal.Texture = "";
                    v.Part.Color = Color3.new(1, 1, 1);
                    v.Light.Color = Color3.new(1, 1, 1);
                end;

                task.wait(0.04);

                for _, v in ipairs(u120) do
                    v.Part.Material = Enum.Material.SmoothPlastic;
                    v.Part.Color = Color3.new(0, 0, 0);
                    v.Decal.Texture = "";

                    if v.Light then
                        v.Light:Destroy();
                        v.Light = nil;
                    end;
                end;
            end;

            while tick() - v124 < 9 do
                local v125 = tick();

                while tick() - v125 < 3 and tick() - v124 < 9 do
                    for _, v in ipairs(u120) do
                        v.Part.Color = Color3_fromRGB_ret;
                        v.Decal.Texture = "rbxassetid://116960549599152";
                        v.Light.Color = Color3_fromRGB_ret;
                    end;

                    task.wait(0.2);

                    if tick() - v124 >= 9 then
                        break;
                    end;

                    for _, v in ipairs(u120) do
                        v.Part.Color = Color3_fromRGB_ret;
                        v.Decal.Texture = "rbxassetid://77795994507375";
                        v.Light.Color = Color3_fromRGB_ret;
                    end;

                    task.wait(0.2);
                end;

                if tick() - v124 >= 9 then
                    break;
                end;

                local v126 = tick();
                local v127 = false;

                while tick() - v126 < 0.2 and tick() - v124 < 9 do
                    if v127 then
                        for _, v in ipairs(u120) do
                            v.Part.Color = Color3_fromRGB_ret2;
                            v.Decal.Texture = "rbxassetid://120293980239489";
                            v.Light.Color = Color3_fromRGB_ret2;
                        end;
                    else
                        for _, v in ipairs(u120) do
                            v.Part.Color = Color3_fromRGB_ret3;
                            v.Decal.Texture = "rbxassetid://79553691209846";
                            v.Light.Color = Color3_fromRGB_ret3;
                        end;
                    end;

                    task.wait(0.05);
                    v127 = not v127;
                end;
            end;

            powerOff();
        end },
    { 804, function(p128, p129, p130) -- Line: 642
            shared.vfx.emit(p129.PointLightsveryimportantbtwww.PointL6);
            require(game.ReplicatedStorage.mvputils.RobbsVFXModule).Emit(p130.CameraLines);
        end },
    { 918, function(p131, p132, p133) -- Line: 652
            require(game.ReplicatedStorage.mvputils.RobbsVFXModule).Emit(p131["Right Arm"]["Sparkle Gun"].FirePart);
        end }
};