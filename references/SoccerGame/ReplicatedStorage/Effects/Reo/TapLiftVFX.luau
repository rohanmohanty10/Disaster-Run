  

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
    -- upvalues: MoonCutsceneStreamer (copy), SpectatorController (copy), SoundManager (copy), Knit (copy), Players (copy), Moonlite (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy), RunService (copy)
    local CutsceneData, v2 = MoonCutsceneStreamer.getCutsceneData("NEL ReoTapLift");

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
    SoundManager.SpawnSound("NeoTapLift", 0.6, workspace, 150);
    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    local u4 = true;
    task.spawn(function() -- Line: 55
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
    HumanoidRootPart.Anchored = true;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame = workspace_CurrentCamera.CFrame;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = u3;
    local v5 = Moonlite.CreatePlayer(CutsceneData, u3);
    local v6 = {};

    for _, child in u3.amir_123445m:GetChildren() do
        local v7 = Char:FindFirstChild(child.Name);

        if v7 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v7;
                table.insert(v6, child2);
            end;
        end;
    end;

    u3.amir_123445m:Destroy();

    if v5._moduleInfo and Char then
        for i, v in v5._moduleInfo.Compiled do
            local v8 = v.Path or i;

            if v8.InstanceNames[2] == "amir_123445m" then
                local table_clone_ret = table.clone(v8);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, Char);
            end;

            local CFrame2 = v.Props.CFrame;

            if CFrame2 and v8.ItemType ~= "Attachment" then
                CFrame2.Default = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(CFrame2.Default));

                for _, v3 in CFrame2.Sequence do
                    v3.Value = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(v3.Value));
                end;
            end;
        end;
    end;

    v5:Compile();

    local function timestampToFrame(p9) -- Line: 131
        local v10, v11 = p9:match("^(%d+):(%d+)$");

        return not (v10 and v11) and (tonumber(p9) or 0) or tonumber(v10) + tonumber(v11) / 1000;
    end;

    local function showCutsceneText(p12: string, u13: number, u14: string, u15) -- Line: 140
        -- upvalues: ReplicatedStorage (ref), Players (ref), TweenService (ref), Debris (ref)
        local v16, v17 = p12:match("^(%d+):(%d+)$");
        local v18;

        if v16 and v17 then
            v18 = tonumber(v16) + tonumber(v17) / 1000;
        else
            v18 = tonumber(p12) or 0;
        end;

        task.delay(v18, function() -- Line: 143
            -- upvalues: ReplicatedStorage (ref), Players (ref), u14 (copy), u15 (copy), TweenService (ref), u13 (copy), Debris (ref)
            local u19 = ReplicatedStorage.Assets.UI.Popup:Clone();
            u19.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
            u19.Position = UDim2.new(0.5, 0, 0.8, 0);
            u19.AnchorPoint = Vector2.new(0.5, 0.5);
            u19.Size = UDim2.new(1, 0, 0.1, 0);
            u19.BackgroundTransparency = 1;
            u19.Font = Enum.Font.ArialBold;
            u19.Text = u14;
            u19.TextColor3 = u15 or Color3.new(1, 1, 1);
            u19.TextTransparency = 0;
            u19.TextStrokeTransparency = 0;
            u19.MaxVisibleGraphemes = 0;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Parent = u19;
            UIStroke.Thickness = 4;
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
            UIStroke.Color = Color3.new(0, 0, 0);
            UIStroke.Transparency = 1;
            TweenService:Create(u19, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                TextTransparency = 0,
                TextStrokeTransparency = 0,
                MaxVisibleGraphemes = #u14
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                Transparency = 0
            }):Play();
            task.delay(u13, function() -- Line: 173
                -- upvalues: TweenService (ref), u19 (copy), UIStroke (copy), Debris (ref)
                TweenService:Create(u19, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1
                }):Play();
                TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
                Debris:AddItem(u19, 1);
            end);
        end);
    end;

    for _, child in u3:GetChildren() do
        local v20;

        if child:IsA("LayerCollector") then
            v20 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 194
                        -- upvalues: child2 (copy), RunService (ref)
                        local v21 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v21);
                        child2.ImageTransparency = 0.999;
                        local v22 = RunService.PreRender:Connect(function() -- Line: 200
                            -- upvalues: child2 (ref)
                            child2.Visible = true;
                        end);

                        while not child2.IsLoaded and child2:IsDescendantOf(game) do
                            task.wait();
                        end;

                        v22:Disconnect();
                        child2.Visible = false;
                        child2.ImageTransparency = 0;
                    end);
                end;
            end;

            v20.Parent = Players.LocalPlayer.PlayerGui;
        elseif child:IsA("PostEffect") then
            child.Parent = workspace.CurrentCamera;
            v20 = child;
        else
            v20 = child;
        end;

        table.insert(v6, v20);
    end;

    u3.Parent = workspace;
    local Character = game.Players.LocalPlayer.Character;

    if not Character.Values.Goalie.Value or Char == Character then
        Camera.Changed:Connect(function(p23: string) -- Line: 226
            -- upvalues: Camera (copy)
            if p23 ~= "CFrame" and p23 ~= "FieldOfView" then
                return;
            end;

            workspace.CurrentCamera[p23] = Camera[p23];
        end);
    end;

    local v24, v25 = ("0:33"):match("^(%d+):(%d+)$");
    local v26;

    if v24 and v25 then
        v26 = tonumber(v24) + tonumber(v25) / 1000;
    else
        v26 = tonumber("0:33") or 0;
    end;

    local u27 = "No...";
    local u28 = nil;
    local u29 = 0.5;
    task.delay(v26, function() -- Line: 143
        -- upvalues: ReplicatedStorage (ref), Players (ref), u27 (copy), u28 (copy), TweenService (ref), u29 (copy), Debris (ref)
        local u30 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u30.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u30.Position = UDim2.new(0.5, 0, 0.8, 0);
        u30.AnchorPoint = Vector2.new(0.5, 0.5);
        u30.Size = UDim2.new(1, 0, 0.1, 0);
        u30.BackgroundTransparency = 1;
        u30.Font = Enum.Font.ArialBold;
        u30.Text = u27;
        u30.TextColor3 = u28 or Color3.new(1, 1, 1);
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
            MaxVisibleGraphemes = #u27
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u29, function() -- Line: 173
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
    local v31, v32 = ("1:29"):match("^(%d+):(%d+)$");
    local v33;

    if v31 and v32 then
        v33 = tonumber(v31) + tonumber(v32) / 1000;
    else
        v33 = tonumber("1:29") or 0;
    end;

    local u34 = "Do you know how many times I\'ve seen it?";
    local u35 = nil;
    local u36 = 2;
    task.delay(v33, function() -- Line: 143
        -- upvalues: ReplicatedStorage (ref), Players (ref), u34 (copy), u35 (copy), TweenService (ref), u36 (copy), Debris (ref)
        local u37 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u37.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u37.Position = UDim2.new(0.5, 0, 0.8, 0);
        u37.AnchorPoint = Vector2.new(0.5, 0.5);
        u37.Size = UDim2.new(1, 0, 0.1, 0);
        u37.BackgroundTransparency = 1;
        u37.Font = Enum.Font.ArialBold;
        u37.Text = u34;
        u37.TextColor3 = u35 or Color3.new(1, 1, 1);
        u37.TextTransparency = 0;
        u37.TextStrokeTransparency = 0;
        u37.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u37;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u37, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u34
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u36, function() -- Line: 173
            -- upvalues: TweenService (ref), u37 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u37, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u37, 1);
        end);
    end);
    local v38, v39 = ("4:7"):match("^(%d+):(%d+)$");
    local v40;

    if v38 and v39 then
        v40 = tonumber(v38) + tonumber(v39) / 1000;
    else
        v40 = tonumber("4:7") or 0;
    end;

    local u41 = "Instantly kill it.";
    local u42 = nil;
    local u43 = 1.2;
    task.delay(v40, function() -- Line: 143
        -- upvalues: ReplicatedStorage (ref), Players (ref), u41 (copy), u42 (copy), TweenService (ref), u43 (copy), Debris (ref)
        local u44 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u44.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u44.Position = UDim2.new(0.5, 0, 0.8, 0);
        u44.AnchorPoint = Vector2.new(0.5, 0.5);
        u44.Size = UDim2.new(1, 0, 0.1, 0);
        u44.BackgroundTransparency = 1;
        u44.Font = Enum.Font.ArialBold;
        u44.Text = u41;
        u44.TextColor3 = u42 or Color3.new(1, 1, 1);
        u44.TextTransparency = 0;
        u44.TextStrokeTransparency = 0;
        u44.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u44;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u44, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u41
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u43, function() -- Line: 173
            -- upvalues: TweenService (ref), u44 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u44, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u44, 1);
        end);
    end);
    local v45, v46 = ("7:27"):match("^(%d+):(%d+)$");
    local v47;

    if v45 and v46 then
        v47 = tonumber(v45) + tonumber(v46) / 1000;
    else
        v47 = tonumber("7:27") or 0;
    end;

    local u48 = "A lift tap. Into..";
    local u49 = nil;
    local u50 = 1;
    task.delay(v47, function() -- Line: 143
        -- upvalues: ReplicatedStorage (ref), Players (ref), u48 (copy), u49 (copy), TweenService (ref), u50 (copy), Debris (ref)
        local u51 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u51.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u51.Position = UDim2.new(0.5, 0, 0.8, 0);
        u51.AnchorPoint = Vector2.new(0.5, 0.5);
        u51.Size = UDim2.new(1, 0, 0.1, 0);
        u51.BackgroundTransparency = 1;
        u51.Font = Enum.Font.ArialBold;
        u51.Text = u48;
        u51.TextColor3 = u49 or Color3.new(1, 1, 1);
        u51.TextTransparency = 0;
        u51.TextStrokeTransparency = 0;
        u51.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u51;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u51, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u48
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u50, function() -- Line: 173
            -- upvalues: TweenService (ref), u51 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u51, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u51, 1);
        end);
    end);
    local v52, v53 = ("9:40"):match("^(%d+):(%d+)$");
    local v54;

    if v52 and v53 then
        v54 = tonumber(v52) + tonumber(v53) / 1000;
    else
        v54 = tonumber("9:40") or 0;
    end;

    local u55 = "..a jumping turn!";
    local u56 = nil;
    local u57 = 1;
    task.delay(v54, function() -- Line: 143
        -- upvalues: ReplicatedStorage (ref), Players (ref), u55 (copy), u56 (copy), TweenService (ref), u57 (copy), Debris (ref)
        local u58 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u58.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u58.Position = UDim2.new(0.5, 0, 0.8, 0);
        u58.AnchorPoint = Vector2.new(0.5, 0.5);
        u58.Size = UDim2.new(1, 0, 0.1, 0);
        u58.BackgroundTransparency = 1;
        u58.Font = Enum.Font.ArialBold;
        u58.Text = u55;
        u58.TextColor3 = u56 or Color3.new(1, 1, 1);
        u58.TextTransparency = 0;
        u58.TextStrokeTransparency = 0;
        u58.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u58;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u58, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u55
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u57, function() -- Line: 173
            -- upvalues: TweenService (ref), u58 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u58, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u58, 1);
        end);
    end);
    local v59, v60 = ("11:58"):match("^(%d+):(%d+)$");
    local v61;

    if v59 and v60 then
        v61 = tonumber(v59) + tonumber(v60) / 1000;
    else
        v61 = tonumber("11:58") or 0;
    end;

    local u62 = " I know this move better than anyone.";
    local u63 = nil;
    local u64 = 1;
    task.delay(v61, function() -- Line: 143
        -- upvalues: ReplicatedStorage (ref), Players (ref), u62 (copy), u63 (copy), TweenService (ref), u64 (copy), Debris (ref)
        local u65 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u65.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u65.Position = UDim2.new(0.5, 0, 0.8, 0);
        u65.AnchorPoint = Vector2.new(0.5, 0.5);
        u65.Size = UDim2.new(1, 0, 0.1, 0);
        u65.BackgroundTransparency = 1;
        u65.Font = Enum.Font.ArialBold;
        u65.Text = u62;
        u65.TextColor3 = u63 or Color3.new(1, 1, 1);
        u65.TextTransparency = 0;
        u65.TextStrokeTransparency = 0;
        u65.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u65;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u65, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u62
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u64, function() -- Line: 173
            -- upvalues: TweenService (ref), u65 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u65, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u65, 1);
        end);
    end);

    if math.random(1, 100) < 5 then
        local v66, v67 = ("13:48"):match("^(%d+):(%d+)$");
        local v68;

        if v66 and v67 then
            v68 = tonumber(v66) + tonumber(v67) / 1000;
        else
            v68 = tonumber("13:48") or 0;
        end;

        local u69 = "McNagi Fryshiro..";
        local u70 = nil;
        local u71 = 0.5;
        task.delay(v68, function() -- Line: 143
            -- upvalues: ReplicatedStorage (ref), Players (ref), u69 (copy), u70 (copy), TweenService (ref), u71 (copy), Debris (ref)
            local u72 = ReplicatedStorage.Assets.UI.Popup:Clone();
            u72.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
            u72.Position = UDim2.new(0.5, 0, 0.8, 0);
            u72.AnchorPoint = Vector2.new(0.5, 0.5);
            u72.Size = UDim2.new(1, 0, 0.1, 0);
            u72.BackgroundTransparency = 1;
            u72.Font = Enum.Font.ArialBold;
            u72.Text = u69;
            u72.TextColor3 = u70 or Color3.new(1, 1, 1);
            u72.TextTransparency = 0;
            u72.TextStrokeTransparency = 0;
            u72.MaxVisibleGraphemes = 0;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Parent = u72;
            UIStroke.Thickness = 4;
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
            UIStroke.Color = Color3.new(0, 0, 0);
            UIStroke.Transparency = 1;
            TweenService:Create(u72, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                TextTransparency = 0,
                TextStrokeTransparency = 0,
                MaxVisibleGraphemes = #u69
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                Transparency = 0
            }):Play();
            task.delay(u71, function() -- Line: 173
                -- upvalues: TweenService (ref), u72 (copy), UIStroke (copy), Debris (ref)
                TweenService:Create(u72, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1
                }):Play();
                TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
                Debris:AddItem(u72, 1);
            end);
        end);
    else
        local v73, v74 = ("13:48"):match("^(%d+):(%d+)$");
        local v75;

        if v73 and v74 then
            v75 = tonumber(v73) + tonumber(v74) / 1000;
        else
            v75 = tonumber("13:48") or 0;
        end;

        local u76 = "Nagi Seishiro..";
        local u77 = nil;
        local u78 = 0.5;
        task.delay(v75, function() -- Line: 143
            -- upvalues: ReplicatedStorage (ref), Players (ref), u76 (copy), u77 (copy), TweenService (ref), u78 (copy), Debris (ref)
            local u79 = ReplicatedStorage.Assets.UI.Popup:Clone();
            u79.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
            u79.Position = UDim2.new(0.5, 0, 0.8, 0);
            u79.AnchorPoint = Vector2.new(0.5, 0.5);
            u79.Size = UDim2.new(1, 0, 0.1, 0);
            u79.BackgroundTransparency = 1;
            u79.Font = Enum.Font.ArialBold;
            u79.Text = u76;
            u79.TextColor3 = u77 or Color3.new(1, 1, 1);
            u79.TextTransparency = 0;
            u79.TextStrokeTransparency = 0;
            u79.MaxVisibleGraphemes = 0;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Parent = u79;
            UIStroke.Thickness = 4;
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
            UIStroke.Color = Color3.new(0, 0, 0);
            UIStroke.Transparency = 1;
            TweenService:Create(u79, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                TextTransparency = 0,
                TextStrokeTransparency = 0,
                MaxVisibleGraphemes = #u76
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                Transparency = 0
            }):Play();
            task.delay(u78, function() -- Line: 173
                -- upvalues: TweenService (ref), u79 (copy), UIStroke (copy), Debris (ref)
                TweenService:Create(u79, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1
                }):Play();
                TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
                Debris:AddItem(u79, 1);
            end);
        end);
    end;

    local Color3_fromRGB_ret = Color3.fromRGB(140, 0, 255);
    local v80, v81 = ("14:5"):match("^(%d+):(%d+)$");
    local v82;

    if v80 and v81 then
        v82 = tonumber(v80) + tonumber(v81) / 1000;
    else
        v82 = tonumber("14:5") or 0;
    end;

    local u83 = "Copied!";
    local u84 = 1;
    task.delay(v82, function() -- Line: 143
        -- upvalues: ReplicatedStorage (ref), Players (ref), u83 (copy), Color3_fromRGB_ret (copy), TweenService (ref), u84 (copy), Debris (ref)
        local u85 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u85.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u85.Position = UDim2.new(0.5, 0, 0.8, 0);
        u85.AnchorPoint = Vector2.new(0.5, 0.5);
        u85.Size = UDim2.new(1, 0, 0.1, 0);
        u85.BackgroundTransparency = 1;
        u85.Font = Enum.Font.ArialBold;
        u85.Text = u83;
        u85.TextColor3 = Color3_fromRGB_ret or Color3.new(1, 1, 1);
        u85.TextTransparency = 0;
        u85.TextStrokeTransparency = 0;
        u85.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u85;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u85, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u83
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u84, function() -- Line: 173
            -- upvalues: TweenService (ref), u85 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u85, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u85, 1);
        end);
    end);
    v5:Play();
    local v86 = script.VFX:Clone();
    v86:PivotTo(Char.HumanoidRootPart.CFrame);
    local v87 = {};

    for _, child in v86:GetChildren() do
        table.insert(v87, child);
        child.Parent = workspace;
    end;

    require(script.Compile2)(v5);
    task.wait(16);
    v5:Stop();
    u4 = false;
    task.wait();
    Controller.Cutscene = false;
    Players.LocalPlayer.Character.Values.InCutscene.Value = false;

    if Players.LocalPlayer.Team ~= game.Teams.Visitor then
        Players.LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    end;

    v5:Destroy();
    u3:Destroy();
    v86:Destroy();

    for _, v in v87 do
        v:Destroy();
    end;

    for _, v in v6 do
        v:Destroy();
    end;

    Camera:Destroy();
    workspace.CurrentCamera.CFrame = CFrame;
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    workspace.CurrentCamera.CameraSubject = CameraSubject;
    HumanoidRootPart.Anchored = false;
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = true;
    HumanoidRootPart.Massless = true;
    task.wait();
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = false;
    HumanoidRootPart.Massless = false;
end;