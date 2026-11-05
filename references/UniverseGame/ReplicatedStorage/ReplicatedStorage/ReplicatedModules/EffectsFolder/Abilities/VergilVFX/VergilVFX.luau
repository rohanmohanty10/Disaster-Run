  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local TableUtil = require(ReplicatedStorage.ReplicatedModules.KnitPackage.TableUtil);
local Trove = require(ReplicatedStorage.ReplicatedModules.KnitPackage.Trove);
local Sequence_V2 = require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V2);
local AnimationHandler = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);
local ImpactFrames = require(script.ImpactFrames);
local JCESDistortSlash = require(script.JCESDistortSlash);

local function Orientation(p1, p2, p3) -- Line: 14
    return CFrame.fromOrientation(math.rad(p1), math.rad(p2), (math.rad(p3)));
end;

local function WrapParticleHandler(p4) -- Line: 18
    -- upvalues: TableUtil (copy), ParticleHandler (copy)
    local HSVShift = p4.HSVShift;
    local u5 = TableUtil.Copy(ParticleHandler, true);
    local EmitFromAttribute = u5.EmitFromAttribute;

    function u5.EmitFromAttribute(p6) -- Line: 23
        -- upvalues: HSVShift (copy), u5 (copy), EmitFromAttribute (copy)
        if HSVShift then
            u5.HSVShiftParticles(p6, HSVShift);
        end;

        EmitFromAttribute(p6);
    end;

    local EnableParticles = u5.EnableParticles;

    function u5.EnableParticles(p7) -- Line: 31
        -- upvalues: HSVShift (copy), u5 (copy), EnableParticles (copy)
        if HSVShift then
            u5.HSVShiftParticles(p7, HSVShift);
        end;

        EnableParticles(p7);
    end;

    return u5;
end;

