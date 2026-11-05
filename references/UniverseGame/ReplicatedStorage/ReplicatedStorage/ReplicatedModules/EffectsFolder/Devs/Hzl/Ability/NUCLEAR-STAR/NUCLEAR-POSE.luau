  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local LocalPlayer = Players.LocalPlayer;
local Settings = LocalPlayer:WaitForChild("Settings");
local MasterVolume = Settings:FindFirstChild("MasterVolume");
local ClientEmoteVolume = Settings:FindFirstChild("ClientEmoteVolume");
local OtherEmoteVolume = Settings:FindFirstChild("OtherEmoteVolume");

return function(p1) -- Line: 29
    -- upvalues: Players (copy), Trove (copy), ParticleHandler (copy), TweenService (copy), AssetHandler (copy), UserInputService (copy), LocalPlayer (copy), ClientEmoteVolume (copy), MasterVolume (copy), OtherEmoteVolume (copy)
    local Reference = p1.Reference;
    local Character = p1.Character;
    local u2 = Players:GetPlayerFromCharacter(Character);

    if not (Reference and Reference.Parent) then
        return;
    end;

    local v3 = Trove.new();
    v3:AttachToInstance(Reference);
    local u4 = 0.016666666666666666;
    local u5 = 0.03333333333333333;
    local u6 = 0.06666666666666667;
    local u7 = TweenInfo.new(u4 * 1.5, Enum.EasingStyle.Sine);
    local u8 = Color3.fromRGB(140, 140, 140);
    local u9 = Character:GetAttribute("MeterColor") or Color3.fromRGB(120, 187, 220);
    local u10 = CFrame.Angles(1.5707963267948966, 0, 0);
    local v11 = ParticleHandler.GetUnusualHSVData({
        Character = Character
    });

    if v11 then
        u9 = ParticleHandler.TryHSVShift(u9, v11);
    end;

    local Attach = Reference:WaitForChild("Attach");
    local AudioAnalyzer = Attach:WaitForChild("AudioAnalyzer");
    Attach:WaitForChild("AudioEmitter");
    local AudioPlayer = Attach:WaitForChild("AudioPlayer");
    Attach:FindFirstChildWhichIsA("Motor6D");
    local Volume = AudioPlayer.Volume;
    local Value = u2.Settings.FieldOfView.Value;

    local function Animate(p12, p13) -- Line: 92
        -- upvalues: TweenService (ref), u7 (copy)
        TweenService:Create(p12, u7, p13):Play();
    end;

    local u14 = {};
    local u15 = 1;
    local v16 = 0;
    local v17 = 0;
    local u18 = 0;
    local u19 = 0;
    local v20 = 0;
    local u21 = 0;
    local v22 = 0;
    local v23 = 0;

    for i = 1, 24 do
        local v24 = 64 ^ (i / 24);
        u14[i] = {
            Lower = math.floor(v24),
            Fract = v24 - math.floor(v24)
        };
    end;

    local v25 = AssetHandler.GetAbilityData(Character);
    local u26 = v3:Add(AssetHandler.CloneAsset("Particles/Pose/PoseGround", v25));
    local u27 = v3:Add(AssetHandler.CloneAsset("Particles/Pose/PoseEffects", v25));
    local u28 = {};
    local u29 = {};
    local v30 = {};

    local function MapBins() -- Line: 102
        -- upvalues: AudioAnalyzer (copy), u14 (copy)
        local v31 = AudioAnalyzer:GetSpectrum();

        if not v31[1] then
            return nil;
        end;

        local v32 = {};

        for i = 1, 24 do
            local v33 = u14[i];
            local Lower = v33.Lower;
            local v34 = math.lerp(v31[Lower], v31[Lower > 64 and 64 or v33.Lower + 1], v33.Fract);
            v32[i] = math.sqrt(v34) * 2;
        end;

        return v32;
    end;

    for _, descendant in u26:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            table.insert(u28, descendant);
            local Color = descendant.Color;

            if v11 then
                local v35 = {};

                for _, v in descendant.Color.Keypoints do
                    local v36 = ParticleHandler.TryHSVShift(v.Value, v11);
                    table.insert(v35, ColorSequenceKeypoint.new(v.Time, v36));
                end;

                Color = ColorSequence.new(v35);
            end;

            u29[descendant] = Color;
        end;
    end;

    for _, descendant in u27:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            table.insert(u28, descendant);
            local Color = descendant.Color;

            if v11 then
                local v37 = {};

                for _, v in descendant.Color.Keypoints do
                    local v38 = ParticleHandler.TryHSVShift(v.Value, v11);
                    table.insert(v37, ColorSequenceKeypoint.new(v.Time, v38));
                end;

                Color = ColorSequence.new(v37);
            end;

            u29[descendant] = Color;

            if descendant.Name == "Bass" then
                table.insert(v30, descendant);
            end;
        end;
    end;

    local function UpdateParticles() -- Line: 164
        -- upvalues: u26 (copy), u27 (copy), u15 (ref), u8 (copy), u28 (copy), u29 (copy)
        if not (u26.Parent and u27.Parent) then
            return;
        end;

        local v39 = math.min(u15 * 2.5, 1);

        local function LerpToOriginal(p40, p41) -- Line: 169
            -- upvalues: u8 (ref)
            local v42 = {};

            for _, v in p40.Keypoints do
                local v43 = u8:Lerp(v.Value, p41);
                table.insert(v42, ColorSequenceKeypoint.new(v.Time, v43));
            end;

            return ColorSequence.new(v42);
        end;

        for _, v in u28 do
            if u29[v] then
                v.Color = LerpToOriginal(u29[v], v39);
            end;

            if v.Name == "MusicTone" then
                v.Size = NumberSequence.new(u15 * 0.9 + 0.2);
            elseif v.Name == "Line" then
                v.Rate = u15 * 10 + 25;
            end;
        end;
    end;

    for _, v in { u26, u27 } do
        if v == u26 then
            ParticleHandler.ScaleParticle(v, 1.15);
        else
            ParticleHandler.ScaleParticle(v, 1.15);
            v.Size = v.Size * 1.2;
        end;

        ParticleHandler.AttachTo(v, {
            Part = Character:FindFirstChild("HumanoidRootPart"),
            Offset = CFrame.new(0, 2.95, 0)
        });
        ParticleHandler.Unusualify(v, {
            IncludeParts = true,
            Character = Character
        });
        v.Parent = workspace.Effects;
        ParticleHandler.EnableAllParticles(v, true);
    end;

    local function GetMainPart(p44) -- Line: 204
        if p44:IsA("BasePart") then
            return p44;
        end;

        if not p44:IsA("Model") then
            return nil;
        end;

        if p44.PrimaryPart then
            return p44.PrimaryPart;
        end;

        warn((`Model: {p44.Name} has no PrimaryPart set!`));

        return nil;
    end;

    local function GetAllParts(p45) -- Line: 218
        if p45:IsA("BasePart") then
            return { p45 };
        end;

        if not p45:IsA("Model") then
            return {};
        end;

        local v46 = {};

        for _, descendant in p45:GetDescendants() do
            if descendant:IsA("BasePart") then
                table.insert(v46, descendant);
            end;
        end;

        return v46;
    end;

    local function FastColorUpdate(p47, p48) -- Line: 246
        for _, v in p47 do
            v.Color = p48;
        end;
    end;

    local function FastTextureUpdate(p49, p50) -- Line: 252
        for _, v in p49 do
            v.Color3 = p50;
        end;
    end;

    local v51 = AssetHandler.GetAsset("Models/StarPose", v25);
    local u52 = {};
    local u53 = {};
    local u54 = {};

    local function GetDecalTextures(p55) -- Line: 233
        -- upvalues: GetAllParts (copy)
        local v56 = {};

        for _, v in GetAllParts(p55) do
            for _, child in v:GetChildren() do
                if child:IsA("Decal") or child:IsA("Texture") then
                    table.insert(v56, child);
                end;
            end;
        end;

        return v56;
    end;

    for i = 1, 24 do
        local v57 = 0.2617993877991494 * (i - 1);
        local v58 = v51:Clone();
        local v59;

        if v58:IsA("BasePart") then
            v59 = v58;
        elseif v58:IsA("Model") then
            if v58.PrimaryPart then
                v59 = v58.PrimaryPart;
            else
                warn((`Model: {v58.Name} has no PrimaryPart set!`));
                v59 = nil;
            end;
        else
            v59 = nil;
        end;

        local u60 = GetAllParts(v58);
        local v61 = GetDecalTextures(v58);

        if v59 then
            for _, v in u60 do
                v.Anchored = true;
                v.Material = Enum.Material.Neon;
            end;

            local new = CFrame.new;
            local Position = Attach.Position;
            local v62 = math.cos(v57) * 10;
            local v63 = math.sin(v57) * 10;
            v59.CFrame = new(Position + Vector3.new(v62, 0, v63), Attach.Position) * u10;
            v58.Name = i;
            v58.Parent = Reference;
            task.delay((i - 1) * 0.014583333333333332, function() -- Line: 285
                -- upvalues: u60 (copy), TweenService (ref)
                for _, v in u60 do
                    TweenService:Create(v, TweenInfo.new(0.3645833333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Transparency = 0
                    }):Play();
                end;
            end);
            local Attachment = v59:FindFirstChild("Attachment");
            local v64;

            if Attachment then
                v64 = Attachment:FindFirstChildOfClass("ParticleEmitter");
            else
                v64 = nil;
            end;

            u53[i] = 0;
            u52[i] = v58;
            u54[i] = {
                ParticleEmitter = v64,
                MainPart = v59,
                AllParts = u60,
                DecalTextures = v61,
                LastColor = Color3.new(0, 0, 0)
            };
        end;
    end;

    if not UserInputService.TouchEnabled and LocalPlayer == u2 then
        local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui");
        local UI = PlayerGui:WaitForChild("UI");
        UI.Enabled = false;
        local u65 = false;
        v3:Add(UI:WaitForChild("Menus").Changed:Connect(function(p66) -- Line: 316
            -- upvalues: u65 (ref), UI (copy)
            print(p66, u65);

            if p66 == "Visible" and (u65 and not UI.Menus.Visible) then
                UI.Enabled = false;
                u65 = false;
            end;
        end));
        v3:Add(UserInputService.InputBegan:Connect(function(p67, p68) -- Line: 326
            -- upvalues: u65 (ref), UI (copy)
            if p68 then
                return;
            end;

            if p67.KeyCode.Name == "M" then
                u65 = not u65;
                UI.Enabled = not UI.Enabled;
            end;
        end));
        local CinematicBlackBars = PlayerGui:FindFirstChild("CinematicBlackBars");
        CinematicBlackBars.Enabled = true;
        CinematicBlackBars.Upper.Position = UDim2.fromScale(0.5, -1.1);
        CinematicBlackBars.Lower.Position = UDim2.fromScale(0.5, 1.1);
        CinematicBlackBars.Upper.Rotation = -CinematicBlackBars.Upper.Rotation;
        CinematicBlackBars.Lower.Rotation = -CinematicBlackBars.Lower.Rotation;
        TweenService:Create(CinematicBlackBars.Upper, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
            Position = UDim2.fromScale(0.5, -0.9)
        }):Play();
        TweenService:Create(CinematicBlackBars.Lower, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0.25), {
            Position = UDim2.fromScale(0.5, 0.9)
        }):Play();
        v3:Add(function() -- Line: 348
            -- upvalues: TweenService (ref), CinematicBlackBars (copy)
            TweenService:Create(CinematicBlackBars.Upper, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, -1.1)
            }):Play();
            TweenService:Create(CinematicBlackBars.Lower, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, 1.1)
            }):Play();
            task.delay(0.5, function() -- Line: 352
                -- upvalues: CinematicBlackBars (ref)
                CinematicBlackBars.Enabled = false;
            end);
        end);
        v3:Add(function() -- Line: 357
            -- upvalues: UI (copy)
            UI.Enabled = true;
        end);
    end;

    local function Update() -- Line: 362
        -- upvalues: MapBins (copy), u15 (ref), AudioAnalyzer (copy), u18 (ref), u4 (ref), u21 (ref), u19 (ref), u53 (copy), u52 (copy), u54 (copy), u8 (copy), u9 (ref), Attach (copy), u10 (copy), TweenService (ref), u7 (copy), LocalPlayer (ref), u2 (copy), Value (copy)
        local v69 = MapBins();

        if not v69 then
            return;
        end;

        u15 = AudioAnalyzer.RmsLevel;
        u18 = u18 + u4 * 1.5;
        local v70 = os.clock() * 1.5;
        u21 = math.sin(v70) * (math.min(u15, 1) * 1.5);
        local v71 = os.clock() * 1.8;
        local v72 = math.sin(v71) * (math.min(u15, 1) * 0.6108652381980153);
        local v73 = math.max(0, u15 - 0.6) / 0.4;
        u19 = math.lerp(u19, v73, 0.05);
        local v74 = os.clock() * 0.8;
        local v75 = math.sin(v74) * (u19 * 0.05235987755982989);
        local v76 = os.clock() * 0.8 * 0.7;
        local v77 = math.cos(v76) * (u19 * 0.05235987755982989 * 0.6);
        local v78 = CFrame.Angles(v75, 0, v77);

        for i = 1, 24 do
            local v79 = v69[i];
            local v80 = u53[i];

            if v80 < v79 then
                u53[i] = v79;
            else
                local v81 = v80 - math.max((v80 - v79) * 0.030000000000000027, u4 * 0.025 * 60);
                u53[i] = math.max(v79, v81);
            end;

            local v82 = u53[i];
            local _ = u52[i];
            local v83 = u54[i];
            local MainPart = v83.MainPart;
            local v84 = 0.2617993877991494 * (i - 1) + u18;
            local v85 = 10 + v82 * 2;
            local v86 = math.min(v82, 1);
            local v87 = v86 * 4.072;
            local v88 = u8:Lerp(u9, v86);
            local v89 = math.cos(v84) * v85;
            local v90 = math.sin(v84) * v85;
            local v91 = v78 * Vector3.new(v89, u21, v90);
            TweenService:Create(MainPart, u7, {
                CFrame = CFrame.new(Attach.Position + v91, Attach.Position) * u10 * CFrame.Angles(0, v72, 0)
            }):Play();

            if v83.ParticleEmitter then
                v83.ParticleEmitter.Size = NumberSequence.new(v87);
                v83.ParticleEmitter.Color = ColorSequence.new(v88);
            end;
        end;

        if LocalPlayer == u2 then
            workspace.CurrentCamera.FieldOfView = math.lerp(workspace.CurrentCamera.FieldOfView, Value + u15 * 5, 0.75);
        end;
    end;

    local function UpdateColors() -- Line: 423
        -- upvalues: MapBins (copy), u53 (copy), u54 (copy), u8 (copy), u9 (ref)
        if not MapBins() then
            return;
        end;

        for i = 1, 24 do
            local v92 = u54[i];
            local v93 = u8:Lerp(u9, (math.min(u53[i], 1)));

            if math.abs(v93.R - v92.LastColor.R) + math.abs(v93.G - v92.LastColor.G) + math.abs(v93.B - v92.LastColor.B) > 0.05 then
                for _, v in v92.AllParts do
                    v.Color = v93;
                end;

                v92.LastColor = v93;
            end;
        end;
    end;

    local function UpdateTextures() -- Line: 444
        -- upvalues: MapBins (copy), LocalPlayer (ref), Attach (copy), u53 (copy), u54 (copy), u8 (copy), u9 (ref)
        if not MapBins() then
            return;
        end;

        if LocalPlayer:DistanceFromCharacter(Attach.Position) > 100 then
            return;
        end;

        for i = 1, 24 do
            local v94 = u54[i];
            local v95 = u8:Lerp(u9, (math.min(u53[i], 1)));

            if #v94.DecalTextures > 0 then
                for _, v in v94.DecalTextures do
                    v.Color3 = v95;
                end;
            end;
        end;
    end;

    local function UpdateVolume() -- Line: 463
        -- upvalues: Volume (copy), LocalPlayer (ref), u2 (copy), ClientEmoteVolume (ref), MasterVolume (ref), OtherEmoteVolume (ref), AudioPlayer (copy)
        local v96 = Volume;
        local v97;

        if LocalPlayer == u2 then
            v97 = v96 * (ClientEmoteVolume.Value / 100 * (MasterVolume.Value / 100));
        else
            v97 = v96 * (OtherEmoteVolume.Value / 100 * (MasterVolume.Value / 100));
        end;

        if AudioPlayer.Volume ~= v97 then
            AudioPlayer.Volume = v97;
        end;
    end;

    local function UpdateQuality() -- Line: 476
        -- upvalues: LocalPlayer (ref), Attach (copy), u4 (ref), u5 (ref), u6 (ref)
        local v98 = LocalPlayer:DistanceFromCharacter(Attach.Position);

        if v98 <= 100 then
            u4 = 0.016666666666666666;
            u5 = 0.03333333333333333;
            u6 = 0.06666666666666667;

            return;
        end;

        if v98 < 100 or v98 >= 200 then
            if v98 >= 200 then
                u4 = 0.1;
                u5 = 0.1;
                u6 = 0.2;
            end;

            return;
        end;

        u4 = 0.03333333333333333;
        u5 = 0.05;
        u6 = 0.1;
    end;

    while Reference and Reference.Parent do
        local v99 = os.clock();

        if u4 <= v99 - v23 then
            Update();
            local v100;

            if LocalPlayer == u2 then
                v100 = Volume * (ClientEmoteVolume.Value / 100 * (MasterVolume.Value / 100));
            else
                v100 = Volume * (OtherEmoteVolume.Value / 100 * (MasterVolume.Value / 100));
            end;

            if AudioPlayer.Volume ~= v100 then
                AudioPlayer.Volume = v100;
            end;

            UpdateParticles();

            if u15 >= 0.725 and v99 - v17 > 0.25 then
                for _, v in v30 do
                    v:Emit();
                end;

                v17 = v99;
            end;

            v23 = v99;
        end;

        if u5 <= v99 - v16 then
            UpdateColors();
            v16 = v99;
        end;

        if u6 <= v99 - v22 then
            UpdateTextures();
            v22 = v99;
        end;

        if v99 - v20 >= 0.35 and u2 ~= LocalPlayer then
            local v101 = LocalPlayer:DistanceFromCharacter(Attach.Position);

            if v101 <= 100 then
                u4 = 0.016666666666666666;
                u5 = 0.03333333333333333;
                u6 = 0.06666666666666667;
            elseif v101 >= 100 and v101 < 200 then
                u4 = 0.03333333333333333;
                u5 = 0.05;
                u6 = 0.1;
            elseif v101 >= 200 then
                u4 = 0.1;
                u5 = 0.1;
                u6 = 0.2;
            end;
        else
            v99 = v20;
        end;

        task.wait();
        v20 = v99;
    end;

    if LocalPlayer == u2 then
        workspace.CurrentCamera.FieldOfView = u2.Settings.FieldOfView.Value;
    end;

    for _, v in u52 do
        v:Destroy();
    end;

    table.clear(u52);
    table.clear(u54);
    table.clear(u28);
    table.clear(v30);
    table.clear(u29);
    table.clear(u53);
    v3:Destroy();
end;