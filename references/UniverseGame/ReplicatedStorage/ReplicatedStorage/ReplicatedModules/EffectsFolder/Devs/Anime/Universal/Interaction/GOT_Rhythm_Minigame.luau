  

 

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ProximityPromptService = game:GetService("ProximityPromptService");
local GuiService = game:GetService("GuiService");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
require(ReplicatedStorage.ReplicatedModules.Types);
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
Random.new();
local u1 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled;
local u2 = UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled and not UserInputService.TouchEnabled;
local u3 = {};

for _, child in script.Cosmetics:GetChildren() do
    u3[child.Name] = require(child);
end;

local u4 = CFrame.new(-3, 0.2, -8.5) * CFrame.Angles(0, 3.141592653589793, 0);
local u5 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(190, 225, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 175, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 225, 255)) });
local u6 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 130, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 90, 220)), ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 130, 255)) });
local u7 = NumberSequence.new(1);
local u8 = {};
local u9 = { 0, 0.06, 0.13 };
local u10 = { 0.1, 0.35, 0.6 };

for i = 0, 100 do
    u8[i] = NumberSequence.new(i / 100);
end;

local function GetNS(p11) -- Line: 60
    -- upvalues: u8 (copy)
    local v12 = math.floor(p11 * 100 + 0.5);

    return u8[math.clamp(v12, 0, 100)];
end;

local u13 = {};
u13.__index = u13;

function u13.new(p14, p15) -- Line: 91
    -- upvalues: Trove (copy), LocalPlayer (copy), CurrentCamera (copy), u13 (copy)
    local v16 = p15.LookAhead or 3;
    local v17 = p15.SampleRate or 0.35;
    local v18 = p15.PathHeight or 1.8;
    local v19 = p15.BeamWidth or 0.012;
    local v20 = math.ceil(v16 / v17) + 3 + 5;
    local v21 = {
        Trove = Trove.new(),
        Destroyed = false,
        Active = false,
        Config = p15,
        Song = p14,
        Duration = p15.Duration or p14.TimeLength,
        LookAhead = v16,
        SampleRate = v17,
        PathHeight = v18,
        Tolerance = p15.Tolerance or 0.3,
        Character = p15.Character or LocalPlayer.Character,
        LayerWidths = { v19, v19 * 0.7, v19 * 0.4 },
        MaxVisible = v20,
        PeakDropValue = 0,
        PeakDropTime = p15.PeakDropTime,
        PeakDropLocked = p15.PeakDropTime ~= nil,
        PrevSpectrumRaw = 0,
        Score = 0,
        TotalFrames = 0,
        GameStarted = false,
        GameEnded = false,
        Ending = false,
        EndingStartTime = 0,
        StartTime = 0,
        AudibleStarted = false,
        BaseFOV = CurrentCamera.FieldOfView,
        FOVPunch = 0,
        PrevAudibleRaw = 0,
        LoudnessBuffer = {},
        LoudIdx = 1,
        Samples = {},
        LastAnalysisTime = -1,
        SampleStart = 1,
        RunningY = 0,
        TargetY = 0,
        Energy = 0,
        PrevRaw = 0,
        PrevPathY = 0,
        SmoothedSlope = 0,
        CursorY = 0,
        TargetCursorY = 0,
        OrbIsGood = true,
        CurrentCamCF = nil,
        FiredTimedEffect = false,
        LastBeatTime = -2,
        Analyzer = nil,
        StartBin = 0,
        EndBin = 0,
        BinWidth = 0,
        BinsResolved = false
    };

    return setmetatable(v21, u13);
end;

