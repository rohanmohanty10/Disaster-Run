  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
require(game.ReplicatedStorage.ClientLibrary.BoatTween);
local u1 = RaycastParams.new();
u1.IgnoreWater = true;
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
u1.CollisionGroup = "Map";

function RaycastMap(p2, p3)
    -- upvalues: u1 (copy)
    return workspace:Raycast(p2, p3, u1);
end;

local _ = Fusion.New;
Random.new();
local LocalPlayer = Players.LocalPlayer;
local Settings = LocalPlayer:WaitForChild("Settings");
local MasterVolume = Settings:FindFirstChild("MasterVolume");
local ClientEmoteVolume = Settings:FindFirstChild("ClientEmoteVolume");
local OtherEmoteVolume = Settings:FindFirstChild("OtherEmoteVolume");

return function(p4) -- Line: 48
    -- upvalues: Players (copy), Trove (copy), ParticleHandler (copy), TweenService (copy), AssetHandler (copy), UserInputService (copy), LocalPlayer (copy), ClientEmoteVolume (copy), MasterVolume (copy), OtherEmoteVolume (copy)
    local Reference = p4.Reference;
    local Character = p4.Character;
    local u5 = Players:GetPlayerFromCharacter(Character);

    if not (Reference and Reference.Parent) then
        return;
    end;

    local v6 = Trove.new();
    v6:AttachToInstance(Reference);
    local u7 = 0.016666666666666666;
    local u8 = TweenInfo.new(u7 * 2.5, Enum.EasingStyle.Sine);
    ParticleHandler.GetUnusualHSVData({
        Character = Character
    });
    local Attach = Reference:WaitForChild("Attach");
    local AudioAnalyzer = Attach:WaitForChild("AudioAnalyzer");
    Attach:WaitForChild("AudioEmitter");
    local AudioPlayer = Attach:WaitForChild("AudioPlayer");
    Attach:FindFirstChildWhichIsA("Motor6D");
    local Volume = AudioPlayer.Volume;
    local Value = u5.Settings.FieldOfView.Value;

    local function GetRelative(p9, p10, p11) -- Line: 99
        return p10 == 0 and 1 or math.round(p9 * p11 / p10);
    end;

    local function Animate(p12, p13) -- Line: 104
        -- upvalues: TweenService (ref), u8 (copy)
        TweenService:Create(p12, u8, p13):Play();
    end;

    local v14 = {};
    local v15 = { 0, 2.0943951023931953, 4.1887902047863905 };
    local v16 = {};
    local u17 = 0;
    local v18 = 0;
    local v19 = 0;
    local u20 = {};
    local u21 = {};
    local u22 = {};
    local u23 = 0;
    local u24 = 1;

    for i = 1, 54 do
        local v25 = 2000 ^ (i / 54);
        v14[i] = {
            Lower = math.floor(v25),
            Fract = v25 - math.floor(v25)
        };
    end;

    local u26 = {};
    local u27 = {};
    local u28 = {};

    for i = 1, 54 do
        local v29 = (i - 1) / 53 * 53 + 1;
        local v30 = math.floor(v29);
        local v31 = math.min(v30 + 1, 54);
        u26[i] = v30;
        u27[i] = v31;
        u28[i] = v29 - v30;
    end;

    local u32 = {};
    local Beam = Instance.new("Beam");
    Beam.FaceCamera = false;
    Beam.Transparency = NumberSequence.new(0);
    Beam.LightInfluence = 0;
    Beam.LightEmission = 1;
    Beam.Brightness = 2.5;
    Beam.Texture = "rbxassetid://78209312692216";
    Beam.Color = ColorSequence.new(Color3.fromRGB(95, 255, 84));
    Beam.Width0 = 0;
    Beam.Width1 = 0;
    ParticleHandler.Unusualify(Beam, {
        Character = Character
    });
    local Trail = Instance.new("Trail");
    Trail.Lifetime = 0.07;
    Trail.Color = Beam.Color;
    Trail.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.5), NumberSequenceKeypoint.new(1, 1) });
    Trail.LightInfluence = 0;
    Trail.LightEmission = 1;
    Trail.Brightness = 2.5;
    Trail.Enabled = false;

    local function MapBins() -- Line: 130
        -- upvalues: AudioAnalyzer (copy), u26 (copy), u27 (copy), u28 (copy), u32 (copy)
        local v33 = AudioAnalyzer:GetSpectrum();

        if not v33[1] then
            return;
        end;

        for i = 1, 54 do
            local v34 = u26[i];
            u32[i] = math.sqrt(v33[v34] + (v33[u27[i]] - v33[v34]) * u28[i]) * 2;
        end;
    end;

    for _, v in v15 do
        local v35 = math.cos(v);
        local v36 = math.sin(v);
        local v37 = Vector3.new(v35, 0, v36) * 18;
        table.insert(v16, v37);
    end;

    local v38 = AssetHandler.GetAbilityData(Character);
    local u39 = v6:Add(AssetHandler.CloneAsset("Particles/Pose/PoseGround", v38));
    local u40 = v6:Add(AssetHandler.CloneAsset("Particles/Pose/PoseEffects", v38));
    local v41 = v6:Add(AssetHandler.CloneAsset("Particles/Pose/UserAura", v38));
    v41.Parent = workspace.Effects;
    ParticleHandler.Unusualify(v41, {
        Character = Character
    });
    ParticleHandler.Chromaify(v41, {
        Character = Character
    });
    ParticleHandler.AttachTo(v41, {
        Part = Character:FindFirstChild("Torso") or Character:FindFirstChild("HumanoidRootPart")
    });
    local u42 = {};
    local u43 = {};
    local u44 = false;

    for _, descendant in u40:GetDescendants() do
        if descendant.Name == "Line" then
            table.insert(u43, descendant);
        elseif descendant.Name == "MusicTone" then
            table.insert(u42, descendant);
        end;
    end;

    local function UpdateParticles() -- Line: 199
        -- upvalues: u39 (copy), u40 (copy), u42 (copy), u24 (ref), u43 (copy)
        if not (u39.Parent and u40.Parent) then
            return;
        end;

        for _, v in u42 do
            v.Size = NumberSequence.new(u24 * 0.9 + 0.2);
        end;

        for _, v in u43 do
            v.Rate = u24 * 10 + 25;
        end;
    end;

    for _, v in { u39, u40 } do
        if v == u39 then
            ParticleHandler.ScaleParticle(v, 1.15);
        else
            ParticleHandler.ScaleParticle(v, 0.95);
            v.Size = v.Size * 0.95;
        end;

        ParticleHandler.AttachTo(v, {
            Part = Character:FindFirstChild("HumanoidRootPart"),
            Offset = CFrame.new(0, 2.95, 0)
        });
        ParticleHandler.Unusualify(v, {
            Character = Character
        });
        ParticleHandler.Chromaify(v, {
            Character = Character
        });
        v.Parent = workspace.Effects;
        ParticleHandler.EnableAllParticles(v, true);
    end;

    local function AddPart(p45) -- Line: 228
        -- upvalues: Attach (copy), Reference (copy), u23 (ref), u21 (copy), Beam (copy), Trail (copy), u20 (copy), ParticleHandler (ref), Character (copy), TweenService (ref), u22 (copy)
        local Part = Instance.new("Part");
        Part.Size = Vector3.new(1, 1, 1);
        Part.Transparency = 1;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CastShadow = false;
        Part.CFrame = CFrame.new(Attach.Position) * p45;
        Part.Parent = Reference;
        u23 = u23 + 1;
        Part.Name = tostring(u23);
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = Part;

        if u21[u23 - 1] then
            local u46 = Instance.fromExisting(Beam);
            u46.Attachment0 = Attachment;
            u46.Attachment1 = u21[u23 - 1]:FindFirstChild("Attachment");
            u46.Parent = Attachment;
            local u47 = Instance.fromExisting(Trail);
            u47.Attachment0 = Attachment;
            u47.Attachment1 = u21[u23 - 1]:FindFirstChild("Attachment");
            u47.Parent = Attachment;
            u20[Part] = u46;
            ParticleHandler.Chromaify(u46, {
                Character = Character
            });
            ParticleHandler.Chromaify(u47, {
                Character = Character
            });
            task.delay((u23 - 1) * 0.03518518518518518, function() -- Line: 261
                -- upvalues: u47 (copy), TweenService (ref), u46 (copy)
                u47.Enabled = true;
                TweenService:Create(u46, TweenInfo.new(0.3851851851851852, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Width0 = 1.35,
                    Width1 = 1.35
                }):Play();
            end);
        end;

        if u23 == 54 then
            local u48 = Instance.fromExisting(Beam);
            u48.Attachment0 = u21[1]:FindFirstChild("Attachment");
            u48.Attachment1 = Attachment;
            u48.Parent = u21[1]:FindFirstChild("Attachment");
            local u49 = Instance.fromExisting(Trail);
            u49.Attachment0 = u21[1]:FindFirstChild("Attachment");
            u49.Attachment1 = Attachment;
            u49.Parent = u21[1]:FindFirstChild("Attachment");
            ParticleHandler.Chromaify(u48, {
                Character = Character
            });
            ParticleHandler.Chromaify(u49, {
                Character = Character
            });
            task.delay((u23 - 1) * 0.03518518518518518, function() -- Line: 282
                -- upvalues: u49 (copy), TweenService (ref), u48 (copy)
                u49.Enabled = true;
                TweenService:Create(u48, TweenInfo.new(0.3851851851851852, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Width0 = 1.35,
                    Width1 = 1.35
                }):Play();
            end);
            u20[u21[1]] = u48;
        end;

        table.insert(u21, Part);
        table.insert(u22, p45);
    end;

    for i = 1, #v16 do
        local v50 = v16[i];
        local v51 = v16[i % #v16 + 1];
        local Unit = (v51 - v50).Unit;

        for i2 = 1, 18 do
            local v52 = v50:Lerp(v51, i2 / 19);
            AddPart(CFrame.new(v52) * CFrame.lookAt(Vector3.new(0, 0, 0), Unit, Vector3.new(0, 1, 0)));
        end;
    end;

    if not UserInputService.TouchEnabled and LocalPlayer == u5 then
        local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui");
        local UI = PlayerGui:WaitForChild("UI");
        UI.Enabled = false;
        local u53 = false;
        v6:Add(UI:WaitForChild("Menus").Changed:Connect(function(p54) -- Line: 324
            -- upvalues: u53 (ref), UI (copy)
            print(p54, u53);

            if p54 == "Visible" and (u53 and not UI.Menus.Visible) then
                UI.Enabled = false;
                u53 = false;
            end;
        end));
        v6:Add(UserInputService.InputBegan:Connect(function(p55, p56) -- Line: 334
            -- upvalues: u53 (ref), UI (copy)
            if p56 then
                return;
            end;

            if p55.KeyCode.Name == "M" then
                u53 = not u53;
                UI.Enabled = not UI.Enabled;
            end;
        end));
        local CinematicBlackBars = PlayerGui:FindFirstChild("CinematicBlackBars");
        CinematicBlackBars.Enabled = true;
        CinematicBlackBars.Upper.Position = UDim2.fromScale(0.5, -1.1);
        CinematicBlackBars.Lower.Position = UDim2.fromScale(0.5, 1.1);
        TweenService:Create(CinematicBlackBars.Upper, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
            Position = UDim2.fromScale(0.5, -0.9)
        }):Play();
        TweenService:Create(CinematicBlackBars.Lower, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0.25), {
            Position = UDim2.fromScale(0.5, 0.9)
        }):Play();
        v6:Add(function() -- Line: 353
            -- upvalues: TweenService (ref), CinematicBlackBars (copy)
            TweenService:Create(CinematicBlackBars.Upper, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, -1.1)
            }):Play();
            TweenService:Create(CinematicBlackBars.Lower, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, 1.1)
            }):Play();
            task.delay(0.5, function() -- Line: 357
                -- upvalues: CinematicBlackBars (ref)
                CinematicBlackBars.Enabled = false;
            end);
        end);
        v6:Add(function() -- Line: 362
            -- upvalues: UI (copy)
            UI.Enabled = true;
        end);
    end;

    task.delay(2.25, function() -- Line: 367
        -- upvalues: u44 (ref)
        u44 = true;
    end);
    local CurrentCamera = workspace.CurrentCamera;

    local function Update() -- Line: 373
        -- upvalues: MapBins (copy), u24 (ref), AudioAnalyzer (copy), Attach (copy), u17 (ref), u23 (ref), u32 (copy), u21 (copy), u22 (copy), TweenService (ref), u8 (copy), LocalPlayer (ref), u5 (copy), CurrentCamera (copy), Value (copy)
        MapBins();
        u24 = AudioAnalyzer.RmsLevel;
        local v57 = CFrame.new(Attach.Position) * CFrame.new(0, -2.95, 0) * CFrame.Angles(0, u17 * 0.17453292519943295, 0);

        for i = 1, u23 do
            local v58 = u32[i] or 0;
            TweenService:Create(u21[i], u8, {
                CFrame = v57 * u22[i] * CFrame.new(v58 * -3, math.min(10 * v58, 10), 0)
            }):Play();
        end;

        if LocalPlayer == u5 then
            CurrentCamera.FieldOfView = math.lerp(CurrentCamera.FieldOfView, Value + u24 * 15, 0.75);
        end;
    end;

    local function UpdateVolume() -- Line: 394
        -- upvalues: Volume (copy), LocalPlayer (ref), u5 (copy), ClientEmoteVolume (ref), MasterVolume (ref), OtherEmoteVolume (ref), AudioPlayer (copy)
        local v59 = Volume;
        local v60;

        if LocalPlayer == u5 then
            v60 = v59 * (ClientEmoteVolume.Value / 100 * (MasterVolume.Value / 100));
        else
            v60 = v59 * (OtherEmoteVolume.Value / 100 * (MasterVolume.Value / 100));
        end;

        if AudioPlayer.Volume ~= v60 then
            AudioPlayer.Volume = v60;
        end;
    end;

    local function UpdateQuality() -- Line: 407
        -- upvalues: LocalPlayer (ref), Attach (copy), u7 (ref)
        local v61 = LocalPlayer:DistanceFromCharacter(Attach.Position);

        if v61 <= 100 then
            u7 = 0.016666666666666666;

            return;
        end;

        if v61 >= 100 and v61 < 200 then
            u7 = 0.05;

            return;
        end;

        if v61 >= 200 then
            u7 = 0.125;
        end;
    end;

    local u62 = true;
    local v63 = u5 == LocalPlayer;
    v6:Add(function() -- Line: 422
        -- upvalues: u62 (ref)
        u62 = false;
    end);

    if v63 then
        v6:Connect(ClientEmoteVolume:GetPropertyChangedSignal("Value"), UpdateVolume);
    else
        v6:Connect(OtherEmoteVolume:GetPropertyChangedSignal("Value"), UpdateVolume);
    end;

    v6:Connect(MasterVolume:GetPropertyChangedSignal("Value"), UpdateVolume);
    local v64;

    if LocalPlayer == u5 then
        v64 = Volume * (ClientEmoteVolume.Value / 100 * (MasterVolume.Value / 100));
    else
        v64 = Volume * (OtherEmoteVolume.Value / 100 * (MasterVolume.Value / 100));
    end;

    if AudioPlayer.Volume ~= v64 then
        AudioPlayer.Volume = v64;
    end;

    while u62 do
        local v65 = os.clock();

        if u7 <= v65 - v19 then
            Update();
            UpdateParticles();
            v19 = v65;
        end;

        if v63 or v65 - v18 < 0.35 then
            v65 = v18;
        else
            local v66 = LocalPlayer:DistanceFromCharacter(Attach.Position);

            if v66 <= 100 then
                u7 = 0.016666666666666666;
            elseif v66 >= 100 and v66 < 200 then
                u7 = 0.05;
            else
                u7 = v66 >= 200 and 0.125 or u7;
            end;
        end;

        task.wait();
        u17 = u17 + (task.wait() + u24 / 22.5);
        v18 = v65;
    end;

    if LocalPlayer == u5 then
        workspace.CurrentCamera.FieldOfView = u5.Settings.FieldOfView.Value;
    end;

    for _, v in u21 do
        v:Destroy();
    end;

    table.clear(u21);
    table.clear(u20);
    table.clear(u43);
    table.clear(u42);
    table.clear(u26);
    table.clear(u27);
    table.clear(u28);
    v6:Destroy();
end;