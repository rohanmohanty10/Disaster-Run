  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local MoonCutsceneStreamer = require(ReplicatedStorage2.Shared.MoonCutsceneStreamer);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local CutsceneUtils = require(ReplicatedStorage2.Modules.CutsceneUtils);
local Moonlite = require(ReplicatedStorage.Shared.Moonlite);

local function changeLighting(p1) -- Line: 21
    -- upvalues: Lighting (copy)
    for _, child in Lighting:GetChildren() do
        child:Destroy();
    end;

    for i, v in p1:GetAttributes() do
        Lighting[i] = v;
    end;

    for _, child in p1:GetChildren() do
        child:Clone().Parent = Lighting;
    end;
end;

return function(p2) -- Line: 36
    -- upvalues: MoonCutsceneStreamer (copy), SpectatorController (copy), SoundManager (copy), Knit (copy), Players (copy), Moonlite (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy), RunService (copy), CutsceneUtils (copy), ReplicatedStorage2 (copy)
    local CutsceneData, v3 = MoonCutsceneStreamer.getCutsceneData("NEL RinSecretAwk");

    if not (CutsceneData and v3) then
        warn("how did this happen. no cutscene data");

        return;
    end;

    local v4 = v3.VFX:Clone();

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p2.Char;

    if not Char then
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
    SoundManager.SpawnSound("RinSecretAwk", 0.6, workspace, 150);
    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    local u5 = true;
    task.spawn(function() -- Line: 67
        -- upvalues: u5 (ref), Controller (copy), Players (ref)
        while u5 do
            task.wait();

            if workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
                workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            end;

            Controller.Cutscene = true;
            Players.LocalPlayer.PlayerGui.InGameUI.Enabled = false;
            workspace.CurrentCamera.FieldOfView = 30;
        end;
    end);
    local Pivot = v4:GetPivot();
    local Pivot2 = HumanoidRootPart:GetPivot();
    v4:PivotTo(Pivot2);
    HumanoidRootPart.Anchored = true;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame = workspace_CurrentCamera.CFrame;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = v4;
    local v6 = Moonlite.CreatePlayer(CutsceneData, v4);
    local v7 = {};

    for _, child in v4.Rin:GetChildren() do
        local v8 = Char:FindFirstChild(child.Name);

        if v8 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v8;
                table.insert(v7, child2);
            end;
        end;
    end;

    v4.Rin:Destroy();

    if v6._moduleInfo and Char then
        for i, v in v6._moduleInfo.Compiled do
            local v9 = v.Path or i;

            if v9.InstanceNames[2] == "Rin" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, Char);
            end;

            local CFrame2 = v.Props.CFrame;

            if CFrame2 and v9.ItemType ~= "Attachment" then
                CFrame2.Default = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(CFrame2.Default));

                for _, v2 in CFrame2.Sequence do
                    v2.Value = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(v2.Value));
                end;
            end;
        end;
    end;

    v6:Compile();

    local function timestampToFrame(p10) -- Line: 136
        local v11, v12 = p10:match("^(%d+):(%d+)$");

        return not (v11 and v12) and (tonumber(p10) or 0) or tonumber(v11) + tonumber(v12) / 1000;
    end;

    local function showCutsceneText(p13: string, u14: number, u15: string, u16) -- Line: 145
        -- upvalues: ReplicatedStorage (ref), Players (ref), TweenService (ref), Debris (ref)
        local v17, v18 = p13:match("^(%d+):(%d+)$");
        local v19;

        if v17 and v18 then
            v19 = tonumber(v17) + tonumber(v18) / 1000;
        else
            v19 = tonumber(p13) or 0;
        end;

        task.delay(v19, function() -- Line: 148
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
            task.delay(u14, function() -- Line: 178
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

    for _, child in v4:GetChildren() do
        local v21;

        if child:IsA("LayerCollector") then
            v21 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 199
                        -- upvalues: child2 (copy), RunService (ref)
                        local v22 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v22);
                        child2.ImageTransparency = 0.999;
                        local v23 = RunService.PreRender:Connect(function() -- Line: 205
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

    v4.Parent = workspace;
    local _ = game.Players.LocalPlayer.Character;
    Camera.Changed:Connect(function(p24: string) -- Line: 231
        -- upvalues: Camera (copy)
        if p24 ~= "CFrame" and p24 ~= "FieldOfView" then
            return;
        end;

        workspace.CurrentCamera[p24] = Camera[p24];
    end);
    local v25, v26 = ("1"):match("^(%d+):(%d+)$");
    local v27;

    if v25 and v26 then
        v27 = tonumber(v25) + tonumber(v26) / 1000;
    else
        v27 = tonumber("1") or 0;
    end;

    local u28 = "Rin...";
    local u29 = nil;
    local u30 = 0.5;
    task.delay(v27, function() -- Line: 148
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
        task.delay(u30, function() -- Line: 178
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
    local v32, v33 = ("3:07"):match("^(%d+):(%d+)$");
    local v34;

    if v32 and v33 then
        v34 = tonumber(v32) + tonumber(v33) / 1000;
    else
        v34 = tonumber("3:07") or 0;
    end;

    local u35 = "If I win...";
    local u36 = nil;
    local u37 = 0.6;
    task.delay(v34, function() -- Line: 148
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
        task.delay(u37, function() -- Line: 178
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
    local v39, v40 = ("4:00"):match("^(%d+):(%d+)$");
    local v41;

    if v39 and v40 then
        v41 = tonumber(v39) + tonumber(v40) / 1000;
    else
        v41 = tonumber("4:00") or 0;
    end;

    local u42 = "Our dream is dead.";
    local u43 = nil;
    local u44 = 0.8;
    task.delay(v41, function() -- Line: 148
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
        task.delay(u44, function() -- Line: 178
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
    local v46, v47 = ("6:00"):match("^(%d+):(%d+)$");
    local v48;

    if v46 and v47 then
        v48 = tonumber(v46) + tonumber(v47) / 1000;
    else
        v48 = tonumber("6:00") or 0;
    end;

    local u49 = "No wait...";
    local u50 = nil;
    local u51 = 0.8;
    task.delay(v48, function() -- Line: 148
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
        task.delay(u51, function() -- Line: 178
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
    local v53, v54 = ("7:0"):match("^(%d+):(%d+)$");
    local v55;

    if v53 and v54 then
        v55 = tonumber(v53) + tonumber(v54) / 1000;
    else
        v55 = tonumber("7:0") or 0;
    end;

    local u56 = "ready...";
    local u57 = nil;
    local u58 = 1;
    task.delay(v55, function() -- Line: 148
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
        task.delay(u58, function() -- Line: 178
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
    local v60, v61 = ("12:00"):match("^(%d+):(%d+)$");
    local v62;

    if v60 and v61 then
        v62 = tonumber(v60) + tonumber(v61) / 1000;
    else
        v62 = tonumber("12:00") or 0;
    end;

    local u63 = "Rin for the past 4 years while I was away...";
    local u64 = nil;
    local u65 = 1;
    task.delay(v62, function() -- Line: 148
        -- upvalues: ReplicatedStorage (ref), Players (ref), u63 (copy), u64 (copy), TweenService (ref), u65 (copy), Debris (ref)
        local u66 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u66.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u66.Position = UDim2.new(0.5, 0, 0.8, 0);
        u66.AnchorPoint = Vector2.new(0.5, 0.5);
        u66.Size = UDim2.new(1, 0, 0.1, 0);
        u66.BackgroundTransparency = 1;
        u66.Font = Enum.Font.ArialBold;
        u66.Text = u63;
        u66.TextColor3 = u64 or Color3.new(1, 1, 1);
        u66.TextTransparency = 0;
        u66.TextStrokeTransparency = 0;
        u66.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u66;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u66, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u63
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u65, function() -- Line: 178
            -- upvalues: TweenService (ref), u66 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u66, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u66, 1);
        end);
    end);
    local v67, v68 = ("13:14"):match("^(%d+):(%d+)$");
    local v69;

    if v67 and v68 then
        v69 = tonumber(v67) + tonumber(v68) / 1000;
    else
        v69 = tonumber("13:14") or 0;
    end;

    local u70 = "What have you been doing here?";
    local u71 = nil;
    local u72 = 1;
    task.delay(v69, function() -- Line: 148
        -- upvalues: ReplicatedStorage (ref), Players (ref), u70 (copy), u71 (copy), TweenService (ref), u72 (copy), Debris (ref)
        local u73 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u73.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u73.Position = UDim2.new(0.5, 0, 0.8, 0);
        u73.AnchorPoint = Vector2.new(0.5, 0.5);
        u73.Size = UDim2.new(1, 0, 0.1, 0);
        u73.BackgroundTransparency = 1;
        u73.Font = Enum.Font.ArialBold;
        u73.Text = u70;
        u73.TextColor3 = u71 or Color3.new(1, 1, 1);
        u73.TextTransparency = 0;
        u73.TextStrokeTransparency = 0;
        u73.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u73;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u73, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u70
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u72, function() -- Line: 178
            -- upvalues: TweenService (ref), u73 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u73, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u73, 1);
        end);
    end);
    Char:SetAttribute("CutsceneChar", true);
    local v74 = 0;
    local v75 = {};

    for _, descendant in workspace:FindFirstChild("Field"):GetDescendants() do
        v74 = v74 + 1;

        if descendant:IsA("BasePart") and descendant.Transparency ~= 1 then
            v75[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        end;
    end;

    CutsceneUtils.ChangeLighting(script.LightingConfig);
    v6:Play();
    require(script.CodeEvents)(v6);
    v6.Completed:Wait();
    v6:Stop();
    u5 = false;
    task.wait();
    Controller.Cutscene = false;
    Players.LocalPlayer.Character.Values.InCutscene.Value = false;

    if Players.LocalPlayer.Team ~= game.Teams.Visitor then
        Players.LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    end;

    v6:Destroy();
    v4:Destroy();

    for _, v in v7 do
        v:Destroy();
    end;

    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
    Camera:Destroy();

    for i, v in v75 do
        i.Transparency = v;
    end;

    workspace.CurrentCamera.CFrame = CFrame;
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    workspace.CurrentCamera.CameraSubject = CameraSubject;
    HumanoidRootPart.Anchored = false;
    Char:SetAttribute("CutsceneChar", nil);
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = true;
    HumanoidRootPart.Massless = true;
    task.wait();
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = false;
    HumanoidRootPart.Massless = false;
end;