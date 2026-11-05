  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.KnitPackage.TableUtil);
local Trove = require(ReplicatedStorage.ReplicatedModules.KnitPackage.Trove);
local Sequence_V2 = require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V2);
require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);

local function Orientation(p1, p2, p3) -- Line: 12
    return CFrame.fromOrientation(math.rad(p1), math.rad(p2), (math.rad(p3)));
end;

return {
    Init = function(p4) -- Line: 17, Name: Init
        -- upvalues: ReplicatedStorage (copy), ParticleHandler (copy), TweenService (copy), Trove (copy), Sequence_V2 (copy)
        local Cache = p4.Cache;
        local MirageBlade = ReplicatedStorage["Client Assets"].Assets.Abilities.Vergil.GeneralEffects.MirageBlade;
        local u5 = RaycastParams.new();
        u5.FilterType = Enum.RaycastFilterType.Include;
        u5.FilterDescendantsInstances = { workspace.Map };
        local u6 = Random.new();

        local function Emit(p7, p8) -- Line: 31
            -- upvalues: ParticleHandler (ref)
            ParticleHandler.EmitFromAttribute(p7);

            if p8 == false then
                return;
            end;

            ParticleHandler.DestroyByMaxLifetime(p7);
        end;

        local function CreateParticle(p9, p10) -- Line: 38
            local v11 = p9:Clone();

            for i, v in p10 or {} do
                v11[i] = v;
            end;

            return v11;
        end;

        local u12 = TweenInfo.new(0.3);
        local u13 = TweenInfo.new(0.035);
        TweenInfo.new(0.1);
        local u14 = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1);

        local function RandomizeXYPosition(p15, p16) -- Line: 51
            -- upvalues: u6 (copy)
            return u6:NextInteger(1, 2) == 1 and -2 or 2, u6:NextInteger(p15 or -2, p16 or 2);
        end;

        local function RandomizeTrueXYPosition(p17, p18) -- Line: 61
            -- upvalues: u6 (copy)
            return u6:NextInteger(-4, 4), u6:NextInteger(p17 or -2, p18 or 2);
        end;

        local function RandomizeXZPosition(p19, p20) -- Line: 71
            -- upvalues: u6 (copy)
            local v21 = p19 or -16;
            local v22 = p20 or 16;

            return u6:NextNumber(v21, v22), u6:NextNumber(v21, v22);
        end;

        local function TweenOutBlade(p23, p24) -- Line: 78
            -- upvalues: TweenService (ref), u13 (copy), u12 (copy)
            for _, descendant in p23:GetDescendants() do
                if descendant:IsA("BasePart") then
                    local v25;

                    if p24 then
                        v25 = u13;
                    else
                        v25 = u12;
                    end;

                    TweenService:Create(descendant, v25, {
                        Transparency = 1
                    }):Play();
                end;
            end;
        end;

        local function TweenOffDistance(p26, p27, u28) -- Line: 88
            -- upvalues: TweenService (ref)
            if u28 then
                u28.Enabled = false;
            end;

            p26.PrimaryPart.Anchored = false;
            local v29 = (p27 - p26.PrimaryPart.Position).Magnitude / 500;
            TweenService:Create(p26.PrimaryPart, TweenInfo.new(v29), {
                Position = p27
            }):Play();
            TweenService:Create(p26["Cube.001"], TweenInfo.new(v29), {
                Position = p27
            }):Play();

            if u28 then
                task.delay(v29, function() -- Line: 104
                    -- upvalues: u28 (copy)
                    u28.Enabled = true;
                end);
            end;
        end;

        local function ShootSingleBladeOnlyZOffset(u30, u31) -- Line: 110
            -- upvalues: Trove (ref), MirageBlade (copy), ParticleHandler (ref), u5 (copy), TweenOutBlade (copy), TweenOffDistance (copy), Sequence_V2 (ref)
            if not u31 then
                return;
            end;

            local HumanoidRootPart = u30.HumanoidRootPart;
            local u32 = nil;
            local u33 = nil;
            local u34 = nil;
            local u35 = nil;
            local u36 = false;
            local u37 = Trove.new();
            Sequence_V2.CreateFromOldSequence({
                Frames = {
                    { 0, function() -- Line: 125
                            -- upvalues: u33 (ref), u37 (copy), MirageBlade (ref), ParticleHandler (ref), u30 (copy), u32 (ref), HumanoidRootPart (copy), u31 (copy), u35 (ref), u5 (ref), TweenOutBlade (ref), u36 (ref)
                            u33 = u37:Clone(MirageBlade);
                            ParticleHandler.Unusualify(u33, {
                                IncludeParts = true,
                                IncludeSurfaces = true,
                                Character = u30
                            });
                            u33.Parent = workspace;
                            u33.Blade.Anchored = true;
                            u32 = CFrame.lookAt(HumanoidRootPart.Position + Vector3.new(0, 0, -3), u31.HumanoidRootPart.Position) * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966);
                            u33:PivotTo(u32);
                            u35 = workspace:Raycast(u33.PrimaryPart.Position, u33.PrimaryPart.CFrame.LookVector * 5000, u5);

                            if u35 then
                                return;
                            end;

                            TweenOutBlade(u33);
                            task.delay(0.3, u33.Destroy, u33);
                            u36 = true;
                        end },
                    { 10, function() -- Line: 144
                            -- upvalues: u36 (ref), u35 (ref), u33 (ref), u34 (ref), u37 (copy), TweenOffDistance (ref), u31 (copy)
                            if u36 then
                                return;
                            end;

                            local Rotation = u35.Instance.CFrame:ToObjectSpace(u33.PrimaryPart.CFrame).Rotation;
                            u33.PrimaryPart.Anchored = false;
                            u34 = u37:Add(Instance.new("Weld"));
                            TweenOffDistance(u33, u31.HumanoidRootPart.Position, u34);
                            u34.Parent = u31.HumanoidRootPart;
                            u34.Part0 = u31.HumanoidRootPart;
                            u34.Part1 = u33.PrimaryPart;
                            u34.C0 = Rotation;
                        end },
                    { 190, function() -- Line: 160
                            -- upvalues: u36 (ref), TweenOutBlade (ref), u33 (ref)
                            if u36 then
                                return;
                            end;

                            TweenOutBlade(u33);
                        end },
                    { 200, function() -- Line: 167
                            -- upvalues: u36 (ref), u37 (copy)
                            if u36 then
                                return;
                            end;

                            u37:Destroy();
                        end }
                }
            }):Play();
        end;

        local function RandomizeAngle(p38, p39) -- Line: 183
            local v40 = p38 or -5;
            local v41 = p39 or 5;
            local v42 = math.random(v40, v41);
            local v43 = math.rad(v42);
            local v44 = math.random(v40, v41);

            return v43, math.rad(v44);
        end;

        function Cache.MirageBladeShootSingleBlade(p45) -- Line: 189
            -- upvalues: u6 (copy), Trove (ref), MirageBlade (copy), ParticleHandler (ref), u5 (copy), TweenOutBlade (copy), TweenOffDistance (copy), Sequence_V2 (ref)
            local Attacker = p45.Attacker;
            local Target = p45.Target;

            if not Target then
                return;
            end;

            local u46, u47;

            if p45.TrueRandom then
                u46 = u6:NextInteger(-4, 4);
                u47 = u6:NextInteger(nil or -2, nil or 2);
            else
                u46 = u6:NextInteger(1, 2) == 1 and -2 or 2;
                u47 = u6:NextInteger(nil or -2, nil or 2);
            end;

            local HumanoidRootPart = Attacker.HumanoidRootPart;
            local u48 = nil;
            local u49 = nil;
            local u50 = nil;
            local u51 = nil;
            local u52 = false;
            local u53 = Trove.new();
            Sequence_V2.CreateFromOldSequence({
                Frames = {
                    { 0, function() -- Line: 213
                            -- upvalues: u49 (ref), u53 (copy), MirageBlade (ref), ParticleHandler (ref), Attacker (copy), u48 (ref), HumanoidRootPart (copy), u46 (ref), u47 (ref), Target (copy), u51 (ref), u5 (ref), TweenOutBlade (ref), u52 (ref)
                            u49 = u53:Clone(MirageBlade);
                            ParticleHandler.Unusualify(u49, {
                                IncludeParts = true,
                                IncludeSurfaces = true,
                                Character = Attacker
                            });
                            u49.Parent = workspace;
                            u49.Blade.Anchored = true;
                            u48 = CFrame.lookAt(HumanoidRootPart.Position + Vector3.new(u46, 4 + u47, 0), Target.HumanoidRootPart.Position) * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966);
                            u49:PivotTo(u48);
                            u51 = workspace:Raycast(u49.PrimaryPart.Position, u49.PrimaryPart.CFrame.LookVector * 5000, u5);

                            if u51 then
                                return;
                            end;

                            TweenOutBlade(u49);
                            task.delay(0.3, u49.Destroy, u49);
                            u52 = true;
                        end },
                    { 10, function() -- Line: 232
                            -- upvalues: u52 (ref), u51 (ref), u49 (ref), u50 (ref), u53 (copy), TweenOffDistance (ref), Target (copy)
                            if u52 then
                                return;
                            end;

                            local Rotation = u51.Instance.CFrame:ToObjectSpace(u49.PrimaryPart.CFrame).Rotation;
                            u49.PrimaryPart.Anchored = false;
                            u50 = u53:Add(Instance.new("Weld"));
                            TweenOffDistance(u49, Target.HumanoidRootPart.Position, u50);
                            u50.Parent = Target.HumanoidRootPart;
                            u50.Part0 = Target.HumanoidRootPart;
                            u50.Part1 = u49.PrimaryPart;
                            u50.C0 = Rotation;
                        end },
                    { 190, function() -- Line: 248
                            -- upvalues: u52 (ref), TweenOutBlade (ref), u49 (ref)
                            if u52 then
                                return;
                            end;

                            TweenOutBlade(u49);
                        end },
                    { 200, function() -- Line: 255
                            -- upvalues: u53 (copy)
                            u53:Destroy();
                        end }
                }
            }):Play();
        end;

        function Cache.MirageBladeBlisteringBlades(p54) -- Line: 267
            -- upvalues: MirageBlade (copy), ParticleHandler (ref), u5 (copy), TweenOutBlade (copy), TweenOffDistance (copy), Sequence_V2 (ref)
            local Attacker = p54.Attacker;
            local Target = p54.Target;

            if not Target then
                return;
            end;

            local u55 = {};
            local HumanoidRootPart = Attacker.HumanoidRootPart;

            local function MakeSide(p56) -- Line: 276
                -- upvalues: MirageBlade (ref), ParticleHandler (ref), Attacker (copy), HumanoidRootPart (copy), u55 (copy)
                local v57 = p56 == 1 and -2 or 2;

                for i = 1, 4 do
                    local v58 = MirageBlade:Clone();
                    ParticleHandler.Unusualify(v58, {
                        IncludeParts = true,
                        IncludeSurfaces = true,
                        Character = Attacker
                    });
                    v58.Parent = workspace;
                    v58:PivotTo(HumanoidRootPart.CFrame * CFrame.new(v57, i + 3, 0) * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966));
                    local v59 = HumanoidRootPart.CFrame:ToObjectSpace(v58.PrimaryPart.CFrame);
                    local Weld = Instance.new("Weld");
                    Weld.Parent = v58;
                    Weld.Part0 = HumanoidRootPart;
                    Weld.Part1 = v58.PrimaryPart;
                    Weld.C0 = v59;
                    table.insert(u55, { v58, Weld });
                end;
            end;

            MakeSide(1);
            MakeSide(2);
            local u60 = false;
            Sequence_V2.CreateFromOldSequence({
                Frames = {
                    { 60, function() -- Line: 305
                            -- upvalues: u55 (copy), Target (copy), HumanoidRootPart (copy), u60 (ref)
                            for _, v in u55 do
                                local u61, u62 = table.unpack(v);
                                local u63 = CFrame.lookAt(u61.PrimaryPart.Position, Target.HumanoidRootPart.Position);
                                u62.C0 = HumanoidRootPart.CFrame:ToObjectSpace(u63);
                                task.spawn(function() -- Line: 311
                                    -- upvalues: u60 (ref), u63 (ref), u61 (copy), Target (ref), u62 (copy), HumanoidRootPart (ref)
                                    while not u60 do
                                        u63 = CFrame.lookAt(u61.PrimaryPart.Position, Target.HumanoidRootPart.Position);
                                        u62.C0 = HumanoidRootPart.CFrame:ToObjectSpace(u63);
                                        task.wait();
                                    end;
                                end);
                            end;
                        end },
                    { 120, function() -- Line: 321
                            -- upvalues: u60 (ref), u55 (copy), u5 (ref), TweenOutBlade (ref), TweenOffDistance (ref), Target (copy)
                            u60 = true;

                            for _, v in u55 do
                                local u64, u65 = table.unpack(v);
                                local v66 = workspace:Raycast(u64.PrimaryPart.Position, u64.PrimaryPart.CFrame.LookVector * 5000, u5);

                                if v66 then
                                    TweenOffDistance(u64, Target.HumanoidRootPart.Position, u65);
                                    local Rotation = Target.HumanoidRootPart.CFrame:ToObjectSpace(u64.PrimaryPart.CFrame).Rotation;
                                    u65.Part0 = v66.Instance;
                                    u65.Part1 = u64.PrimaryPart;
                                    u65.C0 = Rotation;
                                else
                                    TweenOutBlade(u64);
                                    task.delay(0.3, function() -- Line: 329
                                        -- upvalues: u64 (copy), u65 (copy)
                                        u64:Destroy();
                                        u65:Destroy();
                                    end);
                                end;
                            end;
                        end },
                    { 480, function() -- Line: 345
                            -- upvalues: u55 (copy), TweenOutBlade (ref)
                            for _, v in u55 do
                                local u67, u68 = table.unpack(v);
                                TweenOutBlade(u67);
                                task.delay(0.3, function() -- Line: 350
                                    -- upvalues: u67 (copy), u68 (copy)
                                    u67:Destroy();
                                    u68:Destroy();
                                end);
                            end;
                        end }
                }
            }):Play();
        end;

        function Cache.MirageBladeSpiralBlades(p69) -- Line: 365
            -- upvalues: MirageBlade (copy), ParticleHandler (ref), TweenService (ref), u14 (copy), TweenOffDistance (copy), TweenOutBlade (copy), Sequence_V2 (ref)
            local Attacker = p69.Attacker;
            local Part = Instance.new("Part");
            Part.Transparency = 1;
            Part.CanCollide = false;
            Part.CanTouch = false;
            Part.CanQuery = false;
            Part.Parent = Attacker.HumanoidRootPart;
            Part.CFrame = Attacker.HumanoidRootPart.CFrame;
            Part.Size = Vector3.new(0.5, 0.5, 0.5);
            local Weld = Instance.new("Weld");
            Weld.Parent = Part;
            Weld.Part0 = Attacker.HumanoidRootPart;
            Weld.Part1 = Part;
            local u70 = {};

            for i = 1, 8 do
                local v71 = i / 8 * 3.141592653589793 * 2;
                local v72 = math.cos(v71) * 2;
                local v73 = math.sin(v71) * 2;
                local v74 = MirageBlade:Clone();
                ParticleHandler.Unusualify(v74, {
                    IncludeParts = true,
                    IncludeSurfaces = true,
                    Character = Attacker
                });
                v74.Parent = workspace;
                local v75 = Vector3.new(v72, 0, v73);
                local Unit = v75.Unit;
                local Weld2 = Instance.new("Weld");
                Weld2.Parent = Part;
                Weld2.Name = i;
                Weld2.Part0 = Part;
                Weld2.Part1 = v74.PrimaryPart;
                Weld2.C0 = CFrame.new(v75) * CFrame.lookAt(v75, v75 + Unit, Vector3.new(0, 1, 0));
                table.insert(u70, { v74, Weld2 });
            end;

            local u76 = TweenService:Create(Weld, u14, {
                C0 = CFrame.Angles(0, 3.141592653589793, 0)
            });
            u76:Play();
            Sequence_V2.CreateFromOldSequence({
                Frames = {
                    { 300, function() -- Line: 414
                            -- upvalues: u76 (copy)
                            u76:Cancel();
                        end },
                    { 360, function() -- Line: 419
                            -- upvalues: u70 (copy), Part (copy), TweenOffDistance (ref), TweenOutBlade (ref)
                            for _, v in u70 do
                                local v77, _ = table.unpack(v);
                                Part:Destroy();
                                v77.PrimaryPart.Anchored = true;
                                TweenOffDistance(v77, v77.PrimaryPart.Position + v77.PrimaryPart.CFrame.LookVector * 10, nil);
                                TweenOutBlade(v77, true);
                                task.delay(0.3, v77.Destroy, v77);
                            end;
                        end },
                    { 400, function() -- Line: 432
                            -- upvalues: u70 (copy), TweenOutBlade (ref)
                            for _, v in u70 do
                                local u78, u79 = table.unpack(v);
                                TweenOutBlade(u78);
                                task.delay(0.3, function() -- Line: 437
                                    -- upvalues: u78 (copy), u79 (copy)
                                    u78:Destroy();
                                    u79:Destroy();
                                end);
                            end;
                        end }
                }
            }):Play();
        end;

        function Cache.MirageBladeStormBlades(p80) -- Line: 452
            -- upvalues: u6 (copy), ShootSingleBladeOnlyZOffset (copy), u5 (copy), MirageBlade (copy), ParticleHandler (ref), TweenService (ref), u14 (copy), TweenOutBlade (copy), TweenOffDistance (copy), Sequence_V2 (ref)
            local Attacker = p80.Attacker;
            local Target = p80.Target;

            if not Target then
                return;
            end;

            local _ = u6:NextInteger(1, 2) == 1 and -2 or 2;
            u6:NextInteger(nil or -2, nil or 2);
            local HumanoidRootPart = Attacker.HumanoidRootPart;
            local u81 = nil;
            local u82 = nil;
            local u83 = {};
            local u84 = nil;
            local u85 = nil;
            ShootSingleBladeOnlyZOffset(Attacker, Target);
            Sequence_V2.CreateFromOldSequence({
                Frames = {
                    { 0, function() -- Line: 476
                            -- upvalues: u81 (ref), HumanoidRootPart (copy), Target (copy), u5 (ref)
                            u81 = workspace:Raycast(HumanoidRootPart.Position, (Target.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit * 3500, u5);
                        end },
                    { 10, function() -- Line: 479
                            -- upvalues: u84 (ref), Target (copy), MirageBlade (ref), ParticleHandler (ref), Attacker (copy), u83 (copy), u82 (ref), TweenService (ref), u14 (ref)
                            u84 = Instance.new("Part");
                            u84.Transparency = 1;
                            u84.CanCollide = false;
                            u84.CanTouch = false;
                            u84.CanQuery = false;
                            u84.Parent = Target.HumanoidRootPart;
                            u84.CFrame = Target.HumanoidRootPart.CFrame;
                            u84.Size = Vector3.new(0.5, 0.5, 0.5);
                            local Weld = Instance.new("Weld");
                            Weld.Parent = u84;
                            Weld.Part0 = Target.HumanoidRootPart;
                            Weld.Part1 = u84;

                            for i = 1, 8 do
                                local v86 = i / 8 * 3.141592653589793 * 2;
                                local v87 = math.cos(v86) * 2;
                                local v88 = math.sin(v86) * 2;
                                local v89 = MirageBlade:Clone();
                                ParticleHandler.Unusualify(v89, {
                                    IncludeParts = true,
                                    IncludeSurfaces = true,
                                    Character = Attacker
                                });
                                v89.Parent = workspace;
                                local v90 = Vector3.new(v87, 0, v88);
                                local Unit = v90.Unit;
                                local Weld2 = Instance.new("Weld");
                                Weld2.Parent = u84;
                                Weld2.Name = i;
                                Weld2.Part0 = u84;
                                Weld2.Part1 = v89.PrimaryPart;
                                Weld2.C0 = CFrame.new(v90) * CFrame.lookAt(v90, -(v90 + Unit), Vector3.new(0, 1, 0));
                                table.insert(u83, { v89, Weld2 });
                            end;

                            u82 = TweenService:Create(Weld, u14, {
                                C0 = CFrame.Angles(0, 3.141592653589793, 0)
                            });
                            u82:Play();
                        end },
                    { 190, function() -- Line: 529
                            -- upvalues: u85 (ref), u83 (copy), u84 (ref), u5 (ref), TweenOutBlade (ref), TweenOffDistance (ref), Target (copy)
                            u85 = table.clone(u83);
                            table.clear(u83);

                            for _, v in u85 do
                                local v91, v92 = table.unpack(v);
                                u84:Destroy();
                                v92:Destroy();
                                v91.PrimaryPart.Anchored = true;
                                local v93 = workspace:Raycast(v91.PrimaryPart.Position, v91.PrimaryPart.CFrame.LookVector * 350, u5);

                                if v93 then
                                    local Rotation = v93.Instance.CFrame:ToObjectSpace(v91.PrimaryPart.CFrame).Rotation;
                                    v91.PrimaryPart.Anchored = false;
                                    local Weld = Instance.new("Weld");
                                    TweenOffDistance(v91, Target.HumanoidRootPart.Position, Weld);
                                    Weld.Parent = v91;
                                    Weld.Part0 = v93.Instance;
                                    Weld.Part1 = v91.PrimaryPart;
                                    Weld.C0 = Rotation;
                                    table.insert(u83, { v91, Weld });
                                else
                                    TweenOutBlade(v91);
                                    task.delay(0.3, v91.Destroy, v91);
                                end;
                            end;

                            local BodyVelocity = Instance.new("BodyVelocity");
                            BodyVelocity.Parent = Target.HumanoidRootPart;
                            BodyVelocity.MaxForce = Vector3.new(100000000, 100000000, 100000000);
                            BodyVelocity.Velocity = Vector3.new(0, 75, 0);
                            task.delay(0.1, BodyVelocity.Destroy, BodyVelocity);
                        end },
                    { 210, function() -- Line: 564
                            -- upvalues: ShootSingleBladeOnlyZOffset (ref), Attacker (copy), Target (copy), u85 (ref)
                            ShootSingleBladeOnlyZOffset(Attacker, Target);
                            table.clear(u85);
                        end },
                    { 560, function() -- Line: 568
                            -- upvalues: u83 (copy), TweenOutBlade (ref)
                            for _, v in u83 do
                                local u94, u95 = table.unpack(v);
                                TweenOutBlade(u94);
                                task.delay(0.3, function() -- Line: 573
                                    -- upvalues: u94 (copy), u95 (copy)
                                    u94:Destroy();
                                    u95:Destroy();
                                end);
                            end;
                        end }
                }
            }):Play();
        end;

        function Cache.MirageBladeHeavyRain(p96) -- Line: 588
            -- upvalues: ShootSingleBladeOnlyZOffset (copy), MirageBlade (copy), ParticleHandler (ref), u6 (copy), u5 (copy), TweenOutBlade (copy), TweenOffDistance (copy), Sequence_V2 (ref)
            local Attacker = p96.Attacker;
            local Target = p96.Target;

            if not Target then
                return;
            end;

            local Origin = p96.Origin;
            local u97 = {};
            ShootSingleBladeOnlyZOffset(Attacker, Target);
            Sequence_V2.CreateFromOldSequence({
                Frames = {
                    { 10, function() -- Line: 602
                            -- upvalues: MirageBlade (ref), ParticleHandler (ref), Attacker (copy), u6 (ref), Origin (copy), u97 (copy)
                            for _ = 1, 24 do
                                local v98 = MirageBlade:Clone();
                                ParticleHandler.Unusualify(v98, {
                                    IncludeParts = true,
                                    IncludeSurfaces = true,
                                    Character = Attacker
                                });
                                v98.Parent = workspace;
                                v98.Blade.Anchored = true;
                                local v99 = nil or -16;
                                local v100 = nil or 16;
                                local v101 = u6:NextNumber(v99, v100);
                                local v102 = u6:NextNumber(v99, v100);
                                local v103 = Origin * CFrame.new(0, 21.5, 0) * CFrame.new(v101, 0, v102);
                                local v104 = nil or -5;
                                local v105 = nil or 5;
                                local v106 = math.random(v104, v105);
                                local v107 = math.rad(v106);
                                local v108 = math.random(v104, v105);
                                local v109 = math.rad(v108);
                                v98:PivotTo(v103 * CFrame.Angles(v107, 0, v109));
                                table.insert(u97, v98);
                            end;
                        end },
                    { 20, function() -- Line: 616
                            -- upvalues: u97 (copy), u5 (ref), TweenOutBlade (ref), u6 (ref), TweenOffDistance (ref)
                            for _, v in u97 do
                                local v110 = workspace:Raycast(v.PrimaryPart.Position, v.PrimaryPart.CFrame.LookVector * 3500, u5);

                                if v110 then
                                    local v111 = v110.Instance.CFrame:ToObjectSpace(v.PrimaryPart.CFrame) * CFrame.new(0, 0, -v.PrimaryPart.Position.Y);
                                    local Weld = Instance.new("Weld");
                                    Weld.Enabled = false;
                                    Weld.Parent = v;
                                    Weld.Part0 = v110.Instance;
                                    Weld.Part1 = v.PrimaryPart;
                                    Weld.C0 = v111;
                                    task.delay(u6:NextNumber(0, 0.5), TweenOffDistance, v, v110.Position, Weld);
                                else
                                    TweenOutBlade(v);
                                    task.delay(0.3, v.Destroy, v);
                                end;
                            end;
                        end },
                    { 200, function() -- Line: 636
                            -- upvalues: u97 (copy), TweenOutBlade (ref)
                            for _, v in u97 do
                                TweenOutBlade(v);
                                task.delay(0.3, v.Destroy, v);
                            end;
                        end }
                }
            }):Play();
        end;
    end
};