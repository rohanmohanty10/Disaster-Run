  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
ReplicatedStorage:FindFirstChild("Assets"):FindFirstChild("Vfx");
local Debris2 = workspace:FindFirstChild("Debris");

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

return function(u32) -- Line: 149
    -- upvalues: SpectatorController (copy), Players (copy), Debris2 (copy), TweenService (copy), ReplicatedStorage (copy), RunService (copy), Debris (copy), VfxManager (copy), SoundManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = u32.Char;
    Char:FindFirstChild("PlrFootball"):FindFirstChild("BallAnims"):FindFirstChild("BALL");
    local u33 = script.Name .. " VFX FOLDER " .. Char.Name;

    if u32.Task ~= "Cutscene" then
        local v34 = u32.Task == "Cleanup" and Debris2:FindFirstChild(u33);

        if v34 then
            v34:SetAttribute("Active", nil);
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
    local Vignette = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
    local BALL = Char:FindFirstChild("PlrFootball"):FindFirstChild("BallAnims"):FindFirstChild("BALL");
    local Folder = Instance.new("Folder");
    Folder.Name = u33;
    Folder.Parent = Debris2;
    Folder:SetAttribute("Active", true);
    task.delay(8.5, function() -- Line: 175
        -- upvalues: Folder (copy)
        if Folder and Folder:GetAttribute("Active") then
            Folder:SetAttribute("Active", nil);
        end;
    end);
    local u37 = script["Screen Cover"]:Clone();
    u37.Parent = Vignette;
    u37.BackgroundTransparency = 1;
    task.delay(8.5, function() -- Line: 68
        -- upvalues: u37 (copy)
        if typeof(u37) == "table" then
            for _, v in u37 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u37 then
            u37:Destroy();
        end;
    end);
    task.delay(7.466666666666667, function() -- Line: 188
        -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), TweenService (ref), u37 (copy)
        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u37, TweenInfo.new(1.0333333333333334, Enum.EasingStyle.Linear), {
            BackgroundTransparency = 0
        }):Play();
    end);

    if Vignette then
        for _, v in {
            Vignette.Vignette,
            Vignette.Vignette.LL,
            Vignette.Vignette.UR,
            Vignette.Vignette.LL.LR
        } do
            v.ImageColor3 = Color3.fromRGB(0, 0, 0);
            v.ImageTransparency = 0.8;
            task.delay(0.9166666666666666, function() -- Line: 199
                -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), TweenService (ref), v (copy), u36 (ref)
                if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
                    return;
                end;

                local v38 = TweenService:Create(v, TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0
                });
                v38:Play();
                table.insert(u36, v38);
                task.wait(0.11666666666666667);

                if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
                    return;
                end;

                local v39 = TweenService:Create(v, TweenInfo.new(0.7, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0.8
                });
                v39:Play();
                table.insert(u36, v39);
                task.wait(0.9833333333333333);

                if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
                    return;
                end;

                local v40 = TweenService:Create(v, TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0,
                    ImageColor3 = Color3.fromRGB(67, 100, 255)
                });
                v40:Play();
                table.insert(u36, v40);
                task.wait(0.11666666666666667);

                if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
                    return;
                end;

                local v41 = TweenService:Create(v, TweenInfo.new(1.55, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(190, 106, 255)
                });
                v41:Play();
                table.insert(u36, v41);
                task.wait(1.55);

                if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
                    return;
                end;

                local v42 = TweenService:Create(v, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0.8,
                    ImageColor3 = Color3.fromRGB(0, 0, 0)
                });
                v42:Play();
                table.insert(u36, v42);
                task.wait(0.21666666666666667);

                if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
                    return;
                end;

                local v43 = TweenService:Create(v, TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0,
                    ImageColor3 = Color3.fromRGB(255, 0, 0)
                });
                v43:Play();
                table.insert(u36, v43);
                task.wait(0.9);

                if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
                    return;
                end;

                local v44 = TweenService:Create(v, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0.8,
                    ImageColor3 = Color3.fromRGB(0, 0, 0)
                });
                v44:Play();
                table.insert(u36, v44);
                task.wait(0.15);

                if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
                    return;
                end;

                local v45 = TweenService:Create(v, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(67, 100, 255)
                });
                v45:Play();
                table.insert(u36, v45);
                task.wait(1.5);

                if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
                    return;
                end;

                local v46 = TweenService:Create(v, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0.8,
                    ImageColor3 = Color3.fromRGB(0, 0, 0)
                });
                v46:Play();
                table.insert(u36, v46);
            end);
        end;
    end;

    local u47 = nil;
    task.delay(2.4, function() -- Line: 267
        -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), u47 (ref), ReplicatedStorage (ref), Players (ref), TweenService (ref)
        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        u47 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u47.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u47.Position = UDim2.new(0.5, 0, 0.8, 0);
        u47.Size = UDim2.new(1, 0, 0.1, 0);
        u47.BackgroundTransparency = 1;
        u47.AnchorPoint = Vector2.new(0.5, 0.5);
        u47.Font = Enum.Font.ArialBold;
        u47.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u47;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        u47.MaxVisibleGraphemes = 0;
        u47.TextTransparency = 0;
        u47.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        u47.Text = "Eat this...";
        TweenService:Create(u47, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #u47.Text
        }):Play();
        task.wait(0.8333333333333333);

        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u47, TweenInfo.new(0.55, Enum.EasingStyle.Linear), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
        task.wait(0.7333333333333334);

        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        u47.MaxVisibleGraphemes = 0;
        u47.TextTransparency = 0;
        u47.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        u47.Text = "Loser.";
        TweenService:Create(u47, TweenInfo.new(0.19166666666666668, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #u47.Text
        }):Play();
        task.wait(0.38333333333333336);

        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u47, TweenInfo.new(0.95, Enum.EasingStyle.Linear), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.95, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
    end);
    local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");
    local TintColor = ColorCorrection.TintColor;
    local u48 = nil;
    task.delay(3.6166666666666667, function() -- Line: 327
        -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), u48 (ref), TweenService (ref), ColorCorrection (copy)
        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        u48 = TweenService:Create(ColorCorrection, TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 0, 0)
        });
        u48:Play();
        task.wait(0.03333333333333333);

        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        u48 = TweenService:Create(ColorCorrection, TweenInfo.new(0.9333333333333333, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u48:Play();
    end);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local u49 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.01, Enum.EasingStyle.Linear), {
        FieldOfView = 30
    });
    u49:Play();
    task.delay(2.2, function() -- Line: 348
        -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), u49 (ref), TweenService (ref), workspace_CurrentCamera (copy)
        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        u49 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.9666666666666667, Enum.EasingStyle.Linear), {
            FieldOfView = 40
        });
        u49:Play();
        task.wait(0.9666666666666667);

        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        u49 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5166666666666667, Enum.EasingStyle.Linear), {
            FieldOfView = 45
        });
        u49:Play();
        task.wait(0.5166666666666667);

        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        u49 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), {
            FieldOfView = 35
        });
        u49:Play();
        task.wait(0.016666666666666666);

        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        u49 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), {
            FieldOfView = 70
        });
        u49:Play();
        task.wait(0.13333333333333333);

        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        u49 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.4833333333333334, Enum.EasingStyle.Linear), {
            FieldOfView = 45
        });
        u49:Play();
        task.wait(1.4833333333333334);

        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        u49 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.25, Enum.EasingStyle.Linear), {
            FieldOfView = 38
        });
        u49:Play();
        task.wait(1.25);

        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        u49 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.4333333333333333, Enum.EasingStyle.Linear), {
            FieldOfView = 26
        });
        u49:Play();
    end);
    local camera = workspace:FindFirstChild("NagiCam"):FindFirstChild("camera");
    local u50 = script.camera:Clone();
    u50.CFrame = camera.CFrame;
    u50.Parent = Folder;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = u50;
    WeldConstraint.Part1 = camera;
    WeldConstraint.Parent = u50;
    task.delay(8.5, function() -- Line: 68
        -- upvalues: u50 (copy)
        if typeof(u50) == "table" then
            for _, v in u50 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u50 then
            u50:Destroy();
        end;
    end);

    for _, v in { u50.A0.g, u50.A0.h, u50.A0.i } do
        v.Enabled = true;
        v.Transparency = NumberSequence.new(1, 1);
        task.delay(0.65, function() -- Line: 406
            -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), v (copy), u35 (ref), RunService (ref), TweenService (ref)
            if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
                return;
            end;

            local u51 = v;
            local u52 = 1;
            local u53 = nil;
            local os_clock_ret = os.clock();
            local u54 = nil;
            local u55 = 0.08333333333333333;
            local u56 = 1;
            local u57 = 0.8;
            u54 = RunService.Heartbeat:Connect(function(p58) -- Line: 88
                -- upvalues: u53 (ref), os_clock_ret (copy), u55 (copy), TweenService (ref), u52 (ref), u56 (copy), u57 (copy), u51 (copy), u54 (ref)
                u53 = (os.clock() - os_clock_ret) / u55;
                u53 = TweenService:GetValue(u53, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                u52 = u56 + (u57 - u56) * u53;
                u51.Transparency = NumberSequence.new(u52, u52);

                if u55 <= os.clock() - os_clock_ret then
                    u54:Disconnect();
                end;
            end);
            table.insert(u35, u54);
            task.wait(0.08333333333333333);

            if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
                return;
            end;

            local u59 = v;
            local u60 = 0.8;
            local u61 = nil;
            local os_clock_ret2 = os.clock();
            local u62 = nil;
            local u63 = 0.38333333333333336;
            local u64 = 0.8;
            local u65 = 1;
            u62 = RunService.Heartbeat:Connect(function(p66) -- Line: 88
                -- upvalues: u61 (ref), os_clock_ret2 (copy), u63 (copy), TweenService (ref), u60 (ref), u64 (copy), u65 (copy), u59 (copy), u62 (ref)
                u61 = (os.clock() - os_clock_ret2) / u63;
                u61 = TweenService:GetValue(u61, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                u60 = u64 + (u65 - u64) * u61;
                u59.Transparency = NumberSequence.new(u60, u60);

                if u63 <= os.clock() - os_clock_ret2 then
                    u62:Disconnect();
                end;
            end);
            table.insert(u35, u62);
            task.wait(4.4);

            if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
                return;
            end;

            local u67 = v;
            local u68 = 1;
            local u69 = nil;
            local os_clock_ret3 = os.clock();
            local u70 = nil;
            local u71 = 0.08333333333333333;
            local u72 = 1;
            local u73 = 0.8;
            u70 = RunService.Heartbeat:Connect(function(p74) -- Line: 88
                -- upvalues: u69 (ref), os_clock_ret3 (copy), u71 (copy), TweenService (ref), u68 (ref), u72 (copy), u73 (copy), u67 (copy), u70 (ref)
                u69 = (os.clock() - os_clock_ret3) / u71;
                u69 = TweenService:GetValue(u69, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                u68 = u72 + (u73 - u72) * u69;
                u67.Transparency = NumberSequence.new(u68, u68);

                if u71 <= os.clock() - os_clock_ret3 then
                    u70:Disconnect();
                end;
            end);
            table.insert(u35, u70);
            task.wait(0.08333333333333333);

            if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
                return;
            end;

            if v.Name == "g" then
                local u75 = v;
                local u76 = 0.8;
                local u77 = nil;
                local os_clock_ret4 = os.clock();
                local u78 = nil;
                local u79 = 0.4166666666666667;
                local u80 = 0.8;
                local u81 = 1;
                u78 = RunService.Heartbeat:Connect(function(p82) -- Line: 88
                    -- upvalues: u77 (ref), os_clock_ret4 (copy), u79 (copy), TweenService (ref), u76 (ref), u80 (copy), u81 (copy), u75 (copy), u78 (ref)
                    u77 = (os.clock() - os_clock_ret4) / u79;
                    u77 = TweenService:GetValue(u77, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                    u76 = u80 + (u81 - u80) * u77;
                    u75.Transparency = NumberSequence.new(u76, u76);

                    if u79 <= os.clock() - os_clock_ret4 then
                        u78:Disconnect();
                    end;
                end);
                table.insert(u35, u78);

                return;
            end;

            local u83 = v;
            local u84 = 0.8;
            local u85 = nil;
            local os_clock_ret4 = os.clock();
            local u86 = nil;
            local u87 = 0.45;
            local u88 = 0.8;
            local u89 = 1;
            u86 = RunService.Heartbeat:Connect(function(p90) -- Line: 88
                -- upvalues: u85 (ref), os_clock_ret4 (copy), u87 (copy), TweenService (ref), u84 (ref), u88 (copy), u89 (copy), u83 (copy), u86 (ref)
                u85 = (os.clock() - os_clock_ret4) / u87;
                u85 = TweenService:GetValue(u85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                u84 = u88 + (u89 - u88) * u85;
                u83.Transparency = NumberSequence.new(u84, u84);

                if u87 <= os.clock() - os_clock_ret4 then
                    u86:Disconnect();
                end;
            end);
            table.insert(u35, u86);
        end);
    end;

    local u91 = script.BALL:Clone();
    u91.CFrame = BALL.CFrame;
    u91.Parent = Folder;
    local WeldConstraint2 = Instance.new("WeldConstraint");
    WeldConstraint2.Part0 = u91;
    WeldConstraint2.Part1 = BALL;
    WeldConstraint2.Parent = u91;
    local u92 = script.UserVFX:Clone();
    u92.Parent = Folder;
    local u93 = script.CutsceneVFX:Clone();
    u93:PivotTo(HumanoidRootPart.CFrame);
    u93.Parent = Folder;
    EnableVFX(u93.WindBeam, true);

    for _, child in u93.WindgroundBeam.A0:GetChildren() do
        child.Enabled = true;
        child.Transparency = NumberSequence.new(1, 1);
        task.delay(1.0833333333333333, function() -- Line: 460
            -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), child (copy), u35 (ref), RunService (ref), TweenService (ref)
            if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
                return;
            end;

            local u94 = child;
            local u95 = 1;
            local u96 = nil;
            local os_clock_ret = os.clock();
            local u97 = nil;
            local u98 = 0.26666666666666666;
            local u99 = 1;
            local u100 = 0.8;
            u97 = RunService.Heartbeat:Connect(function(p101) -- Line: 88
                -- upvalues: u96 (ref), os_clock_ret (copy), u98 (copy), TweenService (ref), u95 (ref), u99 (copy), u100 (copy), u94 (copy), u97 (ref)
                u96 = (os.clock() - os_clock_ret) / u98;
                u96 = TweenService:GetValue(u96, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                u95 = u99 + (u100 - u99) * u96;
                u94.Transparency = NumberSequence.new(u95, u95);

                if u98 <= os.clock() - os_clock_ret then
                    u97:Disconnect();
                end;
            end);
            table.insert(u35, u97);
            task.wait(0.26666666666666666);

            if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
                return;
            end;

            local u102 = child;
            local u103 = 0.8;
            local u104 = nil;
            local os_clock_ret2 = os.clock();
            local u105 = nil;
            local u106 = 0.9333333333333333;
            local u107 = 0.8;
            local u108 = 1;
            u105 = RunService.Heartbeat:Connect(function(p109) -- Line: 88
                -- upvalues: u104 (ref), os_clock_ret2 (copy), u106 (copy), TweenService (ref), u103 (ref), u107 (copy), u108 (copy), u102 (copy), u105 (ref)
                u104 = (os.clock() - os_clock_ret2) / u106;
                u104 = TweenService:GetValue(u104, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                u103 = u107 + (u108 - u107) * u104;
                u102.Transparency = NumberSequence.new(u103, u103);

                if u106 <= os.clock() - os_clock_ret2 then
                    u105:Disconnect();
                end;
            end);
            table.insert(u35, u105);
        end);
    end;

    task.delay(0.9, function() -- Line: 480
        -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), u93 (copy), u32 (copy), Debris (ref), VfxManager (ref), u92 (copy), HumanoidRootPart (copy)
        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u93.WindBeam, false);
        local v110 = script.Start:Clone();
        v110.Parent = workspace;
        v110.Position = u32.Char.Torso.Position;
        Debris:AddItem(v110, 2);
        VfxManager.Emit(v110);

        for _, descendant in u92:GetDescendants() do
            if (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) and descendant.Parent.Name ~= "Eye2" then
                descendant.Enabled = false;
            end;
        end;

        local v111 = script.CutsceneBG:Clone();
        v111:PivotTo(HumanoidRootPart.CFrame * CFrame.Angles(0, 0, 0));
        v111.Parent = Folder;
        v111.Field.Flower.ParticleEmitter:Emit(200);
    end);
    task.delay(1.15, function() -- Line: 506
        -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), u93 (copy)
        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        print("2");
        EmitAll(u93.GroundLeaf);
    end);
    task.delay(1.6666666666666667, function() -- Line: 512
        -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), u93 (copy)
        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        print("3");
        EnableVFX(u93.GroundRose, true);
    end);
    task.delay(2.2, function() -- Line: 520
        -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), u93 (copy)
        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        print("4");
        EnableVFX(u93.WindBeam, true);
    end);
    task.delay(3.6166666666666667, function() -- Line: 534
        -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), u93 (copy), u50 (copy)
        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        task.wait(0.11666666666666667);

        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u93.RushBeam, true);
        EnableVFX(u93.GroundRose, false);
        EnableVFX(u93.ScopeArea, true);
        EnableVFX(u93.ScopeSpin, true);
        EnableVFX(u93.ScopeSuggest, true);
        EmitAll(u93.ScopeSuggest);
        EnableVFX(u50, true);
    end);
    task.delay(4.366666666666666, function() -- Line: 556
        -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), u91 (copy), u93 (copy)
        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        EmitAll(u91.Emit);
        EnableVFX(u91.Enabled, true);
        EnableVFX(u93.ScopeSuggest, false);
    end);
    task.delay(4.616666666666666, function() -- Line: 564
        -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), u91 (copy)
        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u91.Enabled, false);
    end);
    task.delay(4.966666666666667, function() -- Line: 570
        -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), u93 (copy)
        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u93.ScopeArea, false);
        EnableVFX(u93.ScopeSpin, false);
        EnableVFX(u93.RushBeam, false);
    end);
    task.delay(5.15, function() -- Line: 584
        -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), u93 (copy), u50 (copy)
        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u93.GroundRose, true);
        EnableVFX(u50, false);
    end);
    task.delay(6.466666666666667, function() -- Line: 592
        -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), u93 (copy)
        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        (function(p112, p113, u114, u115, p116, u117) -- Line: 594, Name: ColorCorrectionEffect
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Saturation = p112;
            ColorCorrectionEffect.Contrast = p113;
            ColorCorrectionEffect.Parent = game:GetService("Lighting");
            task.delay(p116, function() -- Line: 601
                -- upvalues: ColorCorrectionEffect (copy), u114 (copy), u115 (copy), u117 (copy)
                ColorCorrectionEffect.Saturation = u114;
                ColorCorrectionEffect.Contrast = u115;
                task.wait(u117);
                ColorCorrectionEffect:Destroy();
            end);
        end)(-1, -3, -1, 3, 0.04, 0.09);
        task.wait(0.016666666666666666);

        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u93.GroundRose, false);
    end);
    task.delay(6.6, function() -- Line: 629
        -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), u93 (copy), u50 (copy)
        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        EmitAll(u93.RoseKick);
        EnableVFX(u50, true);
        EmitAll(u50.KickEmit);
    end);
    task.delay(7.583333333333333, function() -- Line: 636
        -- upvalues: Folder (copy), Debris2 (ref), u33 (copy), u50 (copy)
        if not Folder:GetAttribute("Active") or Debris2:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u50, false);
    end);
    local u118 = SoundManager.SpawnSound("kaiser beinschuss", 0.7, workspace, 150);

    local function v122() -- Line: 644
        -- upvalues: u35 (ref), Folder (copy), u36 (ref), u49 (ref), u48 (ref), u37 (copy), u47 (ref), u118 (copy), TweenService (ref), workspace_CurrentCamera (copy), FieldOfView (copy), Vignette (copy), ColorCorrection (copy), TintColor (copy)
        for _, v in u35 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            local u119 = Folder;
            task.delay(4, function() -- Line: 68
                -- upvalues: u119 (copy)
                if typeof(u119) == "table" then
                    for _, v in u119 do
                        if v then
                            v:Destroy();
                        end;
                    end;

                    return;
                end;

                if u119 then
                    u119:Destroy();
                end;
            end);
            EnableVFX(Folder, false);

            for _, descendant in Folder:GetDescendants() do
                if descendant:IsA("Part") or (descendant:IsA("MeshPart") or (descendant:IsA("BasePart") or (descendant:IsA("Texture") or descendant:IsA("Decal")))) then
                    descendant.Transparency = 1;
                end;
            end;
        end;

        for _, v in u36 do
            v:Pause();
        end;

        if u49 then
            u49:Pause();
        end;

        if u48 then
            u48:Pause();
        end;

        if u37 then
            u37:Destroy();
        end;

        if u47 then
            u47:Destroy();
        end;

        if u118 then
            local v120 = TweenService:Create(u118, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                Volume = 0
            });
            v120:Play();
            v120.Completed:Once(function() -- Line: 687
                -- upvalues: u118 (ref)
                u118:Destroy();
            end);
        end;

        workspace_CurrentCamera.FieldOfView = FieldOfView;
        task.spawn(function() -- Line: 694
            -- upvalues: Vignette (ref), ColorCorrection (ref), TintColor (ref)
            for i = 1, 4 do
                local v121;

                if Vignette then
                    v121 = i;

                    for _, v in {
                        Vignette.Vignette,
                        Vignette.Vignette.LL,
                        Vignette.Vignette.UR,
                        Vignette.Vignette.LL.LR
                    } do
                        v.ImageTransparency = 1;
                    end;
                else
                    v121 = i;
                end;

                ColorCorrection.TintColor = TintColor;
                task.wait(0.05);
            end;
        end);
        table.clear(u36);
        table.clear(u35);
        u35 = nil;
        u36 = nil;
    end;

    table.insert(u35, Folder.Destroying:Connect(v122));
    table.insert(u35, Folder.AttributeChanged:Connect(v122));
end;