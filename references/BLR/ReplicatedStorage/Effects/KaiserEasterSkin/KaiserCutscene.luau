  

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

function Emit_All_With_Duration(p3)
    local function emit(u4) -- Line: 28
        if u4:IsA("ParticleEmitter") or (u4:IsA("Beam") or u4:IsA("Trail")) then
            local Attribute = u4:GetAttribute("EmitDuration");
            local Attribute2 = u4:GetAttribute("EmitDelay");
            local Attribute3 = u4:GetAttribute("EmitCount");

            if Attribute and Attribute ~= 0 then
                if Attribute2 and Attribute2 ~= 0 then
                    task.delay(Attribute2, function() -- Line: 36
                        -- upvalues: u4 (copy), Attribute (copy)
                        u4.Enabled = true;
                        task.delay(Attribute, function() -- Line: 39
                            -- upvalues: u4 (ref)
                            u4.Enabled = false;
                        end);
                    end);

                    return;
                end;

                u4.Enabled = true;
                task.delay(Attribute, function() -- Line: 46
                    -- upvalues: u4 (copy)
                    u4.Enabled = false;
                end);

                return;
            end;

            if Attribute3 and Attribute3 ~= 0 then
                if Attribute2 and Attribute2 ~= 0 then
                    task.delay(Attribute2, function() -- Line: 53
                        -- upvalues: u4 (copy), Attribute3 (copy)
                        u4:Emit(Attribute3);
                    end);

                    return;
                end;

                u4:Emit(Attribute3);
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

