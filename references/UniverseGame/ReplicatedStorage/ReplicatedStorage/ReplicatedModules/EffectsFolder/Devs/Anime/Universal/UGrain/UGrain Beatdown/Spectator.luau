  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AnimationHandler = require(PathShortcuts.ReplicatedModules.AnimationHandler);

local function Highlight(p1, p2, p3) -- Line: 12
    -- upvalues: ParticleHandler (copy), EffectsHandler (copy)
    if not (p1 and p1.Parent) then
        return;
    end;

    local v4 = p3 or ParticleHandler.GetUnusualHSVData({
        Character = p1
    });
    EffectsHandler.CallEffect("HighlightObject", p1, {
        FillTransparency = -0.5,
        OutlineTransparency = 1,
        Tween = true,
        Style = "Sine",
        Direction = "In",
        DepthMode = Enum.HighlightDepthMode.Occluded,
        FillColor = ParticleHandler.TryHSVShift(Color3.fromRGB(71, 145, 255), v4),
        Lifetime = p2
    });
end;

return function(p5) -- Line: 27
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), AnimationHandler (copy), RunService (copy), EffectsHandler (copy), Highlight (copy)
    local v6 = p5 or {};
    local u7 = v6.HSVData or ParticleHandler.GetUnusualHSVData({
        Player = v6.Player or v6.AttackerPlayer,
        Character = v6.Character or v6.Attacker
    });
    local Attacker = v6.Attacker;
    local Target = v6.Target;
    local AttackerPlayer = v6.AttackerPlayer;
    local CFrame2 = Attacker.HumanoidRootPart.CFrame;
    local Animations = v6.Animations;
    local Trove = v6.Trove;
    local CloneChar = v6.CloneChar;
    local AttackerClone = v6.AttackerClone;
    local TargetClone = v6.TargetClone;
    local u8 = AssetHandler.GetAbilityData(Attacker);
    local u9 = os.clock();

    local function IsAlive() -- Line: 42
        -- upvalues: Attacker (copy), Target (copy)
        return Attacker.Parent and Target.Parent;
    end;

    local u10 = {};

    local function Load(p11, p12) -- Line: 45
        -- upvalues: Animations (copy), u10 (copy), AnimationHandler (ref)
        if not (p11 and p11.Parent) then
            return;
        end;

        for _, v in p12 do
            local v13 = Animations[v];

            if v13 then
                if typeof(v13) == "string" then
                    v13 = string.match(v13, "%d+") or v13;
                end;

                u10[v] = AnimationHandler.PlayAnimId(p11, v13, true);
            end;
        end;
    end;

    local function PlayTrack(p14, p15, p16) -- Line: 57
        -- upvalues: u10 (copy)
        local v17 = u10[p14];

        if v17 then
            if p16 ~= nil then
                v17.Looped = p16;
            end;

            v17:Play(0);

            if p15 and (p15 > 0 and (v17.Length and v17.Length > 0)) then
                v17.TimePosition = math.min(p15, v17.Length - 0.001);
            end;

            return v17;
        end;
    end;

    local function StopTrack(p18, p19) -- Line: 68
        -- upvalues: u10 (copy)
        local v20 = u10[p18];

        if v20 then
            v20:Stop(p19 or 0);
        end;
    end;

    Trove:Add(function() -- Line: 73
        -- upvalues: u10 (copy)
        for _, v in u10 do
            v:Stop();
        end;
    end);

    if AttackerClone and AttackerClone.Parent then
        AttackerClone:PivotTo(CFrame2);
    end;

    if TargetClone and TargetClone.Parent then
        TargetClone:PivotTo(CFrame2);
    end;

    local function ScheduleFrameEvents(p21, p22, p23) -- Line: 81
        -- upvalues: u9 (copy), Trove (copy), Attacker (copy), Target (copy), RunService (ref)
        local u24 = p22 or u9;
        local u25 = {};

        for i, v in pairs(p21) do
            if type(i) == "number" then
                u25[#u25 + 1] = v;
            end;
        end;

        table.sort(u25, function(p26, p27) -- Line: 89
            return p26[1] < p27[1];
        end);
        local u28 = 1;
        local u29 = #u25;
        local u30 = nil;

        local function Process() -- Line: 94
            -- upvalues: Attacker (ref), Target (ref), u30 (ref), u24 (ref), u28 (ref), u29 (copy), u25 (copy)
            if not (Attacker.Parent and Target.Parent) then
                if u30 then
                    u30:Disconnect();
                    u30 = nil;
                end;

                return;
            end;

            local v31 = os.clock() - u24;

            while u28 <= u29 do
                local v32 = u25[u28];

                if v31 < v32[1] / 60 then
                    break;
                end;

                u28 = u28 + 1;
                local u33 = v32[2];
                local u34 = math.max(0, v31 - v32[1] / 60);
                task.spawn(function() -- Line: 106
                    -- upvalues: Attacker (ref), Target (ref), u33 (copy), u34 (copy)
                    if Attacker.Parent and Target.Parent then
                        u33(u34);
                    end;
                end);
            end;

            if u29 < u28 and u30 then
                u30:Disconnect();
                u30 = nil;
            end;
        end;

        u30 = RunService.Heartbeat:Connect(Process);
        (p23 or Trove):Add(function() -- Line: 114
            -- upvalues: u30 (ref)
            if u30 then
                u30:Disconnect();
                u30 = nil;
            end;
        end);
        Process();
    end;

    local function WaitUntilTime(p35) -- Line: 120
        -- upvalues: Attacker (copy), Target (copy), RunService (ref)
        while true do
            if not (Attacker.Parent and Target.Parent) or os.clock() >= p35 then
                return;
            end;

            RunService.Heartbeat:Wait();
        end;
    end;

    local function WaitUntilFrame(p36, p37) -- Line: 126
        -- upvalues: WaitUntilTime (copy), u9 (copy)
        WaitUntilTime((p37 or u9) + p36 / 60);
    end;

    local u38 = { CFrame.new(1.046, -0.154, -17.719) * CFrame.Angles(0, -1.5707963267948966, 0), CFrame.new(2.542, -0.154, -32.563) * CFrame.Angles(0, 1.5707963267948966, 0), CFrame.new(1.046, -0.154, -34.175) * CFrame.Angles(0, -1.5707963267948966, 0) };

    local function DashEffect(p39) -- Line: 136
        -- upvalues: EffectsHandler (ref), CFrame2 (copy), u38 (copy), AttackerPlayer (copy), TargetClone (copy)
        EffectsHandler.CallEffect("Emit Particle V3", {
            VFXForgeEmit = true,
            Path = "Particles/Beatdown/Dash",
            Origin = CFrame2 * u38[p39],
            Player = AttackerPlayer
        });
        local v40 = TargetClone and TargetClone:FindFirstChild("HumanoidRootPart");

        if v40 then
            EffectsHandler.CallEffect("Emit Particle V3", {
                VFXForgeEmit = true,
                Path = "Particles/Beatdown/Hit",
                Player = AttackerPlayer,
                Origin = v40
            });
        end;
    end;

    local u41 = nil;
    local u42 = nil;

    local function StartEnd(p43) -- Line: 158
        -- upvalues: Trove (copy), u10 (copy), CloneChar (copy), AttackerClone (copy), CFrame2 (copy), TargetClone (copy), u42 (ref), ParticleHandler (ref), EffectsHandler (ref), Load (copy), AttackerPlayer (copy), Highlight (ref), u7 (copy), ScheduleFrameEvents (copy), WaitUntilTime (copy), u9 (copy)
        local v44 = p43 or 0;
        local v45 = os.clock() - v44;
        local v46 = Trove:Extend();
        local v47 = u10["Outside UGrain_Beatdown Attacker Loop"];

        if v47 then
            v47:Stop(0.1);
        end;

        local v48 = u10["Outside UGrain_Beatdown Target Loop"];

        if v48 then
            v48:Stop(0.1);
        end;

        local u49 = v46:Add(CloneChar(AttackerClone));
        u49.Parent = workspace.Effects;
        u49:PivotTo(CFrame2);
        local u50 = v46:Add(CloneChar(TargetClone));
        u50.Parent = workspace.Effects;
        u50:PivotTo(CFrame2);

        if u42 and u42.Parent then
            ParticleHandler.EnableAllParticles(u42, false);
        end;

        if AttackerClone and AttackerClone.Parent then
            EffectsHandler.CallEffect("SK_VANISH", {
                Transparency = 1,
                AffectStands = true,
                Character = AttackerClone,
                TweenInfo = { 0 }
            });
        end;

        if TargetClone and TargetClone.Parent then
            EffectsHandler.CallEffect("SK_VANISH", {
                Transparency = 1,
                AffectStands = true,
                Character = TargetClone,
                TweenInfo = { 0 }
            });
        end;

        Load(u49, { "Outside UGrain_Beatdown Attacker End" });
        Load(u50, { "Outside UGrain_Beatdown Target End" });
        local v51 = u10["Outside UGrain_Beatdown Attacker End"];

        if v51 then
            v51.Looped = false;
            v51:Play(0);

            if v44 and (v44 > 0 and (v51.Length and v51.Length > 0)) then
                v51.TimePosition = math.min(v44, v51.Length - 0.001);
            end;
        end;

        local v52 = u10["Outside UGrain_Beatdown Target End"];

        if v52 then
            v52.Looped = false;
            v52:Play(0);

            if v44 and (v44 > 0 and (v52.Length and v52.Length > 0)) then
                v52.TimePosition = math.min(v44, v52.Length - 0.001);
            end;
        end;

        local v54 = {
            { 3, function() -- Line: 201
                    -- upvalues: EffectsHandler (ref), AttackerPlayer (ref), CFrame2 (ref), Highlight (ref), u49 (copy), u7 (ref), u50 (copy)
                    EffectsHandler.CallEffect("Emit Particle V3", {
                        VFXForgeEmit = true,
                        Path = "Particles/Beatdown/End/Portal",
                        Player = AttackerPlayer,
                        Origin = CFrame2
                    });
                    Highlight(u49, 0.72, u7);
                    Highlight(u50, 0.72, u7);
                end },
            { 71, function() -- Line: 212
                    -- upvalues: EffectsHandler (ref), CFrame2 (ref), AttackerPlayer (ref), u50 (copy)
                    EffectsHandler.CallEffect("Emit Particle V3", {
                        VFXForgeEmit = true,
                        Path = "Particles/Beatdown/End/Impact",
                        Origin = CFrame2,
                        Player = AttackerPlayer
                    });
                    local v53 = u50 and u50:FindFirstChild("Torso");

                    if v53 then
                        EffectsHandler.CallEffect("Bubble Distortion", {
                            StartSize = Vector3.new(2.6666667, 2.6666667, 2.6666667),
                            EndSize = Vector3.new(11, 11, 11),
                            Transparency = 7,
                            Time = 0.6,
                            Origin = CFrame.new(v53.Position)
                        });
                    end;
                end },
            { 133, function() -- Line: 231
                    -- upvalues: u49 (copy), u50 (copy), EffectsHandler (ref)
                    for _, v in { u49, u50 } do
                        if v and v.Parent then
                            EffectsHandler.CallEffect("SK_VANISH", {
                                Transparency = 1,
                                AffectStands = true,
                                Character = v
                            });
                        end;
                    end;
                end },
            { 147, function() -- Line: 243
                    -- upvalues: EffectsHandler (ref), CFrame2 (ref), AttackerPlayer (ref)
                    EffectsHandler.CallEffect("Emit Particle V3", {
                        VFXForgeEmit = true,
                        Path = "Particles/Beatdown/End/GroundSlam",
                        Origin = CFrame2,
                        Player = AttackerPlayer
                    });
                end }
        };
        ScheduleFrameEvents(v54, v45, v46);
        WaitUntilTime((v45 or u9) + v54[#v54][1] / 60);
        v46:Destroy();
    end;

    local v67 = {
        { 0, function() -- Line: 259
                -- upvalues: u41 (ref), Trove (copy), AssetHandler (ref), u8 (copy), ParticleHandler (ref), u7 (copy), AttackerClone (copy), CFrame2 (copy), Load (copy), TargetClone (copy), u10 (copy), u42 (ref)
                u41 = Trove:Add(AssetHandler.CloneAsset("Models/Atoms", u8));
                ParticleHandler.Unusualify(u41, {
                    HSVData = u7
                });

                if AttackerClone and AttackerClone.PrimaryPart then
                    u41.PrimaryPart.CFrame = AttackerClone.PrimaryPart.CFrame * CFrame.new(0, 500, 0);
                else
                    u41.PrimaryPart.CFrame = CFrame2 * CFrame.new(0, 500, 0);
                end;

                u41.Parent = workspace.Effects;
                Load(u41, { "UGrain_Beatdown Atoms Start" });
                Load(AttackerClone, { "Outside UGrain_Beatdown Attacker Start", "Outside UGrain_Beatdown Attacker Loop" });
                Load(TargetClone, { "Outside UGrain_Beatdown Target Start", "Outside UGrain_Beatdown Target Loop" });
                local v55 = u10["UGrain_Beatdown Atoms Start"];

                if v55 then
                    v55.Looped = false;
                    v55:Play(0);
                end;

                local v56 = u10["Outside UGrain_Beatdown Attacker Start"];

                if v56 then
                    v56.Looped = false;
                    v56:Play(0);
                end;

                local v57 = u10["Outside UGrain_Beatdown Target Start"];

                if v57 then
                    v57.Looped = false;
                    v57:Play(0);
                end;

                local v58 = AttackerClone and AttackerClone:FindFirstChild("Torso");

                if v58 then
                    u42 = AssetHandler.CloneAsset("Particles/Beatdown/BodyTrail", u8);
                    ParticleHandler.Unusualify(u42, {
                        HSVData = u7
                    });
                    u42.Parent = AttackerClone;
                    ParticleHandler.AttachTo(u42, {
                        Part = v58
                    });
                    Trove:Add(function() -- Line: 290
                        -- upvalues: u42 (ref), ParticleHandler (ref)
                        if u42 and u42.Parent then
                            ParticleHandler.EnableAllParticles(u42, false);
                            ParticleHandler.DestroyEmit(u42);
                        end;
                    end);
                end;
            end },
        { 4, function() -- Line: 299
                -- upvalues: DashEffect (copy)
                DashEffect(1);
            end },
        { 79, function() -- Line: 300
                -- upvalues: DashEffect (copy)
                DashEffect(2);
            end },
        { 145, function() -- Line: 301
                -- upvalues: DashEffect (copy)
                DashEffect(3);
            end },
        { 237, function(p59) -- Line: 303
                -- upvalues: AttackerClone (copy), EffectsHandler (ref), AttackerPlayer (copy)
                local v60 = AttackerClone and AttackerClone:FindFirstChild("HumanoidRootPart");

                if not v60 then
                    return;
                end;

                EffectsHandler.CallEffect("Emit Particle V3", {
                    VFXForgeEmit = true,
                    Path = "Particles/Beatdown/WhirlStart",
                    Player = AttackerPlayer,
                    Origin = v60
                });
                EffectsHandler.CallEffect("UGrain Tornado", {
                    Scalar = 0.4,
                    Origin = CFrame.new(v60.Position),
                    Player = AttackerPlayer,
                    Duration = math.max(0, 1.05 - p59)
                });
            end },
        { 300, function(p61) -- Line: 322
                -- upvalues: u10 (copy)
                local v62 = u10["Outside UGrain_Beatdown Attacker Start"];

                if v62 then
                    v62:Stop(0.1);
                end;

                local v63 = u10["Outside UGrain_Beatdown Target Start"];

                if v63 then
                    v63:Stop(0.1);
                end;

                local v64 = u10["Outside UGrain_Beatdown Attacker Loop"];

                if v64 then
                    v64.Looped = true;
                    v64:Play(0);

                    if p61 and (p61 > 0 and (v64.Length and v64.Length > 0)) then
                        v64.TimePosition = math.min(p61, v64.Length - 0.001);
                    end;
                end;

                local v65 = u10["Outside UGrain_Beatdown Target Loop"];

                if not v65 then
                    return;
                end;

                v65.Looped = true;
                v65:Play(0);

                if p61 and (p61 > 0 and (v65.Length and v65.Length > 0)) then
                    v65.TimePosition = math.min(p61, v65.Length - 0.001);
                end;
            end },
        { 1951, function(p66) -- Line: 330
                -- upvalues: StartEnd (copy)
                StartEnd(p66);
            end },
        { 2098, function() -- Line: 334
            end }
    };
    ScheduleFrameEvents(v67, u9, Trove);
    WaitUntilTime(u9 + v67[#v67][1] / 60);
end;