  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Vfx = ReplicatedStorage:FindFirstChild("Assets"):FindFirstChild("Vfx");
local Debris = workspace:FindFirstChild("Debris");

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
            v.Enabled = p2 or false;
        end;
    end;
end;

function EmitAll(p3)
    local function emit(u4) -- Line: 28
        if u4:IsA("ParticleEmitter") or (u4:IsA("Beam") or u4:IsA("Trail")) then
            local Attribute = u4:GetAttribute("EmitDelay");
            local Attribute2 = u4:GetAttribute("EmitCount");

            if Attribute2 and Attribute2 ~= 0 then
                if Attribute and Attribute ~= 0 then
                    task.delay(Attribute, function() -- Line: 35
                        -- upvalues: u4 (copy), Attribute2 (copy)
                        u4:Emit(Attribute2);
                    end);

                    return;
                end;

                u4:Emit(Attribute2);
            end;
        end;
    end;

    if typeof(p3) == "table" then
        for _, v in p3 do
            if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
                emit(v);
            else
                for _, descendant in v:GetDescendants() do
                    emit(descendant);
                end;
            end;
        end;

        return;
    end;

    if p3:IsA("ParticleEmitter") or (p3:IsA("Beam") or p3:IsA("Trail")) then
        emit(p3);

        return;
    end;

    for _, descendant in p3:GetDescendants() do
        emit(descendant);
    end;
end;

local function Destroy_Effect(u5: any, p6: number) -- Line: 66
    task.delay(p6, function() -- Line: 68
        -- upvalues: u5 (copy)
        if typeof(u5) == "table" then
            for _, v in u5 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u5 then
            u5:Destroy();
        end;
    end);
end;