local function Destroy_Effect(u5: any, p6: number) -- Line: 85
    task.delay(p6, function() -- Line: 87
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

local function tweenbeam(u7, u8, u9, u10, u11, p12) -- Line: 103
    -- upvalues: RunService (copy), TweenService (copy)
    local u13 = nil;
    local os_clock_ret = os.clock();
    local u14 = nil;
    u14 = RunService.Heartbeat:Connect(function(p15) -- Line: 107
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

local function Weld(p16, p17) -- Line: 121
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p16;
    WeldConstraint.Part1 = p17;
    WeldConstraint.Parent = p16;

    return WeldConstraint;
end;

return function(p18) -- Line: 128
    -- upvalues: SpectatorController (copy), SoundManager (copy), Debris (copy), Players (copy), TweenService (copy), ReplicatedStorage (copy), RunService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p18.Char;
    local u19 = script.Name .. " VFX FOLDER " .. Char.Name;

    if p18.Task ~= "Cutscene" then
        local v20 = p18.Task == "Cleanup" and Debris:FindFirstChild(u19);

        if v20 then
            v20:SetAttribute("Active", nil);
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

    local u21 = SoundManager.SpawnSound("kaiser awak", 0.7, workspace, 150);
    local u22 = {};
    local u23 = {};
    local Folder = Instance.new("Folder");
    Folder.Name = u19;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(8, function() -- Line: 87
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
    task.delay(8, function() -- Line: 153
        -- upvalues: Folder (copy)
        if Folder and Folder:GetAttribute("Active") then
            Folder:SetAttribute("Active", nil);
        end;
    end);
    local Vignette = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");

    if Vignette then
        for _, v in {
            Vignette.Vignette,
            Vignette.Vignette.LL,
            Vignette.Vignette.UR,
            Vignette.Vignette.LL.LR
        } do
            v.ImageColor3 = Color3.fromRGB(0, 0, 0);
            v.ImageTransparency = 0;
            task.delay(0.2833333333333333, function() -- Line: 169
                -- upvalues: Folder (copy), Debris (ref), u19 (copy), TweenService (ref), v (copy), u23 (ref)
                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
                    return;
                end;

                local v24 = TweenService:Create(v, TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(255, 157, 91)
                });
                v24:Play();
                table.insert(u23, v24);
                task.wait(0.11666666666666667);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
                    return;
                end;

                local v25 = TweenService:Create(v, TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(0, 0, 0)
                });
                v25:Play();
                table.insert(u23, v25);
                task.wait(3.466666666666667);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
                    return;
                end;

                local v26 = TweenService:Create(v, TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(151, 173, 255)
                });
                v26:Play();
                table.insert(u23, v26);
                task.wait(0.11666666666666667);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
                    return;
                end;

                local v27 = TweenService:Create(v, TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(0, 0, 0)
                });
                v27:Play();
                table.insert(u23, v27);
                task.wait(1.6666666666666667);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
                    return;
                end;

                local v28 = TweenService:Create(v, TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(151, 173, 255)
                });
                v28:Play();
                table.insert(u23, v28);
                task.wait(0.11666666666666667);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
                    return;
                end;

                local v29 = TweenService:Create(v, TweenInfo.new(1.7, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(255, 94, 252)
                });
                v29:Play();
                table.insert(u23, v29);
                task.wait(1.7);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
                    return;
                end;

                local v30 = TweenService:Create(v, TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(0, 0, 0)
                });
                v30:Play();
                table.insert(u23, v30);
            end);
        end;
    end;

    local u31 = script["Screen Cover"]:Clone();
    u31.Parent = Vignette;
    u31.BackgroundTransparency = 1;
    task.delay(8, function() -- Line: 87
        -- upvalues: u31 (copy)
        if typeof(u31) == "table" then
            for _, v in u31 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u31 then
            u31:Destroy();
        end;
    end);
    task.delay(7.583333333333333, function() -- Line: 223
        -- upvalues: Folder (copy), Debris (ref), u19 (copy), TweenService (ref), u31 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        TweenService:Create(u31, TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), {
            BackgroundTransparency = 0
        }):Play();
    end);
    local u32 = script.Blur:Clone();
    u32.Parent = game.Lighting;
    task.delay(4.383333333333334, function() -- Line: 231
        -- upvalues: Folder (copy), Debris (ref), u19 (copy), TweenService (ref), u32 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        TweenService:Create(u32, TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear), {
            Size = 15
        }):Play();
        task.wait(0.4166666666666667);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        TweenService:Create(u32, TweenInfo.new(1.2166666666666666, Enum.EasingStyle.Linear), {
            Size = 1
        }):Play();
    end);
    local Atmosphere = game.Lighting:FindFirstChild("Atmosphere");
    local Density = Atmosphere.Density;
    local Offset = Atmosphere.Offset;
    local Color = Atmosphere.Color;
    local Decay = Atmosphere.Decay;
    local Haze = Atmosphere.Haze;
    Atmosphere.Density = 0.397;
    Atmosphere.Offset = 0.079;
    Atmosphere.Color = Color3.fromRGB(55, 93, 102);
    Atmosphere.Decay = Color3.fromRGB(41, 73, 255);
    Atmosphere.Glare = 0;
    Atmosphere.Haze = 10;
    local u33 = nil;
    task.delay(4.8, function() -- Line: 258
        -- upvalues: Folder (copy), Debris (ref), u19 (copy), u33 (ref), TweenService (ref), Atmosphere (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        u33 = TweenService:Create(Atmosphere, TweenInfo.new(0.36666666666666664, Enum.EasingStyle.Linear), {
            Density = 0.5
        });
        u33:Play();
    end);
    local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");
    local TintColor = ColorCorrection.TintColor;
    local u34 = nil;
    task.delay(0.25, function() -- Line: 270
        -- upvalues: Folder (copy), Debris (ref), u19 (copy), u34 (ref), TweenService (ref), ColorCorrection (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        u34 = TweenService:Create(ColorCorrection, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 190, 93)
        });
        u34:Play();
        task.wait(0.2);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        u34 = TweenService:Create(ColorCorrection, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u34:Play();
        task.wait(3.3);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        u34 = TweenService:Create(ColorCorrection, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(115, 140, 255)
        });
        u34:Play();
        task.wait(0.2);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        u34 = TweenService:Create(ColorCorrection, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u34:Play();
        task.wait(1.8166666666666667);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        task.wait(0.2);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        u34 = TweenService:Create(ColorCorrection, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u34:Play();
    end);
    local u35 = nil;
    task.delay(1.0333333333333334, function() -- Line: 312
        -- upvalues: Folder (copy), Debris (ref), u19 (copy), u35 (ref), ReplicatedStorage (ref), Players (ref), TweenService (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        u35 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u35.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u35.Position = UDim2.new(0.5, 0, 0.8, 0);
        u35.Size = UDim2.new(1, 0, 0.1, 0);
        u35.BackgroundTransparency = 1;
        u35.AnchorPoint = Vector2.new(0.5, 0.5);
        u35.Font = Enum.Font.ArialBold;
        u35.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u35;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        u35.MaxVisibleGraphemes = 0;
        u35.TextTransparency = 0;
        u35.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        u35.Text = "Get on your knees...";
        TweenService:Create(u35, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #u35.Text
        }):Play();
        task.wait(0.4);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        TweenService:Create(u35, TweenInfo.new(0.8166666666666667, Enum.EasingStyle.Linear), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.8166666666666667, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
        task.wait(1.1833333333333333);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        u35.MaxVisibleGraphemes = 0;
        u35.TextTransparency = 0;
        u35.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        u35.Text = "Soccer Game..";
        TweenService:Create(u35, TweenInfo.new(0.19166666666666668, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #u35.Text
        }):Play();
        task.wait(0.38333333333333336);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        TweenService:Create(u35, TweenInfo.new(0.5166666666666667, Enum.EasingStyle.Linear), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.5166666666666667, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
    end);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local u36 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
        FieldOfView = 20
    });
    u36:Play();
    task.delay(0.05, function() -- Line: 372
        -- upvalues: Folder (copy), Debris (ref), u19 (copy), u36 (ref), TweenService (ref), workspace_CurrentCamera (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        u36 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(2.7491666666666665, Enum.EasingStyle.Back), {
            FieldOfView = 55
        });
        u36:Play();
        task.wait(2.7491666666666665);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        u36 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(2.3, Enum.EasingStyle.Back), {
            FieldOfView = 40
        });
        u36:Play();
        task.wait(2.3);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        u36 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Back), {
            FieldOfView = 100
        });
        u36:Play();
        task.wait(0.016666666666666666);

        if Folder:GetAttribute("Active") and Debris:FindFirstChild(u19) ~= nil then
        end;
    end);
    local camera = workspace:FindFirstChild("AwakeningCam"):FindFirstChild("camera");
    local u37 = script.camera:Clone();
    u37.CFrame = camera.CFrame;
    u37.Parent = Folder;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = u37;
    WeldConstraint.Part1 = camera;
    WeldConstraint.Parent = u37;
    task.delay(8, function() -- Line: 87
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

    for _, v in { u37.A0.g, u37.A0.h, u37.A0.i } do
        v.Enabled = true;
        v.Transparency = NumberSequence.new(1, 1);
        task.delay(4.383333333333334, function() -- Line: 414
            -- upvalues: Folder (copy), Debris (ref), u19 (copy), v (copy), u22 (ref), RunService (ref), TweenService (ref)
            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
                return;
            end;

            local u38 = v;
            local u39 = 1;
            local u40 = nil;
            local os_clock_ret = os.clock();
            local u41 = nil;
            local u42 = 0.25;
            local u43 = 1;
            local u44 = 0.8;
            u41 = RunService.Heartbeat:Connect(function(p45) -- Line: 107
                -- upvalues: u40 (ref), os_clock_ret (copy), u42 (copy), TweenService (ref), u39 (ref), u43 (copy), u44 (copy), u38 (copy), u41 (ref)
                u40 = (os.clock() - os_clock_ret) / u42;
                u40 = TweenService:GetValue(u40, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                u39 = u43 + (u44 - u43) * u40;
                u38.Transparency = NumberSequence.new(u39, u39);

                if u42 <= os.clock() - os_clock_ret then
                    u41:Disconnect();
                end;
            end);
            table.insert(u22, u41);
            task.wait(0.25);

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
                return;
            end;

            local u46 = v;
            local u47 = 0.8;
            local u48 = nil;
            local os_clock_ret2 = os.clock();
            local u49 = nil;
            local u50 = 0.6666666666666666;
            local u51 = 0.8;
            local u52 = 1;
            u49 = RunService.Heartbeat:Connect(function(p53) -- Line: 107
                -- upvalues: u48 (ref), os_clock_ret2 (copy), u50 (copy), TweenService (ref), u47 (ref), u51 (copy), u52 (copy), u46 (copy), u49 (ref)
                u48 = (os.clock() - os_clock_ret2) / u50;
                u48 = TweenService:GetValue(u48, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                u47 = u51 + (u52 - u51) * u48;
                u46.Transparency = NumberSequence.new(u47, u47);

                if u50 <= os.clock() - os_clock_ret2 then
                    u49:Disconnect();
                end;
            end);
            table.insert(u22, u49);
        end);
    end;

    local v54 = script.Folder.CutsceneBG:Clone();
    v54:PivotTo(HumanoidRootPart.CFrame * CFrame.Angles(0, 3.6651914291880923, 0));
    v54.Parent = Folder;
    v54.Field.Flower.ParticleEmitter:Emit(200);
    local u55 = script.UserVFX:Clone();
    u55.Parent = Folder;

    for _, child in u55:GetChildren() do
        local v56 = Char:FindFirstChild(child.Name);

        if v56 then
            child.CFrame = v56.CFrame;
            local WeldConstraint2 = Instance.new("WeldConstraint");
            WeldConstraint2.Part0 = child;
            WeldConstraint2.Part1 = v56;
            WeldConstraint2.Parent = child;
        end;
    end;

    for _, descendant in u55.Head:GetDescendants() do
        if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "Eye" then
            descendant:Emit(descendant:GetAttribute("EmitCount"));
            descendant.Enabled = true;
        end;
    end;

    task.delay(0.08333333333333333, function() -- Line: 475
        -- upvalues: Folder (copy), Debris (ref), u19 (copy)
        if Folder:GetAttribute("Active") and Debris:FindFirstChild(u19) ~= nil then
        end;
    end);
    task.delay(0.25, function() -- Line: 480
        -- upvalues: Folder (copy), Debris (ref), u19 (copy), u55 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        for _, descendant in u55:GetDescendants() do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Lines" then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.5833333333333334, function() -- Line: 490
        -- upvalues: Folder (copy), Debris (ref), u19 (copy), u55 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        for _, descendant in u55:GetDescendants() do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Lines" then
                task.spawn(function() -- Line: 495
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end);
    task.delay(3.8, function() -- Line: 504
        -- upvalues: Folder (copy), Debris (ref), u19 (copy), u55 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        for _, descendant in u55.Head:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(5.033333333333333, function() -- Line: 515
        -- upvalues: Folder (copy), Debris (ref), u19 (copy), Char (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        task.wait(0.03333333333333333);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        for _, descendant in Char:GetDescendants() do
            if descendant.Name == "Phone" and descendant:IsA("MeshPart") then
                descendant.Transparency = 1;
            end;
        end;
    end);
    task.delay(5.633333333333334, function() -- Line: 531
        -- upvalues: Folder (copy), Debris (ref), u19 (copy)
        if Folder:GetAttribute("Active") and Debris:FindFirstChild(u19) ~= nil then
        end;
    end);
    task.delay(5.883333333333334, function() -- Line: 538
        -- upvalues: Folder (copy), Debris (ref), u19 (copy), u55 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        (function(p57, p58, u59, u60, p61, u62) -- Line: 542, Name: ColorCorrectionEffect
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Saturation = p57;
            ColorCorrectionEffect.Contrast = p58;
            ColorCorrectionEffect.Parent = game:GetService("Lighting");
            task.delay(p61, function() -- Line: 548
                -- upvalues: ColorCorrectionEffect (copy), u59 (copy), u60 (copy), u62 (copy)
                ColorCorrectionEffect.Saturation = u59;
                ColorCorrectionEffect.Contrast = u60;
                task.wait(u62);
                ColorCorrectionEffect:Destroy();
            end);
        end)(-1, -3, -1, 3, 0.04, 0.09);
        task.wait(0.016666666666666666);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u19) == nil then
            return;
        end;

        for _, descendant in u55:GetDescendants() do
            if descendant:IsA("ParticleEmitter") and descendant.Name ~= "Lines" then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
                descendant.Enabled = true;
            elseif descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);

    local function v66() -- Line: 583
        -- upvalues: u22 (ref), Folder (copy), u23 (ref), u36 (ref), u32 (copy), u35 (ref), u33 (ref), u31 (copy), u34 (ref), Atmosphere (copy), Density (copy), Haze (copy), Color (copy), Decay (copy), Offset (copy), ColorCorrection (copy), TintColor (copy), Vignette (copy), u21 (copy), TweenService (ref), workspace_CurrentCamera (copy), FieldOfView (copy)
        for _, v in u22 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            local u63 = Folder;
            task.delay(4, function() -- Line: 87
                -- upvalues: u63 (copy)
                if typeof(u63) == "table" then
                    for _, v in u63 do
                        if v then
                            v:Destroy();
                        end;
                    end;

                    return;
                end;

                if u63 then
                    u63:Destroy();
                end;
            end);
            EnableVFX(Folder, false);

            for _, descendant in Folder:GetDescendants() do
                if descendant:IsA("Part") or (descendant:IsA("MeshPart") or (descendant:IsA("BasePart") or (descendant:IsA("Texture") or descendant:IsA("Decal")))) then
                    descendant.Transparency = 1;
                end;
            end;
        end;

        for _, v in u23 do
            v:Pause();
        end;

        if u36 then
            u36:Pause();
        end;

        if u32 then
            u32:Destroy();
        end;

        if u35 then
            u35:Destroy();
        end;

        if u33 then
            u33:Pause();
        end;

        if u31 then
            u31:Destroy();
        end;

        if u34 then
            u34:Pause();
        end;

        task.spawn(function() -- Line: 630
            -- upvalues: Atmosphere (ref), Density (ref), Haze (ref), Color (ref), Decay (ref), Offset (ref), ColorCorrection (ref), TintColor (ref), Vignette (ref)
            for i = 1, 4 do
                Atmosphere.Density = Density;
                Atmosphere.Haze = Haze;
                Atmosphere.Color = Color;
                Atmosphere.Decay = Decay;
                Atmosphere.Offset = Offset;
                ColorCorrection.TintColor = TintColor;
                local v64;

                if Vignette then
                    v64 = i;

                    for _, v in {
                        Vignette.Vignette,
                        Vignette.Vignette.LL,
                        Vignette.Vignette.UR,
                        Vignette.Vignette.LL.LR
                    } do
                        v.ImageTransparency = 1;
                    end;
                else
                    v64 = i;
                end;

                task.wait(0.05);
            end;
        end);

        if u21 then
            local v65 = TweenService:Create(u21, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                Volume = 0
            });
            v65:Play();
            v65.Completed:Once(function() -- Line: 656
                -- upvalues: u21 (ref)
                u21:Destroy();
            end);
        end;

        workspace_CurrentCamera.FieldOfView = FieldOfView;
        table.clear(u23);
        table.clear(u22);
        u22 = nil;
        u23 = nil;
    end;

    table.insert(u22, Folder.Destroying:Connect(v66));
    table.insert(u22, Folder.AttributeChanged:Connect(v66));
end;