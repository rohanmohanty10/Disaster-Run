  

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
    local CutsceneData, v2 = MoonCutsceneStreamer.getCutsceneData("KingFeast");

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

    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);
    SoundManager.SpawnSound("Twisted Path", 0.6, workspace, 150);
    local EnemyChar1 = p1.EnemyChar1;
    local EnemyChar2 = p1.EnemyChar2;
    local EnemyChar3 = p1.EnemyChar3;

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

    if EnemyChar3 then
        EnemyChar3.Archivable = true;
        EnemyChar3 = EnemyChar3:Clone();
        EnemyChar3.HumanoidRootPart.Anchored = true;
        EnemyChar3:PivotTo(Char.HumanoidRootPart.CFrame);
        EnemyChar3.Parent = workspace;
    end;

    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    local u4 = true;
    task.spawn(function() -- Line: 84
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
    local v5 = RunService.PostSimulation:Connect(function() -- Line: 108
        -- upvalues: HumanoidRootPart (copy), Pivot2 (copy)
        HumanoidRootPart:PivotTo(Pivot2);
    end);
    local CameraSubject = workspace.CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = u3;
    local u6 = Moonlite.CreatePlayer(CutsceneData, u3);
    local v7 = {};

    for _, child in u3.mainchar:GetChildren() do
        local v8 = Char:FindFirstChild(child.Name);

        if v8 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v8;
                table.insert(v7, child2);
            end;
        end;
    end;

    u3.mainchar:Destroy();

    if EnemyChar1 then
        u3.char2:Destroy();
    end;

    if EnemyChar2 then
        u3.char3:Destroy();
    end;

    if EnemyChar3 then
        u3.char4:Destroy();
    end;

    if u6._moduleInfo and Char then
        for i, v in u6._moduleInfo.Compiled do
            local v9 = v.Path or i;

            if v9.InstanceNames[2] == "mainchar" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, Char);
            elseif EnemyChar1 and v9.InstanceNames[2] == "char2" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, EnemyChar1);
            elseif EnemyChar2 and v9.InstanceNames[2] == "char3" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, EnemyChar2);
            elseif EnemyChar3 and v9.InstanceNames[2] == "char4" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, EnemyChar3);
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

    local function timestampToFrame(p10) -- Line: 184
        local v11, v12 = p10:match("^(%d+):(%d+)$");

        return not (v11 and v12) and (tonumber(p10) or 0) or tonumber(v11) + tonumber(v12) / 1000;
    end;

    local function showCutsceneText(p13: string, u14: number, u15: string, u16) -- Line: 193
        -- upvalues: ReplicatedStorage (ref), Players (ref), TweenService (ref), Debris (ref)
        local v17, v18 = p13:match("^(%d+):(%d+)$");
        local v19;

        if v17 and v18 then
            v19 = tonumber(v17) + tonumber(v18) / 1000;
        else
            v19 = tonumber(p13) or 0;
        end;

        print(v19);
        task.delay(v19, function() -- Line: 196
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
            task.delay(u14, function() -- Line: 226
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
                    task.spawn(function() -- Line: 247
                        -- upvalues: child2 (copy), RunService (ref)
                        local v22 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v22);
                        child2.ImageTransparency = 0.999;
                        local v23 = RunService.PreRender:Connect(function() -- Line: 253
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
        Camera.Changed:Connect(function(p24: string) -- Line: 279
            -- upvalues: Camera (copy)
            if p24 ~= "CFrame" and p24 ~= "FieldOfView" then
                return;
            end;

            workspace.CurrentCamera[p24] = Camera[p24];
        end);
    end;

    local v25, v26 = ("0:05"):match("^(%d+):(%d+)$");
    local v27;

    if v25 and v26 then
        v27 = tonumber(v25) + tonumber(v26) / 1000;
    else
        v27 = tonumber("0:05") or 0;
    end;

    print(v27);
    local u28 = "I can see it, I can feel it!";
    local u29 = nil;
    local u30 = 1.6;
    task.delay(v27, function() -- Line: 196
        -- upvalues: ReplicatedStorage (ref), Players (ref), u28 (copy), u29 (copy), TweenService (ref), u30 (copy), Debris (ref)
        local u31 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u31.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u31.Position = UDim2.new(0.5, 0, 0.8, 0);
        u31.AnchorPoint = Vector2.new(0.5, 0.5);
        u31.Size = UDim2.new(1, 0, 0.1, 0);
        u31.BackgroundTransparency = 1;
        u31.Font = Enum.Font.ArialBold;
        u31.Text = u28;
        u31.TextColor3 = u29 or Color3.new(1, 1, 1);
        u31.TextTransparency = 0;
        u31.TextStrokeTransparency = 0;
        u31.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u31;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u31, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u28
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u30, function() -- Line: 226
            -- upvalues: TweenService (ref), u31 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u31, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u31, 1);
        end);
    end);
    local v32, v33 = ("2:21"):match("^(%d+):(%d+)$");
    local v34;

    if v32 and v33 then
        v34 = tonumber(v32) + tonumber(v33) / 1000;
    else
        v34 = tonumber("2:21") or 0;
    end;

    print(v34);
    local u35 = "Now that I know defeat..";
    local u36 = nil;
    local u37 = 1;
    task.delay(v34, function() -- Line: 196
        -- upvalues: ReplicatedStorage (ref), Players (ref), u35 (copy), u36 (copy), TweenService (ref), u37 (copy), Debris (ref)
        local u38 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u38.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u38.Position = UDim2.new(0.5, 0, 0.8, 0);
        u38.AnchorPoint = Vector2.new(0.5, 0.5);
        u38.Size = UDim2.new(1, 0, 0.1, 0);
        u38.BackgroundTransparency = 1;
        u38.Font = Enum.Font.ArialBold;
        u38.Text = u35;
        u38.TextColor3 = u36 or Color3.new(1, 1, 1);
        u38.TextTransparency = 0;
        u38.TextStrokeTransparency = 0;
        u38.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u38;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u38, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u35
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u37, function() -- Line: 226
            -- upvalues: TweenService (ref), u38 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u38, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u38, 1);
        end);
    end);
    local v39, v40 = ("3:51"):match("^(%d+):(%d+)$");
    local v41;

    if v39 and v40 then
        v41 = tonumber(v39) + tonumber(v40) / 1000;
    else
        v41 = tonumber("3:51") or 0;
    end;

    print(v41);
    local u42 = "what I need to find is..";
    local u43 = nil;
    local u44 = 1;
    task.delay(v41, function() -- Line: 196
        -- upvalues: ReplicatedStorage (ref), Players (ref), u42 (copy), u43 (copy), TweenService (ref), u44 (copy), Debris (ref)
        local u45 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u45.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u45.Position = UDim2.new(0.5, 0, 0.8, 0);
        u45.AnchorPoint = Vector2.new(0.5, 0.5);
        u45.Size = UDim2.new(1, 0, 0.1, 0);
        u45.BackgroundTransparency = 1;
        u45.Font = Enum.Font.ArialBold;
        u45.Text = u42;
        u45.TextColor3 = u43 or Color3.new(1, 1, 1);
        u45.TextTransparency = 0;
        u45.TextStrokeTransparency = 0;
        u45.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u45;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u45, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u42
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u44, function() -- Line: 226
            -- upvalues: TweenService (ref), u45 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u45, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u45, 1);
        end);
    end);
    local v46, v47 = ("5:09"):match("^(%d+):(%d+)$");
    local v48;

    if v46 and v47 then
        v48 = tonumber(v46) + tonumber(v47) / 1000;
    else
        v48 = tonumber("5:09") or 0;
    end;

    print(v48);
    local u49 = "the route that exists for my goal..";
    local u50 = nil;
    local u51 = 1.2;
    task.delay(v48, function() -- Line: 196
        -- upvalues: ReplicatedStorage (ref), Players (ref), u49 (copy), u50 (copy), TweenService (ref), u51 (copy), Debris (ref)
        local u52 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u52.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u52.Position = UDim2.new(0.5, 0, 0.8, 0);
        u52.AnchorPoint = Vector2.new(0.5, 0.5);
        u52.Size = UDim2.new(1, 0, 0.1, 0);
        u52.BackgroundTransparency = 1;
        u52.Font = Enum.Font.ArialBold;
        u52.Text = u49;
        u52.TextColor3 = u50 or Color3.new(1, 1, 1);
        u52.TextTransparency = 0;
        u52.TextStrokeTransparency = 0;
        u52.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u52;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u52, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u49
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u51, function() -- Line: 226
            -- upvalues: TweenService (ref), u52 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u52, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u52, 1);
        end);
    end);
    local v53, v54 = ("7:46"):match("^(%d+):(%d+)$");
    local v55;

    if v53 and v54 then
        v55 = tonumber(v53) + tonumber(v54) / 1000;
    else
        v55 = tonumber("7:46") or 0;
    end;

    print(v55);
    local u56 = "is this... Twisted Path!";
    local u57 = nil;
    local u58 = 3;
    task.delay(v55, function() -- Line: 196
        -- upvalues: ReplicatedStorage (ref), Players (ref), u56 (copy), u57 (copy), TweenService (ref), u58 (copy), Debris (ref)
        local u59 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u59.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u59.Position = UDim2.new(0.5, 0, 0.8, 0);
        u59.AnchorPoint = Vector2.new(0.5, 0.5);
        u59.Size = UDim2.new(1, 0, 0.1, 0);
        u59.BackgroundTransparency = 1;
        u59.Font = Enum.Font.ArialBold;
        u59.Text = u56;
        u59.TextColor3 = u57 or Color3.new(1, 1, 1);
        u59.TextTransparency = 0;
        u59.TextStrokeTransparency = 0;
        u59.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u59;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u59, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u56
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u58, function() -- Line: 226
            -- upvalues: TweenService (ref), u59 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u59, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u59, 1);
        end);
    end);
    u6:Play();
    local u60 = nil;
    u60 = RunService.PostSimulation:Connect(function() -- Line: 297
        -- upvalues: u6 (copy), u60 (ref)
        if u6.CurrentFrame >= 1100 then
            u6:Stop(0);

            if u60 then
                u60:Disconnect();
                u60 = nil;
            end;
        end;
    end);
    u6.Completed:Wait();

    if u60 then
        u60:Disconnect();
        u60 = nil;
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

    if EnemyChar3 then
        EnemyChar3:Destroy();
    end;

    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = true;
    HumanoidRootPart.Massless = true;
    task.wait();
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = false;
    HumanoidRootPart.Massless = false;
end;