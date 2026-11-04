  

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
ReplicatedStorage:FindFirstChild("Assets"):FindFirstChild("Vfx");
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
    -- upvalues: SpectatorController (copy), Players (copy), Debris (copy), TweenService (copy), ReplicatedStorage (copy), RunService (copy), SoundManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p32.Char;
    Char:FindFirstChild("PlrFootball"):FindFirstChild("BallAnims"):FindFirstChild("BALL");
    local u33 = script.Name .. " VFX FOLDER " .. Char.Name;

    if p32.Task ~= "Cutscene" then
        local v34 = p32.Task == "Cleanup" and Debris:FindFirstChild(u33);

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
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.spawn(function() -- Line: 175
        -- upvalues: Players (ref)
        local v37 = script.FirstFrames:Clone();
        v37.Parent = Players.LocalPlayer.PlayerGui;
        local VideoFrame = v37:FindFirstChild("VideoFrame");
        VideoFrame.Visible = false;
        task.wait(6.1);
        VideoFrame.Visible = true;
        VideoFrame:Play();
        print(VideoFrame);
        task.wait(VideoFrame.TimeLength);
        v37:Destroy();
    end);
    task.delay(8.5, function() -- Line: 191
        -- upvalues: Folder (copy)
        if Folder and Folder:GetAttribute("Active") then
            Folder:SetAttribute("Active", nil);
        end;
    end);
    local u38 = script["Screen Cover"]:Clone();
    u38.Parent = Vignette;
    u38.BackgroundTransparency = 1;
    task.delay(8.5, function() -- Line: 68
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
    task.delay(7.466666666666667, function() -- Line: 204
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), TweenService (ref), u38 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u38, TweenInfo.new(1.0333333333333334, Enum.EasingStyle.Linear), {
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
            task.delay(0.9166666666666666, function() -- Line: 215
                -- upvalues: Folder (copy), Debris (ref), u33 (copy), TweenService (ref), v (copy), u36 (ref)
                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                local v39 = TweenService:Create(v, TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0
                });
                v39:Play();
                table.insert(u36, v39);
                task.wait(0.11666666666666667);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                local v40 = TweenService:Create(v, TweenInfo.new(0.7, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0.8
                });
                v40:Play();
                table.insert(u36, v40);
                task.wait(0.9833333333333333);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                local v41 = TweenService:Create(v, TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0,
                    ImageColor3 = Color3.fromRGB(67, 100, 255)
                });
                v41:Play();
                table.insert(u36, v41);
                task.wait(0.11666666666666667);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                local v42 = TweenService:Create(v, TweenInfo.new(1.55, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(190, 106, 255)
                });
                v42:Play();
                table.insert(u36, v42);
                task.wait(1.55);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                local v43 = TweenService:Create(v, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0.8,
                    ImageColor3 = Color3.fromRGB(0, 0, 0)
                });
                v43:Play();
                table.insert(u36, v43);
                task.wait(0.21666666666666667);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                local v44 = TweenService:Create(v, TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0,
                    ImageColor3 = Color3.fromRGB(255, 0, 0)
                });
                v44:Play();
                table.insert(u36, v44);
                task.wait(0.9);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                local v45 = TweenService:Create(v, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0.8,
                    ImageColor3 = Color3.fromRGB(0, 0, 0)
                });
                v45:Play();
                table.insert(u36, v45);
                task.wait(0.15);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                local v46 = TweenService:Create(v, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(67, 100, 255)
                });
                v46:Play();
                table.insert(u36, v46);
                task.wait(1.5);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                local v47 = TweenService:Create(v, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0.8,
                    ImageColor3 = Color3.fromRGB(0, 0, 0)
                });
                v47:Play();
                table.insert(u36, v47);
            end);
        end;
    end;

    local u48 = nil;
    task.delay(2.4, function() -- Line: 283
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u48 (ref), ReplicatedStorage (ref), Players (ref), TweenService (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u48 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u48.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u48.Position = UDim2.new(0.5, 0, 0.8, 0);
        u48.Size = UDim2.new(1, 0, 0.1, 0);
        u48.BackgroundTransparency = 1;
        u48.AnchorPoint = Vector2.new(0.5, 0.5);
        u48.Font = Enum.Font.ArialBold;
        u48.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u48;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        u48.MaxVisibleGraphemes = 0;
        u48.TextTransparency = 0;
        u48.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        u48.Text = "Eat this...";
        TweenService:Create(u48, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #u48.Text
        }):Play();
        task.wait(0.8333333333333333);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u48, TweenInfo.new(0.55, Enum.EasingStyle.Linear), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
        task.wait(0.7333333333333334);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u48.MaxVisibleGraphemes = 0;
        u48.TextTransparency = 0;
        u48.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        u48.Text = "Loser.";
        TweenService:Create(u48, TweenInfo.new(0.19166666666666668, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #u48.Text
        }):Play();
        task.wait(0.38333333333333336);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u48, TweenInfo.new(0.95, Enum.EasingStyle.Linear), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.95, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
    end);
    local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");
    local TintColor = ColorCorrection.TintColor;
    local u49 = nil;
    task.delay(3.6166666666666667, function() -- Line: 343
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u49 (ref), TweenService (ref), ColorCorrection (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u49 = TweenService:Create(ColorCorrection, TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 0, 0)
        });
        u49:Play();
        task.wait(0.03333333333333333);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u49 = TweenService:Create(ColorCorrection, TweenInfo.new(0.9333333333333333, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u49:Play();
    end);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local u50 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.01, Enum.EasingStyle.Linear), {
        FieldOfView = 30
    });
    u50:Play();
    task.delay(2.2, function() -- Line: 364
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u50 (ref), TweenService (ref), workspace_CurrentCamera (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u50 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.9666666666666667, Enum.EasingStyle.Linear), {
            FieldOfView = 40
        });
        u50:Play();
        task.wait(0.9666666666666667);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u50 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5166666666666667, Enum.EasingStyle.Linear), {
            FieldOfView = 45
        });
        u50:Play();
        task.wait(0.5166666666666667);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u50 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), {
            FieldOfView = 35
        });
        u50:Play();
        task.wait(0.016666666666666666);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u50 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), {
            FieldOfView = 70
        });
        u50:Play();
        task.wait(0.13333333333333333);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u50 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.4833333333333334, Enum.EasingStyle.Linear), {
            FieldOfView = 45
        });
        u50:Play();
        task.wait(1.4833333333333334);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u50 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.25, Enum.EasingStyle.Linear), {
            FieldOfView = 38
        });
        u50:Play();
        task.wait(1.25);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u50 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.4333333333333333, Enum.EasingStyle.Linear), {
            FieldOfView = 26
        });
        u50:Play();
    end);
    local camera = workspace:FindFirstChild("NagiCam"):FindFirstChild("camera");
    local u51 = script.camera:Clone();
    u51.CFrame = camera.CFrame;
    u51.Parent = Folder;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = u51;
    WeldConstraint.Part1 = camera;
    WeldConstraint.Parent = u51;
    task.delay(8.5, function() -- Line: 68
        -- upvalues: u51 (copy)
        if typeof(u51) == "table" then
            for _, v in u51 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u51 then
            u51:Destroy();
        end;
    end);

    for _, v in { u51.A0.g, u51.A0.h, u51.A0.i } do
        v.Enabled = true;
        v.Transparency = NumberSequence.new(1, 1);
        task.delay(0.65, function() -- Line: 422
            -- upvalues: Folder (copy), Debris (ref), u33 (copy), v (copy), u35 (ref), RunService (ref), TweenService (ref)
            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            local u52 = v;
            local u53 = 1;
            local u54 = nil;
            local os_clock_ret = os.clock();
            local u55 = nil;
            local u56 = 0.08333333333333333;
            local u57 = 1;
            local u58 = 0.8;
            u55 = RunService.Heartbeat:Connect(function(p59) -- Line: 88
                -- upvalues: u54 (ref), os_clock_ret (copy), u56 (copy), TweenService (ref), u53 (ref), u57 (copy), u58 (copy), u52 (copy), u55 (ref)
                u54 = (os.clock() - os_clock_ret) / u56;
                u54 = TweenService:GetValue(u54, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                u53 = u57 + (u58 - u57) * u54;
                u52.Transparency = NumberSequence.new(u53, u53);

                if u56 <= os.clock() - os_clock_ret then
                    u55:Disconnect();
                end;
            end);
            table.insert(u35, u55);
            task.wait(0.08333333333333333);

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            local u60 = v;
            local u61 = 0.8;
            local u62 = nil;
            local os_clock_ret2 = os.clock();
            local u63 = nil;
            local u64 = 0.38333333333333336;
            local u65 = 0.8;
            local u66 = 1;
            u63 = RunService.Heartbeat:Connect(function(p67) -- Line: 88
                -- upvalues: u62 (ref), os_clock_ret2 (copy), u64 (copy), TweenService (ref), u61 (ref), u65 (copy), u66 (copy), u60 (copy), u63 (ref)
                u62 = (os.clock() - os_clock_ret2) / u64;
                u62 = TweenService:GetValue(u62, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                u61 = u65 + (u66 - u65) * u62;
                u60.Transparency = NumberSequence.new(u61, u61);

                if u64 <= os.clock() - os_clock_ret2 then
                    u63:Disconnect();
                end;
            end);
            table.insert(u35, u63);
            task.wait(4.4);

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            local u68 = v;
            local u69 = 1;
            local u70 = nil;
            local os_clock_ret3 = os.clock();
            local u71 = nil;
            local u72 = 0.08333333333333333;
            local u73 = 1;
            local u74 = 0.8;
            u71 = RunService.Heartbeat:Connect(function(p75) -- Line: 88
                -- upvalues: u70 (ref), os_clock_ret3 (copy), u72 (copy), TweenService (ref), u69 (ref), u73 (copy), u74 (copy), u68 (copy), u71 (ref)
                u70 = (os.clock() - os_clock_ret3) / u72;
                u70 = TweenService:GetValue(u70, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                u69 = u73 + (u74 - u73) * u70;
                u68.Transparency = NumberSequence.new(u69, u69);

                if u72 <= os.clock() - os_clock_ret3 then
                    u71:Disconnect();
                end;
            end);
            table.insert(u35, u71);
            task.wait(0.08333333333333333);

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            if v.Name == "g" then
                local u76 = v;
                local u77 = 0.8;
                local u78 = nil;
                local os_clock_ret4 = os.clock();
                local u79 = nil;
                local u80 = 0.4166666666666667;
                local u81 = 0.8;
                local u82 = 1;
                u79 = RunService.Heartbeat:Connect(function(p83) -- Line: 88
                    -- upvalues: u78 (ref), os_clock_ret4 (copy), u80 (copy), TweenService (ref), u77 (ref), u81 (copy), u82 (copy), u76 (copy), u79 (ref)
                    u78 = (os.clock() - os_clock_ret4) / u80;
                    u78 = TweenService:GetValue(u78, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                    u77 = u81 + (u82 - u81) * u78;
                    u76.Transparency = NumberSequence.new(u77, u77);

                    if u80 <= os.clock() - os_clock_ret4 then
                        u79:Disconnect();
                    end;
                end);
                table.insert(u35, u79);

                return;
            end;

            local u84 = v;
            local u85 = 0.8;
            local u86 = nil;
            local os_clock_ret4 = os.clock();
            local u87 = nil;
            local u88 = 0.45;
            local u89 = 0.8;
            local u90 = 1;
            u87 = RunService.Heartbeat:Connect(function(p91) -- Line: 88
                -- upvalues: u86 (ref), os_clock_ret4 (copy), u88 (copy), TweenService (ref), u85 (ref), u89 (copy), u90 (copy), u84 (copy), u87 (ref)
                u86 = (os.clock() - os_clock_ret4) / u88;
                u86 = TweenService:GetValue(u86, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                u85 = u89 + (u90 - u89) * u86;
                u84.Transparency = NumberSequence.new(u85, u85);

                if u88 <= os.clock() - os_clock_ret4 then
                    u87:Disconnect();
                end;
            end);
            table.insert(u35, u87);
        end);
    end;

    local u92 = script.BALL:Clone();
    u92.CFrame = BALL.CFrame;
    u92.Parent = Folder;
    local WeldConstraint2 = Instance.new("WeldConstraint");
    WeldConstraint2.Part0 = u92;
    WeldConstraint2.Part1 = BALL;
    WeldConstraint2.Parent = u92;
    local u93 = script.UserVFX:Clone();
    u93.Parent = Folder;

    for _, child in u93:GetChildren() do
        local v94 = Char:FindFirstChild(child.Name);

        if v94 then
            child.CFrame = v94.CFrame;
            local WeldConstraint3 = Instance.new("WeldConstraint");
            WeldConstraint3.Part0 = child;
            WeldConstraint3.Part1 = v94;
            WeldConstraint3.Parent = child;
        end;
    end;

    local u95 = script.CutsceneVFX:Clone();
    u95:PivotTo(HumanoidRootPart.CFrame);
    u95.Parent = Folder;
    EnableVFX(u95.WindBeam, true);

    for _, child in u95.WindgroundBeam.A0:GetChildren() do
        child.Enabled = true;
        child.Transparency = NumberSequence.new(1, 1);
        task.delay(1.0833333333333333, function() -- Line: 476
            -- upvalues: Folder (copy), Debris (ref), u33 (copy), child (copy), u35 (ref), RunService (ref), TweenService (ref)
            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            local u96 = child;
            local u97 = 1;
            local u98 = nil;
            local os_clock_ret = os.clock();
            local u99 = nil;
            local u100 = 0.26666666666666666;
            local u101 = 1;
            local u102 = 0.8;
            u99 = RunService.Heartbeat:Connect(function(p103) -- Line: 88
                -- upvalues: u98 (ref), os_clock_ret (copy), u100 (copy), TweenService (ref), u97 (ref), u101 (copy), u102 (copy), u96 (copy), u99 (ref)
                u98 = (os.clock() - os_clock_ret) / u100;
                u98 = TweenService:GetValue(u98, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                u97 = u101 + (u102 - u101) * u98;
                u96.Transparency = NumberSequence.new(u97, u97);

                if u100 <= os.clock() - os_clock_ret then
                    u99:Disconnect();
                end;
            end);
            table.insert(u35, u99);
            task.wait(0.26666666666666666);

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            local u104 = child;
            local u105 = 0.8;
            local u106 = nil;
            local os_clock_ret2 = os.clock();
            local u107 = nil;
            local u108 = 0.9333333333333333;
            local u109 = 0.8;
            local u110 = 1;
            u107 = RunService.Heartbeat:Connect(function(p111) -- Line: 88
                -- upvalues: u106 (ref), os_clock_ret2 (copy), u108 (copy), TweenService (ref), u105 (ref), u109 (copy), u110 (copy), u104 (copy), u107 (ref)
                u106 = (os.clock() - os_clock_ret2) / u108;
                u106 = TweenService:GetValue(u106, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                u105 = u109 + (u110 - u109) * u106;
                u104.Transparency = NumberSequence.new(u105, u105);

                if u108 <= os.clock() - os_clock_ret2 then
                    u107:Disconnect();
                end;
            end);
            table.insert(u35, u107);
        end);
    end;

    for _, descendant in u93:GetDescendants() do
        if (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) and descendant.Parent.Name ~= "Eye2" then
            descendant.Enabled = true;
        end;
    end;

    task.delay(0.9, function() -- Line: 496
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u95 (copy), u93 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EmitAll(u95.AryuSmash);
        EnableVFX(u95.WindBeam, false);

        for _, descendant in u93:GetDescendants() do
            if (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) and descendant.Parent.Name ~= "Eye2" then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(1.15, function() -- Line: 509
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u95 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EmitAll(u95.GroundLeaf);
    end);
    task.delay(1.6666666666666667, function() -- Line: 515
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u95 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u95.GroundRose, true);
        EnableVFX(u95.RosesArea, true);
    end);
    task.delay(2.2, function() -- Line: 523
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u95 (copy), u93 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u95.WindBeam, true);

        for _, descendant in u93:GetDescendants() do
            if (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) and descendant.Parent.Name ~= "Eye2" then
                task.spawn(function() -- Line: 530
                    -- upvalues: descendant (copy)
                    descendant.Enabled = true;
                end);
            end;
        end;
    end);
    task.delay(3.6166666666666667, function() -- Line: 537
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u93 (copy), u95 (copy), u51 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        for _, descendant in u93:GetDescendants() do
            if (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) and descendant.Parent.Name ~= "Eye" then
                descendant.Enabled = false;
            end;
        end;

        task.wait(0.11666666666666667);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u95.RushBeam, true);
        EnableVFX(u95.GroundRose, false);
        EnableVFX(u95.RosesArea, false);
        EnableVFX(u95.ScopeArea, true);
        EnableVFX(u95.ScopeSpin, true);
        EnableVFX(u95.ScopeSuggest, true);
        EmitAll(u95.ScopeSuggest);
        EnableVFX(u51, true);
    end);
    task.delay(4.366666666666666, function() -- Line: 559
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u92 (copy), u95 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EmitAll(u92.Emit);
        EnableVFX(u92.Enabled, true);
        EnableVFX(u95.ScopeSuggest, false);
    end);
    task.delay(4.616666666666666, function() -- Line: 567
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u92 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u92.Enabled, false);
    end);
    task.delay(4.966666666666667, function() -- Line: 573
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u95 (copy), u93 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u95.ScopeArea, false);
        EnableVFX(u95.ScopeSpin, false);
        EnableVFX(u95.RushBeam, false);

        for _, descendant in u93:GetDescendants() do
            if (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) and descendant.Parent.Name ~= "Eye2" then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(5.15, function() -- Line: 589
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u95 (copy), u51 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u95.GroundRose, true);
        EnableVFX(u95.RosesArea, true);
        EnableVFX(u51, false);
    end);
    task.delay(6.466666666666667, function() -- Line: 597
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u95 (copy), u93 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        (function(p112, p113, u114, u115, p116, u117) -- Line: 599, Name: ColorCorrectionEffect
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Saturation = p112;
            ColorCorrectionEffect.Contrast = p113;
            ColorCorrectionEffect.Parent = game:GetService("Lighting");
            task.delay(p116, function() -- Line: 606
                -- upvalues: ColorCorrectionEffect (copy), u114 (copy), u115 (copy), u117 (copy)
                ColorCorrectionEffect.Saturation = u114;
                ColorCorrectionEffect.Contrast = u115;
                task.wait(u117);
                ColorCorrectionEffect:Destroy();
            end);
        end)(-1, -3, -1, 3, 0.04, 0.09);
        task.wait(0.016666666666666666);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u95.GroundRose, false);
        EnableVFX(u95.RosesArea, false);

        for _, descendant in u93:GetDescendants() do
            if (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) and descendant.Parent.Name == "Eye2" then
                descendant.Enabled = true;
            elseif (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) and descendant.Parent.Name == "Eye" then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(6.6, function() -- Line: 634
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u95 (copy), u51 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EmitAll(u95.RoseKick);
        EnableVFX(u51, true);
        EmitAll(u51.KickEmit);
    end);
    task.delay(7.583333333333333, function() -- Line: 641
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u51 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u51, false);
    end);
    local u118 = SoundManager.SpawnSound("kaiser beinschuss", 0.7, workspace, 150);

    local function v122() -- Line: 649
        -- upvalues: u35 (ref), Folder (copy), u36 (ref), u50 (ref), u49 (ref), u38 (copy), u48 (ref), u118 (copy), TweenService (ref), workspace_CurrentCamera (copy), FieldOfView (copy), Vignette (copy), ColorCorrection (copy), TintColor (copy)
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

        if u50 then
            u50:Pause();
        end;

        if u49 then
            u49:Pause();
        end;

        if u38 then
            u38:Destroy();
        end;

        if u48 then
            u48:Destroy();
        end;

        if u118 then
            local v120 = TweenService:Create(u118, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                Volume = 0
            });
            v120:Play();
            v120.Completed:Once(function() -- Line: 692
                -- upvalues: u118 (ref)
                u118:Destroy();
            end);
        end;

        workspace_CurrentCamera.FieldOfView = FieldOfView;
        task.spawn(function() -- Line: 699
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