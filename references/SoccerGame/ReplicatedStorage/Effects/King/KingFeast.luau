  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local MoonCutsceneStreamer = require(ReplicatedStorage2.Shared.MoonCutsceneStreamer);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Moonlite = require(ReplicatedStorage.Shared.Moonlite);

return function(p1) -- Line: 19
    -- upvalues: MoonCutsceneStreamer (copy), SpectatorController (copy), SoundManager (copy), Knit (copy), Players (copy), RunService (copy), Moonlite (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy)
    local CutsceneData, v2 = MoonCutsceneStreamer.getCutsceneData("KingTwistedPath");

    if not (CutsceneData and v2) then
        warn("how did this happen. no cutscene data");

        return;
    end;

    local u3 = v2.VFX:Clone();

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    if game.Players.LocalPlayer.Character ~= Char and game.Players.LocalPlayer.Character.Values.Goalie.Value then
        return;
    end;

    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local Humanoid = Char:FindFirstChild("Humanoid");

    if not Humanoid then
        return;
    end;

    local EnemyChar1 = p1.EnemyChar1;
    local EnemyChar2 = p1.EnemyChar2;

    if EnemyChar1 then
        EnemyChar1.Archivable = true;
        EnemyChar1 = EnemyChar1:Clone();
        EnemyChar1.HumanoidRootPart.Anchored = true;
        EnemyChar1:PivotTo(Char.HumanoidRootPart.CFrame);
        EnemyChar1.Parent = workspace;
    end;

    if EnemyChar2 then
        EnemyChar2.Archivable = true;
        EnemyChar2 = EnemyChar2:Clone();
        EnemyChar2.HumanoidRootPart.Anchored = true;
        EnemyChar2:PivotTo(Char.HumanoidRootPart.CFrame);
        EnemyChar2.Parent = workspace;
    end;

    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);
    SoundManager.SpawnSound("KingFeastJune", 0.6, workspace, 150);
    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    local u4 = true;
    task.spawn(function() -- Line: 73
        -- upvalues: Char (copy), u3 (copy), u4 (ref), Controller (copy), Players (ref)
        local Character = game.Players.LocalPlayer.Character;

        if not Character.Values.Goalie.Value or Char == Character then
            while u4 do
                task.wait();

                if workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                end;

                Controller.Cutscene = true;
                Players.LocalPlayer.PlayerGui.InGameUI.Enabled = false;
            end;

            return;
        end;

        local Cam = u3:FindFirstChild("Cam");

        if Cam then
            Cam:Destroy();
        end;
    end);
    local Pivot = u3:GetPivot();
    local Pivot2 = HumanoidRootPart:GetPivot();
    u3:PivotTo(Pivot2);
    local v5 = RunService.PostSimulation:Connect(function() -- Line: 97
        -- upvalues: HumanoidRootPart (copy), Pivot2 (copy)
        HumanoidRootPart:PivotTo(Pivot2);
    end);
    local CameraSubject = workspace.CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = u3;
    local u6 = Moonlite.CreatePlayer(CutsceneData, u3);
    local v7 = {};

    for _, child in u3.devhamzast:GetChildren() do
        local v8 = Char:FindFirstChild(child.Name);

        if v8 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v8;
                table.insert(v7, child2);
            end;
        end;
    end;

    u3.devhamzast:Destroy();

    if EnemyChar1 then
        u3.char2:Destroy();
    end;

    if EnemyChar2 then
        u3.char33:Destroy();
    end;

    if u6._moduleInfo and Char then
        for i, v in u6._moduleInfo.Compiled do
            local v9 = v.Path or i;

            if v9.InstanceNames[2] == "devhamzast" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, Char);
            elseif EnemyChar1 and v9.InstanceNames[2] == "char2" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, EnemyChar1);
            elseif EnemyChar2 and v9.InstanceNames[2] == "char33" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, EnemyChar2);
            end;

            local CFrame = v.Props.CFrame;

            if CFrame and v9.ItemType ~= "Attachment" then
                CFrame.Default = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(CFrame.Default));

                for _, v3 in CFrame.Sequence do
                    v3.Value = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(v3.Value));
                end;
            end;
        end;
    end;

    u6:Compile();

    local function timestampToFrame(p10) -- Line: 169
        local v11, v12 = p10:match("^(%d+):(%d+)$");

        return not (v11 and v12) and (tonumber(p10) or 0) or tonumber(v11) + tonumber(v12) / 1000;
    end;

    local function showCutsceneText(p13: string, u14: number, u15: string, u16) -- Line: 178
        -- upvalues: ReplicatedStorage (ref), Players (ref), TweenService (ref), Debris (ref)
        local v17, v18 = p13:match("^(%d+):(%d+)$");
        local v19;

        if v17 and v18 then
            v19 = tonumber(v17) + tonumber(v18) / 1000;
        else
            v19 = tonumber(p13) or 0;
        end;

        task.delay(v19, function() -- Line: 180
            -- upvalues: ReplicatedStorage (ref), Players (ref), u15 (copy), u16 (copy), TweenService (ref), u14 (copy), Debris (ref)
            local u20 = ReplicatedStorage.Assets.UI.Popup:Clone();
            u20.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
            u20.Position = UDim2.new(0.5, 0, 0.8, 0);
            u20.AnchorPoint = Vector2.new(0.5, 0.5);
            u20.Size = UDim2.new(1, 0, 0.1, 0);
            u20.BackgroundTransparency = 1;
            u20.Font = Enum.Font.ArialBold;
            u20.Text = u15;
            u20.TextColor3 = u16 or Color3.new(1, 1, 1);
            u20.TextTransparency = 0;
            u20.TextStrokeTransparency = 0;
            u20.MaxVisibleGraphemes = 0;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Parent = u20;
            UIStroke.Thickness = 4;
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
            UIStroke.Color = Color3.new(0, 0, 0);
            UIStroke.Transparency = 1;
            TweenService:Create(u20, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                TextTransparency = 0,
                TextStrokeTransparency = 0,
                MaxVisibleGraphemes = #u15
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                Transparency = 0
            }):Play();
            task.delay(u14, function() -- Line: 210
                -- upvalues: TweenService (ref), u20 (copy), UIStroke (copy), Debris (ref)
                TweenService:Create(u20, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1
                }):Play();
                TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
                Debris:AddItem(u20, 1);
            end);
        end);
    end;

    for _, child in u3:GetChildren() do
        local v21;

        if child:IsA("LayerCollector") then
            v21 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 233
                        -- upvalues: child2 (copy), RunService (ref)
                        local v22 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v22);
                        child2.ImageTransparency = 0.999;
                        local v23 = RunService.PreRender:Connect(function() -- Line: 239
                            -- upvalues: child2 (ref)
                            child2.Visible = true;
                        end);

                        while not child2.IsLoaded and child2:IsDescendantOf(game) do
                            task.wait();
                        end;

                        v23:Disconnect();
                        child2.Visible = false;
                        child2.ImageTransparency = 0;
                    end);
                end;
            end;

            v21.Parent = Players.LocalPlayer.PlayerGui;
        elseif child:IsA("PostEffect") then
            child.Parent = workspace.CurrentCamera;
            v21 = child;
        else
            v21 = child;
        end;

        table.insert(v7, v21);
    end;

    u3.Parent = workspace;
    local Character = game.Players.LocalPlayer.Character;

    if not Character.Values.Goalie.Value or Char == Character then
        Camera.Changed:Connect(function(p24: string) -- Line: 265
            -- upvalues: Camera (copy)
            if p24 ~= "CFrame" and p24 ~= "FieldOfView" then
                return;
            end;

            workspace.CurrentCamera[p24] = Camera[p24];
        end);
    end;

    local Color3_fromRGB_ret = Color3.fromRGB(8, 119, 255);
    local v25, v26 = ("0:07"):match("^(%d+):(%d+)$");
    local v27;

    if v25 and v26 then
        v27 = tonumber(v25) + tonumber(v26) / 1000;
    else
        v27 = tonumber("0:07") or 0;
    end;

    local u28 = "What, you?";
    local u29 = 1;
    task.delay(v27, function() -- Line: 180
        -- upvalues: ReplicatedStorage (ref), Players (ref), u28 (copy), Color3_fromRGB_ret (copy), TweenService (ref), u29 (copy), Debris (ref)
        local u30 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u30.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u30.Position = UDim2.new(0.5, 0, 0.8, 0);
        u30.AnchorPoint = Vector2.new(0.5, 0.5);
        u30.Size = UDim2.new(1, 0, 0.1, 0);
        u30.BackgroundTransparency = 1;
        u30.Font = Enum.Font.ArialBold;
        u30.Text = u28;
        u30.TextColor3 = Color3_fromRGB_ret or Color3.new(1, 1, 1);
        u30.TextTransparency = 0;
        u30.TextStrokeTransparency = 0;
        u30.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u30;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u30, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u28
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u29, function() -- Line: 210
            -- upvalues: TweenService (ref), u30 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u30, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u30, 1);
        end);
    end);
    local Color3_fromRGB_ret2 = Color3.fromRGB(0, 255, 0);
    local v31, v32 = ("1:42"):match("^(%d+):(%d+)$");
    local v33;

    if v31 and v32 then
        v33 = tonumber(v31) + tonumber(v32) / 1000;
    else
        v33 = tonumber("1:42") or 0;
    end;

    local u34 = "Why are you here?";
    local u35 = 1;
    task.delay(v33, function() -- Line: 180
        -- upvalues: ReplicatedStorage (ref), Players (ref), u34 (copy), Color3_fromRGB_ret2 (copy), TweenService (ref), u35 (copy), Debris (ref)
        local u36 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u36.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u36.Position = UDim2.new(0.5, 0, 0.8, 0);
        u36.AnchorPoint = Vector2.new(0.5, 0.5);
        u36.Size = UDim2.new(1, 0, 0.1, 0);
        u36.BackgroundTransparency = 1;
        u36.Font = Enum.Font.ArialBold;
        u36.Text = u34;
        u36.TextColor3 = Color3_fromRGB_ret2 or Color3.new(1, 1, 1);
        u36.TextTransparency = 0;
        u36.TextStrokeTransparency = 0;
        u36.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u36;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u36, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u34
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u35, function() -- Line: 210
            -- upvalues: TweenService (ref), u36 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u36, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u36, 1);
        end);
    end);
    local Color3_fromRGB_ret3 = Color3.fromRGB(0, 255, 0);
    local v37, v38 = ("2:51"):match("^(%d+):(%d+)$");
    local v39;

    if v37 and v38 then
        v39 = tonumber(v37) + tonumber(v38) / 1000;
    else
        v39 = tonumber("2:51") or 0;
    end;

    local u40 = "Isn\'t that No.11 the only one..";
    local u41 = 1.1;
    task.delay(v39, function() -- Line: 180
        -- upvalues: ReplicatedStorage (ref), Players (ref), u40 (copy), Color3_fromRGB_ret3 (copy), TweenService (ref), u41 (copy), Debris (ref)
        local u42 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u42.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u42.Position = UDim2.new(0.5, 0, 0.8, 0);
        u42.AnchorPoint = Vector2.new(0.5, 0.5);
        u42.Size = UDim2.new(1, 0, 0.1, 0);
        u42.BackgroundTransparency = 1;
        u42.Font = Enum.Font.ArialBold;
        u42.Text = u40;
        u42.TextColor3 = Color3_fromRGB_ret3 or Color3.new(1, 1, 1);
        u42.TextTransparency = 0;
        u42.TextStrokeTransparency = 0;
        u42.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u42;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u42, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u40
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u41, function() -- Line: 210
            -- upvalues: TweenService (ref), u42 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u42, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u42, 1);
        end);
    end);
    local Color3_fromRGB_ret4 = Color3.fromRGB(0, 255, 0);
    local v43, v44 = ("4:23"):match("^(%d+):(%d+)$");
    local v45;

    if v43 and v44 then
        v45 = tonumber(v43) + tonumber(v44) / 1000;
    else
        v45 = tonumber("4:23") or 0;
    end;

    local u46 = "that you want to devour?";
    local u47 = 2.8;
    task.delay(v45, function() -- Line: 180
        -- upvalues: ReplicatedStorage (ref), Players (ref), u46 (copy), Color3_fromRGB_ret4 (copy), TweenService (ref), u47 (copy), Debris (ref)
        local u48 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u48.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u48.Position = UDim2.new(0.5, 0, 0.8, 0);
        u48.AnchorPoint = Vector2.new(0.5, 0.5);
        u48.Size = UDim2.new(1, 0, 0.1, 0);
        u48.BackgroundTransparency = 1;
        u48.Font = Enum.Font.ArialBold;
        u48.Text = u46;
        u48.TextColor3 = Color3_fromRGB_ret4 or Color3.new(1, 1, 1);
        u48.TextTransparency = 0;
        u48.TextStrokeTransparency = 0;
        u48.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u48;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u48, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u46
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u47, function() -- Line: 210
            -- upvalues: TweenService (ref), u48 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u48, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u48, 1);
        end);
    end);
    local v49, v50 = ("7:42"):match("^(%d+):(%d+)$");
    local v51;

    if v49 and v50 then
        v51 = tonumber(v49) + tonumber(v50) / 1000;
    else
        v51 = tonumber("7:42") or 0;
    end;

    local u52 = "I\'ll feast on you Isagi..";
    local u53 = nil;
    local u54 = 2.6;
    task.delay(v51, function() -- Line: 180
        -- upvalues: ReplicatedStorage (ref), Players (ref), u52 (copy), u53 (copy), TweenService (ref), u54 (copy), Debris (ref)
        local u55 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u55.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u55.Position = UDim2.new(0.5, 0, 0.8, 0);
        u55.AnchorPoint = Vector2.new(0.5, 0.5);
        u55.Size = UDim2.new(1, 0, 0.1, 0);
        u55.BackgroundTransparency = 1;
        u55.Font = Enum.Font.ArialBold;
        u55.Text = u52;
        u55.TextColor3 = u53 or Color3.new(1, 1, 1);
        u55.TextTransparency = 0;
        u55.TextStrokeTransparency = 0;
        u55.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u55;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u55, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u52
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u54, function() -- Line: 210
            -- upvalues: TweenService (ref), u55 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u55, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u55, 1);
        end);
    end);
    local v56, v57 = ("10:35"):match("^(%d+):(%d+)$");
    local v58;

    if v56 and v57 then
        v58 = tonumber(v56) + tonumber(v57) / 1000;
    else
        v58 = tonumber("10:35") or 0;
    end;

    local u59 = "Your light..";
    local u60 = nil;
    local u61 = 1.6;
    task.delay(v58, function() -- Line: 180
        -- upvalues: ReplicatedStorage (ref), Players (ref), u59 (copy), u60 (copy), TweenService (ref), u61 (copy), Debris (ref)
        local u62 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u62.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u62.Position = UDim2.new(0.5, 0, 0.8, 0);
        u62.AnchorPoint = Vector2.new(0.5, 0.5);
        u62.Size = UDim2.new(1, 0, 0.1, 0);
        u62.BackgroundTransparency = 1;
        u62.Font = Enum.Font.ArialBold;
        u62.Text = u59;
        u62.TextColor3 = u60 or Color3.new(1, 1, 1);
        u62.TextTransparency = 0;
        u62.TextStrokeTransparency = 0;
        u62.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u62;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u62, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u59
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u61, function() -- Line: 210
            -- upvalues: TweenService (ref), u62 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u62, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u62, 1);
        end);
    end);
    local v63, v64 = ("12:22"):match("^(%d+):(%d+)$");
    local v65;

    if v63 and v64 then
        v65 = tonumber(v63) + tonumber(v64) / 1000;
    else
        v65 = tonumber("12:22") or 0;
    end;

    local u66 = "is mine!";
    local u67 = nil;
    local u68 = 3;
    task.delay(v65, function() -- Line: 180
        -- upvalues: ReplicatedStorage (ref), Players (ref), u66 (copy), u67 (copy), TweenService (ref), u68 (copy), Debris (ref)
        local u69 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u69.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u69.Position = UDim2.new(0.5, 0, 0.8, 0);
        u69.AnchorPoint = Vector2.new(0.5, 0.5);
        u69.Size = UDim2.new(1, 0, 0.1, 0);
        u69.BackgroundTransparency = 1;
        u69.Font = Enum.Font.ArialBold;
        u69.Text = u66;
        u69.TextColor3 = u67 or Color3.new(1, 1, 1);
        u69.TextTransparency = 0;
        u69.TextStrokeTransparency = 0;
        u69.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u69;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u69, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u66
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u68, function() -- Line: 210
            -- upvalues: TweenService (ref), u69 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u69, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u69, 1);
        end);
    end);
    u6:Play();
    local u70 = nil;
    u70 = RunService.PostSimulation:Connect(function() -- Line: 295
        -- upvalues: u6 (copy), u70 (ref)
        if u6.CurrentFrame >= 1100 then
            u6:Stop();

            if u70 then
                u70:Disconnect();
                u70 = nil;
            end;
        end;
    end);
    u6.Completed:Wait();

    if u70 then
        u70:Disconnect();
        u70 = nil;
    end;

    u4 = false;
    task.wait();
    v5:Disconnect();
    HumanoidRootPart:PivotTo(Pivot2);
    Controller.Cutscene = false;
    Players.LocalPlayer.Character.Values.InCutscene.Value = false;

    if Players.LocalPlayer.Team ~= game.Teams.Visitor then
        Players.LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    end;

    u6:Destroy();
    u3:Destroy();

    for _, v in v7 do
        v:Destroy();
    end;

    Camera:Destroy();
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    workspace.CurrentCamera.CameraSubject = CameraSubject;

    if EnemyChar1 then
        EnemyChar1:Destroy();
    end;

    if EnemyChar2 then
        EnemyChar2:Destroy();
    end;

    HumanoidRootPart.Massless = true;
    task.wait();
    HumanoidRootPart.Massless = false;
end;