  

 

return function(u1, u2, u3) -- Line: 1
    local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
    local PathShortcuts = require(ReplicatedModules.PathShortcuts);
    local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
    local Sequence_V2 = require(ReplicatedModules.Classes.Sequence_V2);
    local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
    require(PathShortcuts.KnitPath.Trove);
    local AnimationHandler = require(ReplicatedModules.AnimationHandler);
    local PaleVisual = u3.PaleVisual;
    local TweenService = game:GetService("TweenService");
    game:GetService("RunService");
    local Umbra = PathShortcuts.ClientAssets.Assets.Abilities.Umbra;
    local _ = Umbra.Afterimage;
    local TweenAndClean = u3.TweenAndClean;
    local GetCloneColor = u3.GetCloneColor;
    local CloneTeleportVFX = u3.CloneTeleportVFX;
    local CreateAfterimage = u3.CreateAfterimage;

    function u2.UmbraSwallowingVoidHandVFX(p4) -- Line: 25
        -- upvalues: Umbra (copy), ParticleHandler (copy), PaleVisual (copy)
        local Attacker = p4.Attacker;
        local HumanoidRootPart = Attacker.HumanoidRootPart;
        local v5 = Attacker["Left Arm"];
        local HSVShift = p4.HSVShift;
        local u6 = Umbra.SwallowingVoid.PrepareEnable:Clone();
        u6.Anchored = false;
        ParticleHandler.Unusualify(u6, {
            Character = Attacker
        });
        ParticleHandler.AttachParticle(u6, v5, {
            C0 = CFrame.new(0, 1, 0)
        });
        ParticleHandler.EnableParticles(u6, true);
        u6.Parent = workspace.Effects;
        task.delay(p4.FrameDelay / 60, function() -- Line: 42
            -- upvalues: ParticleHandler (ref), u6 (copy)
            ParticleHandler.EnableParticles(u6, false);
            ParticleHandler.DestroyByMaxLifetime(u6);
        end);

        if not p4.Pull then
            return;
        end;

        task.spawn(PaleVisual.BezierCurve, {
            Amount = 10,
            Duration = 0.3,
            Delay = 0.0005,
            Origin = HumanoidRootPart,
            Object = Umbra.SwallowingVoid.Trail,
            HSVShift = HSVShift,
            Points = {
                {
                    X = { -50, 50 },
                    Y = { -50, 50 },
                    Z = { -50, 50 }
                },
                {
                    X = { -25, 25 },
                    Y = { -25, 25 },
                    Z = { 25, -25 }
                },
                HumanoidRootPart.Position
            }
        });
        task.spawn(PaleVisual.BezierCurve, {
            Amount = 10,
            Duration = 0.3,
            Delay = 0.0005,
            Origin = HumanoidRootPart,
            Object = Umbra.SwallowingVoid.TrailBl,
            HSVShift = HSVShift,
            Points = {
                {
                    X = { -50, 50 },
                    Y = { -50, 50 },
                    Z = { -50, 50 }
                },
                {
                    X = { -25, 25 },
                    Y = { -25, 25 },
                    Z = { 25, -25 }
                },
                HumanoidRootPart.Position
            }
        });
    end;

    function u2.UmbraSwordSpikes(p7) -- Line: 93
        -- upvalues: Umbra (copy), TweenService (copy), ParticleHandler (copy)
        local HSVShift = p7.HSVShift;
        local v8 = p7.Attacker:FindFirstChild("Stand") or p7.Attacker:FindFirstChild("Umbra");
        local HumanoidRootPart = p7.Attacker.HumanoidRootPart;
        local spike = Umbra.SwallowingVoid.spike;
        local v9 = Random.new();
        local v10 = {};

        for _ = 1, p7.Amount do
            local v11 = v9:NextNumber(5, 25);
            local v12 = v9:NextInteger(1, 360) * 6.283185307179586 / 360;
            local v13 = math.cos(v12) * v11;
            local v14 = math.sin(v12) * v11;
            local v15 = HumanoidRootPart.CFrame * CFrame.new(v13, 0, v14);
            local v16 = 0;
            local v17;

            repeat
                v17 = false;

                for _, v in v10 do
                    if (v.Position - v15.Position).Magnitude < 8 then
                        v17 = true;
                    end;
                end;

                if v17 then
                    local v18 = v9:NextNumber(5, 25);
                    local v19 = v9:NextInteger(1, 360) * 6.283185307179586 / 360;
                    local v20 = math.cos(v19) * v18;
                    local v21 = math.sin(v19) * v18;
                    v15 = HumanoidRootPart.CFrame * CFrame.new(v20, 0, v21);
                end;

                v16 = v16 + 1;
            until not v17 or v16 >= 5;

            table.insert(v10, v15);
            local u22 = v8:Clone();

            for _, descendant in u22:GetDescendants() do
                if descendant:IsA("Motor6D") then
                    descendant:Destroy();
                end;
            end;

            u22.PrimaryPart = u22.SwordHandle;
            u22:ScaleTo(u22:GetScale() * 2);
            local _, u23 = u22:GetBoundingBox();
            u22.PrimaryPart.Anchored = true;
            local v24 = v15 * CFrame.Angles(0, 0, 3.141592653589793);
            local Angles = CFrame.Angles;
            local v25 = v9:NextInteger(-30, 30);
            local v26 = math.rad(v25);
            local v27 = v9:NextInteger(-360, 360);
            local v28 = math.rad(v27);
            local v29 = v9:NextInteger(-30, 30);
            u22:PivotTo(v24 * Angles(v26, v28, (math.rad(v29))) + Vector3.new(0, -u23.Y, 0));
            u22.Parent = workspace.Effects;
            TweenService:Create(u22.PrimaryPart, TweenInfo.new(0.1, Enum.EasingStyle.Exponential), {
                CFrame = u22.PrimaryPart.CFrame + Vector3.new(0, u23.Y / 2, 0)
            }):Play();
            task.delay(1, function() -- Line: 159
                -- upvalues: TweenService (ref), u22 (copy), u23 (copy)
                TweenService:Create(u22.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
                    CFrame = u22.PrimaryPart.CFrame + Vector3.new(0, -u23.Y / 1.5, 0)
                }):Play();
                task.delay(1.5, u22.Destroy, u22);
            end);
            local v30 = spike:Clone();
            v30.CFrame = v15 + Vector3.new(0, -2.5, 0);

            if HSVShift then
                ParticleHandler.HSVShiftParticles(v30, HSVShift);
            end;

            v30.Parent = workspace.Effects;
            ParticleHandler.EmitFromAttribute(v30);
            ParticleHandler.DestroyByMaxLifetime(v30);
        end;
    end;

    function u2.UmbraBigSword(u31) -- Line: 179
        -- upvalues: PathShortcuts (copy), ParticleHandler (copy), TweenService (copy), TweenAndClean (copy), Umbra (copy), u2 (copy)
        local HSVShift = u31.HSVShift;
        local v32 = (u31.Attacker:FindFirstChild("Stand") or u31.Attacker:FindFirstChild("Umbra")):Clone();

        for _, descendant in v32:GetDescendants() do
            if descendant:IsA("Motor6D") then
                descendant:Destroy();
            end;
        end;

        local SwordHandle = v32.SwordHandle;
        SwordHandle.Anchored = true;
        v32:ScaleTo(20);
        local Origin = u31.Origin;
        SwordHandle.CFrame = Origin + Vector3.new(0, 230, 0);
        v32.Parent = workspace.Effects;

        if u31.Attacker:GetAttribute("ChromaUnusual") then
            PathShortcuts.Remotes.ClientBind:Fire(u31.Attacker, "Chroma", v32);
        end;

        if u31.FrameDelay then
            task.wait(u31.FrameDelay / 60);
        end;

        local function GroundImpactVFX(p33) -- Line: 210
            -- upvalues: u31 (copy), HSVShift (copy), ParticleHandler (ref), PathShortcuts (ref)
            p33.Anchored = true;
            p33.CFrame = u31.Origin + Vector3.new(0, -2.5, 0);

            if HSVShift then
                ParticleHandler.HSVShiftParticles(p33, HSVShift);
            end;

            if u31.Attacker:GetAttribute("ChromaUnusual") then
                PathShortcuts.Remotes.ClientBind:Fire(u31.Attacker, "Chroma", p33);
            end;

            p33.Parent = workspace.Effects;
            ParticleHandler.EmitFromAttribute(p33);
            ParticleHandler.DestroyByMaxLifetime(p33);
        end;

        TweenAndClean((TweenService:Create(SwordHandle, TweenInfo.new(0.1), {
            CFrame = Origin + Vector3.new(0, 104, 0)
        })));
        GroundImpactVFX(Umbra.Devastation["sword Impact"]:Clone());
        local u34 = Umbra.Devastation["sword enable"]:Clone();
        u34.Anchored = true;
        u34.CFrame = u31.Origin + Vector3.new(0, -2.5, 0);

        if HSVShift then
            ParticleHandler.HSVShiftParticles(u34, HSVShift);
        end;

        u34.Parent = workspace.Effects;
        ParticleHandler.EnableParticles(u34, true);
        task.delay(2, function() -- Line: 243
            -- upvalues: ParticleHandler (ref), u34 (copy)
            ParticleHandler.EnableParticles(u34, false);
            ParticleHandler.DestroyByMaxLifetime(u34);
        end);
        task.spawn(u2.UmbraBigSwordMeshes1, u31.Origin * CFrame.new(0, 30, 0) * CFrame.Angles(0, math.random(1, 360), 0));
        TweenAndClean((TweenService:Create(SwordHandle, TweenInfo.new(2), {
            CFrame = Origin + Vector3.new(0, 50, 0)
        })));
        task.spawn(u2.UmbraBigSwordMeshes2, u31.Origin * CFrame.new(0, 60, 0) * CFrame.Angles(0, math.random(1, 360), 0));
        local v35 = TweenService:Create(SwordHandle, TweenInfo.new(0.25), {
            CFrame = Origin + Vector3.new(0, -30, 0)
        });
        GroundImpactVFX(Umbra.Devastation["sword Impact2"]:Clone());
        TweenAndClean(v35, v32);
    end;

    function u2.UmbraBigSwordMeshes1(p36) -- Line: 264
        -- upvalues: Umbra (copy), TweenService (copy)
        if not p36 or typeof(p36) ~= "CFrame" then
            if p36 and typeof(p36) == "Vector3" then
                p36 = CFrame.new(p36);
            else
                p36 = nil;
            end;
        end;

        local v37 = p36 or CFrame.new(0, 0, 0);
        local Effects = workspace.Effects;
        local v38 = {
            [Umbra.Devastation.Meshes.impact1.m3] = {
                1.7,
                CFrame.new(
                    -0.106606282,
                    9.59004021,
                    -0.0247657895,
                    0.0000358295583,
                    0.866018772,
                    -0.500011623,
                    1,
                    -0.0000346022935,
                    0.0000117263844,
                    -7.14627959e-6,
                    -0.500011623,
                    -0.866018713
                ),
                0.4,
                {
                    {
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        {
                            Color = Color3.new(0.639216, 0.635294, 0.647059),
                            CFrame = v37 * CFrame.new(
                                -0.0013770574,
                                -35.1445503,
                                0.000564475602,
                                0.0000390107889,
                                0.866018414,
                                -0.50001204,
                                1,
                                -0.0000421079349,
                                5.08895027e-6,
                                -0.000016647351,
                                -0.500011981,
                                -0.866018534
                            ),
                            Transparency = 1,
                            Size = Vector3.new(31.504784, 92.156364, 92.156364)
                        }
                    },
                    {
                        Enum.EasingStyle.Cubic,
                        Enum.EasingDirection.Out,
                        {
                            Color3 = Color3.new(10.0196, 10.0196, 10.0196),
                            Transparency = 1
                        }
                    },
                    {
                        Enum.EasingStyle.Cubic,
                        Enum.EasingDirection.Out,
                        {
                            Scale = Vector3.new(1.3620211, 2.916117, 2.8394012),
                            VertexColor = Vector3.new(1, 1, 1),
                            Offset = Vector3.new(0, 0, 0)
                        }
                    }
                }
            },
            [Umbra.Devastation.Meshes.impact1.m2] = {
                1,
                CFrame.new(
                    -0.107979529,
                    -29.0536156,
                    -0.0241206065,
                    0.0000357336357,
                    0.866017878,
                    -0.500013053,
                    1,
                    -0.0000352950738,
                    0.0000103346674,
                    -8.69799078e-6,
                    -0.500013053,
                    -0.866017938
                ),
                0.6,
                {
                    {
                        Enum.EasingStyle.Cubic,
                        Enum.EasingDirection.Out,
                        {
                            Color = Color3.new(0.639216, 0.635294, 0.647059),
                            CFrame = v37 * CFrame.new(
                                0.0335125849,
                                -30.3047962,
                                0.0101011675,
                                0.0000465305311,
                                0.866018116,
                                -0.500012696,
                                1,
                                -0.0000434587128,
                                0.0000177885468,
                                -6.32470437e-6,
                                -0.500012696,
                                -0.866018057
                            ),
                            Transparency = 1,
                            Size = Vector3.new(21.826532, 73.8504, 73.8504)
                        }
                    },
                    {
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        {
                            Color3 = Color3.new(10.0196, 10.0196, 10.0196),
                            Transparency = 1
                        }
                    },
                    {
                        Enum.EasingStyle.Sine,
                        Enum.EasingDirection.Out,
                        {
                            Scale = Vector3.new(0.943609, 2.3368592, 2.275382),
                            VertexColor = Vector3.new(1, 1, 1),
                            Offset = Vector3.new(0, 0, 0)
                        }
                    }
                }
            },
            [Umbra.Devastation.Meshes.impact1.m4] = {
                1.9,
                CFrame.new(
                    -0.108106323,
                    -32.4086456,
                    -0.0240325741,
                    0.0000372180948,
                    0.866017699,
                    -0.500013769,
                    1,
                    -0.0000393704686,
                    0,
                    -0.0000142795034,
                    -0.500013351,
                    -0.866017401
                ),
                0.5,
                {
                    {
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        {
                            Color = Color3.new(0.639216, 0.635294, 0.647059),
                            CFrame = v37 * CFrame.new(
                                0.0268130898,
                                -24.8566437,
                                0.0083509339,
                                0.0000302845074,
                                0.866017878,
                                -0.500013053,
                                1,
                                -0.0000403259764,
                                -9.27678684e-6,
                                -0.0000281973789,
                                -0.500012994,
                                -0.866017938
                            ),
                            Transparency = 1,
                            Size = Vector3.new(40.717983, 65.16662, 65.16662)
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
                            Scale = Vector3.new(1.7603278, 2.0620768, 2.0078287),
                            VertexColor = Vector3.new(1, 1, 1),
                            Offset = Vector3.new(0, 0, 0)
                        }
                    }
                }
            },
            [Umbra.Devastation.Meshes.impact1.m1] = {
                0.7,
                CFrame.new(
                    -0.107749149,
                    -13.922431,
                    -0.0242845304,
                    0.0000144196674,
                    -0.0000154674053,
                    -1,
                    1,
                    0,
                    0.0000144200167,
                    0,
                    -1,
                    0.0000153183937
                ),
                0,
                {
                    {
                        Enum.EasingStyle.Cubic,
                        Enum.EasingDirection.Out,
                        {
                            Color = Color3.new(0.639216, 0.635294, 0.647059),
                            CFrame = v37 * CFrame.new(
                                -0.0387510881,
                                -28.1135197,
                                -0.096847795,
                                0.0000174514644,
                                -0.0000154082281,
                                -1,
                                1,
                                -0.0000107446131,
                                0.0000174516299,
                                -0.0000107448805,
                                -1,
                                0.0000154080408
                            ),
                            Transparency = 1,
                            Size = Vector3.new(17.442612, 51.468315, 51.468315)
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
                            Scale = Vector3.new(0.7540825, 1.6286194, 1.5857742),
                            VertexColor = Vector3.new(1, 1, 1),
                            Offset = Vector3.new(0, 0, 0)
                        }
                    }
                }
            }
        };

        for i, v in pairs(v38) do
            local v39 = i.Start:Clone();
            v39.Name = i.Name;
            v39.Transparency = v[3];

            if v39:FindFirstChildOfClass("Decal") then
                v39:FindFirstChildOfClass("Decal").Transparency = v[3];
                v39.Transparency = 1;
            end;

            v39.Anchored = true;
            v39.CanCollide = false;
            v39.CanQuery = false;
            v39.CanTouch = false;
            v39.Locked = true;
            v39.CFrame = v37 * v[2];
            v39.Parent = Effects;
            TweenService:Create(v39, TweenInfo.new(v[1], v[4][1][1], v[4][1][2]), v[4][1][3]):Play();

            if v[4][2] then
                TweenService:Create(v39:FindFirstChildOfClass("Decal"), TweenInfo.new(v[1], v[4][2][1], v[4][2][2]), v[4][2][3]):Play();
            end;

            if v[4][3] then
                TweenService:Create(v39:FindFirstChildOfClass("SpecialMesh"), TweenInfo.new(v[1], v[4][3][1], v[4][3][2]), v[4][3][3]):Play();
            end;

            task.delay(v[1], v39.Destroy, v39);
        end;
    end;

    function u2.UmbraBigSwordMeshes2(p40) -- Line: 310
        -- upvalues: Umbra (copy), TweenService (copy)
        if not p40 or typeof(p40) ~= "CFrame" then
            if p40 and typeof(p40) == "Vector3" then
                p40 = CFrame.new(p40);
            else
                p40 = nil;
            end;
        end;

        local v41 = p40 or CFrame.new(0, 0, 0);
        local Effects = workspace.Effects;
        local v42 = {
            [Umbra.Devastation.Meshes.impact2.m2] = {
                1,
                CFrame.new(
                    -0.181030184,
                    -48.6049004,
                    -0.0411170125,
                    0.0000357338686,
                    0.866018057,
                    -0.500012815,
                    1,
                    -0.0000352952738,
                    0.0000103347938,
                    -8.69797077e-6,
                    -0.500012875,
                    -0.866018057
                ),
                0.6,
                {
                    {
                        Enum.EasingStyle.Cubic,
                        Enum.EasingDirection.Out,
                        {
                            Color = Color3.new(0.639216, 0.635294, 0.647059),
                            CFrame = v41 * CFrame.new(
                                0.0557122752,
                                -50.6980362,
                                0.0161155052,
                                0.000046532361,
                                0.866017044,
                                -0.500014544,
                                1,
                                -0.0000381041318,
                                0.0000270662858,
                                4.38724419e-6,
                                -0.500014603,
                                -0.866016984
                            ),
                            Transparency = 1,
                            Size = Vector3.new(36.51395, 123.545494, 123.545494)
                        }
                    },
                    {
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        {
                            Color3 = Color3.new(10.0196, 10.0196, 10.0196),
                            Transparency = 1
                        }
                    },
                    {
                        Enum.EasingStyle.Sine,
                        Enum.EasingDirection.Out,
                        {
                            Scale = Vector3.new(1.5785784, 3.9093685, 3.8065224),
                            VertexColor = Vector3.new(1, 1, 1),
                            Offset = Vector3.new(0, 0, 0)
                        }
                    }
                }
            },
            [Umbra.Devastation.Meshes.impact2.m4] = {
                1.9,
                CFrame.new(
                    -0.181279689,
                    -54.2175865,
                    -0.0411365479,
                    0.0000372180948,
                    0.866017699,
                    -0.500013888,
                    1,
                    -0.0000393704686,
                    2.20081071e-12,
                    -0.000014279507,
                    -0.500013351,
                    -0.86601764
                ),
                0.5,
                {
                    {
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        {
                            Color = Color3.new(0.639216, 0.635294, 0.647059),
                            CFrame = v41 * CFrame.new(
                                0.0439195037,
                                -41.5836906,
                                0.0132085811,
                                0.0000302861681,
                                0.866016746,
                                -0.50001508,
                                1,
                                -0.0000349718102,
                                -1.36424205e-11,
                                -0.0000174864417,
                                -0.50001514,
                                -0.866016686
                            ),
                            Transparency = 1,
                            Size = Vector3.new(68.11776, 109.01827, 109.01827)
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
                            Scale = Vector3.new(2.9448802, 3.4496808, 3.3589284),
                            VertexColor = Vector3.new(1, 1, 1),
                            Offset = Vector3.new(0, 0, 0)
                        }
                    }
                }
            },
            [Umbra.Devastation.Meshes.impact2.m3] = {
                1.7,
                CFrame.new(
                    -0.178758234,
                    16.042717,
                    -0.0415677875,
                    0.0000358295583,
                    0.866019547,
                    -0.500010192,
                    1,
                    -0.0000346023189,
                    0.0000117263126,
                    -7.14629596e-6,
                    -0.500010252,
                    -0.866019487
                ),
                0.4,
                {
                    {
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        {
                            Color = Color3.new(0.639216, 0.635294, 0.647059),
                            CFrame = v41 * CFrame.new(
                                -0.00232016691,
                                -58.7945023,
                                0.00036427725,
                                0.0000390127971,
                                0.866018116,
                                -0.500012815,
                                1,
                                -0.0000367539833,
                                0.0000143660118,
                                -5.93623736e-6,
                                -0.500012994,
                                -0.866017878
                            ),
                            Transparency = 1,
                            Size = Vector3.new(52.704845, 154.16983, 154.16983)
                        }
                    },
                    {
                        Enum.EasingStyle.Cubic,
                        Enum.EasingDirection.Out,
                        {
                            Color3 = Color3.new(10.0196, 10.0196, 10.0196),
                            Transparency = 1
                        }
                    },
                    {
                        Enum.EasingStyle.Cubic,
                        Enum.EasingDirection.Out,
                        {
                            Scale = Vector3.new(2.2785463, 4.878418, 4.750079),
                            VertexColor = Vector3.new(1, 1, 1),
                            Offset = Vector3.new(0, 0, 0)
                        }
                    }
                }
            },
            [Umbra.Devastation.Meshes.impact2.m1] = {
                0.7,
                CFrame.new(
                    -0.180662781,
                    -23.291687,
                    -0.0411206633,
                    0.000014416175,
                    -0.0000169575214,
                    -1,
                    1,
                    -2.20885865e-9,
                    0.0000144235091,
                    2.23039964e-9,
                    -1,
                    0.0000138282776
                ),
                0,
                {
                    {
                        Enum.EasingStyle.Cubic,
                        Enum.EasingDirection.Out,
                        {
                            Color = Color3.new(0.639216, 0.635294, 0.647059),
                            CFrame = v41 * CFrame.new(
                                -0.0653472319,
                                -47.0322838,
                                -0.163067028,
                                0.0000174498236,
                                -0.0000187754631,
                                -1,
                                1,
                                -3.55876182e-8,
                                0.0000174571614,
                                -3.12174961e-8,
                                -1,
                                0.0000158250332
                            ),
                            Transparency = 1,
                            Size = Vector3.new(29.18002, 86.10215, 86.10215)
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
                            Scale = Vector3.new(1.2615165, 2.7245429, 2.6528666),
                            VertexColor = Vector3.new(1, 1, 1),
                            Offset = Vector3.new(0, 0, 0)
                        }
                    }
                }
            }
        };

        for i, v in pairs(v42) do
            local v43 = i.Start:Clone();
            v43.Name = i.Name;
            v43.Transparency = v[3];

            if v43:FindFirstChildOfClass("Decal") then
                v43:FindFirstChildOfClass("Decal").Transparency = v[3];
                v43.Transparency = 1;
            end;

            v43.Anchored = true;
            v43.CanCollide = false;
            v43.CanQuery = false;
            v43.CanTouch = false;
            v43.Locked = true;
            v43.CFrame = v41 * v[2];
            v43.Parent = Effects;
            TweenService:Create(v43, TweenInfo.new(v[1], v[4][1][1], v[4][1][2]), v[4][1][3]):Play();

            if v[4][2] then
                TweenService:Create(v43:FindFirstChildOfClass("Decal"), TweenInfo.new(v[1], v[4][2][1], v[4][2][2]), v[4][2][3]):Play();
            end;

            if v[4][3] then
                TweenService:Create(v43:FindFirstChildOfClass("SpecialMesh"), TweenInfo.new(v[1], v[4][3][1], v[4][3][2]), v[4][3][3]):Play();
            end;

            task.delay(v[1], v43.Destroy, v43);
        end;
    end;

    function u2.UmbraFallenLeavesAfterimage(p44) -- Line: 356
        -- upvalues: GetCloneColor (copy), CreateAfterimage (copy), AnimationHandler (copy), CloneTeleportVFX (copy), Umbra (copy), ParticleHandler (copy)
        local Attacker = p44.Attacker;
        local HumanoidRootPart = Attacker.HumanoidRootPart;
        local v45 = Random.new();
        local v46 = {
            VFX = false,
            Properties = {
                Start = {
                    Transparency = 0.75,
                    Color = GetCloneColor(p44.Skin, {
                        HSVShift = p44.HSVShift
                    })
                }
            }
        };

        local function CalculateAngleOffset(p47, p48) -- Line: 378
            local v49 = p47 * 6.283185307179586 / 360;
            local v50 = math.cos(v49) * p48;
            local v51 = math.sin(v49) * p48;

            return CFrame.new(v50, 0, v51);
        end;

        for _ = 1, p44.Hits do
            for _ = 1, v45:NextInteger(p44.CloneRange.Min, p44.CloneRange.Max) do
                local CFrame2 = HumanoidRootPart.CFrame;
                local v52 = v45:NextInteger(1, 360);
                local v53 = v45:NextNumber(0, 8);
                local v54 = v52 * 6.283185307179586 / 360;
                local v55 = math.cos(v54) * v53;
                local v56 = math.sin(v54) * v53;
                local v57 = CFrame2 * CFrame.new(v55, 0, v56);
                local v58 = v45:NextInteger(1, 360);
                local v59 = v45:NextNumber(20, 30);
                local v60 = v58 * 6.283185307179586 / 360;
                local v61 = math.cos(v60) * v59;
                local v62 = math.sin(v60) * v59;
                local v63 = CFrame.new(v61, 0, v62);
                local u64 = CFrame.lookAt((v57 * v63).Position, v57.Position);
                local v65 = v57 * CFrame.new(-v63.X, 0, -v63.Z);
                local u66 = CFrame.lookAt(v57.Position, v65.Position) + (v65.Position - v57.Position);
                v46.Origin = u64;
                local u67 = CreateAfterimage(Attacker, v46);

                for _, descendant in u67:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        descendant.CollisionGroup = "BypassAll";
                    end;
                end;

                local AnimationController = Instance.new("AnimationController");
                local Animator = Instance.new("Animator");
                Animator.Parent = AnimationController;
                AnimationController.Parent = u67;
                Animator.AncestryChanged:Connect(function(p68, p69) -- Line: 414
                    -- upvalues: Animator (copy), AnimationHandler (ref)
                    if not Animator:IsDescendantOf(workspace) then
                        return;
                    end;

                    local v70 = AnimationHandler.CreateAnimations("Umbra");
                    local v71 = AnimationHandler.new(Animator);
                    v71:AddAnimations(v70);
                    v71:PlayAnimation("Clear Clouds Loop"):AdjustSpeed(0);
                end);
                local u72 = 0;
                local FrameYield = p44.FrameYield;
                local u73 = 0;
                local u74 = {
                    TweenData = {
                        End = { 0.25, Enum.EasingStyle.Sine }
                    },
                    Properties = {
                        Start = {
                            Transparency = 0.75,
                            Color = GetCloneColor(p44.Skin, {
                                HSVShift = p44.HSVShift
                            })
                        },
                        End = {
                            Transparency = 1
                        }
                    }
                };
                local u75 = CloneTeleportVFX(p44.Skin, {
                    Character = Attacker,
                    TeleportVFX = Umbra.TeleportEffects.Teleport_FallenLeaves,
                    HSVShift = p44.HSVShift
                });
                u75.CFrame = u64;
                u75.Parent = workspace.Effects;
                ParticleHandler.EmitFromAttribute(u75);
                task.spawn(function() -- Line: 453
                    -- upvalues: u72 (ref), FrameYield (copy), u67 (copy), u64 (ref), u66 (ref), u73 (ref), u74 (copy), CreateAfterimage (ref), u75 (copy), ParticleHandler (ref)
                    while u72 < FrameYield do
                        u72 = u72 + task.wait() * 60;
                        u67.HumanoidRootPart.CFrame = u64:Lerp(u66, u72 / FrameYield);
                        u73 = u73 + 1;

                        if u73 % 3 == 0 then
                            u74.Origin = u67.HumanoidRootPart.CFrame;
                            local v76 = CreateAfterimage(u67, u74);
                            task.delay(0.5, v76.Destroy, v76);
                        end;
                    end;

                    u75.CFrame = u66;
                    ParticleHandler.EmitFromAttribute(u75);
                    ParticleHandler.DestroyByMaxLifetime(u75);
                    u67:Destroy();
                end);
            end;

            task.wait(p44.FrameYield / 60);
        end;
    end;

    function u2.UmbraFallenLeavesSlashes(p77) -- Line: 478
        -- upvalues: Umbra (copy), ParticleHandler (copy)
        local HumanoidRootPart = p77.Attacker.HumanoidRootPart;
        local u78 = Umbra.FallenLeaves.fxMid:Clone();
        u78.CFrame = HumanoidRootPart.CFrame;

        if p77.HSVShift then
            ParticleHandler.HSVShiftParticles(u78, p77.HSVShift);
        end;

        u78.Parent = workspace.Effects;
        ParticleHandler.EnableParticles(u78, true);
        task.delay(p77.Duration, function() -- Line: 492
            -- upvalues: ParticleHandler (ref), u78 (copy)
            ParticleHandler.EnableParticles(u78, false);
            ParticleHandler.DestroyByMaxLifetime(u78);
        end);
    end;

    function u2.UmbraFallenLeavesFinisher(p79) -- Line: 498
        -- upvalues: Umbra (copy), ParticleHandler (copy)
        local HumanoidRootPart = p79.Attacker.HumanoidRootPart;
        local u80 = Umbra.FallenLeaves.fxEndTornado:Clone();
        u80.CFrame = HumanoidRootPart.CFrame;

        if p79.HSVShift then
            ParticleHandler.HSVShiftParticles(u80, p79.HSVShift);
        end;

        u80.Parent = workspace.Effects;
        ParticleHandler.EnableParticles(u80, true);
        task.delay(0.75, function() -- Line: 512
            -- upvalues: ParticleHandler (ref), u80 (copy)
            ParticleHandler.EnableParticles(u80, false);
            ParticleHandler.DestroyByMaxLifetime(u80);
        end);
    end;

    function u2.UmbraSwordImpalement(p81) -- Line: 518
        -- upvalues: TweenService (copy), Umbra (copy), ParticleHandler (copy)
        local _ = p81.Attacker.HumanoidRootPart;
        local HumanoidRootPart = p81.Target.HumanoidRootPart;
        local HSVShift = p81.HSVShift;
        local v82 = Random.new();
        local CFrame2 = HumanoidRootPart.CFrame;
        local u83 = (p81.Attacker:FindFirstChild("Stand") or p81.Attacker:FindFirstChild("Umbra")):Clone();

        for _, descendant in u83:GetDescendants() do
            if descendant:IsA("Motor6D") then
                descendant:Destroy();
            end;
        end;

        u83.PrimaryPart = u83.SwordHandle;
        u83:ScaleTo(u83:GetScale() * 2);
        local _, u84 = u83:GetBoundingBox();
        u83.PrimaryPart.Anchored = true;
        local v85 = CFrame2 * CFrame.Angles(0, 0, 3.141592653589793);
        local Angles = CFrame.Angles;
        local v86 = v82:NextInteger(-15, 15);
        local v87 = math.rad(v86);
        local v88 = v82:NextInteger(-360, 360);
        local v89 = math.rad(v88);
        local v90 = v82:NextInteger(-15, 15);
        u83:PivotTo(v85 * Angles(v87, v89, (math.rad(v90))) + Vector3.new(0, -u84.Y, 0));
        u83.Parent = workspace.Effects;
        TweenService:Create(u83.PrimaryPart, TweenInfo.new(0.1, Enum.EasingStyle.Exponential), {
            CFrame = u83.PrimaryPart.CFrame + Vector3.new(0, u84.Y / 2, 0)
        }):Play();
        local v91 = Umbra.SwordImpale.vfxSpike:Clone();
        v91.CFrame = CFrame2;

        if HSVShift then
            ParticleHandler.HSVShiftParticles(v91, HSVShift);
        end;

        v91.Parent = workspace.Effects;
        ParticleHandler.EmitFromAttribute(v91);
        ParticleHandler.DestroyByMaxLifetime(v91);
        task.delay(1, function() -- Line: 563
            -- upvalues: TweenService (ref), u83 (ref), u84 (copy)
            TweenService:Create(u83.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
                CFrame = u83.PrimaryPart.CFrame + Vector3.new(0, -u84.Y / 1.5, 0)
            }):Play();
            task.delay(1.5, u83.Destroy, u83);
        end);
    end;

    function u2.UmbraSovereignAwaken(p92) -- Line: 572
        -- upvalues: Umbra (copy), u3 (copy), ParticleHandler (copy), TableUtil (copy), TweenService (copy), Sequence_V2 (copy)
        local HSVShift = p92.HSVShift;
        local Attacker = p92.Attacker;
        local HumanoidRootPart = Attacker.HumanoidRootPart;
        local AwakenEffects = Umbra.AwakenEffects;
        local u93 = u3.UmbraAwakenHighlight:Clone();

        if HSVShift then
            u93.OutlineColor = ParticleHandler.HSVShiftColor(u93.OutlineColor, HSVShift);
        end;

        local u94 = {};

        for _, child in AwakenEffects:GetChildren() do
            if child.Name ~= "AwakenAura" and (child.Name ~= "SwordAwakenAura" and (child.Name ~= "UmbraAwakenHighlight" and child.Name ~= "SovereignSigil")) then
                local v95 = child:Clone();
                v95.Anchored = true;
                v95.CFrame = HumanoidRootPart.CFrame;

                if HSVShift then
                    ParticleHandler.HSVShiftParticles(v95, HSVShift);
                end;

                v95.Parent = workspace.Effects;
                u94[v95.Name] = v95;
            end;
        end;

        local function EnableParticles(p96, p97, p98) -- Line: 604
            for _, descendant in p96:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and (not p98 or descendant.Name:find(p98)) then
                    descendant.Enabled = p97;
                end;
            end;
        end;

        local function GlitchParticles(p99, p100) -- Line: 612
            -- upvalues: ParticleHandler (ref), u94 (copy), EnableParticles (copy)
            if p100 then
                ParticleHandler.EmitFromAttribute(u94.UmbraAwakenEmit);
            end;

            if p99 == nil then
                return;
            end;

            EnableParticles(u94.UmbraAwakenEnable, p99, "Glitch");
        end;

        local function ChargeParticles(p101, p102) -- Line: 621
            -- upvalues: EnableParticles (copy), u94 (copy)
            if p101 == nil then
                return;
            end;

            EnableParticles(u94.UmbraAwakenEnable, p101, "Charge");
        end;

        local function BurstParticles(p103, p104) -- Line: 626
            -- upvalues: ParticleHandler (ref), u94 (copy)
            if p104 then
                ParticleHandler.EmitFromAttribute(u94.UmbraAwakenBurstEmit);
            end;

            if p103 == nil then
                return;
            end;

            for _, descendant in u94.UmbraAwakenBurstEnable:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = p103;
                end;
            end;
        end;

        local function HighlightTween(p105, p106, p107) -- Line: 635
            -- upvalues: TableUtil (ref), TweenService (ref), u93 (copy)
            local v108 = TableUtil.Reconcile(p107, {
                RepeatCount = 0,
                Reverses = false,
                DelayTime = 0,
                EasingStyle = Enum.EasingStyle.Quad,
                EasingDirection = Enum.EasingDirection.Out
            });
            TweenService:Create(u93, TweenInfo.new((p106 - p105) / 60, v108.EasingStyle, v108.EasingDirection, v108.RepeatCount, v108.Reverses, v108.DelayTime), v108.Values):Play();
        end;

        local v109 = {
            { 21, function() -- Line: 651
                    -- upvalues: u94 (copy), HighlightTween (copy)
                    for _, descendant in u94.UmbraAwakenEnable:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") and descendant.Name:find("Glitch") then
                            descendant.Enabled = true;
                        end;
                    end;

                    HighlightTween(21, 30, {
                        Reverses = true,
                        Values = {
                            OutlineTransparency = 0,
                            FillTransparency = 0
                        }
                    });
                end },
            { 32, function() -- Line: 662
                    -- upvalues: u94 (copy)
                    for _, descendant in u94.UmbraAwakenEnable:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") and descendant.Name:find("Glitch") then
                            descendant.Enabled = false;
                        end;
                    end;
                end },
            { 78, function() -- Line: 666
                    -- upvalues: u94 (copy), HighlightTween (copy)
                    for _, descendant in u94.UmbraAwakenEnable:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") and descendant.Name:find("Glitch") then
                            descendant.Enabled = true;
                        end;
                    end;

                    HighlightTween(78, 90, {
                        Reverses = true,
                        Values = {
                            OutlineTransparency = 0,
                            FillTransparency = 0
                        }
                    });
                end },
            { 93, function() -- Line: 677
                    -- upvalues: u94 (copy)
                    for _, descendant in u94.UmbraAwakenEnable:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") and descendant.Name:find("Glitch") then
                            descendant.Enabled = false;
                        end;
                    end;
                end },
            { 220, function() -- Line: 681
                    -- upvalues: u94 (copy)
                    for _, descendant in u94.UmbraAwakenEnable:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") and descendant.Name:find("Glitch") then
                            descendant.Enabled = true;
                        end;
                    end;
                end },
            { 221, function() -- Line: 685
                    -- upvalues: HighlightTween (copy)
                    HighlightTween(221, 242, {
                        Reverses = true,
                        Values = {
                            OutlineTransparency = 0,
                            FillTransparency = 0
                        }
                    });
                end },
            { 230, function() -- Line: 695
                    -- upvalues: ParticleHandler (ref), u94 (copy)
                    ParticleHandler.EmitFromAttribute(u94.UmbraAwakenEmit);
                end },
            { 238, function() -- Line: 699
                    -- upvalues: u94 (copy)
                    for _, descendant in u94.UmbraAwakenEnable:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") and descendant.Name:find("Glitch") then
                            descendant.Enabled = false;
                        end;
                    end;
                end },
            { 259, function() -- Line: 703
                    -- upvalues: u94 (copy)
                    for _, descendant in u94.UmbraAwakenEnable:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") and descendant.Name:find("Glitch") then
                            descendant.Enabled = true;
                        end;
                    end;

                    for _, descendant in u94.UmbraAwakenEnable:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") and descendant.Name:find("Charge") then
                            descendant.Enabled = true;
                        end;
                    end;
                end },
            { 286, function() -- Line: 708
                    -- upvalues: HighlightTween (copy)
                    HighlightTween(286, 322, {
                        EasingStyle = Enum.EasingStyle.Sine,
                        EasingDirection = Enum.EasingDirection.InOut,
                        Values = {
                            OutlineTransparency = 0,
                            FillTransparency = 0
                        }
                    });
                end },
            { 328, function() -- Line: 719
                    -- upvalues: u94 (copy)
                    for _, descendant in u94.UmbraAwakenEnable:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") and descendant.Name:find("Glitch") then
                            descendant.Enabled = false;
                        end;
                    end;
                end },
            { 335, function() -- Line: 723
                    -- upvalues: u94 (copy), ParticleHandler (ref)
                    for _, descendant in u94.UmbraAwakenEnable:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") and descendant.Name:find("Charge") then
                            descendant.Enabled = false;
                        end;
                    end;

                    ParticleHandler.EmitFromAttribute(u94.UmbraAwakenBurstEmit);

                    for _, descendant in u94.UmbraAwakenBurstEnable:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.Enabled = true;
                        end;
                    end;
                end },
            { 380, function() -- Line: 728
                    -- upvalues: u94 (copy), HighlightTween (copy)
                    for _, descendant in u94.UmbraAwakenBurstEnable:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.Enabled = false;
                        end;
                    end;

                    HighlightTween(380, 440, {
                        EasingStyle = Enum.EasingStyle.Linear,
                        Values = {
                            OutlineTransparency = 1,
                            FillTransparency = 1
                        }
                    });
                end },
            { 500, function() -- Line: 739
                    -- upvalues: u94 (copy), ParticleHandler (ref), u93 (copy)
                    for _, v in u94 do
                        ParticleHandler.DestroyByMaxLifetime(v);
                    end;

                    u93:Destroy();
                end }
        };
        u93.Parent = Attacker;
        Sequence_V2.CreateFromOldSequence({
            Frames = v109
        }):Play();
    end;

    function u2.UmbraDevastationHandVFX(p110) -- Line: 755
        -- upvalues: Umbra (copy), ParticleHandler (copy)
        local HSVShift = p110.HSVShift;
        local Attacker = p110.Attacker;
        local HumanoidRootPart = Attacker.HumanoidRootPart;
        local v111 = Attacker["Left Arm"];
        local Head = Attacker.Head;
        local v112 = Umbra.Devastation.Prepare:Clone();
        local v113 = Umbra.Devastation.PrepareEnable:Clone();
        local u114 = Umbra.Devastation.fxGroundEnable:Clone();
        local u115 = Umbra.Devastation.EyeStar:Clone();
        ParticleHandler.AttachParticle(v112, v111, {
            C0 = CFrame.new(0, 1, 0)
        });
        ParticleHandler.AttachParticle(u114, HumanoidRootPart);
        ParticleHandler.AttachParticle(u115, Head);

        if HSVShift then
            ParticleHandler.HSVShiftParticles(v112, HSVShift);
            ParticleHandler.HSVShiftParticles(v113, HSVShift);
            ParticleHandler.HSVShiftParticles(u114, HSVShift);
            ParticleHandler.HSVShiftParticles(u115, HSVShift);
        end;

        v112.Parent = workspace.Effects;
        u114.Parent = workspace.Effects;
        ParticleHandler.EmitFromAttribute(v112);
        ParticleHandler.DestroyByMaxLifetime(v112);
        ParticleHandler.EnableParticles(u114, true);
        task.delay(1.3, function() -- Line: 788
            -- upvalues: ParticleHandler (ref), u114 (copy)
            ParticleHandler.EnableParticles(u114, false);
            ParticleHandler.DestroyByMaxLifetime(u114);
        end);
        ParticleHandler.AttachParticle(v113, v111, {
            C0 = CFrame.new(0, 1, 0)
        });
        v113.Parent = workspace.Effects;
        ParticleHandler.EnableParticles(v113, true);
        u115.Parent = workspace.Effects;
        ParticleHandler.EnableParticles(u115, true);
        task.delay(1.3, function() -- Line: 802
            -- upvalues: ParticleHandler (ref), u115 (copy)
            ParticleHandler.EnableParticles(u115, false);
            ParticleHandler.DestroyByMaxLifetime(u115);
        end);

        if p110.FrameDelay then
            task.wait(p110.FrameDelay / 60);
        end;

        ParticleHandler.EnableParticles(v113, false);
        ParticleHandler.DestroyByMaxLifetime(v113);
    end;

    function u2.UmbraSwordImpaleHandVFX(p116) -- Line: 813
        -- upvalues: Umbra (copy), ParticleHandler (copy)
        local HSVShift = p116.HSVShift;
        local Attacker = p116.Attacker;
        local v117 = Attacker["Left Arm"];
        local v118 = Umbra.SwordImpale.PrepareEnable:Clone();
        v118.Anchored = false;
        ParticleHandler.AttachParticle(v118, v117);

        if HSVShift then
            ParticleHandler.HSVShiftParticles(v118, HSVShift);
        end;

        v118.Parent = workspace.Effects;
        ParticleHandler.EnableParticles(v118, true);

        while Attacker:GetAttribute("SwordImpaleCharge") do
            task.wait(0.1);
        end;

        ParticleHandler.EnableParticles(v118, false);
        ParticleHandler.DestroyByMaxLifetime(v118);
    end;

    function u2.UmbraAscendedPunishmentVFX(p119) -- Line: 839
        -- upvalues: Umbra (copy), ParticleHandler (copy), PathShortcuts (copy), PaleVisual (copy), Sequence_V2 (copy)
        local HSVShift = p119.HSVShift;
        local Attacker = p119.Attacker;
        local HumanoidRootPart = Attacker.HumanoidRootPart;
        local Torso = Attacker.Torso;
        local AscendedPunishment = Umbra.AscendedPunishment;
        local u120 = Attacker:GetAttribute("ChromaUnusual");
        Sequence_V2.CreateFromOldSequence({
            Frames = {
                { 0, function(p121, p122, p123) -- Line: 849
                        -- upvalues: HSVShift (copy), ParticleHandler (ref), u120 (copy), PathShortcuts (ref), Attacker (copy), HumanoidRootPart (copy)
                        if HSVShift then
                            for _, v in p123 do
                                ParticleHandler.HSVShiftParticles(v, HSVShift);

                                if u120 then
                                    PathShortcuts.Remotes.ClientBind:Fire(Attacker, "Chroma", v);
                                end;
                            end;
                        end;

                        p123.JumpChargeVFX.CFrame = HumanoidRootPart.CFrame;
                        p123.JumpChargeVFX.Parent = workspace.Effects;
                        ParticleHandler.EnableParticles(p123.JumpChargeVFX, true);
                    end },
                { 40, function(p124, p125, p126) -- Line: 864
                        -- upvalues: ParticleHandler (ref), HumanoidRootPart (copy)
                        ParticleHandler.EnableParticles(p126.JumpChargeVFX, false);
                        p126.JumpVFX.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
                        p126.JumpVFX.Parent = workspace.Effects;
                        ParticleHandler.EmitFromAttribute(p126.JumpVFX);
                        local v127 = ParticleHandler.AttachParticle(p126.TrailJumpVFX, HumanoidRootPart);
                        p126.TrailJumpVFX.Anchored = false;
                        p126.TrailJumpVFX.Parent = workspace.Effects;
                        ParticleHandler.EnableParticles(p126.TrailJumpVFX, true);
                        local v128 = os.clock();

                        while os.clock() - v128 < 0.8333333333333334 do
                            v127.C0 = v127.C0 * CFrame.Angles(0, 0.08726646259971647, 0);
                            task.wait();
                        end;
                    end },
                { 90, function(p129, p130, p131) -- Line: 885
                        -- upvalues: ParticleHandler (ref), Torso (copy), PaleVisual (ref), HumanoidRootPart (copy), AscendedPunishment (copy), HSVShift (copy)
                        ParticleHandler.EnableAllParticles(p131.TrailJumpVFX, false);
                        p131.ChargeVFX.Anchored = false;
                        ParticleHandler.AttachParticle(p131.ChargeVFX, Torso);
                        p131.ChargeVFX.Parent = workspace.Effects;
                        ParticleHandler.EnableParticles(p131.ChargeVFX, true);
                        task.spawn(PaleVisual.BezierCurve, {
                            Amount = 40,
                            Duration = 0.15,
                            Delay = 0.0005,
                            Origin = HumanoidRootPart,
                            Object = AscendedPunishment.Trail,
                            HSVShift = HSVShift,
                            Points = {
                                {
                                    X = { -100, 100 },
                                    Y = { -100, 100 },
                                    Z = { -100, 100 }
                                },
                                {
                                    X = { -100, 100 },
                                    Y = { -50, 50 },
                                    Z = { 100, -100 }
                                },
                                HumanoidRootPart.Position
                            }
                        });
                    end },
                { 155, function(p132, p133, p134) -- Line: 915
                        -- upvalues: ParticleHandler (ref), HumanoidRootPart (copy), Attacker (copy)
                        ParticleHandler.EnableParticles(p134.ChargeVFX, false);
                        p134.PortalVFX.Anchored = false;
                        local v135 = ParticleHandler.AttachParticle(p134.PortalVFX, HumanoidRootPart);
                        v135.C0 = CFrame.new(0, 0, -20) * CFrame.Angles(0.7853981633974483, 0, 0);
                        p134.PortalVFX.Parent = workspace.Effects;
                        ParticleHandler.EnableParticles(p134.PortalVFX, true);

                        while Attacker:GetAttribute("AscendedPunishmentCharge") do
                            task.wait(0.1);
                        end;

                        v135:Destroy();
                        p134.PortalVFX.Anchored = true;
                        ParticleHandler.EnableParticles(p134.PortalVFX, false);

                        for _, v in p134 do
                            ParticleHandler.DestroyByMaxLifetime(v);
                        end;

                        table.clear(p134);
                    end }
            }
        }):Play({
            JumpChargeVFX = AscendedPunishment.Charge:Clone(),
            JumpVFX = AscendedPunishment.Jump:Clone(),
            TrailJumpVFX = AscendedPunishment.TrailJump:Clone(),
            ChargeVFX = AscendedPunishment.ChargeInAir:Clone(),
            PortalVFX = AscendedPunishment.Portal:Clone()
        });
    end;

    function u2.UmbraSwordRain(p136) -- Line: 954
        -- upvalues: Umbra (copy), ParticleHandler (copy), TweenService (copy)
        local HSVShift = p136.HSVShift;
        local HumanoidRootPart = p136.Attacker.HumanoidRootPart;
        local v137 = p136.Attacker:FindFirstChild("Stand") or p136.Attacker:FindFirstChild("Umbra");
        local SwordHit = Umbra.AscendedPunishment.SwordHit;
        local SwordTrail = Umbra.AscendedPunishment.SwordTrail;
        local v138 = Random.new();
        local v139 = RaycastParams.new();
        v139.FilterDescendantsInstances = { workspace.Map };
        v139.FilterType = Enum.RaycastFilterType.Include;
        v139.IgnoreWater = true;
        local v140 = 0;

        while v140 < p136.Duration do
            local v141 = v138:NextInteger(0, 50);
            local v142 = v138:NextInteger(1, 360) * 6.283185307179586 / 360;
            local v143 = math.cos(v142) * v141;
            local v144 = math.sin(v142) * v141;
            local v145 = HumanoidRootPart.CFrame * CFrame.new(v143, v138:NextInteger(25, 50), v144);
            local u146 = v137:Clone();

            for _, descendant in u146:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Motor6D") then
                    descendant:Destroy();
                end;
            end;

            u146:ScaleTo(2);
            u146.PrimaryPart = u146.SwordHandle;
            u146.PrimaryPart.Anchored = true;
            local _, v147 = u146:GetBoundingBox();
            local Angles = CFrame.Angles;
            local v148 = v138:NextInteger(15, 45);
            u146:PivotTo(v145 * Angles(math.rad(v148), 1.5707963267948966, 0));
            u146.Parent = workspace.Effects;
            local v149 = SwordTrail:Clone();
            v149.CollisionGroup = "BypassAll";
            v149.Anchored = false;
            ParticleHandler.AttachParticle(v149, u146.SwordHandle, {
                C0 = CFrame.new(0, 10, 0)
            });

            if HSVShift then
                ParticleHandler.HSVShiftParticles(v149, HSVShift);
            end;

            v149.Parent = u146;
            local v150 = workspace:Raycast(u146.PrimaryPart.Position, -u146.PrimaryPart.CFrame.UpVector * 100, v139);
            local u151 = u146.PrimaryPart.CFrame + -u146.PrimaryPart.CFrame.UpVector * 100;

            if v150 and v150.Position then
                u151 = CFrame.new(v150.Position) * CFrame.fromOrientation(u146.PrimaryPart.CFrame:ToOrientation()) * CFrame.new(0, v147.Y / 1.5, 0);
            end;

            local v152 = TweenService:Create(u146.PrimaryPart, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                CFrame = u151
            });
            v152:Play();
            v152.Completed:Once(function() -- Line: 1017
                -- upvalues: u146 (copy), SwordHit (copy), u151 (ref), HSVShift (copy), ParticleHandler (ref)
                task.delay(0.25, u146.Destroy, u146);
                local v153 = SwordHit:Clone();
                v153.CFrame = CFrame.new(u151.Position) + Vector3.new(0, -10, 0);

                if HSVShift then
                    ParticleHandler.HSVShiftParticles(v153, HSVShift);
                end;

                v153.Parent = workspace.Effects;
                ParticleHandler.EmitFromAttribute(v153);
                ParticleHandler.DestroyByMaxLifetime(v153);
            end);
            v140 = v140 + task.wait(0.03333333333333333);
        end;
    end;

    function u2.UmbraWhirlwindVFX(p154) -- Line: 1035
        -- upvalues: Umbra (copy), TweenService (copy), ParticleHandler (copy), Sequence_V2 (copy)
        local HSVShift = p154.HSVShift;
        local Attacker = p154.Attacker;
        local HumanoidRootPart = Attacker.HumanoidRootPart;
        local u155 = Attacker["Right Arm"];
        local Whirlwind = Umbra.Whirlwind;

        local function Meshes(p156) -- Line: 1043
            -- upvalues: Umbra (ref), TweenService (ref)
            if not p156 or typeof(p156) ~= "CFrame" then
                if p156 and typeof(p156) == "Vector3" then
                    p156 = CFrame.new(p156);
                else
                    p156 = nil;
                end;
            end;

            local v157 = p156 or CFrame.new(0, 0, 0);
            local Effects = workspace.Effects;
            local v158 = {
                [Umbra.Whirlwind.Mesh.Enable.m1] = {
                    0.9,
                    CFrame.new(0.0639117733, 8.73042552e-7, -9.06412315, 1, 0, 0, 0, -4.37113883e-8, -1, 0, 1, -4.37113883e-8),
                    0,
                    {
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color = Color3.new(0.639216, 0.635294, 0.647059),
                                CFrame = v157 * CFrame.new(0.064420104, 0.000122760015, -10.3242207, 1, 0, 0, 0, -4.37113883e-8, -1, 0, 1, -4.37113883e-8) * CFrame.Angles(0, math.random(-360, 360), 0),
                                Transparency = 1,
                                Size = Vector3.new(53.027946, 6.166236, 53.027946)
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = Color3.new(10.0196, 10.0196, 10.0196),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(0.061797787, 0.008972545, 0.061797787),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                },
                [Umbra.Whirlwind.Mesh.Enable.m6] = {
                    0.3,
                    CFrame.new(
                        0.0896704644,
                        1.33250569e-6,
                        -19.5754166,
                        0,
                        -0.00459319307,
                        0.99998945,
                        1,
                        -4.37109264e-8,
                        -2.00774841e-10,
                        4.37113883e-8,
                        0.99998945,
                        0.00459319307
                    ),
                    0.9,
                    {
                        {
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            {
                                Color = Color3.new(0.988235, 0.980392, 1),
                                CFrame = v157 * CFrame.new(
                                    0.07614059,
                                    7.24588688e-7,
                                    -16.5766563,
                                    0,
                                    -0.00459319307,
                                    0.99998945,
                                    1,
                                    -4.37109264e-8,
                                    -2.00774841e-10,
                                    4.37113883e-8,
                                    0.99998945,
                                    0.00459319307
                                ),
                                Transparency = 1,
                                Size = Vector3.new(140.62097, 23.5, 140.62097)
                            }
                        }
                    }
                },
                [Umbra.Whirlwind.Mesh.Enable.m5] = {
                    0.6,
                    CFrame.new(0.0639404878, 9.29675878e-7, -15.8141241, 1, 0, 0, 0, -4.37113883e-8, -1, 0, 1, -4.37113883e-8),
                    0.8,
                    {
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color = Color3.new(0.639216, 0.635294, 0.647059),
                                CFrame = v157 * CFrame.new(0.0644003525, 0.000122900092, -8.0742178, 1, 0, 0, 0, -4.37113883e-8, -1, 0, 1, -4.37113883e-8) * CFrame.Angles(0, math.random(-360, 360), 0),
                                Transparency = 1,
                                Size = Vector3.new(78.749695, 19.66624, 78.749695)
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = Color3.new(10.0196, 10.0196, 10.0196),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(0.09177344, 0.028616522, 0.09177344),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                },
                [Umbra.Whirlwind.Mesh.Enable.m4] = {
                    0.6,
                    CFrame.new(0.0639404878, 9.29675878e-7, -15.8141241, 1, 0, 0, 0, -4.37113883e-8, -1, 0, 1, -4.37113883e-8),
                    0,
                    {
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color = Color3.new(0.639216, 0.635294, 0.647059),
                                CFrame = v157 * CFrame.new(0.0644111112, 0.000122563302, -5.82421398, 1, 0, 0, 0, -4.37113883e-8, -1, 0, 1, -4.37113883e-8),
                                Transparency = 1,
                                Size = Vector3.new(61.21363, 22.166237, 61.21363)
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = Color3.new(10.0196, 10.0196, 10.0196),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(0.07133724, 0.03225429, 0.07133724),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                },
                [Umbra.Whirlwind.Mesh.Enable.m3] = {
                    0.4,
                    CFrame.new(0.0639404878, 9.29675878e-7, -15.8141241, 1, 0, 0, 0, -4.37113883e-8, -1, 0, 1, -4.37113883e-8),
                    0,
                    {
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color = Color3.new(0.639216, 0.635294, 0.647059),
                                CFrame = v157 * CFrame.new(0.064412348, 0.000122419267, 2.92578006, 1, 0, 0, 0, -4.37113883e-8, -1, 0, 1, -4.37113883e-8) * CFrame.Angles(0, math.random(-360, 360), 0),
                                Transparency = 1,
                                Size = Vector3.new(35.82849, 63.666237, 35.82849)
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = Color3.new(10.0196, 10.0196, 10.0196),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(0.041753862, 0.092641324, 0.041753862),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                },
                [Umbra.Whirlwind.Mesh.Enable.m2] = {
                    0.4,
                    CFrame.new(0.0639404878, 9.29675878e-7, -15.8141241, 1, 0, 0, 0, -4.37113883e-8, -1, 0, 1, -4.37113883e-8),
                    0,
                    {
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color = Color3.new(0.639216, 0.635294, 0.647059),
                                CFrame = v157 * CFrame.new(0.06440036, 0.000122900092, -8.0742197, 1, 0, 0, 0, -4.37113883e-8, -1, 0, 1, -4.37113883e-8) * CFrame.Angles(0, math.random(-360, 360), 0),
                                Transparency = 1,
                                Size = Vector3.new(35.82849, 13.666236, 35.82849)
                            }
                        },
                        {
                            Enum.EasingStyle.Cubic,
                            Enum.EasingDirection.Out,
                            {
                                Color3 = Color3.new(10.0196, 10.0196, 10.0196),
                                Transparency = 1
                            }
                        },
                        {
                            Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out,
                            {
                                Scale = Vector3.new(0.041753862, 0.019885864, 0.041753862),
                                VertexColor = Vector3.new(1, 1, 1),
                                Offset = Vector3.new(0, 0, 0)
                            }
                        }
                    }
                }
            };

            for i, v in pairs(v158) do
                local v159 = i.Start:Clone();
                v159.Name = i.Name;
                v159.Transparency = v[3];

                if v159:FindFirstChildOfClass("Decal") then
                    v159:FindFirstChildOfClass("Decal").Transparency = v[3];
                    v159.Transparency = 1;
                end;

                v159.Anchored = true;
                v159.CanCollide = false;
                v159.CanQuery = false;
                v159.CanTouch = false;
                v159.Locked = true;
                v159.CFrame = v157 * v[2];
                v159.Parent = Effects;
                TweenService:Create(v159, TweenInfo.new(v[1], v[4][1][1], v[4][1][2]), v[4][1][3]):Play();

                if v[4][2] then
                    TweenService:Create(v159:FindFirstChildOfClass("Decal"), TweenInfo.new(v[1], v[4][2][1], v[4][2][2]), v[4][2][3]):Play();
                end;

                if v[4][3] then
                    TweenService:Create(v159:FindFirstChildOfClass("SpecialMesh"), TweenInfo.new(v[1], v[4][3][1], v[4][3][2]), v[4][3][3]):Play();
                end;

                task.delay(v[1], v159.Destroy, v159);
            end;
        end;

        Sequence_V2.CreateFromOldSequence({
            Frames = {
                { 0, function(p160, p161, p162) -- Line: 1089
                        -- upvalues: HSVShift (copy), ParticleHandler (ref)
                        if not HSVShift then
                            return;
                        end;

                        for i, v in p162 do
                            if i ~= "UUID" then
                                ParticleHandler.HSVShiftParticles(v, HSVShift);
                            end;
                        end;
                    end },
                { 20, function(p163, p164, p165) -- Line: 1097
                        -- upvalues: ParticleHandler (ref), u155 (copy)
                        p165.PrepareVFX.Anchored = false;
                        ParticleHandler.AttachParticle(p165.PrepareVFX, u155);
                        p165.PrepareVFX.Parent = workspace.Effects;
                        ParticleHandler.EmitFromAttribute(p165.PrepareVFX);
                    end },
                { 95, function(p166, p167, p168) -- Line: 1104
                        -- upvalues: HumanoidRootPart (copy), ParticleHandler (ref)
                        p168.ThrustVFX.CFrame = HumanoidRootPart.CFrame;
                        p168.ThrustVFX.Anchored = true;
                        p168.ThrustVFX.Parent = workspace.Effects;
                        ParticleHandler.EmitFromAttribute(p168.ThrustVFX);
                    end },
                { 100, function(p169, p170, p171) -- Line: 1111
                        -- upvalues: Meshes (copy)
                        local v172 = workspace.Effects:WaitForChild(p171.UUID, 5);

                        if not v172 then
                            return;
                        end;

                        local v173 = os.clock();

                        repeat
                            Meshes(v172.CFrame * CFrame.new(0, 0, 15));
                            task.wait(0.1);
                        until os.clock() - v173 >= 2;
                    end },
                { 135, function(p174, p175, p176) -- Line: 1121
                        -- upvalues: ParticleHandler (ref)
                        for i, v in p176 do
                            if i ~= "UUID" then
                                ParticleHandler.DestroyByMaxLifetime(v);
                            end;
                        end;

                        table.clear(p176);
                    end }
            }
        }):Play({
            PrepareVFX = Whirlwind.Prepare:Clone(),
            ThrustVFX = Whirlwind.Emit:Clone(),
            UUID = p154.UUID
        });
    end;

    function u2.UmbraObtainmentCutscene(p177) -- Line: 1141
        -- upvalues: TableUtil (copy), ParticleHandler (copy), Umbra (copy), TweenService (copy), Sequence_V2 (copy)
        local HSVShift = p177.HSVShift;
        local Attacker = p177.Attacker;
        local HumanoidRootPart = Attacker.HumanoidRootPart;
        local Torso = Attacker.Torso;
        local SwordHandle = Attacker:WaitForChild("Umbra", 5):WaitForChild("SwordHandle", 5);
        local u178 = TableUtil.Copy(ParticleHandler, true);

        function u178.EnableParticles(p179, p180) -- Line: 1150
            if p179:IsA("ParticleEmitter") then
                p179.Enabled = p180;
            end;

            for _, descendant in p179:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = p180;
                end;
            end;
        end;

        function u178.AttachParticle(p181, p182, p183) -- Line: 1161
            local v184 = p183 or {};

            if p181:IsA("Model") then
                p181 = p181.PrimaryPart;
            end;

            local Weld = Instance.new("Weld");

            if v184.InverseAttach then
                Weld.Part0 = p182;
                Weld.Part1 = p181;
            else
                Weld.Part0 = p181;
                Weld.Part1 = p182;
            end;

            if v184.C0 then
                Weld.C0 = v184.C0;
            end;

            if v184.C1 then
                Weld.C1 = v184.C1;
            end;

            Weld.Parent = p181;
            p181.Anchored = false;
            p181.CanCollide = false;
            p181.Massless = true;

            return Weld;
        end;

        local v185 = SwordHandle;
        local u186 = nil;

        for _, child in SwordHandle:GetChildren() do
            if child.Name == "SwordHandle" and child:IsA("BasePart") then
                v185 = child;
            end;
        end;

        local u187 = nil;

        for _, child in SwordHandle:GetChildren() do
            if child.Name == "Blade" and child:IsA("BasePart") then
                u187 = child;
            end;
        end;

        local ObtainmentCutscene = Umbra.ObtainmentCutscene;
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        local u188 = {
            Contrast = ColorCorrectionEffect.Contrast,
            Saturation = ColorCorrectionEffect.Saturation,
            TintColor = ColorCorrectionEffect.TintColor
        };

        local function RestoreColorCorrectionDefault() -- Line: 1221
            -- upvalues: u188 (copy), ColorCorrectionEffect (copy)
            for i, v in u188 do
                ColorCorrectionEffect[i] = v;
            end;
        end;

        u187.Color = Color3.new(0, 0, 0);
        local u189 = { "Head", "Torso", "Left Arm", "Left Leg", "Right Arm", "Right Leg" };
        local u190 = {};

        for _, child in ObtainmentCutscene:GetChildren() do
            if child.Name ~= "CameraEffect" then
                if child.Name == "UmbraRig" then
                    local v191 = child.Umbra.SwordHandle.WindCenter:Clone();
                    v191.Parent = v185;
                    u190.WindCenter = v191;

                    for _, v in u189 do
                        local v192 = {};

                        for _, child2 in child[v]:GetChildren() do
                            if child2:IsA("ParticleEmitter") then
                                local v193 = child2:Clone();
                                v193.Parent = Attacker[v];
                                v192[v193.Name] = v193;
                            end;
                        end;

                        u190[v] = v192;
                    end;

                    local v194 = child.Umbra.SwordHandle.BladeAura:Clone();

                    for _, child2 in SwordHandle:GetChildren() do
                        if child2.Name == "Blade" and child2:IsA("BasePart") then
                            v194.Weld.Part0 = child2;
                        end;
                    end;

                    v194.Weld.Part1 = v194;
                    v194.Parent = SwordHandle;
                    u190.BladeAura = v194;
                    local v195 = child.ObtainHighlight:Clone();
                    v195.Parent = Attacker;
                    u190.ObtainHighlight = v195;
                else
                    local v196 = child:Clone();

                    if v196.Name == "UmbraObtainLandEffect" then
                        v196.Anchored = true;
                        v196.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
                    elseif v196.Name == "UmbraObtainEffect" or v196.Name == "ObtainmentStab" then
                        u178.AttachParticle(v196, Torso);
                    elseif v196.Name == "UmbraObtainIgnite" then
                        u178.AttachParticle(v196, v185, {
                            InverseAttach = true,
                            C0 = CFrame.new(0.082, -3.362, 0.014) * CFrame.Angles(-1.5707963267948966, 0, 0)
                        });
                    end;

                    if HSVShift then
                        u178.HSVShiftParticles(v196, HSVShift);
                    end;

                    v196.Parent = workspace.Effects;
                    u190[v196.Name] = v196;
                end;
            end;
        end;

        Sequence_V2.CreateFromOldSequence({
            Frames = {
                { 27, function(p197, p198, p199) -- Line: 1296
                        -- upvalues: u178 (copy)
                        u178.EnableParticles(p199.WindCenter, true);
                    end },
                { 65, function(p200, p201, p202) -- Line: 1300
                        -- upvalues: u178 (copy)
                        u178.EnableParticles(p202.WindCenter, false);
                    end },
                { 360, function(p203, p204, p205) -- Line: 1304
                        -- upvalues: u178 (copy)
                        u178.EnableParticles(p205["Left Arm"].DarkParticle, true);
                        u178.EnableParticles(p205["Left Arm"].DarkParticle2, true);
                    end },
                { 420, function(p206, p207, p208) -- Line: 1309
                        -- upvalues: u186 (ref), Attacker (copy), ObtainmentCutscene (copy), u178 (copy)
                        u186 = workspace.Effects:FindFirstChild((`ObtainmentCamera_{Attacker.Name}`));

                        if not u186 then
                            return;
                        end;

                        p208.CameraParticle = ObtainmentCutscene.CameraEffect.Effect:Clone();
                        p208.CameraParticle.Parent = u186.Bone;
                        p208.CameraParticle.Aura_Enable.Rate = 5;
                        u178.EnableParticles(p208.CameraParticle, true);
                    end },
                { 600, function(p209, p210, p211) -- Line: 1319
                        -- upvalues: u186 (ref), TweenService (ref)
                        if not u186 then
                            return;
                        end;

                        TweenService:Create(p211.CameraParticle.Aura_Enable, TweenInfo.new((660 - p210) / 60, Enum.EasingStyle.Linear), {
                            Rate = 15
                        }):Play();
                    end },
                { 610, function(p212, p213, p214) -- Line: 1328
                        -- upvalues: u178 (copy), TweenService (ref), u187 (ref)
                        u178.EnableParticles(p214.BladeAura, true);
                        TweenService:Create(u187, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                            Color = Color3.new(1, 0, 1)
                        }):Play();
                    end },
                { 625, function(p215, p216, p217) -- Line: 1335
                        -- upvalues: u178 (copy), u189 (copy)
                        u178.EmitFromAttribute(p217.UmbraObtainIgnite);

                        for _, v in u189 do
                            u178.EnableParticles(p217[v].DarkParticle, true);
                            u178.EnableParticles(p217[v].DarkParticle2, true);
                        end;
                    end },
                { 655, function(p218, p219, p220) -- Line: 1344
                        -- upvalues: u178 (copy)
                        u178.EnableParticles(p220.UmbraObtainEffect.DarkGlitch_Enable, true);
                    end },
                { 660, function(p221, p222, p223) -- Line: 1348
                        -- upvalues: u186 (ref), TweenService (ref)
                        if not u186 then
                            return;
                        end;

                        TweenService:Create(p223.CameraParticle.Aura_Enable, TweenInfo.new((1480 - p222) / 60, Enum.EasingStyle.Linear), {
                            Rate = 25
                        }):Play();
                    end },
                { 871, function(p224, p225, p226) -- Line: 1357
                        -- upvalues: u178 (copy), ColorCorrectionEffect (copy)
                        u178.EnableParticles(p226.UmbraObtainEffect.DarkGlitch_Enable, false);
                        ColorCorrectionEffect.TintColor = Color3.fromRGB(206, 90, 255);
                        ColorCorrectionEffect.Contrast = -10;
                        ColorCorrectionEffect.Saturation = -1;
                        ColorCorrectionEffect.Enabled = true;
                        ColorCorrectionEffect.Parent = game.Lighting;
                    end },
                { 876, function(p227, p228, p229) -- Line: 1367
                        -- upvalues: u188 (copy), ColorCorrectionEffect (copy)
                        for i, v in u188 do
                            ColorCorrectionEffect[i] = v;
                        end;
                    end },
                { 925, function(p230, p231, p232) -- Line: 1371
                        -- upvalues: u178 (copy)
                        u178.EmitFromAttribute(p232.UmbraObtainIgnite);
                    end },
                { 946, function(p233, p234, p235) -- Line: 1375
                        -- upvalues: u178 (copy), ColorCorrectionEffect (copy)
                        for _, descendant in p235.ObtainmentStab:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") then
                                if descendant.Name:find("Enable") then
                                    u178.EnableParticles(descendant, true);
                                elseif descendant.Name:find("Emit") then
                                    u178.EmitFromAttribute(descendant);
                                end;
                            end;
                        end;

                        ColorCorrectionEffect.Contrast = -100;
                        ColorCorrectionEffect.Saturation = -1;
                    end },
                { 952, function(p236, p237, p238) -- Line: 1389
                        -- upvalues: u178 (copy), u188 (copy), ColorCorrectionEffect (copy), TweenService (ref)
                        u178.EnableParticles(p238.UmbraObtainEffect.DarkGlitch_Enable, true);

                        for i, v in u188 do
                            ColorCorrectionEffect[i] = v;
                        end;

                        TweenService:Create(ColorCorrectionEffect, TweenInfo.new((1550 - p237) / 60, Enum.EasingStyle.Linear), {
                            Contrast = 4,
                            TintColor = Color3.fromRGB(206, 90, 255)
                        }):Play();
                    end },
                { 960, function(p239, p240, p241) -- Line: 1400
                        -- upvalues: u178 (copy), TweenService (ref)
                        u178.EnableParticles(p241.UmbraObtainEffect.ChromaticStars_Enable, true);
                        TweenService:Create(p241.ObtainHighlight, TweenInfo.new((1470 - p240) / 60, Enum.EasingStyle.Linear), {
                            FillTransparency = 0
                        }):Play();
                    end },
                { 1100, function(p242, p243, p244) -- Line: 1409
                        -- upvalues: u178 (copy)
                        u178.EnableParticles(p244.UmbraObtainEffect.Center.Aura_Enable, true);
                        u178.EnableParticles(p244.UmbraObtainEffect.Center.DarkSlash_Enable, true);

                        for _, descendant in p244.ObtainmentStab:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") and descendant.Name:find("Enable") then
                                u178.EnableParticles(descendant, false);
                            end;
                        end;
                    end },
                { 1380, function(p245, p246, p247) -- Line: 1421
                        -- upvalues: u178 (copy), TweenService (ref)
                        p247.UmbraObtainEffect.Glitch_Enable.Rate = 0;
                        u178.EnableParticles(p247.UmbraObtainEffect.Glitch_Enable, true);
                        TweenService:Create(p247.UmbraObtainEffect.Glitch_Enable, TweenInfo.new((1530 - p246) / 60, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            Rate = 100
                        }):Play();
                        TweenService:Create(p247.ObtainHighlight, TweenInfo.new((1560 - p246) / 60, Enum.EasingStyle.Quad), {
                            OutlineTransparency = 0
                        }):Play();
                    end },
                { 1480, function(p248, p249, p250) -- Line: 1436
                        -- upvalues: u186 (ref), TweenService (ref)
                        if not u186 then
                            return;
                        end;

                        TweenService:Create(p250.CameraParticle.Aura_Enable, TweenInfo.new((1565 - p249) / 60, Enum.EasingStyle.Linear), {
                            Rate = 5
                        }):Play();
                    end },
                { 1500, function(p251, p252, p253) -- Line: 1445
                        -- upvalues: u186 (ref)
                        if not u186 then
                            return;
                        end;

                        p253.OldCameraColor = p253.CameraParticle.Aura_Enable.Color;
                        p253.CameraParticle.Aura_Enable.Color = ColorSequence.new(Color3.fromRGB(206, 90, 255));
                    end },
                { 1550, function(p254, p255, p256) -- Line: 1452
                        -- upvalues: u178 (copy), TweenService (ref), ColorCorrectionEffect (copy)
                        u178.EnableParticles(p256.UmbraObtainEffect.ChromaticStars_Enable, false);
                        u178.EnableParticles(p256.UmbraObtainEffect.Center.DarkSlash_Enable, false);
                        TweenService:Create(ColorCorrectionEffect, TweenInfo.new((1710 - p255) / 60, Enum.EasingStyle.Linear), {
                            TintColor = Color3.new(1, 1, 1)
                        }):Play();
                    end },
                { 1560, function(p257, p258, p259) -- Line: 1461
                        -- upvalues: TweenService (ref)
                        TweenService:Create(p259.ObtainHighlight, TweenInfo.new((1650 - p258) / 60, Enum.EasingStyle.Linear), {
                            FillTransparency = 1
                        }):Play();
                    end },
                { 1563, function(p260, p261, p262) -- Line: 1468
                        -- upvalues: ColorCorrectionEffect (copy)
                        ColorCorrectionEffect.Contrast = 100;
                        ColorCorrectionEffect.Saturation = -1;
                    end },
                { 1565, function(p263, p264, p265) -- Line: 1473
                        -- upvalues: u188 (copy), ColorCorrectionEffect (copy), u189 (copy), u178 (copy)
                        for i, v in u188 do
                            ColorCorrectionEffect[i] = v;
                        end;

                        p265.UmbraObtainEffect.Center.Aura_Enable.Color = ColorSequence.new(Color3.fromRGB(206, 90, 255));

                        for _, v in u189 do
                            for _, v2 in p265[v] do
                                u178.EnableParticles(v2, true);
                            end;
                        end;

                        for _, descendant in p265.UmbraObtainEffect:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") then
                                if descendant.Name:find("Enable") then
                                    u178.EnableParticles(descendant, true);
                                elseif descendant.Name:find("Emit") then
                                    u178.EmitFromAttribute(descendant);
                                end;
                            end;
                        end;
                    end },
                { 1710, function(p266, p267, p268) -- Line: 1492
                        -- upvalues: u178 (copy), TweenService (ref), ColorCorrectionEffect (copy)
                        u178.EnableParticles(p268.UmbraObtainEffect.Center.Aura_Enable, false);
                        TweenService:Create(ColorCorrectionEffect, TweenInfo.new((1740 - p267) / 60, Enum.EasingStyle.Linear), {
                            Contrast = 0.05
                        }):Play();
                    end },
                { 1740, function(p269, p270, p271) -- Line: 1501
                        -- upvalues: u186 (ref), u178 (copy)
                        if u186 then
                            p271.CameraParticle.Aura_Enable.Color = p271.OldCameraColor;
                            p271.OldCameraColor = nil;
                        end;

                        for _, descendant in p271.UmbraObtainEffect:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") and descendant.Name:find("Burst") then
                                u178.EnableParticles(descendant, false);
                            end;
                        end;

                        p271.UmbraObtainEffect.Glitch_Enable.Rate = 2000;
                        p271.UmbraObtainEffect.DarkGlitch_Enable.Rate = 2000;
                    end },
                { 1785, function(p272, p273, p274) -- Line: 1518
                        -- upvalues: u178 (copy)
                        for _, descendant in p274.UmbraObtainEffect:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") and descendant.Name:find("Glitch") then
                                u178.EnableParticles(descendant, true);
                            end;
                        end;
                    end },
                { 1795, function(p275, p276, p277) -- Line: 1527
                        -- upvalues: u178 (copy)
                        for _, descendant in p277.UmbraObtainEffect:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") and descendant.Name:find("Glitch") then
                                u178.EnableParticles(descendant, false);
                            end;
                        end;
                    end },
                { 1812, function(p278, p279, p280) -- Line: 1536
                        -- upvalues: ColorCorrectionEffect (copy)
                        ColorCorrectionEffect.Contrast = 100;
                        ColorCorrectionEffect.Saturation = -1;
                    end },
                { 1815, function(p281, p282, p283) -- Line: 1541
                        -- upvalues: u178 (copy), ColorCorrectionEffect (copy)
                        u178.EmitFromAttribute(p283.UmbraObtainLandEffect);
                        ColorCorrectionEffect.Contrast = -100;
                    end },
                { 1818, function(p284, p285, p286) -- Line: 1546
                        -- upvalues: u178 (copy), u188 (copy), ColorCorrectionEffect (copy)
                        u178.EmitFromAttribute(p286.UmbraObtainLandEffect);

                        for i, v in u188 do
                            ColorCorrectionEffect[i] = v;
                        end;
                    end },
                { 1885, function(p287, p288, p289) -- Line: 1551
                        -- upvalues: u178 (copy)
                        for _, descendant in p289.UmbraObtainEffect:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") and descendant.Name:find("Glitch") then
                                u178.EnableParticles(descendant, true);
                            end;
                        end;
                    end },
                { 1895, function(p290, p291, p292) -- Line: 1560
                        -- upvalues: u178 (copy)
                        for _, descendant in p292.UmbraObtainEffect:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") and descendant.Name:find("Glitch") then
                                u178.EnableParticles(descendant, false);
                            end;
                        end;
                    end },
                { 1940, function(p293, p294, p295) -- Line: 1569
                        -- upvalues: u178 (copy)
                        for _, descendant in p295.UmbraObtainEffect:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") and descendant.Name:find("Glitch") then
                                u178.EnableParticles(descendant, true);
                            end;
                        end;
                    end },
                { 1950, function(p296, p297, p298) -- Line: 1578
                        -- upvalues: u178 (copy)
                        for _, descendant in p298.UmbraObtainEffect:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") and descendant.Name:find("Glitch") then
                                u178.EnableParticles(descendant, false);
                            end;
                        end;
                    end },
                { 1990, function(p299, p300, p301) -- Line: 1587
                        -- upvalues: u178 (copy)
                        for _, descendant in p301.UmbraObtainEffect:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") and descendant.Name:find("Glitch") then
                                u178.EnableParticles(descendant, true);
                            end;
                        end;
                    end },
                { 1994, function(p302, p303, p304) -- Line: 1596
                        -- upvalues: u178 (copy), ColorCorrectionEffect (copy)
                        for _, descendant in p304.ObtainmentStab:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") then
                                if descendant.Name:find("Enable") then
                                    u178.EnableParticles(descendant, true);
                                elseif descendant.Name:find("Emit") then
                                    u178.EmitFromAttribute(descendant);
                                end;
                            end;
                        end;

                        ColorCorrectionEffect.Contrast = -100;
                        ColorCorrectionEffect.Saturation = -1;
                    end },
                { 2000, function(p305, p306, p307) -- Line: 1610
                        -- upvalues: u178 (copy)
                        for _, descendant in p307.UmbraObtainEffect:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") and descendant.Name:find("Glitch") then
                                u178.EnableParticles(descendant, false);
                            end;
                        end;
                    end },
                { 2000, function(p308, p309, p310) -- Line: 1619
                        -- upvalues: ColorCorrectionEffect (copy)
                        ColorCorrectionEffect.Enabled = false;
                    end },
                { 2005, function(p311, p312, p313) -- Line: 1623
                        -- upvalues: u178 (copy)
                        u178.EnableParticles(p313.ObtainmentStab, false);
                    end },
                { 2010, function(p314, p315, p316) -- Line: 1627
                        -- upvalues: ColorCorrectionEffect (copy), u178 (copy), u190 (copy)
                        ColorCorrectionEffect:Destroy();

                        local function CleanupParticles(p317) -- Line: 1629
                            -- upvalues: u178 (ref), CleanupParticles (copy)
                            for _, v in p317 do
                                if type(v) == "table" then
                                    CleanupParticles(v);
                                else
                                    u178.EnableParticles(v, false);
                                    u178.DestroyByMaxLifetime(v);
                                end;
                            end;
                        end;

                        CleanupParticles(u190);
                    end }
            }
        }):Play(u190);
    end;

    function u2.UmbraThreefoldSlice(p318) -- Line: 1652
        -- upvalues: Umbra (copy), GetCloneColor (copy), u1 (copy), u3 (copy), ParticleHandler (copy), CreateAfterimage (copy), AnimationHandler (copy), TweenService (copy), Sequence_V2 (copy)
        local HSVShift = p318.HSVShift;
        local Attacker = p318.Attacker;
        local HumanoidRootPart = Attacker.HumanoidRootPart;
        local _ = Attacker["Right Arm"];
        local Head = Attacker.Head;
        local ThreefoldSlice = Umbra.ThreefoldSlice;
        local u319 = p318.Attacker:FindFirstChild("Stand") or p318.Attacker:FindFirstChild("Umbra");
        local u320 = nil;

        for _, descendant in Attacker:GetDescendants() do
            if descendant:IsA("Motor6D") and descendant.Name == "SwordHandle" then
                u320 = descendant;
                break;
            end;
        end;

        local u321 = {
            Properties = {
                Start = {
                    Transparency = 0.5,
                    Color = GetCloneColor(p318.Skin, {
                        HSVShift = p318.HSVShift
                    })
                }
            }
        };

        local function CallVFX(p322) -- Line: 1681
            -- upvalues: u1 (ref)
            local HumanoidRootPart2 = p322.HumanoidRootPart;
            u1.CallEffects({
                {
                    Name = "Emit Particle V3",
                    Data = {
                        {
                            Path = "Particles/Misc/SupremeDash",
                            AbilityName = "Kars",
                            AutoSerialize = true,
                            Origin = CFrame.new(HumanoidRootPart2.Position, HumanoidRootPart2.Position + HumanoidRootPart2.CFrame.LookVector)
                        }
                    }
                },
                {
                    Name = "Rock Trail",
                    Data = {
                        {
                            Offset = 5,
                            Distance = 50,
                            Amount = 25,
                            Size = 2.5,
                            Duration = 1.5,
                            DurationOffset = 0.025,
                            Down = true,
                            Origin = HumanoidRootPart2.CFrame,
                            LookVector = HumanoidRootPart2.CFrame.LookVector
                        }
                    }
                }
            });
        end;

        local function AddCloneSword(p323) -- Line: 1715
            -- upvalues: u319 (copy), u320 (ref), ThreefoldSlice (copy), u3 (ref), HSVShift (copy), ParticleHandler (ref)
            local u324 = u319:Clone();
            u324.Name = "SwordClone";

            for _, descendant in u324:GetDescendants() do
                if descendant:IsA("Motor6D") then
                    descendant:Destroy();
                end;
            end;

            local SwordHandle = u324.SwordHandle;
            SwordHandle.Name = "SwordHandle.001";
            local v325 = p323["Left Arm"];
            local Motor6D = Instance.new("Motor6D");
            Motor6D.Name = "SwordHandle2";
            Motor6D.C0 = u320.C0;
            Motor6D.C1 = u320.C1;
            Motor6D.Part0 = v325;
            Motor6D.Part1 = SwordHandle;
            Motor6D.Parent = v325;
            local v326 = ThreefoldSlice.BladeAura:Clone();
            local v327 = u3.BladeHighlight:Clone();
            local v328 = ThreefoldSlice.swordtrail.fxTrails:Clone();

            if HSVShift then
                ParticleHandler.HSVShiftParticles(v326, HSVShift);
                ParticleHandler.HSVShiftParticles(v328, HSVShift);
                v327.FillColor = ParticleHandler.HSVShiftColor(v327.FillColor, HSVShift);
                v327.OutlineColor = ParticleHandler.HSVShiftColor(v327.OutlineColor, HSVShift);
            end;

            v326.Parent = u324;
            v327.Parent = u324;
            v328.Parent = SwordHandle;
            task.delay(2, v328.Destroy, v328);
            u324.Parent = workspace.Effects;

            return function() -- Line: 1756
                -- upvalues: Motor6D (copy), u324 (copy)
                Motor6D:Destroy();
                u324:Destroy();
            end;
        end;

        Sequence_V2.CreateFromOldSequence({
            Frames = {
                { 0, function(p329, p330, u331) -- Line: 1763
                        -- upvalues: ThreefoldSlice (copy), HumanoidRootPart (copy), HSVShift (copy), ParticleHandler (ref), Head (copy), u319 (copy)
                        local v332 = ThreefoldSlice.Cast:Clone();
                        v332.CFrame = HumanoidRootPart.CFrame;

                        if HSVShift then
                            ParticleHandler.HSVShiftParticles(v332, HSVShift);
                            ParticleHandler.HSVShiftParticles(u331.Eyes, HSVShift);
                        end;

                        v332.Parent = workspace.Effects;
                        ParticleHandler.EmitFromAttribute(v332);
                        u331.Eyes.Anchored = false;
                        ParticleHandler.AttachParticle(u331.Eyes, Head);
                        u331.Eyes.Parent = workspace.Effects;
                        ParticleHandler.EnableParticles(u331.Eyes, true);
                        task.delay(2, function() -- Line: 1779
                            -- upvalues: ParticleHandler (ref), u331 (copy)
                            ParticleHandler.EnableParticles(u331.Eyes, false);
                            ParticleHandler.DestroyByMaxLifetime(u331.Eyes);
                        end);
                        local v333 = ThreefoldSlice.swordtrail.fxTrails:Clone();

                        if HSVShift then
                            ParticleHandler.HSVShiftParticles(v333, HSVShift);
                        end;

                        v333.Parent = u319.SwordHandle;
                        task.delay(2, v333.Destroy, v333);
                    end },
                { 0, function(p334, p335, p336) -- Line: 1793
                        -- upvalues: AddCloneSword (copy), Attacker (copy), CreateAfterimage (ref), u321 (copy), AnimationHandler (ref), TweenService (ref), HumanoidRootPart (copy), CallVFX (copy), ThreefoldSlice (copy), HSVShift (copy), ParticleHandler (ref)
                        p336.SwordClone = AddCloneSword(Attacker);

                        for i = 1, 2 do
                            local u337 = CreateAfterimage(Attacker, u321);
                            p336[`Afterimage{i}`] = u337;
                            p336[`SwordClone{i}`] = AddCloneSword(u337);
                            local u338;

                            if i == 1 then
                                u338 = CFrame.new(8, 0, 8) * CFrame.Angles(0, -0.7853981633974483, 0);
                            else
                                u338 = CFrame.new(-8, 0, 8) * CFrame.Angles(0, 0.7853981633974483, 0);
                            end;

                            task.spawn(function() -- Line: 1804
                                -- upvalues: u337 (copy), AnimationHandler (ref), i (copy), TweenService (ref), HumanoidRootPart (ref), u338 (copy), CallVFX (ref), ThreefoldSlice (ref), HSVShift (ref), ParticleHandler (ref)
                                local AnimationController = Instance.new("AnimationController");
                                local Animator = Instance.new("Animator");
                                Animator.Parent = AnimationController;
                                AnimationController.Parent = u337;
                                Animator.AncestryChanged:Connect(function(p339, p340) -- Line: 1812
                                    -- upvalues: Animator (copy), AnimationHandler (ref), i (ref), TweenService (ref), u337 (ref), HumanoidRootPart (ref), u338 (ref), CallVFX (ref), ThreefoldSlice (ref), HSVShift (ref), ParticleHandler (ref)
                                    if not Animator:IsDescendantOf(workspace) then
                                        return;
                                    end;

                                    local v341 = AnimationHandler.CreateAnimations("Umbra");
                                    local v342 = AnimationHandler.new(Animator);
                                    v342:AddAnimations(v341);
                                    local v343 = v342:PlayAnimation("Threefold Slice");
                                    v343:Play();
                                    v343.TimePosition = i == 1 and 0.8333333333333334 or 0.6666666666666666;
                                    TweenService:Create(u337.HumanoidRootPart, TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear), {
                                        CFrame = HumanoidRootPart.CFrame * u338
                                    }):Play();
                                    task.wait(0.08333333333333333);

                                    while v343.TimePosition * 60 < 175 do
                                        u337.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * u338;
                                        task.wait();
                                    end;

                                    CallVFX(u337);
                                    local v344 = ThreefoldSlice.fxDash:Clone();
                                    v344.CFrame = u337.HumanoidRootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0);

                                    if HSVShift then
                                        ParticleHandler.HSVShiftParticles(v344, HSVShift);
                                    end;

                                    v344.Parent = workspace.Effects;
                                    ParticleHandler.EmitFromAttribute(v344);
                                    ParticleHandler.DestroyByMaxLifetime(v344);
                                    TweenService:Create(u337.HumanoidRootPart, TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear), {
                                        CFrame = u337.HumanoidRootPart.CFrame * CFrame.new(0, 0, -50)
                                    }):Play();
                                end);
                            end);
                        end;
                    end },
                { 145, function(p345, p346, p347) -- Line: 1854
                        -- upvalues: HumanoidRootPart (copy), CallVFX (copy), Attacker (copy), ThreefoldSlice (copy), HSVShift (copy), ParticleHandler (ref), TweenService (ref)
                        local v348 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -50);
                        local v349 = RaycastParams.new();
                        v349.FilterDescendantsInstances = { workspace.Map, workspace.Terrain };
                        v349.FilterType = Enum.RaycastFilterType.Include;
                        v349.IgnoreWater = true;
                        local v350 = workspace:Raycast(HumanoidRootPart.Position, HumanoidRootPart.CFrame.LookVector * 50, v349);

                        if v350 and v350.Position then
                            v348 = CFrame.new(v350.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
                        end;

                        CallVFX(Attacker);
                        local v351 = ThreefoldSlice.fxDash:Clone();
                        v351.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0);

                        if HSVShift then
                            ParticleHandler.HSVShiftParticles(v351, HSVShift);
                        end;

                        v351.Parent = workspace.Effects;
                        ParticleHandler.EmitFromAttribute(v351);
                        ParticleHandler.DestroyByMaxLifetime(v351);
                        TweenService:Create(HumanoidRootPart, TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear), {
                            CFrame = v348
                        }):Play();
                    end },
                { 160, function(p352, p353, p354) -- Line: 1885
                        -- upvalues: ThreefoldSlice (copy), HSVShift (copy), ParticleHandler (ref)
                        for i, v in p354 do
                            if type(v) == "function" then
                                v();
                            elseif typeof(v) == "Instance" then
                                if i:find("Afterimage") then
                                    local v355 = ThreefoldSlice.Tp:Clone();
                                    v355.CFrame = v.HumanoidRootPart.CFrame;

                                    if HSVShift then
                                        ParticleHandler.HSVShiftParticles(v355, HSVShift);
                                    end;

                                    v355.Parent = workspace.Effects;
                                    ParticleHandler.EmitFromAttribute(v355);
                                    ParticleHandler.DestroyByMaxLifetime(v355);
                                end;

                                v:Destroy();
                            end;
                        end;
                    end }
            }
        }):Play({
            Technique = p318.Technique,
            Eyes = Umbra.Devastation.EyeStar:Clone()
        });
    end;
end;