function u13.Setup(u22) -- Line: 147
    -- upvalues: CurrentCamera (copy), ProximityPromptService (copy), u2 (copy), GuiService (copy), LocalPlayer (copy), u1 (copy), TweenService (copy), u5 (copy), u6 (copy)
    local Folder = Instance.new("Folder");
    Folder.Name = "Minigame";
    Folder.Parent = CurrentCamera;
    u22.Trove:Add(Folder);
    local Part = Instance.new("Part");
    Part.Transparency = 1;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Parent = Folder;
    u22.Anchor = Part;
    local v23 = u22.Trove:Clone(script.Orb);
    v23.Anchored = true;
    v23.CanCollide = false;
    v23.CanQuery = false;
    v23.CanTouch = false;
    v23.CastShadow = false;
    v23.Parent = Folder;
    u22.Orb = v23;
    u22.OrbDefaultSize = v23.Size;
    local v24 = {};
    local v25 = {};
    local v26 = {};

    for _, descendant in v23:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            table.insert(v24, descendant);
            v25[descendant] = descendant.Color;
            local v27 = {};

            for _, v in descendant.Color.Keypoints do
                local Value = v.Value;
                local new = ColorSequenceKeypoint.new;
                local Time = v.Time;
                local new2 = Color3.new;
                local v28 = math.clamp(Value.R + 0.6, 0, 1);
                table.insert(v27, new(Time, new2(v28, Value.G * 0.15, Value.B * 0.15)));
            end;

            v26[descendant] = ColorSequence.new(v27);
        end;
    end;

    u22.OrbParticles = v24;
    u22.OrbOrigColors = v25;
    u22.OrbRedColors = v26;
    local CameraType = CurrentCamera.CameraType;
    local CameraSubject = CurrentCamera.CameraSubject;
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    ProximityPromptService.Enabled = false;

    if u2 then
        GuiService.AutoSelectGuiEnabled = false;
        GuiService.GuiNavigationEnabled = false;
        GuiService.SelectedObject = nil;
    end;

    u22.Trove:Add(function() -- Line: 203
        -- upvalues: ProximityPromptService (ref), u2 (ref), GuiService (ref), CurrentCamera (ref), CameraType (copy), CameraSubject (copy), u22 (copy)
        ProximityPromptService.Enabled = true;

        if u2 then
            GuiService.AutoSelectGuiEnabled = true;
            GuiService.GuiNavigationEnabled = true;
        end;

        CurrentCamera.CameraType = CameraType;
        CurrentCamera.CameraSubject = CameraSubject;
        CurrentCamera.FieldOfView = u22.BaseFOV;
    end);
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "MinigameUI";
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = 50;
    ScreenGui.Parent = LocalPlayer.PlayerGui;
    u22.Trove:Add(ScreenGui);
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = ScreenGui;

    local function MakeLabel(p29, p30) -- Line: 228
        -- upvalues: Frame (copy)
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Size = UDim2.fromScale(0.2, 0.05);
        TextLabel.Position = UDim2.fromScale(0.5, p29);
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold);
        TextLabel.TextSize = p30;
        TextLabel.TextColor3 = Color3.new(1, 1, 1);
        TextLabel.TextStrokeTransparency = 0.5;
        TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
        TextLabel.Text = "";
        TextLabel.Parent = Frame;
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromHex("#afc8ff"));
        UIGradient.Rotation = 90;
        UIGradient.Parent = TextLabel;

        return TextLabel;
    end;

    u22.TimeLabel = MakeLabel(0.82, 24);
    u22.AccLabel = MakeLabel(0.86, 20);
    local v31 = u2 and "Left Stick to move" or (u1 and "Drag to move" or nil);

    if v31 then
        local u32 = MakeLabel(0.5, 22);
        u32.Text = v31;
        u32.TextTransparency = 0;
        task.delay(3, function() -- Line: 263
            -- upvalues: u32 (copy), TweenService (ref)
            if not u32.Parent then
                return;
            end;

            TweenService:Create(u32, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
        end);
    end;

    local v33 = {};
    local v34 = {};
    local v35 = {};
    local v36 = {};

    for i = 1, 3 do
        v33[i] = {};
        v34[i] = {};
        v35[i] = {};
        v36[i] = {};

        for i2 = 1, u22.MaxVisible do
            local Attachment = Instance.new("Attachment");
            Attachment.Parent = Part;
            v33[i][i2] = Attachment;
            local Attachment2 = Instance.new("Attachment");
            Attachment2.Parent = Part;
            v34[i][i2] = Attachment2;

            if i2 > 1 then
                for _, v in {
                    { v33, v35 },
                    { v34, v36 }
                } do
                    local Beam = Instance.new("Beam");
                    Beam.Attachment0 = v[1][i][i2 - 1];
                    local v37;

                    if v[1] == v33 then
                        v37 = Attachment;
                    else
                        v37 = Attachment2;
                    end;

                    Beam.Attachment1 = v37;
                    local v38;

                    if i == 1 then
                        v38 = u5;
                    else
                        v38 = u6;
                    end;

                    Beam.Color = v38;
                    Beam.Transparency = NumberSequence.new(1);
                    Beam.Width0 = u22.LayerWidths[i];
                    Beam.Width1 = u22.LayerWidths[i];
                    Beam.LightEmission = i == 1 and 1 or 0.7;
                    Beam.LightInfluence = 0;
                    Beam.FaceCamera = true;
                    Beam.Segments = 1;
                    Beam.Parent = Part;
                    v[2][i][i2 - 1] = Beam;
                end;
            end;
        end;
    end;

    u22.TopAtts = v33;
    u22.BotAtts = v34;
    u22.TopBeams = v35;
    u22.BotBeams = v36;
    u22.Effect = u22.Trove:Clone(script.Effect);
    u22.Effect.Anchored = true;
    u22.Effect.CanCollide = false;
    u22.Effect.Transparency = 1;
    u22.Effect.Parent = Folder;
    local v39 = u22.Trove:Clone(u22.Song);
    v39.Volume = 0;
    v39.Name = "MinigameAnalysis";
    v39.Parent = u22.Song.Parent;
    u22.Analysis = v39;
    local AudioAnalyzer = Instance.new("AudioAnalyzer");
    AudioAnalyzer.Parent = v39;
    u22.Trove:Add(AudioAnalyzer);
    local Wire = Instance.new("Wire");
    Wire.SourceInstance = v39;
    Wire.SourceName = "Output";
    Wire.TargetInstance = AudioAnalyzer;
    Wire.TargetName = "Input";
    Wire.Parent = AudioAnalyzer;
    u22.Trove:Add(Wire);
    u22.Analyzer = AudioAnalyzer;
    local PitchShiftSoundEffect = Instance.new("PitchShiftSoundEffect");
    PitchShiftSoundEffect.Octave = 1;
    PitchShiftSoundEffect.Parent = u22.Song;
    u22.Trove:Add(PitchShiftSoundEffect);
    u22.Pitch = PitchShiftSoundEffect;
    local EqualizerSoundEffect = Instance.new("EqualizerSoundEffect");
    EqualizerSoundEffect.HighGain = 0;
    EqualizerSoundEffect.MidGain = 0;
    EqualizerSoundEffect.LowGain = 0;
    EqualizerSoundEffect.Parent = u22.Song;
    u22.Trove:Add(EqualizerSoundEffect);
    u22.Distort = EqualizerSoundEffect;
end;

function u13.GetSpectrumData(p40) -- Line: 347
    local v41 = p40.Analyzer:GetSpectrum();

    if not v41 or #v41 == 0 then
        return 0, 0.5;
    end;

    if not p40.BinsResolved then
        local v42 = #v41;
        local v43 = 22050 / v42;
        local v44 = math.ceil(200 / v43);
        p40.StartBin = math.max(1, v44);
        local v45 = math.floor(12000 / v43);
        p40.EndBin = math.min(v42, v45);
        p40.BinWidth = v43;
        p40.BinsResolved = true;
    end;

    local v46 = 0;
    local v47 = 0;
    local v48 = 0;
    local v49 = 0;

    for i = p40.StartBin, p40.EndBin do
        local v50 = v41[i];
        v46 = v46 + v50;
        v47 = v47 + v50 * (i * p40.BinWidth);

        if v48 >= v50 then
            v50 = v48;
        end;

        v49 = v49 + 1;
        v48 = v50;
    end;

    if v49 == 0 or v46 < 0.00001 then
        return 0, 0.5;
    end;

    local v51 = math.max(v47 / v46, 200);
    local v52 = (math.log(v51) - 5.298317366548036) / 4.0943445622221;

    return (v46 / v49 * 0.4 + v48 * 0.6) * 800, math.clamp(v52, 0, 1);
end;

function u13.SetOrbColor(p53, p54) -- Line: 388
    if p54 == p53.OrbIsGood then
        return;
    end;

    p53.OrbIsGood = p54;

    for _, v in p53.OrbParticles do
        local v55;

        if p54 then
            v55 = p53.OrbOrigColors[v];
        else
            v55 = p53.OrbRedColors[v];
        end;

        v.Color = v55;
    end;
end;

function u13.ProcessSpectrum(p56, p57) -- Line: 396
    local PlaybackLoudness = p56.Analysis.PlaybackLoudness;
    local v58 = PlaybackLoudness - p56.PrevRaw;
    p56.PrevRaw = PlaybackLoudness;
    local v59 = p56.PathHeight / 2;

    if v58 > 15 and PlaybackLoudness > 25 then
        local v60, v61 = p56:GetSpectrumData();
        local v62;

        if v60 > 1 then
            v62 = (v61 - 0.5) * p56.PathHeight;
        else
            local v63 = math.clamp(PlaybackLoudness / 600, 0, 1);
            v62 = (p56.TargetY >= 0 and -1 or 1) * v63 * v59 * (0.6 + math.random() * 0.4);
        end;

        p56.TargetY = math.clamp(v62, -v59, v59);
    elseif PlaybackLoudness < 10 then
        p56.TargetY = p56.TargetY * 0.9;
    end;

    local v64 = PlaybackLoudness / 1000;

    if p56.Energy < v64 then
        p56.Energy = p56.Energy + (v64 - p56.Energy) * math.min(p57 * 30, 1);
    else
        p56.Energy = p56.Energy + (v64 - p56.Energy) * math.min(p57 * 5, 1);
    end;

    local v65 = math.abs(p56.TargetY - p56.RunningY) > 0.04 and 65 or 3;
    p56.RunningY = p56.RunningY + (p56.TargetY - p56.RunningY) * math.min(p57 * v65, 1);

    return p56.RunningY;
end;

function u13.HideBeams(p66) -- Line: 441
    -- upvalues: u7 (copy)
    for i = 1, 3 do
        for i2 = 1, p66.MaxVisible do
            p66.TopAtts[i][i2].Position = Vector3.new(0, -50, 0);
            p66.BotAtts[i][i2].Position = Vector3.new(0, -50, 0);

            if i2 > 1 then
                p66.TopBeams[i][i2 - 1].Transparency = u7;
                p66.BotBeams[i][i2 - 1].Transparency = u7;
            end;
        end;
    end;
end;

function u13.GetCamCF(p67) -- Line: 454
    -- upvalues: u4 (copy), CurrentCamera (copy)
    local v68 = p67.Character and (p67.Character.Parent and p67.Character:FindFirstChild("HumanoidRootPart"));

    if v68 then
        return v68.CFrame * u4;
    end;

    return CurrentCamera.CFrame;
end;

function u13.GetThumbstickY(p69) -- Line: 462
    -- upvalues: UserInputService (copy)
    local success, result = pcall(UserInputService.GetGamepadState, UserInputService, Enum.UserInputType.Gamepad1);

    if not (success and result) then
        return 0;
    end;

    for _, v in result do
        if v.KeyCode == Enum.KeyCode.Thumbstick1 then
            local Y = v.Position.Y;

            return math.abs(Y) < 0.12 and 0 or Y;
        end;
    end;

    return 0;
end;

function u13.OnTimedEffect(p70, p71) -- Line: 476
    -- upvalues: u3 (copy)
    if p70.Config.CosmeticFX and (u3[p70.Config.CosmeticFX] and typeof(u3[p70.Config.CosmeticFX].OnPeak) == "function") then
        task.spawn(u3[p70.Config.CosmeticFX].OnPeak, p70, p71);
    end;
end;

function u13.OnBeatDrop(p72, p73, p74) -- Line: 482
    -- upvalues: u3 (copy)
    if p72.Config.CosmeticFX and (u3[p72.Config.CosmeticFX] and typeof(u3[p72.Config.CosmeticFX].OnBeat) == "function") then
        task.spawn(u3[p72.Config.CosmeticFX].OnBeat, p72, p73, p74);
    end;
end;

function u13.Run(u75, u76) -- Line: 488
    -- upvalues: RunService (copy), CurrentCamera (copy), u2 (copy), UserInputService (copy), u9 (copy), u10 (copy), u8 (copy), u7 (copy)
    u75.Active = true;
    u75:Setup();

    if u75.Character then
        u75.Trove:AttachToInstance(u75.Character);
    end;

    u75.Analysis:Play();
    u75.StartTime = os.clock();
    u75.CurrentCamCF = u75:GetCamCF();
    local u77 = buffer.create(1);
    task.delay(u75.LookAhead, function() -- Line: 502
        -- upvalues: u75 (copy)
        if not u75.Active or u75.Destroyed then
            return;
        end;

        u75.Song:Play();
        u75.AudibleStarted = true;
    end);
    u75.Trove:Connect(RunService.RenderStepped, function(p78) -- Line: 508
        -- upvalues: u75 (copy), CurrentCamera (ref), u77 (copy), u76 (copy), u2 (ref), UserInputService (ref), u9 (ref), u10 (ref), u8 (ref), u7 (ref)
        if not u75.Active then
            return;
        end;

        u75.CurrentCamCF = u75.CurrentCamCF:Lerp(u75:GetCamCF(), (math.min(p78 * 8, 1)));
        CurrentCamera.CFrame = u75.CurrentCamCF;

        if u75.CamShake and u75.CamShake > 0.01 then
            local v79 = u75.CamShake * 0.75;
            local v80 = CurrentCamera;
            v80.CFrame = v80.CFrame * CFrame.new((math.random() - 0.5) * v79, (math.random() - 0.5) * v79, 0);
            local v81 = u75;
            v81.CamShake = v81.CamShake * math.max(1 - p78 * 5, 0);
        end;

        local v82 = os.clock() - u75.StartTime;
        local v83 = not u75.AudibleStarted and 0 or u75.Song.TimePosition;
        table.insert(u75.LoudnessBuffer, {
            Time = v82,
            Loud = u75.Analysis.PlaybackLoudness
        });

        if not u75.PeakDropLocked then
            local PlaybackLoudness = u75.Analysis.PlaybackLoudness;
            local v84 = math.abs(PlaybackLoudness - u75.PrevSpectrumRaw);
            u75.PrevSpectrumRaw = PlaybackLoudness;
            local v85 = u75.Analysis.TimePosition / u75.Duration;

            if v85 >= 0.2 and (v85 <= 0.8 and u75.PeakDropValue < v84) then
                u75.PeakDropValue = v84;
                u75.PeakDropTime = u75.Analysis.TimePosition;
            end;

            if v85 > 0.8 then
                u75.PeakDropLocked = true;
            end;
        end;

        local v86 = v82 - u75.LookAhead;
        local LoudnessBuffer = u75.LoudnessBuffer;
        local v87 = 0;

        while u75.LoudIdx < #LoudnessBuffer and LoudnessBuffer[u75.LoudIdx + 1].Time <= v86 do
            local v88 = u75;
            v88.LoudIdx = v88.LoudIdx + 1;
        end;

        if u75.LoudIdx <= #LoudnessBuffer and LoudnessBuffer[u75.LoudIdx].Time <= v86 then
            v87 = LoudnessBuffer[u75.LoudIdx].Loud;
        end;

        local v89 = math.abs(v87 - u75.PrevAudibleRaw);
        u75.PrevAudibleRaw = v87;

        if v89 > 15 then
            local FOVPunch = u75.FOVPunch;
            local v90 = math.clamp(v89 / 200, 0.2, 1);
            u75.FOVPunch = math.max(FOVPunch, v90);
        end;

        local v91 = u75;
        v91.FOVPunch = v91.FOVPunch * math.max(1 - p78 * 6, 0);
        CurrentCamera.FieldOfView = u75.BaseFOV + v87 / 1000 * 3 + u75.FOVPunch * 4;

        if u75.AudibleStarted and not u75.Ending then
            if not u75.FiredTimedEffect and (u75.PeakDropLocked and (u75.PeakDropTime and u75.PeakDropTime <= v83)) then
                u75.FiredTimedEffect = true;
                u75:OnTimedEffect(v83);
            end;

            if v89 > 55 and v83 - u75.LastBeatTime >= 2 then
                u75.LastBeatTime = v83;
                u75:OnBeatDrop(v83, (math.clamp(v89 / 200, 0, 1)));
            end;

            if not u75.Song.Playing and u75.LookAhead + 1 < v82 or (u75.Song.TimePosition >= u75.Duration - 0.3 or u75.Song.TimePosition <= 0.1 and u75.LookAhead + 2 < v82) then
                u75.Ending = true;
                u75.EndingStartTime = os.clock();
                u75.GameEnded = true;
            end;
        end;

        if u75.Ending then
            local v92 = (os.clock() - u75.EndingStartTime) / 1.2;
            local v93 = math.clamp(v92, 0, 1);
            u75.Orb.Size = u75.OrbDefaultSize * (1 - v93 * 0.8);

            for _, v in u75.OrbParticles do
                v.Enabled = v93 < 0.5;
            end;

            u75:HideBeams();
            u75.TimeLabel.TextTransparency = v93;
            u75.TimeLabel.TextStrokeTransparency = v93 * 0.5 + 0.5;
            u75.AccLabel.TextTransparency = v93;
            u75.AccLabel.TextStrokeTransparency = v93 * 0.5 + 0.5;
            u75.Pitch.Octave = 1;
            u75.Distort.HighGain = 0;
            u75.Distort.MidGain = 0;
            u75.Distort.LowGain = 0;
            CurrentCamera.FieldOfView = u75.BaseFOV;

            if v93 >= 1 then
                local v94 = u75.TotalFrames <= 0 and 0 or math.floor(u75.Score / u75.TotalFrames * 100);
                buffer.writeu8(u77, 0, v94);
                u76:FireServer(u77);
                u75:Destroy();
            end;

            return;
        end;

        local TimePosition = u75.Analysis.TimePosition;
        local v95 = u75:ProcessSpectrum(p78);

        if TimePosition - u75.LastAnalysisTime >= u75.SampleRate then
            table.insert(u75.Samples, {
                Time = TimePosition,
                Y = v95
            });
            u75.LastAnalysisTime = TimePosition;
        end;

        if not u75.GameStarted and (u75.AudibleStarted and v83 > 0.05) then
            u75.GameStarted = true;
        end;

        local v96 = u75.PathHeight / 2;

        if u2 then
            local v97 = u75:GetThumbstickY() * v96;
            u75.TargetCursorY = math.clamp(v97, -v96, v96);
        else
            local v98 = (1 - UserInputService:GetMouseLocation().Y / CurrentCamera.ViewportSize.Y - 0.5) * u75.PathHeight * 2.5;
            u75.TargetCursorY = math.clamp(v98, -v96, v96);
        end;

        local v99 = u75;
        v99.CursorY = v99.CursorY + (u75.TargetCursorY - u75.CursorY) * math.min(p78 * 14, 1);
        local CFrame2 = CurrentCamera.CFrame;
        local LookVector = CFrame2.LookVector;
        local RightVector = CFrame2.RightVector;
        local UpVector = CFrame2.UpVector;
        local Position = CFrame2.Position;
        u75.Anchor.CFrame = CFrame.new(Position);
        local v100 = LookVector * 1.5 + UpVector * -0.2;
        local v101 = LookVector * 12 + RightVector * 6.5 + UpVector * 1;
        local v102 = v100 + LookVector * -2 + RightVector * -1.5 + UpVector * -0.5;
        local v103 = Position + v100 + UpVector * u75.CursorY;
        local v104 = u75.Tolerance * 2 + u9[3] * 2;
        local Effect = u75.Effect;
        local v105 = math.max((v101 - v100).Magnitude, 0.5);
        Effect.Size = Vector3.new(v104, v104, v105);
        u75.Effect.CFrame = CFrame.lookAt(CFrame2.Position + (v100 + v101) / 2, CFrame2.Position + v101);
        local v106 = (1 / 0);
        local v107 = 0;

        for i = u75.SampleStart, #u75.Samples do
            local v108 = u75.Samples[i];
            local v109 = math.abs(v108.Time - v83);

            if v109 < v106 then
                v107 = v108.Y;
                v106 = v109;
            end;
        end;

        local v110 = math.abs(u75.CursorY - v107);
        local v111 = math.abs(v107 - u75.PrevPathY) / math.max(p78, 0.001);
        u75.PrevPathY = v107;

        if u75.SmoothedSlope < v111 then
            local v112 = u75;
            v112.SmoothedSlope = v112.SmoothedSlope + (v111 - u75.SmoothedSlope) * math.min(p78 * 20, 1);
        else
            local v113 = u75;
            v113.SmoothedSlope = v113.SmoothedSlope + (v111 - u75.SmoothedSlope) * math.min(p78 * 5, 1);
        end;

        local v114 = math.clamp(u75.SmoothedSlope / 3, 0, 1) * 0.35;
        local v115 = v110 <= u75.Tolerance * (v114 + 1);

        if u75.GameStarted and not u75.GameEnded then
            local v116 = u75;
            v116.TotalFrames = v116.TotalFrames + 1;

            if v115 then
                local v117 = u75;
                v117.Score = v117.Score + 1;
            end;
        end;

        u75:SetOrbColor(v115);

        if v115 then
            u75.Orb.CFrame = CFrame.new(v103);
            u75.Orb.Size = u75.OrbDefaultSize;
        else
            local v118 = math.clamp((v110 - u75.Tolerance) / (u75.PathHeight * 0.3), 0, 1);
            local v119 = v118 * 0.06;
            local v120 = v82 * 12 + v118 * 5;
            local v121 = v118 * 0.15;
            local Orb = u75.Orb;
            local new = CFrame.new;
            local v122 = (math.random() - 0.5) * 2 * v119;
            local v123 = (math.random() - 0.5) * 2 * v119;
            local v124 = (math.random() - 0.5) * 2 * v119;
            Orb.CFrame = new(v103 + Vector3.new(v122, v123, v124));
            local Orb2 = u75.Orb;
            local v125 = u75.OrbDefaultSize.X * (1 - math.sin(v120) * v121 * 0.5);
            local v126 = u75.OrbDefaultSize.Y * (math.sin(v120) * v121 + 1);
            local v127 = u75.OrbDefaultSize.Z * (1 - math.sin(v120) * v121 * 0.5);
            Orb2.Size = Vector3.new(v125, v126, v127);
        end;

        local v128 = math.clamp((v110 - u75.Tolerance) / (u75.PathHeight * 0.3), 0, 1);
        local v129 = not u75.GameStarted and 0 or v128;
        u75.Pitch.Octave = v129 * 0.15 * math.sin(v83 * 20) + 1;
        u75.Distort.HighGain = -v129 * 8;
        u75.Distort.MidGain = v129 * 3;
        u75.Distort.LowGain = v129 * 4;
        local v130 = math.max(0, u75.Duration - v83);
        u75.TimeLabel.Text = string.format("%d:%02d", math.floor(v130 / 60), (math.floor(v130 % 60)));
        local v131 = u75.TotalFrames <= 0 and 100 or math.floor(u75.Score / u75.TotalFrames * 100);
        u75.AccLabel.Text = v131 .. "%";
        local AccLabel = u75.AccLabel;
        local v132;

        if v131 >= 80 then
            v132 = Color3.fromRGB(120, 255, 120);
        elseif v131 >= 50 then
            v132 = Color3.fromRGB(255, 220, 80);
        else
            v132 = Color3.fromRGB(255, 80, 80);
        end;

        AccLabel.TextColor3 = v132;
        local Samples = u75.Samples;
        local v133 = 0;
        local v134 = {};

        for i = u75.SampleStart, #Samples do
            local v135 = Samples[i].Time - v83;

            if -(3 * u75.SampleRate + 0.5) <= v135 and v135 <= u75.LookAhead + 0.5 then
                v133 = v133 + 1;
                v134[v133] = i;
            end;
        end;

        for i = 1, u75.MaxVisible do
            local v136 = v134[i];

            if v136 then
                v136 = u75.Samples[v136];
            end;

            if v136 then
                local v137 = v136.Time - v83;
                local v138 = v137 / u75.LookAhead;
                local v139, v140;

                if v138 >= 0 then
                    local v141 = math.clamp(v138, 0, 1);
                    v139 = v100:Lerp(v101, v141);
                    v140 = math.clamp(1 - v141 * 0.7, 0.3, 1);
                else
                    local v142 = math.clamp(-v138 / (3 * u75.SampleRate / u75.LookAhead + 0.3), 0, 1);
                    v139 = v100:Lerp(v102, v142);
                    v140 = math.clamp(1 - v142 * 0.5, 0.5, 1);
                end;

                local v143 = u75.Tolerance * v140;

                for i2 = 1, 3 do
                    local v144 = u9[i2];
                    local v145 = math.sin(v82 * (i2 * 1.5 + 2.5) + i * 0.7 + i2 * 1.3) * v144 * 1.5;
                    local v146 = math.cos(v82 * (i2 * 1.2 + 1.8) + i * 0.5 + i2 * 2.1) * v144 * 0.5;
                    u75.TopAtts[i2][i].Position = v139 + UpVector * (v136.Y * v140 + v143 + v144 + v145) + RightVector * v146;
                    u75.BotAtts[i2][i].Position = v139 + UpVector * (v136.Y * v140 - v143 - v144 - v145) + RightVector * v146;

                    if i > 1 then
                        local v147 = u10[i2];

                        if v138 > 0.85 then
                            v147 = v147 + (1 - v147) * ((v138 - 0.85) / 0.15);
                        elseif v138 < 0 then
                            v147 = v147 + (1 - v147) * math.clamp(-v137 / (3 * u75.SampleRate + 0.3), 0, 1);
                        end;

                        if i2 > 1 then
                            local v148 = v147 + math.sin(v82 * (i2 + 3) + i * 0.4) * 0.1;
                            v147 = math.clamp(v148, 0, 1);
                        end;

                        local v149 = u75.LayerWidths[i2] * v140;
                        local v150 = u75.TopBeams[i2][i - 1];
                        local v151 = math.floor(v147 * 100 + 0.5);
                        v150.Transparency = u8[math.clamp(v151, 0, 100)];
                        u75.TopBeams[i2][i - 1].Width0 = v149;
                        u75.TopBeams[i2][i - 1].Width1 = v149;
                        local v152 = u75.BotBeams[i2][i - 1];
                        local v153 = math.floor(v147 * 100 + 0.5);
                        v152.Transparency = u8[math.clamp(v153, 0, 100)];
                        u75.BotBeams[i2][i - 1].Width0 = v149;
                        u75.BotBeams[i2][i - 1].Width1 = v149;
                    end;
                end;
            else
                for i2 = 1, 3 do
                    u75.TopAtts[i2][i].Position = Vector3.new(0, -50, 0);
                    u75.BotAtts[i2][i].Position = Vector3.new(0, -50, 0);

                    if i > 1 then
                        u75.TopBeams[i2][i - 1].Transparency = u7;
                        u75.BotBeams[i2][i - 1].Transparency = u7;
                    end;
                end;
            end;
        end;

        while u75.SampleStart <= #u75.Samples and u75.Samples[u75.SampleStart].Time - v83 < -(3 * u75.SampleRate + 1) do
            local v154 = u75;
            v154.SampleStart = v154.SampleStart + 1;
        end;
    end);
end;

function u13.GetScore(p155) -- Line: 808
    return p155.TotalFrames <= 0 and 0 or p155.Score / p155.TotalFrames;
end;

function u13.Destroy(u156) -- Line: 812
    if u156.Destroyed then
        return;
    end;

    u156.Destroyed = true;
    u156.Active = false;
    u156.Song:Stop();
    u156.Analysis:Stop();
    u156.Trove:Destroy();
    task.defer(function() -- Line: 821
        -- upvalues: u156 (copy)
        table.clear(u156);
        table.freeze(u156);
    end);
end;

return function(p157, p158) -- Line: 827
    -- upvalues: u13 (copy)
    local v159 = p158.Song or script.Songs:FindFirstChild(p158.SongName or "Zenitsu");

    if v159 then
        local v160 = u13.new(v159, p158);
        task.spawn(v160.Run, v160, p157);

        return v160;
    end;
end;