return {
    Init = function(p8) -- Line: 42, Name: Init
        -- upvalues: ReplicatedStorage (copy), ParticleHandler (copy), TweenService (copy), Trove (copy), WrapParticleHandler (copy), Sequence_V2 (copy), ImpactFrames (copy), JCESDistortSlash (copy), AnimationHandler (copy)
        local Cache = p8.Cache;
        local Vergil = ReplicatedStorage["Client Assets"].Assets.Abilities.Vergil;
        local _ = Vergil.ComboA;
        local GeneralEffects = Vergil.GeneralEffects;
        local JudgementCut = Vergil.JudgementCut;
        local Barrage = Vergil.Barrage;
        local VoidSlash = Vergil.VoidSlash;
        local RapidSlash = Vergil.RapidSlash;
        local UpperSlash = Vergil.UpperSlash;
        local JCE = Vergil.JCE;
        local Pose = Vergil.Pose;

        local function Emit(p9, p10) -- Line: 56
            -- upvalues: ParticleHandler (ref)
            ParticleHandler.EmitFromAttribute(p9);

            if p10 == false then
                return;
            end;

            ParticleHandler.DestroyByMaxLifetime(p9);
        end;

        local function CreateParticle(p11, p12) -- Line: 63
            local v13 = p11:Clone();

            for i, v in p12 or {} do
                v13[i] = v;
            end;

            return v13;
        end;

        function Cache.VergilSheathe(p14) -- Line: 71
            -- upvalues: GeneralEffects (copy), ParticleHandler (ref)
            local Attacker = p14.Attacker;

            if not Attacker:FindFirstChild("HumanoidRootPart") then
                return;
            end;

            local v15 = Attacker["Left Arm"];
            local v16 = GeneralEffects.SheatheEmit:Clone();
            ParticleHandler.AttachParticle(v16, v15, {
                InverseAttach = true,
                C0 = CFrame.new(0, -1.03, -0.925)
            });
            local SheatheLight = v16:WaitForChild("M"):WaitForChild("SheatheLight");
            SheatheLight.Enabled = true;
            v16.Parent = workspace.Effects;
            ParticleHandler.EmitFromAttribute(v16);
            task.wait(0.1);
            SheatheLight.Enabled = false;
            ParticleHandler.DestroyByMaxLifetime(v16);
        end;

        function Cache.VergilSheatheAura(p17) -- Line: 92
            -- upvalues: GeneralEffects (copy), ParticleHandler (ref)
            local Attacker = p17.Attacker;

            if not Attacker:FindFirstChild("HumanoidRootPart") then
                return;
            end;

            local v18 = Attacker["Left Arm"];
            local v19 = GeneralEffects.SheatheHeatAura:Clone();
            ParticleHandler.AttachParticle(v19, v18, {
                InverseAttach = true,
                C0 = CFrame.new(-0.283, -1.118, 1.031) * CFrame.fromOrientation(0.12288863263292076, -0.2010095699521869, -0.04408701690537676)
            });

            if p17.Enable then
                ParticleHandler.EnableParticles(v19, true);
            end;

            v19.Parent = workspace.Effects;

            if p17.Emit then
                ParticleHandler.EmitFromAttribute(v19);
                ParticleHandler.DestroyByMaxLifetime(v19);
            end;

            if p17.Time then
                task.wait(p17.Time);
            end;

            if p17.Enable then
                ParticleHandler.EnableParticles(v19, false);
                ParticleHandler.DestroyByMaxLifetime(v19);
            end;
        end;

        function Cache.VergilComboA(p20) -- Line: 124
            -- upvalues: ParticleHandler (ref), TweenService (ref)
            local HumanoidRootPart = p20.Attacker:FindFirstChild("HumanoidRootPart");

            if not HumanoidRootPart then
                return;
            end;

            local CFrame2 = HumanoidRootPart.CFrame;
            local v21 = p20.VFX:Clone();

            for i, v in {} do
                v21[i] = v;
            end;

            local v22 = ParticleHandler.AttachParticle(v21, HumanoidRootPart, {
                InverseAttach = true,
                C0 = p20.OrientationStart
            });
            local v23 = v21:WaitForChild(p20.DecalName);
            v23.Transparency = p20.DecalTransparency;
            v21.Parent = workspace.Effects;
            local v24 = TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
            local v25 = TweenService:Create(v22, v24, {
                C0 = p20.OrientationGoal
            });
            local v26 = TweenService:Create(v23, v24, {
                Transparency = 1
            });
            v25:Play();
            v26:Play();
            local HSVShift = p20.HSVShift;

            if HSVShift then
                ParticleHandler.HSVShiftParticles(v21, HSVShift);
            end;

            ParticleHandler.EmitFromAttribute(v21);
            ParticleHandler.DestroyByMaxLifetime(v21);

            if p20.DustVFX then
                local v27 = {
                    Anchored = true,
                    CanCollide = false,
                    CFrame = CFrame2 * p20.DustOffset,
                    Parent = workspace.Effects
                };
                local v28 = p20.DustVFX:Clone();

                for i, v in v27 or {} do
                    v28[i] = v;
                end;

                if HSVShift then
                    ParticleHandler.HSVShiftParticles(v28, HSVShift);
                end;

                ParticleHandler.EmitFromAttribute(v28);
                ParticleHandler.DestroyByMaxLifetime(v28);
            end;
        end;

        function Cache.JCStartup(p29) -- Line: 168
            -- upvalues: JudgementCut (copy), ParticleHandler (ref), TweenService (ref)
            local Attacker = p29.Attacker;
            local HumanoidRootPart = Attacker:FindFirstChild("HumanoidRootPart");

            if not HumanoidRootPart then
                return;
            end;

            local Torso = Attacker.Torso;
            local CFrame2 = HumanoidRootPart.CFrame;
            local v30 = JudgementCut.JudgementCutStartupTorso:Clone();

            for i, v in {} do
                v30[i] = v;
            end;

            ParticleHandler.AttachParticle(v30, Torso, {
                InverseAttach = true,
                C0 = p29.OrientationStart
            });
            v30.Parent = workspace.Effects;
            local v31 = {
                Anchored = true,
                CanCollide = false,
                CFrame = CFrame2 + Vector3.new(0, -2, 0)
            };
            local v32 = JudgementCut.JudgementCutStartupDust:Clone();

            for i, v in v31 or {} do
                v32[i] = v;
            end;

            v32.Parent = workspace.Effects;
            ParticleHandler.EmitFromAttribute(v30);
            ParticleHandler.DestroyByMaxLifetime(v30);
            ParticleHandler.EmitFromAttribute(v32);
            ParticleHandler.DestroyByMaxLifetime(v32);
            local v33 = CFrame2 * CFrame.new(0, 0, 10);
            local v34 = RaycastParams.new();
            v34.FilterDescendantsInstances = { workspace.Map };
            v34.FilterType = Enum.RaycastFilterType.Include;
            v34.IgnoreWater = true;
            local v35 = workspace:Raycast(HumanoidRootPart.Position, HumanoidRootPart.CFrame.LookVector * -10, v34);

            if v35 and v35.Position then
                v33 = CFrame.new(v35.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
            end;

            TweenService:Create(HumanoidRootPart, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                CFrame = v33
            }):Play();
            local v36 = TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
            local v37 = {
                Anchored = true,
                CanCollide = false,
                CFrame = CFrame2 + Vector3.new(0, 3, 0)
            };
            local v38 = JudgementCut.WindupImpactMesh.Start:Clone();

            for i, v in v37 or {} do
                v38[i] = v;
            end;

            v38.Parent = workspace.Effects;
            TweenService:Create(v38, v36, {
                CFrame = CFrame2 * CFrame.fromOrientation(-0, 1.5707963267948966, -0) + Vector3.new(0, -3.5, 0)
            }):Play();
            local Decal = v38:WaitForChild("Decal");
            Decal.Transparency = 0;
            TweenService:Create(Decal, v36, {
                Transparency = 1
            }):Play();
            local Mesh = v38:WaitForChild("Mesh");
            Mesh.Scale = Vector3.new(-0.025, -0.1, -0.025);
            TweenService:Create(Mesh, v36, {
                Scale = Vector3.new(-0.07, -0.025, -0.07)
            }):Play();
            task.delay(0.16666666666666666, v38.Destroy, v38);
        end;

        function Cache.JudgementCut(p39) -- Line: 228
            -- upvalues: JudgementCut (copy), ParticleHandler (ref), TweenService (ref)
            local Attacker = p39.Attacker;
            local HumanoidRootPart = Attacker:FindFirstChild("HumanoidRootPart");

            if not HumanoidRootPart then
                return;
            end;

            local _ = Attacker.Torso;
            local v40 = Attacker["Left Arm"];
            local _ = HumanoidRootPart.CFrame;
            local v41 = JudgementCut.JudgementCutSheathe:Clone();

            for i, v in {} do
                v41[i] = v;
            end;

            ParticleHandler.AttachParticle(v41, v40, {
                InverseAttach = true,
                C0 = CFrame.new(0.113, -0.873, -0.914) * CFrame.fromOrientation(0.16646950405521915, -0.20296433871442057, -0.04436626958569585)
            });
            v41.Parent = workspace.Effects;
            ParticleHandler.EmitFromAttribute(v41);
            ParticleHandler.DestroyByMaxLifetime(v41);

            for _ = 1, p39.Amount or 1 do
                local v42 = {
                    Anchored = true,
                    CanCollide = false,
                    CFrame = p39.Goal
                };
                local v43 = p39.VFX:Clone();

                for i, v in v42 or {} do
                    v43[i] = v;
                end;

                local HSVShift = p39.HSVShift;

                if HSVShift then
                    ParticleHandler.HSVShiftParticles(v43, HSVShift);
                end;

                v43.Parent = workspace.Effects;
                ParticleHandler.EmitFromAttribute(v43);
                ParticleHandler.DestroyByMaxLifetime(v43);
            end;

            local v44 = {
                Anchored = true,
                CanCollide = false,
                Size = Vector3.new(0, 0, 0),
                CFrame = p39.Goal
            };
            local v45 = JudgementCut.JudgementCutDistort:Clone();

            for i, v in v44 or {} do
                v45[i] = v;
            end;

            v45.Parent = workspace.Effects;
            TweenService:Create(v45, TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Size = Vector3.new(20, 20, 20)
            }):Play();
            task.delay(0.03333333333333333, v45.Destroy, v45);
        end;

        function Cache.VergilBarrage(p46) -- Line: 274
            -- upvalues: Barrage (copy), ParticleHandler (ref)
            local Attacker = p46.Attacker;
            local HumanoidRootPart = Attacker:FindFirstChild("HumanoidRootPart");

            if not HumanoidRootPart then
                return;
            end;

            local v47 = Barrage.BarrageSlashes:Clone();

            for i, v in {} do
                v47[i] = v;
            end;

            local HSVShift = p46.HSVShift;

            if HSVShift then
                ParticleHandler.HSVShiftParticles(v47, HSVShift);
            end;

            ParticleHandler.AttachParticle(v47, HumanoidRootPart, {
                InverseAttach = true,
                C0 = CFrame.new(0, -1, 0)
            });
            ParticleHandler.EnableParticles(v47, true);
            v47.Parent = workspace.Effects;

            while Attacker:GetAttribute("Barraging") and Attacker.Parent do
                task.wait();
            end;

            ParticleHandler.EnableParticles(v47, false);
            ParticleHandler.DestroyByMaxLifetime(v47);
        end;

        function Cache.VergilBarrageFinisher(p48) -- Line: 300
            -- upvalues: Barrage (copy), ParticleHandler (ref), TweenService (ref)
            local HumanoidRootPart = p48.Attacker:FindFirstChild("HumanoidRootPart");

            if not HumanoidRootPart then
                return;
            end;

            local CFrame2 = HumanoidRootPart.CFrame;
            local BarrageEndSlash = Barrage.BarrageEndSlash;
            local v49 = {
                Anchored = true,
                CanCollide = false,
                CFrame = CFrame2 * CFrame.fromOrientation(0, 3.141592653589793, 0.5235987755982988),
                Parent = workspace.Effects
            };
            local v50 = BarrageEndSlash:Clone();

            for i, v in v49 or {} do
                v50[i] = v;
            end;

            local HSVShift = p48.HSVShift;

            if HSVShift then
                ParticleHandler.HSVShiftParticles(v50, HSVShift);
            end;

            local EndSlashDecal = v50:WaitForChild("EndSlashDecal");
            EndSlashDecal.Transparency = 0;
            TweenService:Create(v50, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                CFrame = CFrame2 * CFrame.fromOrientation(0, 0, -0.5235987755982988)
            }):Play();
            TweenService:Create(EndSlashDecal, TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
            ParticleHandler.EmitFromAttribute(v50);
            task.delay(0.16666666666666666, ParticleHandler.DestroyByMaxLifetime, v50);
            local BarrageEndSlashDust = Barrage.BarrageEndSlashDust;
            local v51 = {
                Anchored = true,
                CanCollide = false,
                CFrame = CFrame2 * CFrame.new(0, -2.95, 0),
                Parent = workspace.Effects
            };
            local v52 = BarrageEndSlashDust:Clone();

            for i, v in v51 or {} do
                v52[i] = v;
            end;

            ParticleHandler.EmitFromAttribute(v52);
            ParticleHandler.DestroyByMaxLifetime(v52);
            local BarrageEndSlashSwipeDust = Barrage.BarrageEndSlashSwipeDust;
            local v53 = {
                Anchored = true,
                CanCollide = false,
                CFrame = CFrame2 * CFrame.new(0, -2.95, -6) * CFrame.fromOrientation(-0, 1.5707963267948966, -0),
                Parent = workspace.Effects
            };
            local v54 = BarrageEndSlashSwipeDust:Clone();

            for i, v in v53 or {} do
                v54[i] = v;
            end;

            ParticleHandler.EmitFromAttribute(v54);
            ParticleHandler.DestroyByMaxLifetime(v54);
        end;

        function Cache.VergilVoidSlash(p55) -- Line: 353
            -- upvalues: Trove (ref), WrapParticleHandler (ref), VoidSlash (copy), TweenService (ref), GeneralEffects (copy), Sequence_V2 (ref)
            local Attacker = p55.Attacker;
            local HumanoidRootPart = Attacker:FindFirstChild("HumanoidRootPart");

            if not HumanoidRootPart then
                return;
            end;

            local _ = Attacker.Torso;
            local u56 = Trove.new();
            local u57 = Random.new();

            local function CreatePart(p58, p59) -- Line: 362
                -- upvalues: u56 (copy), HumanoidRootPart (copy)
                local v60 = u56:Clone(p59[p58]);
                v60.CanCollide = false;
                v60.Anchored = true;
                v60.Massless = true;
                v60.CFrame = HumanoidRootPart.CFrame;
                v60.Parent = workspace.Effects;

                return v60;
            end;

            local u61 = WrapParticleHandler(p55);
            Sequence_V2.CreateFromOldSequence({
                Frames = {
                    { 0, function(p62) -- Line: 376
                            -- upvalues: VoidSlash (ref), u56 (copy), HumanoidRootPart (copy), u61 (copy), TweenService (ref), u57 (copy)
                            local v63 = u56:Clone(VoidSlash.VoidTimeScale);
                            v63.CanCollide = false;
                            v63.Anchored = true;
                            v63.Massless = true;
                            v63.CFrame = HumanoidRootPart.CFrame;
                            v63.Parent = workspace.Effects;
                            p62.VoidTimeScale = v63;
                            local VoidTimeScale = p62.VoidTimeScale;
                            VoidTimeScale.CFrame = VoidTimeScale.CFrame * CFrame.fromOrientation(0, 3.141592653589793, 0);
                            local v64 = u56:Clone(VoidSlash.VoidSlashTick);
                            v64.CanCollide = false;
                            v64.Anchored = true;
                            v64.Massless = true;
                            v64.CFrame = HumanoidRootPart.CFrame;
                            v64.Parent = workspace.Effects;
                            p62.VoidSlashTick = v64;
                            local VoidSlashTick = p62.VoidSlashTick;
                            VoidSlashTick.CFrame = VoidSlashTick.CFrame * CFrame.fromOrientation(0, 3.141592653589793, 0);
                            u61.EmitFromAttribute(p62.VoidTimeScale);
                            u61.EmitFromAttribute(p62.VoidSlashTick);
                            local v65 = u56:Clone(VoidSlash.VoidSlashWindMesh);
                            v65.CanCollide = false;
                            v65.Anchored = true;
                            v65.Massless = true;
                            v65.CFrame = HumanoidRootPart.CFrame;
                            v65.Parent = workspace.Effects;
                            p62.VoidSlashWindMesh = v65;
                            local VoidSlashWindMesh = p62.VoidSlashWindMesh;
                            VoidSlashWindMesh.CFrame = VoidSlashWindMesh.CFrame * CFrame.fromOrientation(0, 3.141592653589793, 0);
                            local v66 = TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
                            TweenService:Create(p62.VoidSlashWindMesh:WaitForChild("VoidSlashWindDecal"), v66, {
                                Transparency = 0.9
                            }):Play();
                            TweenService:Create(p62.VoidTimeScale:WaitForChild("VoidSlashDecal"), v66, {
                                Transparency = 0.65
                            }):Play();
                            local fromOrientation = CFrame.fromOrientation;
                            local v67 = u57:NextNumber(-360, 360);
                            local v68 = fromOrientation(0, math.rad(v67), 0);
                            local VoidTimeScale2 = p62.VoidTimeScale;
                            VoidTimeScale2.CFrame = VoidTimeScale2.CFrame * v68;
                            local v69 = 0;

                            while p62.VoidSlashWindMesh.Parent or p62.VoidTimeScale.Parent do
                                local v70 = math.exp(v69 * -1.84) * 0.25;
                                local v71 = v70 < 0 and 0 or v70;

                                if p62.VoidSlashWindMesh.Parent then
                                    local VoidSlashWindMesh2 = p62.VoidSlashWindMesh;
                                    VoidSlashWindMesh2.CFrame = VoidSlashWindMesh2.CFrame * CFrame.fromOrientation(0, math.rad(v71), 0);
                                end;

                                if p62.VoidTimeScale.Parent then
                                    local VoidTimeScale3 = p62.VoidTimeScale;
                                    VoidTimeScale3.CFrame = VoidTimeScale3.CFrame * CFrame.fromOrientation(0, math.rad(v71), 0);
                                end;

                                v69 = v69 + task.wait();
                            end;
                        end },
                    { 10, function(p72) -- Line: 418
                            for _, descendant in p72.VoidTimeScale:GetDescendants() do
                                if descendant:IsA("ParticleEmitter") then
                                    descendant.TimeScale = 0.15;
                                end;
                            end;
                        end },
                    { 91, function(p73) -- Line: 426
                            -- upvalues: VoidSlash (ref), u56 (copy), HumanoidRootPart (copy), TweenService (ref)
                            local v74 = u56:Clone(VoidSlash.VoidSlashDistort);
                            v74.CanCollide = false;
                            v74.Anchored = true;
                            v74.Massless = true;
                            v74.CFrame = HumanoidRootPart.CFrame;
                            v74.Parent = workspace.Effects;
                            v74.Size = Vector3.new(0, 0, 0);
                            TweenService:Create(v74, TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), {
                                Size = Vector3.new(30, 15, 30)
                            }):Play();
                            task.wait(0.06666666666666667);
                            TweenService:Create(v74, TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), {
                                Size = Vector3.new(0, 0, 0)
                            }):Play();
                        end },
                    { 91, function(p75) -- Line: 437
                            -- upvalues: TweenService (ref)
                            local v76 = TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
                            TweenService:Create(p75.VoidSlashWindMesh:WaitForChild("VoidSlashWindDecal"), v76, {
                                Transparency = 1
                            }):Play();
                            TweenService:Create(p75.VoidTimeScale:WaitForChild("VoidSlashDecal"), v76, {
                                Transparency = 1
                            }):Play();
                        end },
                    { 91, function(p77) -- Line: 446
                            -- upvalues: GeneralEffects (ref), u56 (copy), HumanoidRootPart (copy), u61 (copy), VoidSlash (ref)
                            for _, descendant in p77.VoidTimeScale:GetDescendants() do
                                if descendant:IsA("ParticleEmitter") then
                                    descendant.TimeScale = 1;
                                end;
                            end;

                            local v78 = u56:Clone(GeneralEffects.SheatheEmit);
                            v78.CanCollide = false;
                            v78.Anchored = true;
                            v78.Massless = true;
                            v78.CFrame = HumanoidRootPart.CFrame;
                            v78.Parent = workspace.Effects;
                            u61.EmitFromAttribute(v78);
                            u61.EmitFromAttribute(p77.VoidSlashTick);
                            local v79 = u56:Clone(VoidSlash.DustPull);
                            v79.CanCollide = false;
                            v79.Anchored = true;
                            v79.Massless = true;
                            v79.CFrame = HumanoidRootPart.CFrame;
                            v79.Parent = workspace.Effects;
                            u61.EmitFromAttribute(v79);
                            task.delay(1, u56.Destroy, u56);
                        end }
                }
            }):Play();
        end;

        function Cache.VergilRapidSlash(p80) -- Line: 471
            -- upvalues: Trove (ref), WrapParticleHandler (ref), RapidSlash (copy), TweenService (ref), Sequence_V2 (ref)
            local Attacker = p80.Attacker;
            local HumanoidRootPart = Attacker:FindFirstChild("HumanoidRootPart");

            if not HumanoidRootPart then
                return;
            end;

            local _ = Attacker.Torso;
            local u81 = Trove.new();

            local function _(p82, p83) -- Line: 478
                -- upvalues: u81 (copy), HumanoidRootPart (copy)
                local v84 = u81:Clone(p83[p82]);
                v84.CanCollide = false;
                v84.Anchored = true;
                v84.Massless = true;
                v84.CFrame = HumanoidRootPart.CFrame;
                v84.Parent = workspace.Effects;

                return v84;
            end;

            local function Weld(p85, p86, p87) -- Line: 489
                -- upvalues: u81 (copy)
                p86.Anchored = false;
                p86.CanCollide = false;
                local Weld = Instance.new("Weld");
                Weld.Part0 = p85;
                Weld.Part1 = p86;
                Weld.C0 = p87;
                Weld.Parent = p86;
                u81:Add(Weld);

                return Weld;
            end;

            local u88 = WrapParticleHandler(p80);
            Sequence_V2.CreateFromOldSequence({
                Frames = {
                    { 0, function(p89) -- Line: 507
                            -- upvalues: RapidSlash (ref), u81 (copy), HumanoidRootPart (copy), u88 (copy), TweenService (ref)
                            local v90 = u81:Clone(RapidSlash.RapidSlashLastTick);
                            v90.CanCollide = false;
                            v90.Anchored = true;
                            v90.Massless = true;
                            v90.CFrame = HumanoidRootPart.CFrame;
                            v90.Parent = workspace.Effects;
                            p89.RapidSlashLastTick = v90;
                            p89.EndSlashDecal = p89.RapidSlashLastTick:WaitForChild("EndSlashDecal");
                            p89.EndSlashDecal.Transparency = 1;
                            local RapidSlashLastTick = p89.RapidSlashLastTick;
                            local v91 = CFrame.fromOrientation(-0.01733111947230369, -0.49237483528012027, -0.4479038459393048);
                            RapidSlashLastTick.Anchored = false;
                            RapidSlashLastTick.CanCollide = false;
                            local Weld2 = Instance.new("Weld");
                            Weld2.Part0 = HumanoidRootPart;
                            Weld2.Part1 = RapidSlashLastTick;
                            Weld2.C0 = v91;
                            Weld2.Parent = RapidSlashLastTick;
                            u81:Add(Weld2);
                            p89.SlashWeld = Weld2;
                            local v92 = u81:Clone(RapidSlash.RapidSlashTick1);
                            v92.CanCollide = false;
                            v92.Anchored = true;
                            v92.Massless = true;
                            v92.CFrame = HumanoidRootPart.CFrame;
                            v92.Parent = workspace.Effects;
                            p89.RapidSlashTick1 = v92;
                            local v93 = u81:Clone(RapidSlash.RapidSlashDashTick);
                            v93.CanCollide = false;
                            v93.Anchored = true;
                            v93.Massless = true;
                            v93.CFrame = HumanoidRootPart.CFrame;
                            v93.Parent = workspace.Effects;
                            p89.RapidSlashDashTick = v93;
                            local RapidSlashTick1 = p89.RapidSlashTick1;
                            local v94 = CFrame.new(0, -1, 0) * CFrame.fromOrientation(-0.25268876910373905, -0.06923721142661506, 0.2705958472292008);
                            RapidSlashTick1.Anchored = false;
                            RapidSlashTick1.CanCollide = false;
                            local Weld3 = Instance.new("Weld");
                            Weld3.Part0 = HumanoidRootPart;
                            Weld3.Part1 = RapidSlashTick1;
                            Weld3.C0 = v94;
                            Weld3.Parent = RapidSlashTick1;
                            u81:Add(Weld3);
                            local RapidSlashDashTick = p89.RapidSlashDashTick;
                            local v95 = CFrame.new(0, -2.5, 0);
                            RapidSlashDashTick.Anchored = false;
                            RapidSlashDashTick.CanCollide = false;
                            local Weld4 = Instance.new("Weld");
                            Weld4.Part0 = HumanoidRootPart;
                            Weld4.Part1 = RapidSlashDashTick;
                            Weld4.C0 = v95;
                            Weld4.Parent = RapidSlashDashTick;
                            u81:Add(Weld4);
                            u88.EmitFromAttribute(p89.RapidSlashTick1);
                            u88.EmitFromAttribute(p89.RapidSlashDashTick);
                            local v96 = TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear);
                            TweenService:Create(p89.RapidSlashDashTick, v96, {
                                CFrame = p89.RapidSlashDashTick.CFrame * CFrame.new(0, 0, -6)
                            }):Play();
                        end },
                    { 5, function(p97) -- Line: 527
                            -- upvalues: RapidSlash (ref), u81 (copy), HumanoidRootPart (copy), u88 (copy)
                            local v98 = u81:Clone(RapidSlash.RapidSlashTick2);
                            v98.CanCollide = false;
                            v98.Anchored = true;
                            v98.Massless = true;
                            v98.CFrame = HumanoidRootPart.CFrame;
                            v98.Parent = workspace.Effects;
                            p97.RapidSlashTick2 = v98;
                            local RapidSlashTick2 = p97.RapidSlashTick2;
                            local v99 = CFrame.new(0, -1, 0) * CFrame.fromOrientation(0.2526713158112191, -0.06923721142661506, -0.2705958472292008);
                            RapidSlashTick2.Anchored = false;
                            RapidSlashTick2.CanCollide = false;
                            local Weld2 = Instance.new("Weld");
                            Weld2.Part0 = HumanoidRootPart;
                            Weld2.Part1 = RapidSlashTick2;
                            Weld2.C0 = v99;
                            Weld2.Parent = RapidSlashTick2;
                            u81:Add(Weld2);
                            u88.EmitFromAttribute(p97.RapidSlashTick2);
                            u88.EmitFromAttribute(p97.RapidSlashDashTick);
                        end },
                    { 10, function(p100) -- Line: 535
                            -- upvalues: TweenService (ref), RapidSlash (ref), u81 (copy), HumanoidRootPart (copy), u88 (copy)
                            local v101 = TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
                            TweenService:Create(p100.SlashWeld, v101, {
                                C0 = CFrame.fromOrientation(-0.09546951008408983, 2.8857797451249843, 0.438601241026175)
                            }):Play();
                            local v102 = u81:Clone(RapidSlash.RapidSlashLastTickDust);
                            v102.CanCollide = false;
                            v102.Anchored = true;
                            v102.Massless = true;
                            v102.CFrame = HumanoidRootPart.CFrame;
                            v102.Parent = workspace.Effects;
                            p100.RapidSlashLastTickDust = v102;
                            local RapidSlashLastTickDust = p100.RapidSlashLastTickDust;
                            local v103 = CFrame.new(0, -2.95, 0);
                            RapidSlashLastTickDust.Anchored = false;
                            RapidSlashLastTickDust.CanCollide = false;
                            local Weld2 = Instance.new("Weld");
                            Weld2.Part0 = HumanoidRootPart;
                            Weld2.Part1 = RapidSlashLastTickDust;
                            Weld2.C0 = v103;
                            Weld2.Parent = RapidSlashLastTickDust;
                            u81:Add(Weld2);
                            u88.EmitFromAttribute(p100.RapidSlashLastTick);
                            u88.EmitFromAttribute(p100.RapidSlashLastTickDust);
                            p100.EndSlashDecal.Transparency = 0;
                            local v104 = TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
                            TweenService:Create(p100.EndSlashDecal, v104, {
                                Transparency = 1
                            }):Play();
                            task.delay(1, u81.Destroy, u81);
                        end }
                }
            }):Play();
        end;

        function Cache.VergilUpperSlash(p105) -- Line: 566
            -- upvalues: Trove (ref), WrapParticleHandler (ref), UpperSlash (copy), TweenService (ref), Sequence_V2 (ref)
            local Attacker = p105.Attacker;
            local HumanoidRootPart = Attacker:FindFirstChild("HumanoidRootPart");

            if not HumanoidRootPart then
                return;
            end;

            local _ = Attacker.Torso;
            local u106 = Trove.new();
            Random.new();

            local function _(p107, p108) -- Line: 575
                -- upvalues: u106 (copy), HumanoidRootPart (copy)
                local v109 = u106:Clone(p108[p107]);
                v109.CanCollide = false;
                v109.Anchored = true;
                v109.Massless = true;
                v109.CFrame = HumanoidRootPart.CFrame;
                v109.Parent = workspace.Effects;

                return v109;
            end;

            local function _(p110, p111, p112) -- Line: 586
                -- upvalues: u106 (copy)
                p111.Anchored = false;
                p111.CanCollide = false;
                local Weld = Instance.new("Weld");
                Weld.Part0 = p110;
                Weld.Part1 = p111;
                Weld.C0 = p112;
                Weld.Parent = p111;
                u106:Add(Weld);

                return Weld;
            end;

            local u113 = WrapParticleHandler(p105);
            Sequence_V2.CreateFromOldSequence({
                Frames = {
                    { 0, function(p114) -- Line: 604
                            -- upvalues: UpperSlash (ref), u106 (copy), HumanoidRootPart (copy), u113 (copy), TweenService (ref)
                            local v115 = u106:Clone(UpperSlash.UpperSlashSwing);
                            v115.CanCollide = false;
                            v115.Anchored = true;
                            v115.Massless = true;
                            v115.CFrame = HumanoidRootPart.CFrame;
                            v115.Parent = workspace.Effects;
                            p114.UpperSlashSwing = v115;
                            p114.SlashDecal1 = p114.UpperSlashSwing:WaitForChild("SlashDecal1");
                            p114.SlashDecal1.Transparency = 0;
                            local UpperSlashSwing = p114.UpperSlashSwing;
                            local v116 = CFrame.fromOrientation(1.1186687840657654, 3.0957079475548626, -1.4376102515752094);
                            UpperSlashSwing.Anchored = false;
                            UpperSlashSwing.CanCollide = false;
                            local Weld = Instance.new("Weld");
                            Weld.Part0 = HumanoidRootPart;
                            Weld.Part1 = UpperSlashSwing;
                            Weld.C0 = v116;
                            Weld.Parent = UpperSlashSwing;
                            u106:Add(Weld);
                            p114.SlashWeld = Weld;
                            local v117 = u106:Clone(UpperSlash.UpperSlashDust);
                            v117.CanCollide = false;
                            v117.Anchored = true;
                            v117.Massless = true;
                            v117.CFrame = HumanoidRootPart.CFrame;
                            v117.Parent = workspace.Effects;
                            p114.UpperSlashDust = v117;
                            local UpperSlashDust = p114.UpperSlashDust;
                            local v118 = CFrame.new(-0, -2.95, -2) * CFrame.fromOrientation(0, 3.141592653589793, -0);
                            UpperSlashDust.Anchored = false;
                            UpperSlashDust.CanCollide = false;
                            local Weld2 = Instance.new("Weld");
                            Weld2.Part0 = HumanoidRootPart;
                            Weld2.Part1 = UpperSlashDust;
                            Weld2.C0 = v118;
                            Weld2.Parent = UpperSlashDust;
                            u106:Add(Weld2);
                            u113.EmitFromAttribute(p114.UpperSlashSwing);
                            u113.EmitFromAttribute(p114.UpperSlashDust);
                            local v119 = TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
                            TweenService:Create(p114.SlashDecal1, v119, {
                                Transparency = 1
                            }):Play();
                        end },
                    { 30, function(p120) -- Line: 621
                            -- upvalues: u106 (copy)
                            task.delay(1, u106.Destroy, u106);
                        end }
                }
            }):Play();
        end;

        function Cache.VergilJCE(p121) -- Line: 633
            -- upvalues: Trove (ref), WrapParticleHandler (ref), JCE (copy), GeneralEffects (copy), ImpactFrames (ref), TweenService (ref), JCESDistortSlash (ref), Sequence_V2 (ref)
            local Attacker = p121.Attacker;
            local HumanoidRootPart = Attacker:FindFirstChild("HumanoidRootPart");

            if not HumanoidRootPart then
                return;
            end;

            local _ = Attacker.Torso;
            local LocalPlayer = game.Players.LocalPlayer;

            if LocalPlayer.Character ~= Attacker and (LocalPlayer.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 100 then
                return;
            end;

            local u122 = Trove.new();
            Random.new();
            local u123 = workspace:GetAttribute("FrameTiming") or 3;

            local function _(p124, p125) -- Line: 653
                -- upvalues: u122 (copy), HumanoidRootPart (copy)
                local v126 = u122:Clone(p125[p124]);
                v126.CanCollide = false;
                v126.Anchored = true;
                v126.Massless = true;
                v126.CFrame = HumanoidRootPart.CFrame;
                v126.Parent = workspace.Effects;

                return v126;
            end;

            local function _(p127, p128, p129) -- Line: 664
                -- upvalues: u122 (copy)
                p128.Anchored = false;
                p128.CanCollide = false;
                local Weld = Instance.new("Weld");
                Weld.Part0 = p127;
                Weld.Part1 = p128;
                Weld.C0 = p129;
                Weld.Parent = p128;
                u122:Add(Weld);

                return Weld;
            end;

            local u130 = WrapParticleHandler(p121);
            local u161 = Sequence_V2.CreateFromOldSequence({
                Frames = {
                    { 0, function(p131) -- Line: 683
                            -- upvalues: HumanoidRootPart (copy)
                            p131.Origin = HumanoidRootPart.CFrame;
                        end },
                    { 30, function(p132) -- Line: 686
                            -- upvalues: JCE (ref), u122 (copy), HumanoidRootPart (copy), u130 (copy)
                            local v133 = u122:Clone(JCE.CutsceneStomp);
                            v133.CanCollide = false;
                            v133.Anchored = true;
                            v133.Massless = true;
                            v133.CFrame = HumanoidRootPart.CFrame;
                            v133.Parent = workspace.Effects;
                            p132.CutsceneStomp = v133;
                            local CutsceneStomp = p132.CutsceneStomp;
                            local v134 = CFrame.new(-1.713, -2.875, -1.602);
                            CutsceneStomp.Anchored = false;
                            CutsceneStomp.CanCollide = false;
                            local Weld = Instance.new("Weld");
                            Weld.Part0 = HumanoidRootPart;
                            Weld.Part1 = CutsceneStomp;
                            Weld.C0 = v134;
                            Weld.Parent = CutsceneStomp;
                            u122:Add(Weld);
                            u130.EmitFromAttribute(p132.CutsceneStomp);
                        end },
                    { 165, function(p135) -- Line: 691
                            -- upvalues: JCE (ref), u122 (copy), HumanoidRootPart (copy), u130 (copy)
                            local v136 = u122:Clone(JCE.JCEStart);
                            v136.CanCollide = false;
                            v136.Anchored = true;
                            v136.Massless = true;
                            v136.CFrame = HumanoidRootPart.CFrame;
                            v136.Parent = workspace.Effects;
                            p135.JCEStart = v136;
                            local JCEStart = p135.JCEStart;
                            local v137 = CFrame.new(-0, -2.5, -0);
                            JCEStart.Anchored = false;
                            JCEStart.CanCollide = false;
                            local Weld = Instance.new("Weld");
                            Weld.Part0 = HumanoidRootPart;
                            Weld.Part1 = JCEStart;
                            Weld.C0 = v137;
                            Weld.Parent = JCEStart;
                            u122:Add(Weld);
                            u130.EmitFromAttribute(p135.JCEStart);
                        end },
                    { 195, function(p138) -- Line: 696
                            -- upvalues: JCE (ref), u122 (copy), HumanoidRootPart (copy), u130 (copy)
                            local v139 = u122:Clone(JCE.JCEBorder);
                            v139.CanCollide = false;
                            v139.Anchored = true;
                            v139.Massless = true;
                            v139.CFrame = HumanoidRootPart.CFrame;
                            v139.Parent = workspace.Effects;
                            p138.JCEBorder = v139;
                            local JCEBorder = p138.JCEBorder;
                            local v140 = CFrame.new(-0, -3, -0);
                            JCEBorder.Anchored = false;
                            JCEBorder.CanCollide = false;
                            local Weld = Instance.new("Weld");
                            Weld.Part0 = HumanoidRootPart;
                            Weld.Part1 = JCEBorder;
                            Weld.C0 = v140;
                            Weld.Parent = JCEBorder;
                            u122:Add(Weld);
                            u130.EnableParticles(p138.JCEBorder, true);
                            local v141 = u122:Clone(JCE.JCEStartAOECharge);
                            v141.CanCollide = false;
                            v141.Anchored = true;
                            v141.Massless = true;
                            v141.CFrame = HumanoidRootPart.CFrame;
                            v141.Parent = workspace.Effects;
                            p138.JCEStartAOECharge = v141;
                            local JCEStartAOECharge = p138.JCEStartAOECharge;
                            local v142 = CFrame.new(-0, -3, -0);
                            JCEStartAOECharge.Anchored = false;
                            JCEStartAOECharge.CanCollide = false;
                            local Weld2 = Instance.new("Weld");
                            Weld2.Part0 = HumanoidRootPart;
                            Weld2.Part1 = JCEStartAOECharge;
                            Weld2.C0 = v142;
                            Weld2.Parent = JCEStartAOECharge;
                            u122:Add(Weld2);
                            u130.EnableParticles(p138.JCEStartAOECharge, true);
                        end },
                    { 239, function(p143) -- Line: 705
                            -- upvalues: GeneralEffects (ref), u122 (copy), HumanoidRootPart (copy), u130 (copy)
                            local v144 = u122:Clone(GeneralEffects.JCESheathe);
                            v144.CanCollide = false;
                            v144.Anchored = true;
                            v144.Massless = true;
                            v144.CFrame = HumanoidRootPart.CFrame;
                            v144.Parent = workspace.Effects;
                            p143.JCESheathe = v144;
                            local JCESheathe = p143.JCESheathe;
                            local v145 = CFrame.new(-1.857, -1.449, 0.104) * CFrame.fromOrientation(0.08946557745722934, 1.562401293092804, -0.786131201683286);
                            JCESheathe.Anchored = false;
                            JCESheathe.CanCollide = false;
                            local Weld = Instance.new("Weld");
                            Weld.Part0 = HumanoidRootPart;
                            Weld.Part1 = JCESheathe;
                            Weld.C0 = v145;
                            Weld.Parent = JCESheathe;
                            u122:Add(Weld);
                            u130.EmitFromAttribute(p143.JCESheathe);
                            u130.EnableParticles(p143.JCEBorder, false);
                            u130.EnableParticles(p143.JCEStartAOECharge, false);
                        end },
                    { 257, function(p146) -- Line: 712
                            -- upvalues: JCE (ref), u122 (copy), HumanoidRootPart (copy), u130 (copy), GeneralEffects (ref), ImpactFrames (ref), u123 (copy)
                            local v147 = u122:Clone(JCE.JCEDash);
                            v147.CanCollide = false;
                            v147.Anchored = true;
                            v147.Massless = true;
                            v147.CFrame = HumanoidRootPart.CFrame;
                            v147.Parent = workspace.Effects;
                            p146.JCEDash = v147;
                            local JCEDash = p146.JCEDash;
                            local v148 = CFrame.new(-0, 0, -9);
                            JCEDash.Anchored = false;
                            JCEDash.CanCollide = false;
                            local Weld = Instance.new("Weld");
                            Weld.Part0 = HumanoidRootPart;
                            Weld.Part1 = JCEDash;
                            Weld.C0 = v148;
                            Weld.Parent = JCEDash;
                            u122:Add(Weld);
                            u130.EmitFromAttribute(p146.JCEDash);
                            local v149 = u122:Clone(GeneralEffects.AfterImage);
                            v149.CanCollide = false;
                            v149.Anchored = true;
                            v149.Massless = true;
                            v149.CFrame = HumanoidRootPart.CFrame;
                            v149.Parent = workspace.Effects;
                            p146.AfterImage = v149;
                            local AfterImage = p146.AfterImage;
                            local v150 = CFrame.new(-0.32, -1.18, -4.294) * CFrame.fromOrientation(-1.0402336874811404, 0.3312111321509639, -0.2140995393421444);
                            AfterImage.Anchored = false;
                            AfterImage.CanCollide = false;
                            local Weld2 = Instance.new("Weld");
                            Weld2.Part0 = HumanoidRootPart;
                            Weld2.Part1 = AfterImage;
                            Weld2.C0 = v150;
                            Weld2.Parent = AfterImage;
                            u122:Add(Weld2);
                            u130.EmitFromAttribute(p146.AfterImage);
                            local v151 = u122:Clone(JCE.ShockJCE);
                            v151.CanCollide = false;
                            v151.Anchored = true;
                            v151.Massless = true;
                            v151.CFrame = HumanoidRootPart.CFrame;
                            v151.Parent = workspace.Effects;
                            p146.ShockJCE = v151;
                            local ShockJCE = p146.ShockJCE;
                            local v152 = CFrame.new(-0.32, -1.18, -4.294) * CFrame.fromOrientation(-1.0402336874811404, 0.3312111321509639, -0.2140995393421444);
                            ShockJCE.Anchored = false;
                            ShockJCE.CanCollide = false;
                            local Weld3 = Instance.new("Weld");
                            Weld3.Part0 = HumanoidRootPart;
                            Weld3.Part1 = ShockJCE;
                            Weld3.C0 = v152;
                            Weld3.Parent = ShockJCE;
                            u122:Add(Weld3);
                            u130.EmitFromAttribute(p146.ShockJCE);
                            task.spawn(ImpactFrames, "Impact1", u123);
                        end },
                    { 262, function(p153) -- Line: 727
                            -- upvalues: Attacker (copy), TweenService (ref)
                            for _, descendant in p153.JCEDash:GetDescendants() do
                                if descendant:IsA("ParticleEmitter") then
                                    descendant.TimeScale = 0;
                                end;
                            end;

                            for _, descendant in Attacker:GetDescendants() do
                                if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                                    TweenService:Create(descendant, TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                        Transparency = 1
                                    }):Play();
                                end;
                            end;

                            task.delay(1, function() -- Line: 742
                                -- upvalues: Attacker (ref)
                                if Attacker:GetAttribute("SDT") then
                                    for _, descendant in Attacker.Stand:GetDescendants() do
                                        if (descendant:IsA("BasePart") or descendant:IsA("Decal")) and (descendant.Name ~= "HumanoidRootPart" and (descendant.Name ~= "YamatoSheatheRig" and not descendant:GetAttribute("IsTraitClone"))) then
                                            descendant.Transparency = 0;
                                        end;
                                    end;

                                    return;
                                end;

                                for _, descendant in Attacker:GetDescendants() do
                                    if (descendant:IsA("BasePart") or descendant:IsA("Decal")) and (descendant.Name ~= "HumanoidRootPart" and (descendant.Name ~= "YamatoSheatheRig" and not descendant:GetAttribute("IsTraitClone"))) then
                                        descendant.Transparency = 0;
                                    end;
                                end;
                            end);
                        end },
                    { 312, function(u154) -- Line: 761
                            -- upvalues: ImpactFrames (ref), u123 (copy), JCESDistortSlash (ref), HumanoidRootPart (copy), JCE (ref), u122 (copy), u130 (copy)
                            u154.TempSlashes = {};
                            task.spawn(ImpactFrames, "Impact2", u123);
                            task.spawn(function() -- Line: 765
                                -- upvalues: JCESDistortSlash (ref), u154 (copy), HumanoidRootPart (ref)
                                for _ = 1, 3 do
                                    task.spawn(JCESDistortSlash, {
                                        cache = u154.TempSlashes
                                    });
                                    task.spawn(JCESDistortSlash, {
                                        amount = 5,
                                        locked = false,
                                        origin = HumanoidRootPart.CFrame,
                                        cache = u154.TempSlashes
                                    });
                                    task.wait(0.08333333333333333);
                                end;
                            end);
                            local v155 = u122:Clone(JCE.JCEAOE);
                            v155.CanCollide = false;
                            v155.Anchored = true;
                            v155.Massless = true;
                            v155.CFrame = HumanoidRootPart.CFrame;
                            v155.Parent = workspace.Effects;
                            u154.JCEAOE = v155;
                            u154.JCEAOE.CFrame = u154.Origin * CFrame.new(0, 0, -19);
                            u130.EmitFromAttribute(u154.JCEAOE);

                            for _ = 1, 5 do
                                local u156 = u122:Clone(JCE.SlashAOESpam);
                                u156.CanCollide = false;
                                u156.Anchored = true;
                                u156.Massless = true;
                                u156.CFrame = HumanoidRootPart.CFrame;
                                u156.Parent = workspace.Effects;
                                u156.CFrame = u154.Origin * CFrame.new(0, 0, -19);
                                table.insert(u154.TempSlashes, u156);

                                for _, descendant in u156:GetDescendants() do
                                    if descendant:IsA("ParticleEmitter") then
                                        descendant:Emit(4);
                                    end;
                                end;

                                task.delay(0.05, function() -- Line: 796
                                    -- upvalues: u156 (copy)
                                    for _, descendant in u156:GetDescendants() do
                                        if descendant:IsA("ParticleEmitter") then
                                            descendant.TimeScale = 0;
                                        end;
                                    end;
                                end);
                                task.wait(0.08333333333333333);
                            end;
                        end },
                    { 317, function(p157) -- Line: 807
                            for _, descendant in p157.JCEAOE:GetDescendants() do
                                if descendant:IsA("ParticleEmitter") then
                                    descendant.TimeScale = 0;
                                end;
                            end;
                        end },
                    { 495, function(p158) -- Line: 814
                            -- upvalues: ImpactFrames (ref), u123 (copy)
                            task.spawn(ImpactFrames, "Impact3", u123);
                        end },
                    { 510, function(p159) -- Line: 817
                            -- upvalues: GeneralEffects (ref), u122 (copy), HumanoidRootPart (copy), u130 (copy)
                            for _, descendant in p159.JCEAOE:GetDescendants() do
                                if descendant:IsA("ParticleEmitter") then
                                    descendant.TimeScale = 1;
                                end;
                            end;

                            for _, descendant in p159.JCEDash:GetDescendants() do
                                if descendant:IsA("ParticleEmitter") then
                                    descendant.TimeScale = 1;
                                end;
                            end;

                            for _, v in p159.TempSlashes do
                                for _, descendant in v:GetDescendants() do
                                    if descendant:IsA("ParticleEmitter") then
                                        descendant.TimeScale = 1;
                                    end;
                                end;
                            end;

                            local v160 = u122:Clone(GeneralEffects.SheatheEmit);
                            v160.CanCollide = false;
                            v160.Anchored = true;
                            v160.Massless = true;
                            v160.CFrame = HumanoidRootPart.CFrame;
                            v160.Parent = workspace.Effects;
                            p159.SheatheEmit = v160;
                            u130.EmitFromAttribute(p159.SheatheEmit);
                            p159.Finished = true;
                            task.delay(1, u122.Destroy, u122);
                        end }
                }
            });
            u161:Play();
            u122:Connect(Attacker:GetAttributeChangedSignal("JCECancelled"), function() -- Line: 852
                -- upvalues: Attacker (copy), u161 (copy), u122 (copy)
                if not Attacker:GetAttribute("JCECancelled") then
                    return;
                end;

                u161:Stop();
                task.delay(1, u122.Destroy, u122);
            end);
        end;

        function Cache.VergilJCECamera(p162) -- Line: 859
            -- upvalues: Trove (ref), AnimationHandler (ref), JCE (copy), TweenService (ref), Sequence_V2 (ref)
            local LocalPlayer = game.Players.LocalPlayer;

            if LocalPlayer.Settings.CutsceneCamera.Value == false then
                return;
            end;

            local Character = LocalPlayer.Character;
            local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
            local Attacker = p162.Attacker;
            local HumanoidRootPart2 = Attacker:FindFirstChild("HumanoidRootPart");

            if not HumanoidRootPart2 then
                return;
            end;

            local _ = Attacker.Torso;
            local u163 = Trove.new();
            local CurrentCamera = workspace.CurrentCamera;
            local u164 = Character == Attacker;

            if not u164 and (HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude > 100 then
                return;
            end;

            local function _(p165, p166, p167) -- Line: 881
                -- upvalues: u163 (copy)
                p166.Anchored = false;
                p166.CanCollide = false;
                local Weld = Instance.new("Weld");
                Weld.Part0 = p165;
                Weld.Part1 = p166;
                Weld.C0 = p167;
                Weld.Parent = p166;
                u163:Add(Weld);

                return Weld;
            end;

            local u176 = Sequence_V2.CreateFromOldSequence({
                Frames = {
                    { 0, function(u168) -- Line: 897
                            -- upvalues: AnimationHandler (ref), u164 (copy), CurrentCamera (copy), u163 (copy), JCE (ref), HumanoidRootPart2 (copy), Character (copy)
                            local v169 = AnimationHandler.CreateAnimationByName("Vergil", nil, "JCECamera");

                            if u164 then
                                CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                                u168.TrackCamera = true;
                            end;

                            local u170 = u163:Clone(JCE["camera by kitsun"]);
                            u170.camerarootpart.CFrame = HumanoidRootPart2.CFrame;
                            local camerarootpart = u170.camerarootpart;
                            local identity = CFrame.identity;
                            camerarootpart.Anchored = false;
                            camerarootpart.CanCollide = false;
                            local Weld = Instance.new("Weld");
                            Weld.Part0 = HumanoidRootPart2;
                            Weld.Part1 = camerarootpart;
                            Weld.C0 = identity;
                            Weld.Parent = camerarootpart;
                            u163:Add(Weld);
                            u170.Parent = workspace.Effects;
                            local letterboxtop = u170:WaitForChild("letterboxtop");
                            local letterboxbot = u170:WaitForChild("letterboxbot");

                            if not u164 then
                                letterboxtop.Transparency = 1;
                                letterboxbot.Transparency = 1;
                            end;

                            u163:Connect(Character:GetAttributeChangedSignal("JCECutscene"), function() -- Line: 916
                                -- upvalues: Character (ref), letterboxtop (copy), letterboxbot (copy), CurrentCamera (ref), u168 (copy)
                                if not Character:GetAttribute("JCECutscene") then
                                    return;
                                end;

                                letterboxtop.Transparency = 0;
                                letterboxbot.Transparency = 0;
                                CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                                u168.TrackCamera = true;
                            end);
                            u168.CameraRig = u170;
                            task.spawn(function() -- Line: 926
                                -- upvalues: u168 (copy), CurrentCamera (ref), u170 (copy)
                                while not u168.Finished do
                                    if u168.TrackCamera then
                                        CurrentCamera.CFrame = u170.camera.CFrame;
                                    end;

                                    task.wait();
                                end;
                            end);
                            u170.AnimationController.Animator:LoadAnimation(v169):Play();
                        end },
                    { 312, function(p171) -- Line: 939
                            -- upvalues: TweenService (ref), CurrentCamera (copy)
                            for _, descendant in p171.CameraRig.CameraEffect:GetDescendants() do
                                if descendant:IsA("ParticleEmitter") then
                                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                                end;
                            end;

                            if not p171.TrackCamera then
                                return;
                            end;

                            TweenService:Create(CurrentCamera, TweenInfo.new(1.45, Enum.EasingStyle.Linear), {
                                FieldOfView = 90
                            }):Play();
                        end },
                    { 317, function(p172) -- Line: 951
                            for _, descendant in p172.CameraRig.CameraEffect:GetDescendants() do
                                if descendant:IsA("ParticleEmitter") then
                                    descendant.TimeScale = 0;
                                end;
                            end;
                        end },
                    { 400, function(p173) -- Line: 958
                            -- upvalues: TweenService (ref), CurrentCamera (copy)
                            if not p173.TrackCamera then
                                return;
                            end;

                            TweenService:Create(CurrentCamera, TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), {
                                FieldOfView = 30
                            }):Play();
                        end },
                    { 510, function(p174) -- Line: 964
                            for _, descendant in p174.CameraRig.CameraEffect:GetDescendants() do
                                if descendant:IsA("ParticleEmitter") then
                                    descendant.TimeScale = 1;
                                end;
                            end;
                        end },
                    { 531, function(p175) -- Line: 971
                            -- upvalues: CurrentCamera (copy), u163 (copy), TweenService (ref), LocalPlayer (copy)
                            p175.Finished = true;

                            if p175.TrackCamera then
                                CurrentCamera.CameraType = Enum.CameraType.Custom;
                            end;

                            task.delay(1, u163.Destroy, u163);

                            for _, child in p175.CameraRig:GetChildren() do
                                if child:IsA("BasePart") then
                                    child.Transparency = 1;
                                end;
                            end;

                            if not p175.TrackCamera then
                                return;
                            end;

                            TweenService:Create(CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                                FieldOfView = LocalPlayer.Settings.FieldOfView.Value
                            }):Play();
                        end }
                }
            });
            u176:Play();
            u163:Connect(Attacker:GetAttributeChangedSignal("JCECancelled"), function() -- Line: 997
                -- upvalues: Attacker (copy), u176 (copy), u163 (copy), CurrentCamera (copy)
                if not Attacker:GetAttribute("JCECancelled") then
                    return;
                end;

                u176:Stop();
                task.delay(1, u163.Destroy, u163);
                u176.Finished = true;

                if u176.TrackCamera then
                    CurrentCamera.CameraType = Enum.CameraType.Custom;
                end;
            end);
        end;

        function Cache.VergilPose(p177) -- Line: 1008
            -- upvalues: Pose (copy)
            local Attacker = p177.Attacker;
            local HumanoidRootPart = Attacker:FindFirstChild("HumanoidRootPart");

            if not HumanoidRootPart then
                return;
            end;

            local _ = Attacker.Humanoid.Animator;
            local v178 = Pose.ChairBasePart:Clone();

            if p177.ChairType == "PlasticChair" then
                v178:WaitForChild("TreeChairWeld"):Destroy();
                v178:WaitForChild("TreeChair"):Destroy();
                v178:WaitForChild("PlasticChair").Transparency = 0;
            else
                v178:WaitForChild("ChairWeld"):Destroy();
                v178:WaitForChild("PlasticChair"):Destroy();
                v178:WaitForChild("TreeChair").Transparency = 0;
            end;

            v178.Parent = workspace.Effects;
            local Motor6D = Instance.new("Motor6D");
            Motor6D.Name = "ChairBasePart";
            Motor6D.Part0 = HumanoidRootPart;
            Motor6D.Part1 = v178;
            Motor6D.C0 = CFrame.new(0, -0.846, 0);
            Motor6D.Enabled = true;
            Motor6D.Parent = HumanoidRootPart;

            while Attacker:GetAttribute("Posing") and Attacker.Parent do
                task.wait();
            end;

            v178:Destroy();
            Motor6D:Destroy();
        end;

        function Cache.VergilDoppelClone(p179) -- Line: 1045
            -- upvalues: ParticleHandler (ref), TweenService (ref)
            local Attacker = p179.Attacker;
            local _ = Attacker.Humanoid;
            local HumanoidRootPart = Attacker:FindFirstChild("HumanoidRootPart");

            if not HumanoidRootPart then
                return;
            end;

            local v180 = workspace.Effects:WaitForChild(p179.DoppelName, 5);

            if not v180 then
                return;
            end;

            local HumanoidRootPart2 = v180:WaitForChild("HumanoidRootPart", 5);

            if not HumanoidRootPart2 then
                return;
            end;

            local v181 = {};

            for _, descendant in Attacker:GetDescendants() do
                if descendant:IsA("Motor6D") then
                    v181[descendant.Name] = descendant;
                end;
            end;

            local function GetCloneColor(p182, p183) -- Line: 1065
                -- upvalues: ParticleHandler (ref)
                local v184 = Color3.fromRGB(0, 170, 255);
                local HSVShift = (p183 or {}).HSVShift;

                if HSVShift then
                    v184 = ParticleHandler.HSVShiftColor(v184, HSVShift);
                end;

                return v184;
            end;

            local DoppelOffset = p179.DoppelOffset;
            local Highlight = Instance.new("Highlight");
            Highlight.DepthMode = "Occluded";
            local _ = p179.Skin;
            local v185 = {
                HSVShift = p179.HSVShift
            } or {};
            local v186 = Color3.fromRGB(0, 170, 255);
            local HSVShift = v185.HSVShift;

            if HSVShift then
                v186 = ParticleHandler.HSVShiftColor(v186, HSVShift);
            end;

            Highlight.FillColor = v186;
            Highlight.FillTransparency = 1;
            local _ = p179.Skin;
            local v187 = {
                HSVShift = p179.HSVShift
            } or {};
            local v188 = Color3.fromRGB(0, 170, 255);
            local HSVShift2 = v187.HSVShift;

            if HSVShift2 then
                v188 = ParticleHandler.HSVShiftColor(v188, HSVShift2);
            end;

            Highlight.OutlineColor = v188;
            Highlight.OutlineTransparency = 1;
            Highlight.Parent = v180;
            TweenService:Create(Highlight, TweenInfo.new(1), {
                FillTransparency = 0.75,
                OutlineTransparency = 0.25
            }):Play();

            for _, descendant in v180:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= HumanoidRootPart2 then
                    descendant.Transparency = 1;
                    TweenService:Create(descendant, TweenInfo.new(0.5), {
                        Transparency = 0.5
                    }):Play();
                end;
            end;

            TweenService:Create(HumanoidRootPart2, TweenInfo.new(0.08333333333333333), {
                CFrame = HumanoidRootPart.CFrame * DoppelOffset
            }):Play();
            task.wait(0.08333333333333333);

            while Attacker:GetAttribute("Doppelganger") and (Attacker.Parent and v180.Parent) do
                for _, descendant in v180:GetDescendants() do
                    if descendant:IsA("Motor6D") and v181[descendant.Name] then
                        descendant.Transform = v181[descendant.Name].Transform;
                    end;
                end;

                HumanoidRootPart2.CFrame = HumanoidRootPart.CFrame * DoppelOffset;
                task.wait();
            end;
        end;
    end
};