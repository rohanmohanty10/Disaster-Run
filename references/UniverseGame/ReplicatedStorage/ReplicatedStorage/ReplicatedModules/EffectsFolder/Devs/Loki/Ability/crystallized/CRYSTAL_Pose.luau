  

 

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
    local u8 = TweenInfo.new(u7 * 1.5, Enum.EasingStyle.Sine);
    local u9 = Color3.fromRGB(148, 96, 227);
    local u10 = Color3.fromRGB(255, 159, 75);
    local u11 = CFrame.Angles(1.5707963267948966, 0, 0);
    local v12 = ParticleHandler.GetUnusualHSVData({
        Character = Character
    });

    if v12 then
        u10 = ParticleHandler.TryHSVShift(u10, v12);
    end;

    local Attach = Reference:WaitForChild("Attach");
    local AudioAnalyzer = Attach:WaitForChild("AudioAnalyzer");
    Attach:WaitForChild("AudioEmitter");
    local AudioPlayer = Attach:WaitForChild("AudioPlayer");
    Attach:FindFirstChildWhichIsA("Motor6D");
    local Volume = AudioPlayer.Volume;
    local Value = u5.Settings.FieldOfView.Value;

    local function GetRelative(p13, p14, p15) -- Line: 96
        return p14 == 0 and 1 or math.round(p13 * p15 / p14);
    end;

    local function Animate(p16, p17) -- Line: 101
        -- upvalues: TweenService (ref), u8 (copy)
        TweenService:Create(p16, u8, p17):Play();
    end;

    local u18 = {};
    local u19 = 1;
    local v20 = 0;
    local v21 = 0;
    local u22 = 0;
    local v23 = 0;

    for i = 1, 45 do
        local v24 = 64 ^ (i / 45);
        u18[i] = {
            Lower = math.floor(v24),
            Fract = v24 - math.floor(v24)
        };
    end;

    local v25 = AssetHandler.GetAbilityData(Character);
    local v26 = AssetHandler.GetAsset("Models/Octahedron", v25);
    local u27 = v6:Add(AssetHandler.CloneAsset("Particles/Pose/PoseGround", v25));
    local u28 = v6:Add(AssetHandler.CloneAsset("Particles/Pose/PoseEffects", v25));
    local v29 = {};
    local u30 = {};
    local u31 = {};
    local u32 = {};

    local function MapBins() -- Line: 112
        -- upvalues: AudioAnalyzer (copy), u18 (copy)
        local v33 = AudioAnalyzer:GetSpectrum();

        if not v33[1] then
            return nil;
        end;

        local v34 = {};

        for i = 1, 45 do
            local v35 = u18[i];
            local Lower = v35.Lower;
            local v36 = math.lerp(v33[Lower], v33[Lower > 64 and 64 or v35.Lower + 1], v35.Fract);
            v34[i] = math.sqrt(v36) * 2;
        end;

        return v34;
    end;

    local u37 = false;

    for _, descendant in u28:GetDescendants() do
        if descendant.Name == "Line" then
            table.insert(u31, descendant);
        elseif descendant.Name == "MusicTone" then
            table.insert(u30, descendant);
        elseif descendant.Name == "Bass" then
            table.insert(v29, descendant);
        end;
    end;

    local function UpdateParticles() -- Line: 150
        -- upvalues: u27 (copy), u28 (copy), u30 (copy), u19 (ref), u31 (copy)
        if not (u27.Parent and u28.Parent) then
            return;
        end;

        for _, v in u30 do
            v.Size = NumberSequence.new(u19 * 0.9 + 0.2);
        end;

        for _, v in u31 do
            v.Rate = u19 * 10 + 25;
        end;
    end;

    for _, v in { u27, u28 } do
        if v == u27 then
            ParticleHandler.ScaleParticle(v, 0.785);
        else
            ParticleHandler.ScaleParticle(v, 0.85);
            v.Size = v.Size * 0.9;
        end;

        ParticleHandler.AttachTo(v, {
            Part = Character:FindFirstChild("HumanoidRootPart"),
            Offset = CFrame.new(0, 2.95, 0)
        });
        ParticleHandler.Unusualify(v, {
            Character = Character
        });
        v.Parent = workspace.Effects;
        ParticleHandler.EnableAllParticles(v, true);
    end;

    for i = 1, 45 do
        local v38 = 0.13962634015954636 * (i - 1);
        local new = CFrame.new;
        local Position = Attach.Position;
        local v39 = math.cos(v38) * 8.35;
        local v40 = math.sin(v38) * 8.35;
        local v41 = new(Position + Vector3.new(v39, 0, v40), Attach.Position) * u11;
        local u42 = Instance.fromExisting(v26);
        u42.Anchored = true;
        u42.Size = Vector3.new(0, 0, 0.5);
        u42.Color = u9;
        u42.Transparency = 1;
        u42.CFrame = v41;
        u42.Name = tostring(i);
        u42.Material = Enum.Material.Neon;
        u42.Parent = Reference;
        task.delay((i - 1) * 0.03333333333333333, function() -- Line: 193
            -- upvalues: TweenService (ref), u42 (copy)
            TweenService:Create(u42, TweenInfo.new(0.3833333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                Size = Vector3.new(1, 0.1, 0.5),
                Transparency = 0
            }):Play();
        end);
        u32[i] = u42;
    end;

    if not UserInputService.TouchEnabled and LocalPlayer == u5 then
        local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui");
        local UI = PlayerGui:WaitForChild("UI");
        UI.Enabled = false;
        local u43 = false;
        v6:Add(UI:WaitForChild("Menus").Changed:Connect(function(p44) -- Line: 207
            -- upvalues: u43 (ref), UI (copy)
            print(p44, u43);

            if p44 == "Visible" and (u43 and not UI.Menus.Visible) then
                UI.Enabled = false;
                u43 = false;
            end;
        end));
        v6:Add(UserInputService.InputBegan:Connect(function(p45, p46) -- Line: 217
            -- upvalues: u43 (ref), UI (copy)
            if p46 then
                return;
            end;

            if p45.KeyCode.Name == "M" then
                u43 = not u43;
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
        v6:Add(function() -- Line: 236
            -- upvalues: TweenService (ref), CinematicBlackBars (copy)
            TweenService:Create(CinematicBlackBars.Upper, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, -1.1)
            }):Play();
            TweenService:Create(CinematicBlackBars.Lower, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, 1.1)
            }):Play();
            task.delay(0.5, function() -- Line: 240
                -- upvalues: CinematicBlackBars (ref)
                CinematicBlackBars.Enabled = false;
            end);
        end);
        v6:Add(function() -- Line: 245
            -- upvalues: UI (copy)
            UI.Enabled = true;
        end);
    end;

    task.delay(1.85, function() -- Line: 250
        -- upvalues: u37 (ref)
        u37 = true;
    end);
    local CurrentCamera = workspace.CurrentCamera;

    local function Update() -- Line: 256
        -- upvalues: MapBins (copy), u19 (ref), AudioAnalyzer (copy), u32 (copy), u22 (ref), u37 (ref), u9 (copy), u10 (ref), Attach (copy), u11 (copy), TweenService (ref), u8 (copy), LocalPlayer (ref), u5 (copy), CurrentCamera (copy), Value (copy)
        local v47 = MapBins();

        if not v47 then
            return;
        end;

        u19 = AudioAnalyzer.RmsLevel;

        for i = 1, 45 do
            local v48 = v47[i];
            local v49 = u32[i];
            local Size = v49.Size;
            local v50 = 0.13962634015954636 * (i - 1) - u22;
            local v51 = {};
            local v52;

            if u37 then
                local X = Size.X;
                local v53 = math.clamp(10 * v48, 0, 10);
                v52 = vector.create(X, v53, Size.Z);
            else
                v52 = nil;
            end;

            v51.Size = v52;
            v51.Color = u9:Lerp(u10, (math.min(v48, 1)));
            local new = CFrame.new;
            local Position = Attach.Position;
            local v54 = math.cos(v50) * (u19 * 3 + 8.35);
            local v55 = math.sin(v50) * (u19 * 3 + 8.35);
            v51.CFrame = new(Position + vector.create(v54, 0, v55), Attach.Position) * u11;
            TweenService:Create(v49, u8, v51):Play();
        end;

        if LocalPlayer == u5 then
            CurrentCamera.FieldOfView = math.lerp(CurrentCamera.FieldOfView, Value + u19 * 15, 0.75);
        end;
    end;

    local function UpdateVolume() -- Line: 285
        -- upvalues: Volume (copy), LocalPlayer (ref), u5 (copy), ClientEmoteVolume (ref), MasterVolume (ref), OtherEmoteVolume (ref), AudioPlayer (copy)
        local v56 = Volume;
        local v57;

        if LocalPlayer == u5 then
            v57 = v56 * (ClientEmoteVolume.Value / 100 * (MasterVolume.Value / 100));
        else
            v57 = v56 * (OtherEmoteVolume.Value / 100 * (MasterVolume.Value / 100));
        end;

        if AudioPlayer.Volume ~= v57 then
            AudioPlayer.Volume = v57;
        end;
    end;

    local function UpdateQuality() -- Line: 298
        -- upvalues: LocalPlayer (ref), Attach (copy), u7 (ref)
        local v58 = LocalPlayer:DistanceFromCharacter(Attach.Position);

        if v58 <= 100 then
            u7 = 0.016666666666666666;

            return;
        end;

        if v58 >= 100 and v58 < 200 then
            u7 = 0.03333333333333333;

            return;
        end;

        if v58 >= 200 then
            u7 = 0.1;
        end;
    end;

    while Reference and Reference.Parent do
        local v59 = os.clock();

        if u7 <= v59 - v20 then
            Update();
            local v60;

            if LocalPlayer == u5 then
                v60 = Volume * (ClientEmoteVolume.Value / 100 * (MasterVolume.Value / 100));
            else
                v60 = Volume * (OtherEmoteVolume.Value / 100 * (MasterVolume.Value / 100));
            end;

            if AudioPlayer.Volume ~= v60 then
                AudioPlayer.Volume = v60;
            end;

            UpdateParticles();

            if u19 >= 0.725 and v59 - v23 > 0.25 then
                for _, v in v29 do
                    v:Emit();
                end;

                v23 = v59;
            end;

            v20 = v59;
        end;

        if v59 - v21 >= 0.35 and u5 ~= LocalPlayer then
            local v61 = LocalPlayer:DistanceFromCharacter(Attach.Position);

            if v61 <= 100 then
                u7 = 0.016666666666666666;
            elseif v61 >= 100 and v61 < 200 then
                u7 = 0.03333333333333333;
            else
                u7 = v61 >= 200 and 0.1 or u7;
            end;
        else
            v59 = v21;
        end;

        task.wait();
        u22 = u22 + (task.wait() / 5 + u19 / 22.5);
        v21 = v59;
    end;

    if LocalPlayer == u5 then
        workspace.CurrentCamera.FieldOfView = u5.Settings.FieldOfView.Value;
    end;

    for _, v in u32 do
        v:Destroy();
    end;

    table.clear(u32);
    table.clear(u31);
    table.clear(u30);
    table.clear(v29);
    v6:Destroy();
end;