local function tweenbeam(u7, u8, u9, u10, u11, p12) -- Line: 84
    -- upvalues: RunService (copy), TweenService (copy)
    local u13 = nil;
    local os_clock_ret = os.clock();
    local u14 = nil;
    u14 = RunService.Heartbeat:Connect(function(p15) -- Line: 88
        -- upvalues: u13 (ref), os_clock_ret (copy), u11 (copy), TweenService (ref), u9 (ref), u8 (copy), u10 (copy), u7 (copy), u14 (ref)
        u13 = (os.clock() - os_clock_ret) / u11;
        u13 = TweenService:GetValue(u13, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
        u9 = u8 + (u10 - u8) * u13;
        u7.Transparency = NumberSequence.new(u9, u9);

        if u11 <= os.clock() - os_clock_ret then
            u14:Disconnect();
        end;
    end);
    table.insert(p12, u14);
end;

local function tweenColor(u16, p17) -- Line: 102
    -- upvalues: RunService (copy), TweenService (copy)
    local u18 = nil;
    local os_clock_ret = os.clock();
    local Start = p17.Start;
    local Goal = p17.Goal;
    local Duration = p17.Duration;
    local Conns = p17.Conns;
    local u19 = 0;
    local u20 = 0;
    local u21 = 0;
    local u22 = Start[1];
    local u23 = Start[2];
    local u24 = Start[3];
    local u25 = Goal[1];
    local u26 = Goal[2];
    local u27 = Goal[3];
    local u28 = nil;
    u28 = RunService.Heartbeat:Connect(function(p29) -- Line: 114
        -- upvalues: u18 (ref), os_clock_ret (copy), Duration (copy), TweenService (ref), u19 (ref), u22 (copy), u25 (copy), u20 (ref), u23 (copy), u26 (copy), u21 (ref), u24 (copy), u27 (copy), u16 (copy), u28 (ref)
        u18 = (os.clock() - os_clock_ret) / Duration;
        u18 = TweenService:GetValue(u18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
        u19 = u22 + (u25 - u22) * u18;
        u20 = u23 + (u26 - u23) * u18;
        u21 = u24 + (u27 - u24) * u18;

        if u16:IsA("ColorCorrectionEffect") then
            u16.TintColor = Color3.fromRGB(u19, u20, u21);
        elseif u16.Color then
            if typeof(u16.Color) == "ColorSequence" then
                u16.Color = ColorSequence.new(Color3.fromRGB(u19, u20, u21), Color3.fromRGB(u19, u20, u21));
            else
                u16.Color = Color3.fromRGB(u19, u20, u21);
            end;
        end;

        if Duration <= os.clock() - os_clock_ret then
            u28:Disconnect();
        end;
    end);
    table.insert(Conns, u28);
end;

local function Weld(p30, p31) -- Line: 142
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p30;
    WeldConstraint.Part1 = p31;
    WeldConstraint.Parent = p30;

    return WeldConstraint;
end;

return function(p32) -- Line: 149
    -- upvalues: SpectatorController (copy), Players (copy), Debris (copy), Vfx (copy), TweenService (copy), RunService (copy), SoundManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local LocalPlayer = Players.LocalPlayer;
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("Values");
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p32.Char);

    if Character and (Character.Goalie.Value and (Character.IsInPenalty.Value and (PlayerFromCharacter and LocalPlayer.Team ~= PlayerFromCharacter.Team))) then
        return;
    end;

    local Char = p32.Char;
    local BALL = Char:FindFirstChild("PlrFootball"):FindFirstChild("BallAnims"):FindFirstChild("BALL");
    local u33 = script.Name .. " VFX FOLDER " .. Char.Name;

    if p32.Task ~= "Cutscene" then
        local u34 = p32.Task == "Cleanup" and Debris:FindFirstChild(u33);

        if u34 then
            EnableVFX(u34, false);
            u34.Name = "_";
            u34:SetAttribute("Active", false);
            task.delay(2, function() -- Line: 68
                -- upvalues: u34 (copy)
                if typeof(u34) == "table" then
                    for _, v in u34 do
                        if v then
                            v:Destroy();
                        end;
                    end;

                    return;
                end;

                if u34 then
                    u34:Destroy();
                end;
            end);
        end;

        return;
    end;

    if not Char then
        return;
    end;

    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u35 = {};
    local u36 = {};
    local u37 = {};
    Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
    local Folder = Instance.new("Folder");
    Folder.Name = u33;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(6.333333333333333, function() -- Line: 68
        -- upvalues: Folder (copy)
        if typeof(Folder) == "table" then
            for _, v in Folder do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if Folder then
            Folder:Destroy();
        end;
    end);
    local u38 = Vfx.DemonKing.BallHightlight:Clone();
    u38.Parent = BALL;
    task.delay(6.333333333333333, function() -- Line: 68
        -- upvalues: u38 (copy)
        if typeof(u38) == "table" then
            for _, v in u38 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u38 then
            u38:Destroy();
        end;
    end);
    u38.FillTransparency = 1;
    task.delay(1.05, function() -- Line: 191
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), TweenService (ref), u38 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u38, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), {
            FillTransparency = 0.5
        }):Play();
        task.wait(0.9666666666666667);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u38, TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear), {
            FillTransparency = 1
        }):Play();
        task.wait(0.8500000000000001);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u38, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), {
            FillTransparency = 0.5
        }):Play();
        task.wait(0.13333333333333333);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u38, TweenInfo.new(0.85, Enum.EasingStyle.Linear), {
            FillTransparency = 1
        }):Play();
    end);
    local Vignette = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");

    if Vignette then
        for _, v in {
            Vignette.Vignette,
            Vignette.Vignette.LL,
            Vignette.Vignette.UR,
            Vignette.Vignette.LL.LR
        } do
            v.ImageColor3 = Color3.fromRGB(94, 130, 255);
            v.ImageTransparency = 0.5;
            local v39 = TweenService:Create(v, TweenInfo.new(2.0833333333333335, Enum.EasingStyle.Linear), {
                ImageTransparency = 0,
                ImageColor3 = Color3.fromRGB(42, 76, 255)
            });
            v39:Play();
            table.insert(u37, v39);
            task.delay(2.0833333333333335, function() -- Line: 222
                -- upvalues: Folder (copy), Debris (ref), u33 (copy), TweenService (ref), v (copy), u37 (ref)
                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                local v40 = TweenService:Create(v, TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(255, 255, 255)
                });
                v40:Play();
                table.insert(u37, v40);
                task.wait(0.016666666666666666);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                local v41 = TweenService:Create(v, TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(0, 0, 0)
                });
                v41:Play();
                table.insert(u37, v41);
            end);
        end;
    end;

    local u42 = Vfx.DemonKing["Screen Cover"]:Clone();
    u42.Parent = Vignette;
    u42.BackgroundTransparency = 1;
    task.delay(6.333333333333333, function() -- Line: 68
        -- upvalues: u42 (copy)
        if typeof(u42) == "table" then
            for _, v in u42 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u42 then
            u42:Destroy();
        end;
    end);
    task.delay(5.833333333333333, function() -- Line: 244
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), TweenService (ref), u42 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u42, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            BackgroundTransparency = 0
        }):Play();
    end);
    local u43 = Vfx.DemonKing.DarkTones:Clone();
    u43.Parent = game.Lighting;
    u43.Enabled = false;
    task.delay(6.333333333333333, function() -- Line: 68
        -- upvalues: u43 (copy)
        if typeof(u43) == "table" then
            for _, v in u43 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u43 then
            u43:Destroy();
        end;
    end);
    task.delay(2.0833333333333335, function() -- Line: 254
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u43 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u43.Enabled = true;
    end);
    local u44 = Vfx.DemonKing.DarkTones2:Clone();
    u44.Parent = game.Lighting;
    u44.Enabled = false;
    task.delay(6.333333333333333, function() -- Line: 68
        -- upvalues: u44 (copy)
        if typeof(u44) == "table" then
            for _, v in u44 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u44 then
            u44:Destroy();
        end;
    end);
    task.delay(3.8666666666666667, function() -- Line: 265
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u44 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u44.Enabled = true;
        task.wait(0.7);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u44.Enabled = false;
    end);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local u45 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.0001, Enum.EasingStyle.Linear), {
        FieldOfView = 30
    });
    u45:Play();
    local camera = workspace:FindFirstChild("NagiCam"):FindFirstChild("camera");
    local u46 = Vfx.DemonKing.camera:Clone();
    u46.CFrame = camera.CFrame;
    u46.Parent = Folder;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = u46;
    WeldConstraint.Part1 = camera;
    WeldConstraint.Parent = u46;
    task.delay(6.333333333333333, function() -- Line: 68
        -- upvalues: u46 (copy)
        if typeof(u46) == "table" then
            for _, v in u46 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u46 then
            u46:Destroy();
        end;
    end);

    for _, v in { u46.A0.g, u46.A0.h, u46.A0.i } do
        v.Enabled = true;
        v.Transparency = NumberSequence.new(1, 1);
        local u47 = 1;
        local u48 = nil;
        local os_clock_ret = os.clock();
        local u49 = nil;
        local u50 = 0.08333333333333333;
        local u51 = 1;
        local u52 = 0.8;
        u49 = RunService.Heartbeat:Connect(function(p53) -- Line: 88
            -- upvalues: u48 (ref), os_clock_ret (copy), u50 (copy), TweenService (ref), u47 (ref), u51 (copy), u52 (copy), v (copy), u49 (ref)
            u48 = (os.clock() - os_clock_ret) / u50;
            u48 = TweenService:GetValue(u48, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
            u47 = u51 + (u52 - u51) * u48;
            v.Transparency = NumberSequence.new(u47, u47);

            if u50 <= os.clock() - os_clock_ret then
                u49:Disconnect();
            end;
        end);
        table.insert(u35, u49);
        task.delay(0.08333333333333333, function() -- Line: 295
            -- upvalues: Folder (copy), Debris (ref), u33 (copy), v (copy), u35 (ref), RunService (ref), TweenService (ref)
            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            local u54 = v;
            local u55 = 0.8;
            local u56 = nil;
            local os_clock_ret2 = os.clock();
            local u57 = nil;
            local u58 = 0.36666666666666664;
            local u59 = 0.8;
            local u60 = 1;
            u57 = RunService.Heartbeat:Connect(function(p61) -- Line: 88
                -- upvalues: u56 (ref), os_clock_ret2 (copy), u58 (copy), TweenService (ref), u55 (ref), u59 (copy), u60 (copy), u54 (copy), u57 (ref)
                u56 = (os.clock() - os_clock_ret2) / u58;
                u56 = TweenService:GetValue(u56, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                u55 = u59 + (u60 - u59) * u56;
                u54.Transparency = NumberSequence.new(u55, u55);

                if u58 <= os.clock() - os_clock_ret2 then
                    u57:Disconnect();
                end;
            end);
            table.insert(u35, u57);
        end);
    end;

    local u62 = Vfx.DemonKing.DemonKingVFX:Clone();
    u62:PivotTo(HumanoidRootPart.CFrame);
    u62.Parent = Folder;
    task.delay(8.333333333333332, function() -- Line: 68
        -- upvalues: u62 (copy)
        if typeof(u62) == "table" then
            for _, v in u62 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u62 then
            u62:Destroy();
        end;
    end);
    u62.BlackRoom02.Transparency = 1;
    u62.FloorTexture.SurfaceGui.FloorPuzzle.ImageTransparency = 1;
    task.delay(4.566666666666666, function() -- Line: 311
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), TweenService (ref), u62 (copy), u37 (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        local v63 = TweenService:Create(u62.BlackRoom02, TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), {
            Transparency = 0.15
        });
        v63:Play();
        table.insert(u37, v63);
        local v64 = TweenService:Create(u62.FloorTexture.SurfaceGui.FloorPuzzle, TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.85
        });
        v64:Play();
        table.insert(u37, v64);
    end);
    task.delay(3.966666666666667, function() -- Line: 322
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u62 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u62.Shine, true);
        EnableVFX(u62.SPEEDLINES, true);
    end);
    task.delay(6.25, function() -- Line: 328
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u62 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u62.SPEEDLINES, false);
    end);

    for _, child in Vfx.DemonKing.UserVFX:GetChildren() do
        if Char[child.Name] then
            local u65 = child:Clone();
            u65.CFrame = Char[child.Name].CFrame;
            u65.Parent = Folder;
            local v66 = Char[child.Name];
            local WeldConstraint2 = Instance.new("WeldConstraint");
            WeldConstraint2.Part0 = u65;
            WeldConstraint2.Part1 = v66;
            WeldConstraint2.Parent = u65;
            task.delay(6.333333333333333, function() -- Line: 68
                -- upvalues: u65 (copy)
                if typeof(u65) == "table" then
                    for _, v in u65 do
                        if v then
                            v:Destroy();
                        end;
                    end;

                    return;
                end;

                if u65 then
                    u65:Destroy();
                end;
            end);
            u36[u65.Name] = u65;
        end;
    end;

    for _, v in u36 do
        for _, descendant in v:GetDescendants() do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "PuzzleAura" then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
                descendant.Enabled = true;
            end;
        end;
    end;

    EnableVFX(u62.WindBeam, true);
    task.delay(0.7166666666666667, function() -- Line: 356
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u62 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EmitAll(u62.IsagiFeet1);
    end);
    task.delay(1.05, function() -- Line: 361
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u62 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EmitAll(u62.IsagiFeet2);
    end);
    task.delay(1.65, function() -- Line: 366
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u36 (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        for _, v in u36 do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "PuzzleAura" then
                    descendant.Enabled = false;
                end;
            end;
        end;
    end);
    local u67 = nil;
    task.delay(2.05, function() -- Line: 378
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u67 (ref), u62 (copy), u36 (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        (function(p68, p69, u70, u71, p72, u73) -- Line: 380, Name: ColorCorrectionEffect
            -- upvalues: u67 (ref)
            u67 = Instance.new("ColorCorrectionEffect");
            u67.Saturation = p68;
            u67.Contrast = p69;
            u67.Parent = game:GetService("Lighting");
            task.delay(p72, function() -- Line: 386
                -- upvalues: u67 (ref), u70 (copy), u71 (copy), u73 (copy)
                u67.Saturation = u70;
                u67.Contrast = u71;
                task.wait(u73);
                u67:Destroy();
            end);
        end)(-1, -3, -1, 3, 0.04, 0.05);
        task.wait(0.016666666666666666);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EmitAll(u62.IsagiStomp);
        EnableVFX(u62.IsagiRushBeam, true);

        for _, v in u36 do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "DemonAura" then
                    descendant.Enabled = true;
                end;
            end;
        end;
    end);
    task.delay(2.3666666666666667, function() -- Line: 411
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u62 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EmitAll(u62.SmokerNina2);
        EnableVFX(u62.SmokerNina2, true);
    end);
    local u74 = nil;
    task.delay(2.933333333333333, function() -- Line: 418
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u74 (ref), u62 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        (function(p75: userdata, p76: userdata, u77: userdata, u78: userdata, p79: userdata, u80: userdata) -- Line: 420, Name: ColorCorrectionEffect
            -- upvalues: u74 (ref)
            u74 = Instance.new("ColorCorrectionEffect");
            u74.Saturation = p75;
            u74.Contrast = p76;
            u74.Parent = game:GetService("Lighting");
            task.delay(p79, function() -- Line: 426
                -- upvalues: u74 (ref), u77 (copy), u78 (copy), u80 (copy)
                u74.Saturation = u77;
                u74.Contrast = u78;
                task.wait(u80);
                u74:Destroy();
            end);
        end)(-1, -3, -1, 3, 0.04, 0.05);
        task.wait(0.016666666666666666);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EmitAll(u62.IsagiKick);
    end);
    task.delay(3.8333333333333335, function() -- Line: 442
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u62 (copy), u46 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u62.SmokerNina2, false);
        EnableVFX(u62.SnowyIn, true);
        EnableVFX(u46, true);
    end);
    task.delay(4.633333333333334, function() -- Line: 449
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u62 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EmitAll(u62.IsagiCelebrate);
    end);
    local u81 = SoundManager.SpawnSound("DemonKing", 0.75, workspace, 200, false);
    u81:Play();

    local function v85() -- Line: 457
        -- upvalues: u81 (copy), u44 (copy), u42 (copy), u43 (copy), u38 (copy), u35 (ref), u45 (copy), u36 (ref), Folder (copy), u62 (copy), u67 (ref), u74 (ref), u46 (copy), workspace_CurrentCamera (copy), FieldOfView (copy), Vignette (copy), u37 (ref)
        if u81 then
            u81:Destroy();
        end;

        if u44 then
            u44:Destroy();
        end;

        if u42 then
            u42:Destroy();
        end;

        if u43 then
            u43:Destroy();
        end;

        if u38 then
            u38:Destroy();
        end;

        for _, v in u35 do
            v:Disconnect();
        end;

        if u45 then
            u45:Pause();
        end;

        for _, v in u36 do
            EnableVFX(v, false);
            local u82 = u36;
            task.delay(3, function() -- Line: 68
                -- upvalues: u82 (copy)
                if typeof(u82) == "table" then
                    for _, v2 in u82 do
                        if v2 then
                            v2:Destroy();
                        end;
                    end;

                    return;
                end;

                if u82 then
                    u82:Destroy();
                end;
            end);
        end;

        if Folder then
            Folder.Name = "_";
            local u83 = Folder;
            task.delay(4, function() -- Line: 68
                -- upvalues: u83 (copy)
                if typeof(u83) == "table" then
                    for _, v in u83 do
                        if v then
                            v:Destroy();
                        end;
                    end;

                    return;
                end;

                if u83 then
                    u83:Destroy();
                end;
            end);
            EnableVFX(Folder, false);

            if u62 and u62:FindFirstChild("BlackRoom02") then
                u62.BlackRoom02.Transparency = 1;
            end;
        end;

        if u67 then
            u67:Destroy();
        end;

        if u74 then
            u74:Destroy();
        end;

        if u46 then
            EnableVFX(u46, false);
        end;

        task.spawn(function() -- Line: 511
            -- upvalues: workspace_CurrentCamera (ref), FieldOfView (ref), Vignette (ref)
            for i = 1, 4 do
                workspace_CurrentCamera.FieldOfView = FieldOfView;
                local v84;

                if Vignette then
                    v84 = i;

                    for _, v in {
                        Vignette.Vignette,
                        Vignette.Vignette.LL,
                        Vignette.Vignette.UR,
                        Vignette.Vignette.LL.LR
                    } do
                        v.ImageTransparency = 1;
                    end;
                else
                    v84 = i;
                end;

                task.wait(0.05);
            end;
        end);
        table.clear(u36);
        table.clear(u37);
        table.clear(u35);
        u35 = nil;
        u37 = nil;
        u36 = nil;
    end;

    table.insert(u35, Folder.Destroying:Connect(v85));
    table.insert(u35, Folder.AttributeChanged:Connect(v85));
end;