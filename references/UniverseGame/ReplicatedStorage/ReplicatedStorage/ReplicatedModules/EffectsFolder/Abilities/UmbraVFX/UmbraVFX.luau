  

 

return {
    Init = function(p1) -- Line: 2, Name: Init
        local Cache = p1.Cache;
        local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
        local PathShortcuts = require(ReplicatedModules.PathShortcuts);
        local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
        local Sequence_V2 = require(ReplicatedModules.Classes.Sequence_V2);
        require(PathShortcuts.KnitPath.TableUtil);
        require(PathShortcuts.KnitPath.Trove);
        local AnimationHandler = require(ReplicatedModules.AnimationHandler);
        local PaleVisual_Rewrite = require(script.PaleVisual_Rewrite);
        local TweenService = game:GetService("TweenService");
        local RunService = game:GetService("RunService");
        local Umbra = PathShortcuts.ClientAssets.Assets.Abilities.Umbra;
        local Afterimage = Umbra.Afterimage;
        local UmbraAwakenHighlight = Umbra:WaitForChild("AwakenEffects"):WaitForChild("UmbraAwakenHighlight");

        if game:GetService("RunService"):IsClient() then
            UmbraAwakenHighlight.Parent = nil;
        end;

        local BladeHighlight = Umbra:WaitForChild("ThreefoldSlice"):WaitForChild("BladeHighlight");

        if game:GetService("RunService"):IsClient() then
            BladeHighlight.Parent = nil;
        end;

        local function GetCloneColor(p2, p3) -- Line: 36
            -- upvalues: ParticleHandler (copy)
            local v4 = p3 or {};
            local v5 = Color3.fromRGB(255, 135, 255);

            if p2 == "Hyde" then
                v5 = Color3.fromRGB(255, 0, 0);
            elseif p2 == "Bladed Sapphire" then
                v5 = Color3.fromRGB(85, 255, 255);
            end;

            local HSVShift = v4.HSVShift;

            if HSVShift then
                v5 = ParticleHandler.HSVShiftColor(v5, HSVShift);
            end;

            return v5;
        end;

        local function CreateAfterimage(u6, p7) -- Line: 83
            -- upvalues: Afterimage (copy), TweenService (copy), RunService (copy), PathShortcuts (copy)
            if type(p7) == "table" then
                local HumanoidRootPart = u6.HumanoidRootPart;
                local v8 = p7.TweenData or {};
                local v9 = p7.Properties or {};
                local Start = v8.Start;
                local End = v8.End;
                local Start2 = v9.Start;
                local End2 = v9.End;
                local u10;

                if Start then
                    u10 = TweenInfo.new(unpack(Start));
                else
                    u10 = Start;
                end;

                local u11;

                if End then
                    u11 = TweenInfo.new(unpack(End));
                else
                    u11 = End;
                end;

                local v12 = {};

                for _, descendant in u6:GetDescendants() do
                    if descendant:IsA("Motor6D") then
                        v12[descendant.Name] = descendant;
                    end;
                end;

                local u13 = Afterimage:Clone();

                if p7.Sword ~= false then
                    local v14 = (u6:FindFirstChild("Stand") or u6:FindFirstChild("Umbra")):Clone();
                    local v15 = { "ParticleEmitter", "Beam", "Trail" };

                    for _, descendant in v14:GetDescendants() do
                        if p7.VFX == false and table.find(v15, descendant.ClassName) then
                            descendant:Destroy();
                        elseif descendant:IsA("BasePart") then
                            descendant:SetAttribute("ColorLocked", true);
                        elseif descendant:IsA("Motor6D") then
                            descendant:Destroy();
                        end;
                    end;

                    v14.Parent = u13;
                    local v16 = CFrame.new(0, -1, 0) * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966);
                    local Motor6D = Instance.new("Motor6D");
                    Motor6D.Name = "SwordHandle";
                    Motor6D.C0 = v16;
                    Motor6D.Part0 = u13["Right Arm"];
                    Motor6D.Part1 = v14.SwordHandle;
                    Motor6D.Parent = u13["Right Arm"];
                end;

                u13.HumanoidRootPart.Anchored = true;
                u13.HumanoidRootPart.CFrame = p7.Origin or HumanoidRootPart.CFrame;

                local function TweenPart(p17) -- Line: 134
                    -- upvalues: Start2 (copy), End2 (copy), Start (copy), TweenService (ref), u10 (copy), End (copy), u11 (copy)
                    local v18 = Start2 or {};
                    local v19 = End2 or {};

                    if p17:GetAttribute("ColorLocked") then
                        v18 = table.clone(v18);
                        v18.Color = nil;
                        v19 = table.clone(v19);
                        v19.Color = nil;
                    end;

                    if Start then
                        local v20, v21 = TweenService:Create(p17, u10, v18);
                        v20:Play();
                        v20.Completed:Wait();

                        if v21 then
                            v21:Destroy();
                        end;
                    else
                        for i, v in v18 do
                            p17[i] = v;
                        end;
                    end;

                    if End then
                        local v22, v23 = TweenService:Create(p17, u11, v19);
                        v22:Play();
                        v22.Completed:Wait();

                        if v23 then
                            v23:Destroy();
                        end;
                    end;
                end;

                for _, descendant in u13:GetDescendants() do
                    if descendant:IsA("Motor6D") and v12[descendant.Name] then
                        descendant.Transform = v12[descendant.Name].Transform;
                    elseif descendant:IsA("BasePart") and descendant ~= u13.HumanoidRootPart then
                        task.spawn(TweenPart, descendant);
                    end;
                end;

                RunService.PreSimulation:Once(function() -- Line: 167
                    -- upvalues: u13 (copy), u6 (copy), PathShortcuts (ref)
                    u13.Parent = workspace.Effects;

                    if u6:GetAttribute("ChromaUnusual") then
                        PathShortcuts.Remotes.ClientBind:Fire(u6, "Chroma", u13);
                    end;
                end);

                return u13;
            end;
        end;

        function Cache.ClearCloudsTarget(p24) -- Line: 177
            -- upvalues: GetCloneColor (copy), Umbra (copy), ParticleHandler (copy), CreateAfterimage (copy)
            local HSVShift = p24.HSVShift;
            local Attacker = p24.Attacker;
            local Target = p24.Target;
            local v25 = Random.new();
            local HumanoidRootPart = Attacker.HumanoidRootPart;
            local _ = HumanoidRootPart.CFrame;
            local v26 = {
                Sword = false,
                TweenData = {
                    End = { 0.5, Enum.EasingStyle.Sine }
                },
                Properties = {
                    Start = {
                        Transparency = 0.75,
                        Color = GetCloneColor(p24.Skin, {
                            HSVShift = p24.HSVShift
                        })
                    },
                    End = {
                        Transparency = 1
                    }
                }
            };
            local v27 = Umbra.ClearClouds.Tp:Clone();

            if HSVShift then
                ParticleHandler.HSVShiftParticles(v27, HSVShift);
            end;

            local v28 = v25:NextInteger(0, 10) * 6.283185307179586 / 10;
            local v29 = math.cos(v28) * v25:NextNumber(8, 15);
            local v30 = math.sin(v28) * v25:NextNumber(8, 15);
            local HumanoidRootPart2 = Target:FindFirstChild("HumanoidRootPart");

            if not HumanoidRootPart2 then
                return;
            end;

            local v31 = HumanoidRootPart2.CFrame * CFrame.new(v29, 0, v30);
            local v32 = HumanoidRootPart2.CFrame * CFrame.new(-v29, 0, -v30);
            v27.CFrame = CFrame.lookAt(v31.Position, HumanoidRootPart2.Position);
            v27.Parent = workspace.Effects;
            ParticleHandler.EmitFromAttribute(v27);
            HumanoidRootPart.CFrame = v31;

            for i = 1, 5 do
                HumanoidRootPart.CFrame = v31:Lerp(v32, i / 5);
                local v33 = CreateAfterimage(Attacker, v26);
                task.delay(0.5, v33.Destroy, v33);
                task.wait();
            end;

            v27.CFrame = CFrame.lookAt(v32.Position, Target.HumanoidRootPart.Position);
            ParticleHandler.EmitFromAttribute(v27);
            ParticleHandler.DestroyByMaxLifetime(v27);
            v26.Ended = true;
        end;

        function Cache.ClearCloudsBeforeHit(p34) -- Line: 245
            -- upvalues: Umbra (copy), ParticleHandler (copy)
            local HSVShift = p34.HSVShift;
            local _ = p34.Attacker;
            local BeforeHit = Umbra.ClearClouds.BeforeHit;
            local u35 = {};

            for _, v in p34.Characters do
                local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");

                if HumanoidRootPart then
                    local v36 = BeforeHit:Clone();
                    v36.CFrame = HumanoidRootPart.CFrame;

                    if HSVShift then
                        ParticleHandler.HSVShiftParticles(v36, HSVShift);
                    end;

                    v36.Parent = workspace.Effects;
                    ParticleHandler.EnableParticles(v36, true);
                    table.insert(u35, v36);
                end;
            end;

            task.delay(p34.DestroyFrame / 60, function() -- Line: 269
                -- upvalues: u35 (copy), ParticleHandler (ref)
                for _, v in u35 do
                    pcall(ParticleHandler.EnableParticles, v, false);
                    pcall(ParticleHandler.DestroyByMaxLifetime, v);
                end;

                table.clear(u35);
            end);
        end;

        function Cache.UmbraEmptyMistAfterimage(p37) -- Line: 278
            -- upvalues: GetCloneColor (copy), CreateAfterimage (copy)
            local Attacker = p37.Attacker;
            local HumanoidRootPart = Attacker.HumanoidRootPart;
            local v38 = Random.new();
            local v39 = {
                TweenData = {
                    End = { 0.5 }
                },
                Properties = {
                    Start = {
                        Transparency = 0.25,
                        Color = GetCloneColor(p37.Skin, {
                            HSVShift = p37.HSVShift
                        })
                    },
                    End = {
                        Transparency = 1
                    }
                }
            };

            while Attacker:GetAttribute("EmptyMist") and Attacker.Parent do
                local v40 = v38:NextNumber(5, 20);
                local v41 = v38:NextInteger(0, 5);
                local v42 = v38:NextInteger(1, 10) * 6.283185307179586 / 10;
                local v43 = math.cos(v42) * v40;
                local v44 = math.sin(v42) * v40;
                local v45 = HumanoidRootPart.CFrame * CFrame.new(v43, v41, v44);
                v39.Origin = CFrame.lookAt(HumanoidRootPart.CFrame.Position, v45.Position) * CFrame.new(0, 0, -v40);
                local v46 = CreateAfterimage(Attacker, v39);
                task.delay(0.5, v46.Destroy, v46);
                task.wait(0.05);
            end;
        end;

        function Cache.UmbraEmptyMistAfterimageFinisher(p47) -- Line: 322
            -- upvalues: GetCloneColor (copy), CreateAfterimage (copy), AnimationHandler (copy), TweenService (copy)
            local Attacker = p47.Attacker;
            local HumanoidRootPart = Attacker.HumanoidRootPart;
            local u48 = Random.new();
            local v49 = {
                TweenData = {
                    End = { 0.75 }
                },
                Properties = {
                    Start = {
                        Transparency = 0.25,
                        Color = GetCloneColor(p47.Skin, {
                            HSVShift = p47.HSVShift
                        })
                    },
                    End = {
                        Transparency = 1
                    }
                }
            };
            local u50 = { 37, 68, 135 };

            for _ = 1, 10 do
                local v51 = u48:NextNumber(5, 20);
                local v52 = u48:NextInteger(0, 5);
                local v53 = u48:NextInteger(1, 10) * 6.283185307179586 / 10;
                local v54 = math.cos(v53) * v51;
                local v55 = math.sin(v53) * v51;
                local v56 = HumanoidRootPart.CFrame * CFrame.new(v54, v52, v55);
                local v57 = CFrame.lookAt(HumanoidRootPart.CFrame.Position, v56.Position);
                v49.Origin = v57;
                local v58 = CreateAfterimage(Attacker, v49);

                if p47.FallenLeaves then
                    local AnimationController = Instance.new("AnimationController");
                    local Animator = Instance.new("Animator");
                    Animator.Parent = AnimationController;
                    AnimationController.Parent = v58;
                    Animator.AncestryChanged:Connect(function(p59, p60) -- Line: 371
                        -- upvalues: Animator (copy), AnimationHandler (ref), u50 (copy), u48 (copy)
                        if not Animator:IsDescendantOf(workspace) then
                            return;
                        end;

                        local v61 = AnimationHandler.CreateAnimations("Umbra");
                        local v62 = AnimationHandler.new(Animator);
                        v62:AddAnimations(v61);
                        local v63 = v62:PlayAnimation("Helix");
                        v63:AdjustSpeed(0);
                        v63.TimePosition = u50[u48:NextInteger(1, #u50)] / 60;
                    end);
                end;

                TweenService:Create(v58.HumanoidRootPart, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    CFrame = v57 * CFrame.new(0, 0, -v51)
                }):Play();
                task.delay(0.75, v58.Destroy, v58);
            end;
        end;

        function Cache.UmbraUltVFX(p64) -- Line: 387
            -- upvalues: Umbra (copy), ParticleHandler (copy), TweenService (copy), GetCloneColor (copy), CreateAfterimage (copy), Sequence_V2 (copy)
            local u65 = p64.HSVShift or {};
            local Skin = p64.Skin;
            local Attacker = p64.Attacker;
            local HumanoidRootPart = Attacker.HumanoidRootPart;
            local Torso = Attacker.Torso;
            local Target = p64.Target;
            local _ = Target.HumanoidRootPart;
            local _ = Target.Torso;
            local UltimateEffects = Umbra.UltimateEffects;

            local function EmitParticle(p66, p67) -- Line: 400
                -- upvalues: HumanoidRootPart (copy), ParticleHandler (ref)
                p66.Anchored = true;
                p66.CFrame = (p67 or HumanoidRootPart).CFrame;
                p66.Parent = workspace.Effects;
                ParticleHandler.EmitFromAttribute(p66);

                return p66;
            end;

            Sequence_V2.CreateFromOldSequence({
                Frames = {
                    { 0, function(p68, p69, p70) -- Line: 409
                            -- upvalues: ParticleHandler (ref), u65 (copy), HumanoidRootPart (copy)
                            for _, v in p70 do
                                ParticleHandler.HSVShiftParticles(v, u65);
                            end;

                            local TimeScaleHit = p70.TimeScaleHit;
                            TimeScaleHit.Anchored = true;
                            TimeScaleHit.CFrame = HumanoidRootPart.CFrame;
                            TimeScaleHit.Parent = workspace.Effects;
                            ParticleHandler.EmitFromAttribute(TimeScaleHit);
                            task.delay(0.05, function() -- Line: 416
                                -- upvalues: TimeScaleHit (copy)
                                for _, descendant in TimeScaleHit:GetDescendants() do
                                    if descendant:IsA("ParticleEmitter") then
                                        descendant.TimeScale = 0.05;
                                        task.delay(0.8, function() -- Line: 420
                                            -- upvalues: descendant (copy)
                                            descendant.TimeScale = 1;
                                        end);
                                    end;
                                end;
                            end);
                        end },
                    { 54, function(p71, p72, p73) -- Line: 425
                            -- upvalues: HumanoidRootPart (copy), ParticleHandler (ref)
                            local KickVFX = p73.KickVFX;
                            KickVFX.Anchored = true;
                            KickVFX.CFrame = HumanoidRootPart.CFrame;
                            KickVFX.Parent = workspace.Effects;
                            ParticleHandler.EmitFromAttribute(KickVFX);
                        end },
                    { 169, function(p74, p75, p76) -- Line: 429
                            -- upvalues: HumanoidRootPart (copy), ParticleHandler (ref)
                            local SwordThrowVFX = p76.SwordThrowVFX;
                            SwordThrowVFX.Anchored = true;
                            SwordThrowVFX.CFrame = HumanoidRootPart.CFrame;
                            SwordThrowVFX.Parent = workspace.Effects;
                            ParticleHandler.EmitFromAttribute(SwordThrowVFX);
                            task.delay(0.05, function() -- Line: 431
                                -- upvalues: SwordThrowVFX (copy)
                                for _, descendant in SwordThrowVFX:GetDescendants() do
                                    if descendant:IsA("ParticleEmitter") then
                                        descendant.TimeScale = 0.1;
                                        task.delay(1.3, function() -- Line: 435
                                            -- upvalues: descendant (copy)
                                            descendant.TimeScale = 1;
                                        end);
                                    end;
                                end;
                            end);
                        end },
                    { 258, function(p77, p78, p79) -- Line: 440
                            -- upvalues: HumanoidRootPart (copy), ParticleHandler (ref)
                            local ImpaleVFX = p79.ImpaleVFX;
                            ImpaleVFX.Anchored = true;
                            ImpaleVFX.CFrame = HumanoidRootPart.CFrame;
                            ImpaleVFX.Parent = workspace.Effects;
                            ParticleHandler.EmitFromAttribute(ImpaleVFX);
                        end },
                    { 376, function(p80, p81, p82) -- Line: 444
                            -- upvalues: HumanoidRootPart (copy), ParticleHandler (ref)
                            local PullVFX = p82.PullVFX;
                            PullVFX.Anchored = true;
                            PullVFX.CFrame = HumanoidRootPart.CFrame;
                            PullVFX.Parent = workspace.Effects;
                            ParticleHandler.EmitFromAttribute(PullVFX);
                        end },
                    { 433, function(p83, p84, u85) -- Line: 448
                            -- upvalues: ParticleHandler (ref), HumanoidRootPart (copy), Torso (copy), TweenService (ref)
                            u85.Barrage1.Anchored = false;
                            ParticleHandler.AttachParticle(u85.Barrage1, HumanoidRootPart);
                            u85.Barrage1.Parent = workspace.Effects;
                            ParticleHandler.EnableParticles(u85.Barrage1, true);
                            task.delay(1, function() -- Line: 454
                                -- upvalues: ParticleHandler (ref), u85 (copy)
                                ParticleHandler.EnableParticles(u85.Barrage1, false);
                            end);
                            local v86 = os.clock();

                            while true do
                                local v87 = u85.BarrageBeams.Slashbeam:Clone();
                                v87.CFrame = Torso.CFrame * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
                                v87.Parent = workspace.Effects;

                                for _, descendant in v87:GetDescendants() do
                                    if descendant:IsA("Beam") then
                                        descendant.Enabled = true;
                                        task.delay(0.3, function() -- Line: 466
                                            -- upvalues: descendant (copy)
                                            descendant.Enabled = false;
                                        end);
                                        TweenService:Create(descendant, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                            TextureSpeed = 0,
                                            Width1 = 0,
                                            Width0 = 0
                                        }):Play();
                                    end;
                                end;

                                TweenService:Create(v87, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    CFrame = v87.CFrame * CFrame.Angles(0, -10, 0)
                                }):Play();
                                task.delay(1, v87.Destroy, v87);
                                task.wait(0.01);

                                if os.clock() - v86 >= 1 then
                                    return;
                                end;
                            end;
                        end },
                    { 471, function(p88, p89, p90) -- Line: 475
                            -- upvalues: GetCloneColor (ref), Skin (copy), u65 (copy), Attacker (copy), HumanoidRootPart (copy), CreateAfterimage (ref)
                            local v91 = Random.new();
                            local v92 = {
                                Sword = false,
                                TweenData = {
                                    End = { 0.5 }
                                },
                                Properties = {
                                    Start = {
                                        Transparency = 0.75,
                                        Color = GetCloneColor(Skin, {
                                            HSVShift = u65
                                        })
                                    },
                                    End = {
                                        Transparency = 1
                                    }
                                }
                            };

                            while Attacker:GetAttribute("UltimateAfterimage") and Attacker.Parent do
                                local v93 = v91:NextNumber(0, 5);
                                local v94 = v91:NextInteger(0, 5);
                                local v95 = v91:NextInteger(1, 10) * 6.283185307179586 / 10;
                                local v96 = math.cos(v95) * v93;
                                local v97 = math.sin(v95) * v93;
                                local v98 = HumanoidRootPart.CFrame * CFrame.new(v96, v94, v97);
                                CFrame.lookAt(HumanoidRootPart.CFrame.Position, v98.Position);
                                v92.Origin = HumanoidRootPart.CFrame * CFrame.new(0, 0, -v93);
                                local v99 = CreateAfterimage(Attacker, v92);
                                task.delay(0.5, v99.Destroy, v99);
                                task.wait(0.03333333333333333);
                            end;
                        end },
                    { 475, function(p100, p101, u102) -- Line: 516
                            -- upvalues: ParticleHandler (ref), HumanoidRootPart (copy), Torso (copy), TweenService (ref)
                            u102.Barrage2.Anchored = false;
                            ParticleHandler.AttachParticle(u102.Barrage2, HumanoidRootPart);
                            u102.Barrage2.Parent = workspace.Effects;
                            ParticleHandler.EnableParticles(u102.Barrage2, true);
                            task.delay(3, function() -- Line: 522
                                -- upvalues: ParticleHandler (ref), u102 (copy)
                                ParticleHandler.EnableParticles(u102.Barrage2, false);
                            end);
                            local v103 = os.clock();

                            while true do
                                local v104 = u102.BarrageBeams.Slashbeam2:Clone();
                                v104.CFrame = Torso.CFrame * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
                                v104.Parent = workspace.Effects;

                                for _, descendant in v104:GetDescendants() do
                                    if descendant:IsA("Beam") then
                                        descendant.Enabled = true;
                                        task.delay(0.3, function() -- Line: 534
                                            -- upvalues: descendant (copy)
                                            descendant.Enabled = false;
                                        end);
                                        TweenService:Create(descendant, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                            TextureSpeed = 0,
                                            Width1 = 0,
                                            Width0 = 0
                                        }):Play();
                                    end;
                                end;

                                TweenService:Create(v104, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    CFrame = v104.CFrame * CFrame.Angles(0, -10, 0)
                                }):Play();
                                task.delay(1, v104.Destroy, v104);
                                task.wait(0.01);

                                if os.clock() - v103 >= 2.5 then
                                    return;
                                end;
                            end;
                        end },
                    { 820, function(p105, p106, p107) -- Line: 543
                            -- upvalues: HumanoidRootPart (copy), ParticleHandler (ref)
                            local DashVFX = p107.DashVFX;
                            DashVFX.Anchored = true;
                            DashVFX.CFrame = HumanoidRootPart.CFrame;
                            DashVFX.Parent = workspace.Effects;
                            ParticleHandler.EmitFromAttribute(DashVFX);
                        end },
                    { 921, function(p108, p109, p110) -- Line: 547
                            -- upvalues: HumanoidRootPart (copy), ParticleHandler (ref)
                            local FinalHitVFX = p110.FinalHitVFX;
                            FinalHitVFX.Anchored = true;
                            FinalHitVFX.CFrame = HumanoidRootPart.CFrame;
                            FinalHitVFX.Parent = workspace.Effects;
                            ParticleHandler.EmitFromAttribute(FinalHitVFX);
                        end },
                    { 930, function(p111, p112, p113) -- Line: 551
                            -- upvalues: ParticleHandler (ref)
                            for i, v in p113 do
                                if i ~= "BarrageBeams" then
                                    ParticleHandler.DestroyByMaxLifetime(v);
                                end;
                            end;

                            table.clear(p113);
                        end }
                }
            }):Play({
                TimeScaleHit = UltimateEffects.fxTimeScaleHit:Clone(),
                Barrage1 = UltimateEffects.fxBarrage1:Clone(),
                Barrage2 = UltimateEffects.fxBarrage2:Clone(),
                DashVFX = UltimateEffects.fxDash:Clone(),
                FinalHitVFX = UltimateEffects.fxFinalHit:Clone(),
                KickVFX = UltimateEffects.fxGoFront:Clone(),
                ImpaleVFX = UltimateEffects.fxImpale:Clone(),
                PullVFX = UltimateEffects.fxPull:Clone(),
                SwordThrowVFX = UltimateEffects.fxSwordThrow:Clone(),
                BarrageBeams = UltimateEffects.BarrageBeams
            });
        end;

        function Cache.UmbraUltDeathImage(p114) -- Line: 578
            -- upvalues: Umbra (copy), TweenService (copy)
            local LocalPlayer = game.Players.LocalPlayer;
            local v115 = Umbra.DeathGui:Clone();
            local Death = v115.Death;
            v115.Parent = LocalPlayer.PlayerGui;
            Death.BackgroundTransparency = 0;
            Death.ImageTransparency = 1;
            Death.Visible = true;
            local v116 = TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.In);
            local v117 = TweenService:Create(Death, v116, {
                ImageTransparency = 0
            });
            v117:Play();
            v117.Completed:Wait();
            local v118 = TweenService:Create(Death, v116, {
                ImageTransparency = 1,
                BackgroundTransparency = 1
            });
            v118:Play();
            v118.Completed:Wait();
            Death:Destroy();
        end;

        function Cache.UmbraPiercingVoidAfterimage(p119) -- Line: 608
            -- upvalues: GetCloneColor (copy), CreateAfterimage (copy), AnimationHandler (copy), Umbra (copy), ParticleHandler (copy), PaleVisual_Rewrite (copy), TweenService (copy)
            local HSVShift = p119.HSVShift;
            local Attacker = p119.Attacker;
            local HumanoidRootPart = Attacker.HumanoidRootPart;
            local v120 = CFrame.new(HumanoidRootPart.CFrame.Position) * CFrame.fromOrientation(p119.Goal:ToOrientation());
            local Goal = p119.Goal;
            local v121 = CreateAfterimage(Attacker, {
                Properties = {
                    Start = {
                        Transparency = 0.5,
                        Color = GetCloneColor(p119.Skin, {
                            HSVShift = p119.HSVShift
                        })
                    }
                },
                Origin = v120
            });

            for _, descendant in v121:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.CollisionGroup = "BypassAll";
                end;
            end;

            local AnimationController = Instance.new("AnimationController");
            AnimationController.Parent = v121;
            local Animator = Instance.new("Animator");
            Animator.Parent = AnimationController;
            Animator.AncestryChanged:Connect(function(p122, p123) -- Line: 640
                -- upvalues: Animator (copy), AnimationHandler (ref)
                if not Animator:IsDescendantOf(workspace) then
                    return;
                end;

                local v124 = AnimationHandler.CreateAnimations("Umbra");
                local v125 = AnimationHandler.new(Animator);
                v125:AddAnimations(v124);
                local v126 = v125:PlayAnimation("LMB-3");
                v126:AdjustSpeed(0);
                v126.TimePosition = 0.5;
            end);
            local v127 = 0;
            local MaxFrame = p119.MaxFrame;
            local v128 = Umbra.PiercingVoid.PiercingVoid_AfterimageDash:Clone();
            v128.Anchored = true;

            if HSVShift then
                ParticleHandler.HSVShiftParticles(v128, HSVShift);
            end;

            v128.Parent = workspace.Effects;
            v128.CFrame = v120;
            ParticleHandler.EmitFromAttribute(v128);
            task.spawn(PaleVisual_Rewrite.BezierCurve, {
                Amount = 5,
                Duration = 0.1,
                Origin = HumanoidRootPart,
                Object = Umbra.PiercingVoid.Trail,
                HSVShift = HSVShift,
                Points = {
                    (HumanoidRootPart.CFrame * CFrame.new(0, -0.6, -3.75)).Position,
                    {
                        X = { -28, 28 },
                        Y = { -28, 28 },
                        Z = { -28, 28 }
                    },
                    (HumanoidRootPart.CFrame * CFrame.new(0, -0.6, -25)).Position
                }
            });

            while v127 < MaxFrame do
                v127 = v127 + task.wait() * 60;
                local v129 = v120:Lerp(Goal, v127 / MaxFrame);
                v121.HumanoidRootPart.CFrame = v129;
            end;

            local Duration = p119.Duration;

            for _, descendant in v121:GetDescendants() do
                if descendant:IsA("BasePart") then
                    TweenService:Create(descendant, TweenInfo.new(Duration), {
                        Transparency = 1
                    }):Play();
                end;
            end;

            task.delay(Duration, v121.Destroy, v121);
            ParticleHandler.DestroyByMaxLifetime(v128);
        end;

        function Cache.UmbraPiercingVoidHandVFX(p130) -- Line: 697
            -- upvalues: Umbra (copy), ParticleHandler (copy)
            local HSVShift = p130.HSVShift;
            local v131 = p130.Attacker["Left Arm"];
            local v132 = Umbra.PiercingVoid.PiercingVoid_Startup:Clone();
            ParticleHandler.AttachParticle(v132, v131, {
                C0 = CFrame.new(0, 1, 0)
            });

            if HSVShift then
                ParticleHandler.HSVShiftParticles(v132, HSVShift);
            end;

            v132.Parent = workspace.Effects;
            ParticleHandler.EmitFromAttribute(v132);
            ParticleHandler.DestroyByMaxLifetime(v132);
        end;

        function Cache.UmbraPiercingVoidMeshes(p133) -- Line: 718
            -- upvalues: Umbra (copy), TweenService (copy)
            local _ = p133.Attacker;
            local v134 = p133.Attacker.HumanoidRootPart.CFrame * CFrame.Angles(0, math.random(1, 360), 0);
            local Effects = workspace.Effects;
            local Meshes = Umbra.PiercingVoid.Meshes;
            local v135 = {
                [Meshes.m1] = {
                    0.7,
                    CFrame.new(
                        0.0836277679,
                        -0.801461816,
                        0.0303148925,
                        0.0000144078876,
                        -0.0000152150787,
                        -1,
                        1,
                        0,
                        0.0000144078886,
                        -2.48314305e-18,
                        -1,
                        0.0000152150778
                    ),
                    0,
                    {
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color = Color3.new(0.639216, 0.635294, 0.647059),
                                CFrame = v134 * CFrame.new(
                                    0.124527022,
                                    -0.24631089,
                                    -0.0125522129,
                                    0.00292365276,
                                    0.442816138,
                                    0.896607757,
                                    0.999991357,
                                    0.00138782267,
                                    -0.00394618232,
                                    -0.0029917662,
                                    0.896611392,
                                    -0.442808211
                                ),
                                Transparency = 1,
                                Size = Vector3.new(10.300233, 30.393133, 30.393133)
                            }
                        },
                        {
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = Color3.new(1, 1, 1),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(0.44530174, 0.9617343, 0.9364334),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                },
                [Meshes.m3] = {
                    1.7,
                    CFrame.new(
                        0.0886417925,
                        0.464418292,
                        0.0321773477,
                        0.0000358190991,
                        0.866018951,
                        -0.500012994,
                        1,
                        -0.0000292340465,
                        0.000021003274,
                        -3.57181762e-6,
                        -0.500013232,
                        -0.866016984
                    ),
                    0.4,
                    {
                        {
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            {
                                Color = Color3.new(0.639216, 0.635294, 0.647059),
                                CFrame = v134 * CFrame.new(
                                    0.151601955,
                                    -4.39834261,
                                    0.0469735414,
                                    0.00409716414,
                                    -0.806094706,
                                    0.591776252,
                                    0.999990284,
                                    0.00268978672,
                                    -0.00325224176,
                                    0.00103257829,
                                    0.591783166,
                                    0.806093991
                                ),
                                Transparency = 1,
                                Size = Vector3.new(18.604244, 54.420288, 54.420288)
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = Color3.new(1, 1, 1),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(0.8043024, 1.7220291, 1.6767267),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                },
                [Meshes.m2] = {
                    1,
                    CFrame.new(
                        0.0836277679,
                        -0.801461816,
                        0.0303148925,
                        0.0000369300869,
                        0.86601764,
                        -0.500013471,
                        1,
                        -0.0000288460596,
                        0.0000263130605,
                        -3.30943294e-7,
                        -0.500013471,
                        -0.86601764
                    ),
                    0,
                    {
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color = Color3.new(0.639216, 0.635294, 0.647059),
                                CFrame = v134 * CFrame.new(
                                    0.167075753,
                                    -1.54031062,
                                    0.0505324304,
                                    0.00410251785,
                                    -0.151548058,
                                    0.988441825,
                                    0.999990642,
                                    -0.000376654323,
                                    -0.00420629187,
                                    0.00100938347,
                                    0.988449395,
                                    0.151545495
                                ),
                                Transparency = 1,
                                Size = Vector3.new(12.88903, 43.61023, 43.61023)
                            }
                        },
                        {
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = Color3.new(1, 1, 1),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(0.5572211, 1.379965, 1.3436613),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                },
                [Meshes.m4] = {
                    1.9,
                    CFrame.new(
                        0.0757966787,
                        -2.78266215,
                        0.0274033733,
                        0.0000372063987,
                        0.86601764,
                        -0.500013471,
                        1,
                        -0.0000393562732,
                        6.24617405e-6,
                        -0.0000142693716,
                        -0.500013471,
                        -0.86601764
                    ),
                    0.5,
                    {
                        {
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            {
                                Color = Color3.new(0.639216, 0.635294, 0.647059),
                                CFrame = v134 * CFrame.new(
                                    0.155483603,
                                    1.67697883,
                                    0.0466710553,
                                    0.00410460029,
                                    -0.480473816,
                                    0.876999974,
                                    0.999990702,
                                    0.00108994998,
                                    -0.00407818239,
                                    0.00101345661,
                                    0.87700808,
                                    0.480473936
                                ),
                                Transparency = 1,
                                Size = Vector3.new(24.044832, 38.48227, 38.48227)
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = Color3.new(1, 1, 1),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(1.039511, 1.2177001, 1.1856654),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                }
            };

            for i, v in pairs(v135) do
                local v136 = i.Start:Clone();
                v136.Name = i.Name;
                v136.Transparency = v[3];

                if v136:FindFirstChildOfClass("Decal") then
                    v136:FindFirstChildOfClass("Decal").Transparency = v[3];
                    v136.Transparency = 1;
                end;

                v136.Anchored = true;
                v136.CanCollide = false;
                v136.CanQuery = false;
                v136.CanTouch = false;
                v136.Locked = true;
                v136.CFrame = v134 * v[2];
                v136.Parent = Effects;
                TweenService:Create(v136, TweenInfo.new(v[1], v[4][1][1], v[4][1][2]), v[4][1][3]):Play();

                if v[4][2] then
                    TweenService:Create(v136:FindFirstChildOfClass("Decal"), TweenInfo.new(v[1], v[4][2][1], v[4][2][2]), v[4][2][3]):Play();
                end;

                if v[4][3] then
                    TweenService:Create(v136:FindFirstChildOfClass("SpecialMesh"), TweenInfo.new(v[1], v[4][3][1], v[4][3][2]), v[4][3][3]):Play();
                end;

                task.delay(v[1], v136.Destroy, v136);
            end;
        end;

        function Cache.UmbraSnowstormHelixTeleport(p137) -- Line: 764
            -- upvalues: PaleVisual_Rewrite (copy), Umbra (copy), ParticleHandler (copy)
            local HSVShift = p137.HSVShift;
            local HumanoidRootPart = p137.Attacker.HumanoidRootPart;
            task.spawn(PaleVisual_Rewrite.BezierCurve, {
                Amount = 10,
                Duration = 0.2,
                Origin = HumanoidRootPart,
                Object = Umbra.SnowstormHelix.Trail,
                HSVShift = HSVShift,
                Points = {
                    HumanoidRootPart.CFrame.Position,
                    {
                        X = { -35, 35 },
                        Y = { -35, 35 },
                        Z = { -35, 35 }
                    },
                    (HumanoidRootPart.CFrame * CFrame.new(0, -0.6, -8)).Position
                }
            });
            local v138 = Umbra.SnowstormHelix.Tp1:Clone();
            ParticleHandler.AttachParticle(v138, HumanoidRootPart);

            if HSVShift then
                ParticleHandler.HSVShiftParticles(v138, HSVShift);
            end;

            v138.Parent = workspace.Effects;
            ParticleHandler.EmitFromAttribute(v138);
            ParticleHandler.DestroyByMaxLifetime(v138);
        end;

        function Cache.UmbraSnowstormHelixFinisher(p139) -- Line: 799
            -- upvalues: ParticleHandler (copy), Umbra (copy), Cache (copy), TweenService (copy)
            local HSVShift = p139.HSVShift;
            local HumanoidRootPart = p139.Attacker.HumanoidRootPart;

            local function TornadoParticle(u140) -- Line: 804
                -- upvalues: HumanoidRootPart (copy), HSVShift (copy), ParticleHandler (ref)
                u140.CFrame = HumanoidRootPart.CFrame;

                if HSVShift then
                    ParticleHandler.HSVShiftParticles(u140, HSVShift);
                end;

                u140.Parent = workspace.Effects;
                ParticleHandler.EnableParticles(u140, true);
                task.delay(0.5, function() -- Line: 814
                    -- upvalues: ParticleHandler (ref), u140 (copy)
                    ParticleHandler.EnableParticles(u140, false);
                    ParticleHandler.DestroyByMaxLifetime(u140);
                end);

                return u140;
            end;

            TornadoParticle(Umbra.SnowstormHelix.Tornado:Clone());
            task.wait(0.05);
            local v141 = TornadoParticle(Umbra.SnowstormHelix.TornadoSpin:Clone());
            task.spawn(function() -- Line: 827
                -- upvalues: Cache (ref), HumanoidRootPart (copy), HSVShift (copy)
                local v142 = os.clock();

                repeat
                    Cache.UmbraSnowstormHelixMeshes(HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, math.random(1, 360), 0), HSVShift);
                    task.wait(0.1);
                until os.clock() - v142 >= 0.5;
            end);
            local v143 = os.clock();

            repeat
                v141.CFrame = v141.CFrame:Lerp(v141.CFrame * CFrame.Angles(0, 0.1, 0), TweenService:GetValue(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out));
                task.wait();
            until os.clock() - v143 >= 0.5;
        end;

        function Cache.UmbraSnowstormHelixMeshes(p144, u145) -- Line: 842
            -- upvalues: ParticleHandler (copy), Umbra (copy), TweenService (copy)
            local function GenerateColor(...) -- Line: 844
                -- upvalues: u145 (copy), ParticleHandler (ref)
                local v146 = Color3.new(...);

                if u145 then
                    v146 = ParticleHandler.HSVShift(v146, u145);
                end;

                return v146;
            end;

            local Mesh = Umbra.SnowstormHelix.Mesh;
            local v147 = {
                [Mesh.m5] = {
                    0.4,
                    CFrame.new(
                        -0.00348055363,
                        -5.18104839,
                        0.0648206249,
                        0.0000358205943,
                        0.866028845,
                        -0.499994099,
                        1,
                        -0.0000345934604,
                        0.0000117234658,
                        -7.14366524e-6,
                        -0.49999401,
                        -0.866028905
                    ),
                    0.8,
                    {
                        {
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            {
                                Color = GenerateColor(0.639216, 0.635294, 0.647059),
                                CFrame = p144 * CFrame.new(
                                    0.0595189407,
                                    -10.043808,
                                    0.0796383172,
                                    0.00410060212,
                                    -0.931796432,
                                    0.362958312,
                                    0.999990761,
                                    0.00345313014,
                                    -0.00243264856,
                                    0.00101339282,
                                    0.362964869,
                                    0.931802332
                                ),
                                Transparency = 1,
                                Size = Vector3.new(18.604244, 54.420288, 54.420288)
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = GenerateColor(5.56863, 0.196078, 10),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(0.8043024, 1.7220291, 1.6767267),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                },
                [Mesh.m1] = {
                    0.4,
                    CFrame.new(
                        -0.000100635792,
                        -0.311056137,
                        -0.0000527210141,
                        -0.866025448,
                        0,
                        -0.499999911,
                        0,
                        -1,
                        0,
                        -0.499999911,
                        0,
                        0.866025448
                    ),
                    0.8,
                    {
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color = GenerateColor(0.643137, 0.0705882, 0.964706),
                                CFrame = p144 * CFrame.new(
                                    -0.000100635792,
                                    -1.22360706,
                                    -0.0000527210141,
                                    0.866025448,
                                    0,
                                    0.499999911,
                                    0,
                                    -0.999999642,
                                    0,
                                    0.499999911,
                                    0,
                                    -0.866025448
                                ),
                                Transparency = 1,
                                Size = Vector3.new(41.21966, 22.203918, 41.21966)
                            }
                        }
                    }
                },
                [Mesh.m7] = {
                    0.8,
                    CFrame.new(
                        -0.00335154869,
                        -15.0776529,
                        0.065177016,
                        0.000052822259,
                        0.86601764,
                        -0.500013471,
                        1,
                        -0.0000403355625,
                        0.000023288585,
                        5.40929341e-6,
                        -0.500013471,
                        -0.86601764
                    ),
                    0,
                    {
                        {
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            {
                                Color = GenerateColor(0.639216, 0.635294, 0.647059),
                                CFrame = p144 * CFrame.new(
                                    0.108642794,
                                    -2.80974865,
                                    0.0925744474,
                                    0.00412558392,
                                    -0.931790292,
                                    0.362973779,
                                    0.99999094,
                                    0.00346987252,
                                    -0.00245845178,
                                    0.00103128853,
                                    0.362980664,
                                    0.931796134
                                ),
                                Transparency = 1,
                                Size = Vector3.new(20.033895, 38.48227, 38.48227)
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = GenerateColor(5.56863, 0.196078, 10),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(0.8661094, 1.2177001, 1.1856654),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                },
                [Mesh.m8] = {
                    0.8,
                    CFrame.new(
                        -0.00333786011,
                        -17.7663383,
                        0.0652906299,
                        0.0000403295708,
                        0.422632635,
                        0.906301856,
                        1,
                        -0.0000170445892,
                        -0.0000365507585,
                        5.15172974e-13,
                        0.906301856,
                        -0.422632635
                    ),
                    0,
                    {
                        {
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            {
                                Color = GenerateColor(0.639216, 0.635294, 0.647059),
                                CFrame = p144 * CFrame.new(
                                    -0.0442010127,
                                    3.12653732,
                                    0.186629236,
                                    -0.00133607048,
                                    -0.280388892,
                                    -0.959888577,
                                    0.999991119,
                                    0.00342715648,
                                    -0.00238708314,
                                    0.00396164134,
                                    -0.959883213,
                                    0.280381978
                                ),
                                Transparency = 1,
                                Size = Vector3.new(38.88457, 24.801138, 24.801138)
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = GenerateColor(5.56863, 0.196078, 10),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(1.6810656, 0.78478605, 0.76414025),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                },
                [Mesh.m6] = {
                    0.8,
                    CFrame.new(
                        -0.00349990092,
                        -7.51497173,
                        0.0649151728,
                        0.0000403295708,
                        0.86601764,
                        -0.500013471,
                        1,
                        -0.0000393562805,
                        0.0000124923426,
                        0,
                        -0.500013471,
                        -0.86601764
                    ),
                    0,
                    {
                        {
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            {
                                Color = GenerateColor(0.639216, 0.635294, 0.647059),
                                CFrame = p144 * CFrame.new(
                                    0.0761991963,
                                    -3.05532503,
                                    0.0842737108,
                                    0.00410372298,
                                    -0.931790411,
                                    0.36297366,
                                    0.999991059,
                                    0.00345021393,
                                    -0.00244869106,
                                    0.00102933007,
                                    0.362980485,
                                    0.931796193
                                ),
                                Transparency = 1,
                                Size = Vector3.new(24.044832, 38.48227, 38.48227)
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = GenerateColor(5.56863, 0.196078, 10),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(1.039511, 1.2177001, 1.1856654),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                },
                [Mesh.m2] = {
                    0.6,
                    CFrame.new(-0.0000599268024, 1.21185493, 0.0000411946748, 0, 0, 1, 0, -1, 0, 1, 0, 0),
                    0.8,
                    {
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color = GenerateColor(0.643137, 0.0705882, 0.964706),
                                CFrame = p144 * CFrame.new(
                                    -0.000076519791,
                                    -8.75380898,
                                    0.0000372309732,
                                    0.642787576,
                                    0,
                                    -0.766044438,
                                    0,
                                    -0.999999464,
                                    -0,
                                    -0.766044438,
                                    0,
                                    -0.642787576
                                ),
                                Transparency = 1,
                                Size = Vector3.new(80.69046, 7.145521, 80.69046)
                            }
                        }
                    }
                },
                [Mesh.m3] = {
                    0.5,
                    CFrame.new(
                        -0.000100635792,
                        -0.311056137,
                        -0.0000527210141,
                        -0.866025448,
                        0,
                        -0.499999911,
                        0,
                        -1,
                        0,
                        -0.499999911,
                        0,
                        0.866025448
                    ),
                    0.8,
                    {
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color = GenerateColor(0.643137, 0.0705882, 0.964706),
                                CFrame = p144 * CFrame.new(
                                    -0.000115348026,
                                    -5.13954926,
                                    -0.0000351876442,
                                    2.98023224e-8,
                                    0,
                                    0.999999881,
                                    0,
                                    -0.999999642,
                                    0,
                                    0.999999881,
                                    0,
                                    -2.98023224e-8
                                ),
                                Transparency = 1,
                                Size = Vector3.new(51.9637, 14.372036, 51.9637)
                            }
                        }
                    }
                },
                [Mesh.m4] = {
                    0.6,
                    CFrame.new(
                        -0.00338962302,
                        -10.500452,
                        0.0650140792,
                        0.0000320981198,
                        0.86601764,
                        -0.500013471,
                        1,
                        -0.0000277975378,
                        0.0000160494928,
                        -1.66439426e-13,
                        -0.500013471,
                        -0.86601764
                    ),
                    0,
                    {
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color = GenerateColor(0.639216, 0.635294, 0.647059),
                                CFrame = p144 * CFrame.new(
                                    0.0800342113,
                                    -11.2393026,
                                    0.0851877928,
                                    0.00410404336,
                                    -0.931789279,
                                    0.362976611,
                                    0.999990702,
                                    0.00345431827,
                                    -0.00243902276,
                                    0.00101881858,
                                    0.362983346,
                                    0.931795239
                                ),
                                Transparency = 1,
                                Size = Vector3.new(12.88903, 43.61023, 43.61023)
                            }
                        },
                        {
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = GenerateColor(5.56863, 0.196078, 10),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(0.5572211, 1.379965, 1.3436613),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                }
            };

            for i, v in pairs(v147) do
                local v148 = i.Start:Clone();
                v148.Name = i.Name;
                v148.Transparency = v[3];

                if v148:FindFirstChildOfClass("Decal") then
                    v148:FindFirstChildOfClass("Decal").Transparency = v[3];
                    v148.Transparency = 1;
                end;

                v148.Anchored = true;
                v148.CanCollide = false;
                v148.CanQuery = false;
                v148.CanTouch = false;
                v148.Locked = true;
                v148.CFrame = p144 * v[2];

                if u145 then
                    v148.Color = ParticleHandler.HSVShift(v148.Color, u145);
                end;

                v148.Parent = workspace.Effects;
                TweenService:Create(v148, TweenInfo.new(v[1], v[4][1][1], v[4][1][2]), v[4][1][3]):Play();

                if v[4][2] then
                    TweenService:Create(v148:FindFirstChildOfClass("Decal"), TweenInfo.new(v[1], v[4][2][1], v[4][2][2]), v[4][2][3]):Play();
                end;

                if v[4][3] then
                    TweenService:Create(v148:FindFirstChildOfClass("SpecialMesh"), TweenInfo.new(v[1], v[4][3][1], v[4][3][2]), v[4][3][3]):Play();
                end;

                task.delay(v[1], v148.Destroy, v148);
            end;
        end;

        function Cache.UmbraPoseAfterimage(u149) -- Line: 895
            -- upvalues: CreateAfterimage (copy), TweenService (copy), GetCloneColor (copy)
            local Attacker = u149.Attacker;
            local HumanoidRootPart = Attacker.HumanoidRootPart;
            local u150 = Attacker.Humanoid:GetAppliedDescription();
            local v151 = {};
            local v152 = {};

            for _, descendant in Attacker:GetDescendants() do
                if descendant:IsA("Motor6D") then
                    v151[descendant.Name] = descendant;
                elseif descendant:IsA("Attachment") then
                    table.insert(v152, descendant);
                end;
            end;

            local v153 = {
                Properties = {
                    Start = {
                        CollisionGroup = "BypassAll",
                        Material = "Plastic"
                    }
                }
            };
            local v154 = CFrame.new(0, 0, 2.5) * CFrame.Angles(0, 3.141592653589793, 0);
            v153.Origin = HumanoidRootPart.CFrame * v154;
            local u155 = CreateAfterimage(Attacker, v153);

            for _, v in v152 do
                local v156 = u155:FindFirstChild(v.Parent.Name);

                if v156 then
                    v:Clone().Parent = v156;
                end;
            end;

            local Humanoid = Instance.new("Humanoid");
            Humanoid.DisplayDistanceType = "None";
            Humanoid.HealthDisplayType = "AlwaysOff";
            Humanoid.Parent = u155;
            Humanoid.AncestryChanged:Once(function(p157, p158) -- Line: 939
                -- upvalues: Humanoid (copy), u150 (copy), u155 (copy), TweenService (ref), GetCloneColor (ref), u149 (copy)
                if not Humanoid:IsDescendantOf(workspace) then
                    return;
                end;

                Humanoid:ApplyDescription(u150);

                for _, descendant in u155:GetDescendants() do
                    if descendant:IsA("BasePart") and descendant ~= u155.HumanoidRootPart then
                        descendant.Transparency = 1;
                        TweenService:Create(descendant, TweenInfo.new(1), {
                            Transparency = 0.5
                        }):Play();
                    end;
                end;

                local Highlight = Instance.new("Highlight");
                Highlight.DepthMode = "Occluded";
                Highlight.FillColor = GetCloneColor(u149.Skin, {
                    HSVShift = u149.HSVShift
                });
                Highlight.FillTransparency = 1;
                Highlight.OutlineColor = GetCloneColor(u149.Skin, {
                    HSVShift = u149.HSVShift
                });
                Highlight.OutlineTransparency = 1;
                Highlight.Parent = u155;
                TweenService:Create(Highlight, TweenInfo.new(1), {
                    FillTransparency = 0.75,
                    OutlineTransparency = 0.25
                }):Play();
            end);

            while Attacker:GetAttribute("Posing") and Attacker.Parent do
                for _, descendant in u155:GetDescendants() do
                    if descendant:IsA("Motor6D") and v151[descendant.Name] then
                        descendant.Transform = v151[descendant.Name].Transform;
                    end;
                end;

                u155.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * v154;
                task.wait();
            end;

            for _, descendant in u155:GetDescendants() do
                if descendant:IsA("BasePart") then
                    TweenService:Create(descendant, TweenInfo.new(0.5), {
                        Transparency = 1
                    }):Play();
                elseif descendant:IsA("Highlight") then
                    TweenService:Create(descendant, TweenInfo.new(0.5), {
                        FillTransparency = 1,
                        OutlineTransparency = 1
                    }):Play();
                end;
            end;

            task.delay(0.5, u155.Destroy, u155);
        end;

        function Cache.UmbraGrabVFX(p159) -- Line: 991
            -- upvalues: Umbra (copy), ParticleHandler (copy), Sequence_V2 (copy)
            local HSVShift = p159.HSVShift;
            local HumanoidRootPart = p159.Attacker.HumanoidRootPart;
            local Torso = p159.Target.Torso;
            local Grab = Umbra.Grab;

            local function Emit(p160, p161) -- Line: 1000
                -- upvalues: HumanoidRootPart (copy), ParticleHandler (ref)
                p160.Anchored = true;
                p160.CFrame = (p161 or HumanoidRootPart).CFrame;
                p160.Parent = workspace.Effects;
                ParticleHandler.EmitFromAttribute(p160);
            end;

            Sequence_V2.CreateFromOldSequence({
                Frames = {
                    { 0, function(p162, p163, p164) -- Line: 1008
                            -- upvalues: HSVShift (copy), ParticleHandler (ref), HumanoidRootPart (copy)
                            if HSVShift then
                                for _, v in p164 do
                                    ParticleHandler.HSVShiftParticles(v, HSVShift);
                                end;
                            end;

                            local StartupVFX = p164.StartupVFX;
                            StartupVFX.Anchored = true;
                            StartupVFX.CFrame = HumanoidRootPart.CFrame;
                            StartupVFX.Parent = workspace.Effects;
                            ParticleHandler.EmitFromAttribute(StartupVFX);
                        end },
                    { 45, function(p165, p166, p167) -- Line: 1018
                            -- upvalues: HumanoidRootPart (copy), ParticleHandler (ref)
                            local Throw = p167.Throw;
                            Throw.Anchored = true;
                            Throw.CFrame = HumanoidRootPart.CFrame;
                            Throw.Parent = workspace.Effects;
                            ParticleHandler.EmitFromAttribute(Throw);
                        end },
                    { 125, function(p168, p169, p170) -- Line: 1022
                            -- upvalues: HumanoidRootPart (copy), ParticleHandler (ref), Torso (copy)
                            local Smear = p170.Smear;
                            Smear.Anchored = true;
                            Smear.CFrame = HumanoidRootPart.CFrame;
                            Smear.Parent = workspace.Effects;
                            ParticleHandler.EmitFromAttribute(Smear);
                            local Hit = p170.Hit;
                            Hit.Anchored = true;
                            Hit.CFrame = HumanoidRootPart.CFrame;
                            Hit.Parent = workspace.Effects;
                            ParticleHandler.EmitFromAttribute(Hit);
                            local Impale = p170.Impale;
                            Impale.Anchored = true;
                            Impale.CFrame = (Torso or HumanoidRootPart).CFrame;
                            Impale.Parent = workspace.Effects;
                            ParticleHandler.EmitFromAttribute(Impale);
                            ParticleHandler.AttachParticle(p170.Blood, Torso);
                            p170.Blood.Parent = workspace.Effects;
                            ParticleHandler.EnableParticles(p170.Blood, true);
                        end },
                    { 185, function(p171, p172, p173) -- Line: 1033
                            -- upvalues: HumanoidRootPart (copy), ParticleHandler (ref)
                            local Throw2 = p173.Throw2;
                            Throw2.Anchored = true;
                            Throw2.CFrame = HumanoidRootPart.CFrame;
                            Throw2.Parent = workspace.Effects;
                            ParticleHandler.EmitFromAttribute(Throw2);
                        end },
                    { 189, function(p174, p175, p176) -- Line: 1037
                            -- upvalues: ParticleHandler (ref)
                            for _, v in p176 do
                                ParticleHandler.EnableParticles(v, false);
                                ParticleHandler.DestroyByMaxLifetime(v);
                            end;

                            table.clear(p176);
                        end }
                }
            }):Play({
                StartupVFX = Grab.charge:Clone(),
                Throw = Grab.throw:Clone(),
                Throw2 = Grab.throw2:Clone(),
                Blood = Grab.BloodEnable:Clone(),
                Hit = Grab.hit:Clone(),
                Impale = Grab.impale:Clone(),
                Smear = Grab.smear:Clone()
            });
        end;

        function Cache.UmbraWindShower(p177) -- Line: 1061
            -- upvalues: Umbra (copy), ParticleHandler (copy), Cache (copy), TweenService (copy), Sequence_V2 (copy)
            local HSVShift = p177.HSVShift;
            local Attacker = p177.Attacker;
            local HumanoidRootPart = Attacker.HumanoidRootPart;
            local _ = Attacker.Humanoid;
            local WindShower = Umbra.WindShower;
            Sequence_V2.CreateFromOldSequence({
                Frames = {
                    { 0, function(p178, p179, p180) -- Line: 1070
                            -- upvalues: HSVShift (copy), ParticleHandler (ref)
                            if not HSVShift then
                                return;
                            end;

                            for _, v in p180 do
                                if typeof(v) == "Instance" then
                                    ParticleHandler.HSVShiftParticles(v, HSVShift);
                                end;
                            end;
                        end },
                    { 0, function(p181, p182, p183) -- Line: 1077
                            -- upvalues: HumanoidRootPart (copy), Cache (ref), TweenService (ref)
                            local v184 = p183.Origin * CFrame.new(0, 0, -50);
                            local v185 = RaycastParams.new();
                            v185.FilterDescendantsInstances = { workspace.Map };
                            v185.FilterType = Enum.RaycastFilterType.Include;
                            v185.IgnoreWater = true;
                            local v186 = workspace:Raycast(HumanoidRootPart.Position, HumanoidRootPart.CFrame.LookVector * 50, v185);

                            if v186 and v186.Position then
                                v184 = CFrame.new(v186.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
                            end;

                            Cache.UmbraWindShowerMeshes(v184);
                            TweenService:Create(HumanoidRootPart, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
                                CFrame = v184
                            }):Play();
                            task.wait(0.05);
                            local v187 = v184 * CFrame.new(0, 0, -15);
                            local v188 = workspace:Raycast(HumanoidRootPart.Position, v184.LookVector * 15, v185);

                            if v188 and v188.Position then
                                v187 = CFrame.new(v188.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
                            end;

                            TweenService:Create(HumanoidRootPart, TweenInfo.new(1.25, Enum.EasingStyle.Linear), {
                                CFrame = v187
                            }):Play();
                        end },
                    { 0, function(p189, p190, p191) -- Line: 1110
                            -- upvalues: ParticleHandler (ref)
                            p191.ShowerVFX.Size = Vector3.new(25, 25, 45);
                            p191.ShowerVFX.CFrame = p191.Origin * CFrame.new(0, 0, -25) + Vector3.new(0, 2, 0);
                            p191.ShowerVFX.Anchored = true;
                            p191.ShowerVFX.Parent = workspace.Effects;
                            ParticleHandler.EmitFromAttribute(p191.ShowerVFX);
                        end },
                    { 5, function(p192, p193, p194) -- Line: 1118
                            for _, descendant in p194.ShowerVFX:GetDescendants() do
                                if descendant:IsA("ParticleEmitter") then
                                    descendant.TimeScale = descendant.TimeScale * 0.05;
                                end;
                            end;
                        end },
                    { 60, function(p195, p196, p197) -- Line: 1125
                            -- upvalues: ParticleHandler (ref)
                            p197.SlashesVFX.Size = Vector3.new(25, 25, 45);
                            p197.SlashesVFX.CFrame = p197.ShowerVFX.CFrame;
                            p197.SlashesVFX.Anchored = true;
                            p197.SlashesVFX.Parent = workspace.Effects;
                            ParticleHandler.EnableParticles(p197.SlashesVFX, true);
                        end },
                    { 105, function(p198, p199, p200) -- Line: 1133
                            -- upvalues: ParticleHandler (ref)
                            ParticleHandler.EnableParticles(p200.SlashesVFX, false);
                        end },
                    { 105, function(p201, p202, p203) -- Line: 1137
                            -- upvalues: ParticleHandler (ref)
                            p203.SlashesVFX2.CFrame = p203.ShowerVFX.CFrame;
                            p203.SlashesVFX2.Anchored = true;
                            p203.SlashesVFX2.Parent = workspace.Effects;
                            ParticleHandler.EmitFromAttribute(p203.SlashesVFX2);
                            p203.FinalSlash.CFrame = p203.ShowerVFX.CFrame;
                            p203.FinalSlash.Anchored = true;
                            p203.FinalSlash.Parent = workspace.Effects;
                            ParticleHandler.EmitFromAttribute(p203.FinalSlash);
                        end },
                    { 115, function(p204, p205, p206) -- Line: 1149
                            -- upvalues: ParticleHandler (ref)
                            for _, descendant in p206.ShowerVFX:GetDescendants() do
                                if descendant:IsA("ParticleEmitter") then
                                    descendant.TimeScale = descendant.TimeScale * 20;
                                end;
                            end;

                            for _, v in p206 do
                                if typeof(v) == "Instance" then
                                    ParticleHandler.DestroyByMaxLifetime(v);
                                end;
                            end;
                        end }
                }
            }):Play({
                ShowerVFX = WindShower.Laceration:Clone(),
                SlashesVFX = WindShower.Slashes:Clone(),
                SlashesVFX2 = WindShower.SlashesEnd:Clone(),
                FinalSlash = WindShower.SlashesEnd2:Clone(),
                Origin = HumanoidRootPart.CFrame
            });
        end;

        function Cache.UmbraWindShowerMeshes(p207) -- Line: 1174
            -- upvalues: Umbra (copy), TweenService (copy)
            local Effects = workspace.Effects;
            local Meshes = Umbra.WindShower.Meshes;
            local v208 = {
                [Meshes.m1] = {
                    0.7,
                    CFrame.new(
                        -0.0101661049,
                        0.0230372753,
                        14.4941835,
                        0.00291457516,
                        0.0223776605,
                        0.999745429,
                        0.00300489902,
                        -0.99974525,
                        0.0223688968,
                        0.999991179,
                        0.00293893786,
                        -0.00298107532
                    ),
                    0,
                    {
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color = Color3.new(0.639216, 0.635294, 0.647059),
                                CFrame = p207 * CFrame.new(
                                    0.0043850746,
                                    0.0169140715,
                                    8.08783531,
                                    0.00291457563,
                                    0.0223776661,
                                    0.999746144,
                                    0.00300489785,
                                    -0.999745071,
                                    0.0223689042,
                                    0.999990821,
                                    0.0029389374,
                                    -0.00298107602
                                ) * CFrame.Angles(math.random(-360, 360), 0, 0),
                                Transparency = 1,
                                Size = Vector3.new(20.040155, 19.250637, 19.250637)
                            }
                        },
                        {
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = Color3.new(1, 1, 1),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(0.86638, 0.6091507, 0.5931254),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                },
                [Meshes.m4] = {
                    1.9,
                    CFrame.new(
                        0.055863332,
                        0.0641583353,
                        22.6761017,
                        0.00291457516,
                        0.0223776605,
                        0.999745429,
                        0.00300489902,
                        -0.99974525,
                        0.0223688968,
                        0.999991179,
                        0.00293893786,
                        -0.00298107532
                    ),
                    0.5,
                    {
                        {
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            {
                                Color = Color3.new(0.639216, 0.635294, 0.647059),
                                CFrame = p207 * CFrame.new(
                                    -0.0557407103,
                                    -0.0271098427,
                                    -2.8245945,
                                    0.00291457563,
                                    0.0223776661,
                                    0.999746144,
                                    0.00300489785,
                                    -0.999745071,
                                    0.0223689042,
                                    0.999990821,
                                    0.0029389374,
                                    -0.00298107602
                                ) * CFrame.Angles(math.random(-360, 360), 0, 0),
                                Transparency = 1,
                                Size = Vector3.new(41.708324, 8.243548, 8.243548)
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = Color3.new(1, 1, 1),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(1.9391944, 0.37006313, 0.35782048),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                },
                [Meshes.m5] = {
                    0.1,
                    CFrame.new(
                        0.0545568019,
                        0.0626823679,
                        22.1859093,
                        0.00291452836,
                        0.0223707035,
                        0.999745607,
                        0.00300491787,
                        -0.999745548,
                        0.0223619398,
                        0.999991179,
                        0.00293897861,
                        -0.00298100873
                    ),
                    -2,
                    {
                        {
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            {
                                Color = Color3.new(0.639216, 0.635294, 0.647059),
                                CFrame = p207 * CFrame.new(
                                    -0.0632891282,
                                    -0.0348912105,
                                    -5.41444969,
                                    0.00291452906,
                                    0.0223707184,
                                    0.999746323,
                                    0.00300491741,
                                    -0.999745786,
                                    0.0223619472,
                                    0.999990821,
                                    0.00293897861,
                                    -0.00298100919
                                ) * CFrame.Angles(math.random(-360, 360), 0, 0),
                                Transparency = 1,
                                Size = Vector3.new(36.52857, 4.710202, 4.710202)
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = Color3.new(9.17647, 4.54902, 10),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(1.6983659, 0.21144684, 0.20445162),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                },
                [Meshes.m2] = {
                    1,
                    CFrame.new(
                        -0.0101661049,
                        0.0230372753,
                        14.4941835,
                        0.00291457516,
                        0.0223776605,
                        0.999745429,
                        0.00300489902,
                        -0.99974525,
                        0.0223688968,
                        0.999991179,
                        0.00293893786,
                        -0.00298107532
                    ),
                    0,
                    {
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color = Color3.new(0.639216, 0.635294, 0.647059),
                                CFrame = p207 * CFrame.new(
                                    0.00833925232,
                                    0.00859767105,
                                    2.86119461,
                                    0.00291457563,
                                    0.0223776661,
                                    0.999746144,
                                    0.00300489785,
                                    -0.999745071,
                                    0.0223689042,
                                    0.999990821,
                                    0.0029389374,
                                    -0.00298107602
                                ) * CFrame.Angles(math.random(-360, 360), 0, 0),
                                Transparency = 1,
                                Size = Vector3.new(30.494024, 27.622183, 27.622183)
                            }
                        },
                        {
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = Color3.new(1, 1, 1),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(1.3183239, 0.8740528, 0.8510586),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                },
                [Meshes.m3] = {
                    1.7,
                    CFrame.new(
                        -0.0108547993,
                        0.0242437366,
                        15.2959833,
                        0.00291457516,
                        0.0223776605,
                        0.999745429,
                        0.00300489902,
                        -0.99974525,
                        0.0223688968,
                        0.999991179,
                        0.00293893786,
                        -0.00298107532
                    ),
                    0.4,
                    {
                        {
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            {
                                Color = Color3.new(0.639216, 0.635294, 0.647059),
                                CFrame = p207 * CFrame.new(
                                    0.00476807356,
                                    0.00842952915,
                                    3.423069,
                                    0.00291457563,
                                    0.0223776661,
                                    0.999746144,
                                    0.00300489785,
                                    -0.999745071,
                                    0.0223689042,
                                    0.999990821,
                                    0.0029389374,
                                    -0.00298107602
                                ) * CFrame.Angles(math.random(-360, 360), 0, 0),
                                Transparency = 1,
                                Size = Vector3.new(29.369703, 13.692277, 13.692277)
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = Color3.new(1, 1, 1),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(1.2697169, 0.4332667, 0.42186853),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                }
            };

            for i, v in pairs(v208) do
                local v209 = i.Start:Clone();
                v209.Name = i.Name;
                v209.Transparency = v[3];

                if v209:FindFirstChildOfClass("Decal") then
                    v209:FindFirstChildOfClass("Decal").Transparency = v[3];
                    v209.Transparency = 1;
                end;

                v209.Anchored = true;
                v209.CanCollide = false;
                v209.CanQuery = false;
                v209.CanTouch = false;
                v209.Locked = true;
                v209.CFrame = p207 * v[2];
                v209.Parent = Effects;
                TweenService:Create(v209, TweenInfo.new(v[1], v[4][1][1], v[4][1][2]), v[4][1][3]):Play();

                if v[4][2] then
                    TweenService:Create(v209:FindFirstChildOfClass("Decal"), TweenInfo.new(v[1], v[4][2][1], v[4][2][2]), v[4][2][3]):Play();
                end;

                if v[4][3] then
                    TweenService:Create(v209:FindFirstChildOfClass("SpecialMesh"), TweenInfo.new(v[1], v[4][3][1], v[4][3][2]), v[4][3][3]):Play();
                end;

                task.delay(v[1], v209.Destroy, v209);
            end;
        end;

        function Cache.UmbralDash(p210) -- Line: 1217
            -- upvalues: TweenService (copy), GetCloneColor (copy), CreateAfterimage (copy)
            local _ = p210.HSVShift;
            local Attacker = p210.Attacker;
            local HumanoidRootPart = Attacker.HumanoidRootPart;
            local v211;

            if p210.Goal then
                v211 = p210.Goal;
            elseif typeof(p210.Offset) == "Vector3" then
                v211 = HumanoidRootPart.CFrame + p210.Offset;
            else
                v211 = HumanoidRootPart.CFrame * p210.Offset;
            end;

            if not p210.Npc then
                local v212 = RaycastParams.new();
                v212.FilterDescendantsInstances = { workspace.Map, workspace.Terrain };
                v212.FilterType = Enum.RaycastFilterType.Include;
                v212.IgnoreWater = true;
                local v213 = workspace:Raycast(HumanoidRootPart.Position, CFrame.lookAt(HumanoidRootPart.Position, v211.Position).LookVector * 20, v212);

                if v213 and v213.Position then
                    v211 = CFrame.new(v213.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
                end;
            end;

            local v214 = TweenService:Create(HumanoidRootPart, TweenInfo.new(p210.Time or 0.1, Enum.EasingStyle.Sine), {
                CFrame = v211
            });
            v214:Play();
            local v215 = {
                Sword = false,
                TweenData = {
                    End = { 0.5, Enum.EasingStyle.Sine }
                },
                Properties = {
                    Start = {
                        Transparency = 0.75,
                        Color = GetCloneColor(p210.Skin, {
                            HSVShift = p210.HSVShift
                        })
                    },
                    End = {
                        Transparency = 1
                    }
                }
            };

            while v214.PlaybackState ~= Enum.PlaybackState.Completed and v214.PlaybackState ~= Enum.PlaybackState.Cancelled do
                local v216 = CreateAfterimage(Attacker, v215);
                task.delay(0.5, v216.Destroy, v216);
                task.wait();
            end;
        end;

        require(script.SovereignVFX)(p1, Cache, {
            UmbraAwakenHighlight = UmbraAwakenHighlight,
            BladeHighlight = BladeHighlight,

            TweenAndClean = function(p217, p218) -- Line: 29, Name: TweenAndClean
                p217:Play();
                p217.Completed:Wait();

                if p218 then
                    p218:Destroy();
                end;

                return true;
            end,

            GetCloneColor = GetCloneColor,

            CloneTeleportVFX = function(p219, p220) -- Line: 55, Name: CloneTeleportVFX
                -- upvalues: Umbra (copy), ParticleHandler (copy), PathShortcuts (copy)
                local v221 = p220 or {};
                local v222;

                if v221.TeleportVFX then
                    v222 = v221.TeleportVFX;
                elseif v221.Character:GetAttribute("Sovereign") then
                    v222 = Umbra.TeleportEffects.Teleport_Awakened;
                else
                    v222 = Umbra.TeleportEffects.Teleport_Normal;
                end;

                local v223 = v222:Clone();
                local v224 = p219 == "Hyde" and {
                    HueShift = 70
                } or v221.HSVShift;

                if v224 then
                    ParticleHandler.HSVShiftParticles(v223, v224);
                end;

                if v221.Character:GetAttribute("ChromaUnusual") then
                    PathShortcuts.Remotes.ClientBind:Fire(v221.Character, "Chroma", v223);
                end;

                return v223;
            end,

            CreateAfterimage = CreateAfterimage,
            PaleVisual = PaleVisual_Rewrite
        });
    end
};