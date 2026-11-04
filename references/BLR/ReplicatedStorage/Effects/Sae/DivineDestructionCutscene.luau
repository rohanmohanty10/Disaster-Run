  

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
require(ReplicatedStorage2.Shared.LightingStorage);
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

return function(u2) -- Line: 36
    -- upvalues: MoonCutsceneStreamer (copy), SpectatorController (copy), SoundManager (copy), ReplicatedStorage2 (copy), Knit (copy), Players (copy), Moonlite (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy), RunService (copy), changeLighting (copy)
    local CutsceneData, v3 = MoonCutsceneStreamer.getCutsceneData("SaeDivineDestruction");

    if not (CutsceneData and v3) then
        warn("how did this happen. no cutscene data");

        return;
    end;

    local u4 = v3.VFX:Clone();

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = u2.Char;

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
    SoundManager.SpawnSound("DivineDestruction", 0.6, workspace, 150);
    local Character = game.Players.LocalPlayer.Character;
    local EnemyChar = u2.EnemyChar;

    if EnemyChar then
        EnemyChar.Archivable = true;
        EnemyChar = EnemyChar:Clone();
        EnemyChar.HumanoidRootPart.Anchored = true;
        EnemyChar:PivotTo(Char.HumanoidRootPart.CFrame);
        EnemyChar.Parent = workspace;
    end;

    if EnemyChar and (Character.Values.Goalie.Value and Char ~= Character) then
        EnemyChar:Destroy();
        EnemyChar = nil;
    elseif EnemyChar then
        local ViewportFrame = Instance.new("ViewportFrame");
        ViewportFrame.Parent = workspace;
        u2.EnemyChar.Parent = ViewportFrame;
        task.delay(12, function() -- Line: 84
            -- upvalues: u2 (copy), ReplicatedStorage2 (ref)
            u2.EnemyChar.Parent = ReplicatedStorage2;
            u2.EnemyChar.Parent = workspace;
        end);
    end;

    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    local u5 = true;
    task.spawn(function() -- Line: 94
        -- upvalues: Character (copy), Char (copy), u4 (copy), u5 (ref), Controller (copy), Players (ref)
        if not Character.Values.Goalie.Value or Char == Character then
            while u5 do
                task.wait();

                if workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                end;

                Controller.Cutscene = true;
                Players.LocalPlayer.PlayerGui.InGameUI.Enabled = false;
            end;

            return;
        end;

        local Cam = u4:FindFirstChild("Cam");

        if Cam then
            Cam:Destroy();
        end;
    end);
    local Pivot = u4:GetPivot();
    local Pivot2 = HumanoidRootPart:GetPivot();
    u4:PivotTo(Pivot2);
    HumanoidRootPart.Anchored = true;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame = workspace_CurrentCamera.CFrame;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = u4;
    local v6 = Moonlite.CreatePlayer(CutsceneData, u4);
    local v7 = {};

    for _, child in u4.Sae:GetChildren() do
        local v8 = Char:FindFirstChild(child.Name);

        if v8 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v8;
                table.insert(v7, child2);
            end;
        end;
    end;

    u4.Sae:Destroy();

    if EnemyChar then
        u4.gaga:Destroy();
    end;

    if v6._moduleInfo and Char then
        for i, v in v6._moduleInfo.Compiled do
            local v9 = v.Path or i;

            if v9.InstanceNames[2] == "Sae" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, Char);
            elseif EnemyChar and v9.InstanceNames[2] == "gaga" then
                local table_clone_ret = table.clone(v9);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, EnemyChar);
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

    local function timestampToFrame(p10) -- Line: 175
        local v11, v12 = p10:match("^(%d+):(%d+)$");

        return not (v11 and v12) and (tonumber(p10) or 0) or tonumber(v11) + tonumber(v12) / 1000;
    end;

    local function showCutsceneText(p13: string, u14: number, u15: string, u16) -- Line: 184
        -- upvalues: ReplicatedStorage (ref), Players (ref), TweenService (ref), Debris (ref)
        local v17, v18 = p13:match("^(%d+):(%d+)$");
        local v19;

        if v17 and v18 then
            v19 = tonumber(v17) + tonumber(v18) / 1000;
        else
            v19 = tonumber(p13) or 0;
        end;

        task.delay(v19, function() -- Line: 187
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
            task.delay(u14, function() -- Line: 217
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

    for _, child in u4:GetChildren() do
        local v21;

        if child:IsA("LayerCollector") then
            v21 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 238
                        -- upvalues: child2 (copy), RunService (ref)
                        local v22 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v22);
                        child2.ImageTransparency = 0.999;
                        local v23 = RunService.PreRender:Connect(function() -- Line: 244
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

    u4.Parent = workspace;

    if not Character.Values.Goalie.Value or Char == Character then
        Camera.Changed:Connect(function(p24: string) -- Line: 269
            -- upvalues: Camera (copy)
            if p24 ~= "CFrame" and p24 ~= "FieldOfView" then
                return;
            end;

            workspace.CurrentCamera[p24] = Camera[p24];
        end);
    end;

    local GK = workspace.AI.Home:FindFirstChild("GK");
    local GK2 = workspace.AI.Away:FindFirstChild("GK");
    local v25 = {};

    if GK then
        for _, descendant in GK:GetDescendants() do
            if descendant:IsA("BasePart") or descendant:IsA("Decal") and descendant.Transparency ~= 1 then
                descendant.Transparency = 1;
                table.insert(v25, descendant);
            elseif descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") and descendant.Enabled then
                descendant.Enabled = false;
                table.insert(v25, descendant);
            end;
        end;
    end;

    if GK2 then
        for _, descendant in GK2:GetDescendants() do
            if descendant:IsA("BasePart") or descendant:IsA("Decal") and descendant.Transparency ~= 1 then
                descendant.Transparency = 1;
                table.insert(v25, descendant);
            elseif descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") and descendant.Enabled then
                descendant.Enabled = false;
                table.insert(v25, descendant);
            end;
        end;
    end;

    local v26, v27 = ("9:80"):match("^(%d+):(%d+)$");
    local v28;

    if v26 and v27 then
        v28 = tonumber(v26) + tonumber(v27) / 1000;
    else
        v28 = tonumber("9:80") or 0;
    end;

    local u29 = "Still...";
    local u30 = nil;
    local u31 = 0.5;
    task.delay(v28, function() -- Line: 187
        -- upvalues: ReplicatedStorage (ref), Players (ref), u29 (copy), u30 (copy), TweenService (ref), u31 (copy), Debris (ref)
        local u32 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u32.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u32.Position = UDim2.new(0.5, 0, 0.8, 0);
        u32.AnchorPoint = Vector2.new(0.5, 0.5);
        u32.Size = UDim2.new(1, 0, 0.1, 0);
        u32.BackgroundTransparency = 1;
        u32.Font = Enum.Font.ArialBold;
        u32.Text = u29;
        u32.TextColor3 = u30 or Color3.new(1, 1, 1);
        u32.TextTransparency = 0;
        u32.TextStrokeTransparency = 0;
        u32.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = u32;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        UIStroke.Color = Color3.new(0, 0, 0);
        UIStroke.Transparency = 1;
        TweenService:Create(u32, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            MaxVisibleGraphemes = #u29
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u31, function() -- Line: 217
            -- upvalues: TweenService (ref), u32 (copy), UIStroke (copy), Debris (ref)
            TweenService:Create(u32, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            Debris:AddItem(u32, 1);
        end);
    end);
    local Color3_fromRGB_ret = Color3.fromRGB(169, 0, 181);
    local v33, v34 = ("10:20"):match("^(%d+):(%d+)$");
    local v35;

    if v33 and v34 then
        v35 = tonumber(v33) + tonumber(v34) / 1000;
    else
        v35 = tonumber("10:20") or 0;
    end;

    local u36 = "Half baked";
    local u37 = 1;
    task.delay(v35, function() -- Line: 187
        -- upvalues: ReplicatedStorage (ref), Players (ref), u36 (copy), Color3_fromRGB_ret (copy), TweenService (ref), u37 (copy), Debris (ref)
        local u38 = ReplicatedStorage.Assets.UI.Popup:Clone();
        u38.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        u38.Position = UDim2.new(0.5, 0, 0.8, 0);
        u38.AnchorPoint = Vector2.new(0.5, 0.5);
        u38.Size = UDim2.new(1, 0, 0.1, 0);
        u38.BackgroundTransparency = 1;
        u38.Font = Enum.Font.ArialBold;
        u38.Text = u36;
        u38.TextColor3 = Color3_fromRGB_ret or Color3.new(1, 1, 1);
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
            MaxVisibleGraphemes = #u36
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        task.delay(u37, function() -- Line: 217
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
    Char:SetAttribute("CutsceneChar", true);
    changeLighting(script.LightingConfig);
    v6:Play();
    require(script.CodeEvents)(v6);
    task.wait(12);
    v6:Stop();
    u5 = false;
    task.wait();
    Controller.Cutscene = false;
    Players.LocalPlayer.Character.Values.InCutscene.Value = false;

    if Players.LocalPlayer.Team ~= game.Teams.Visitor then
        Players.LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    end;

    v6:Destroy();
    u4:Destroy();

    for _, v in v7 do
        v:Destroy();
    end;

    Camera:Destroy();
    changeLighting(ReplicatedStorage2.Assets.MainLighting);
    workspace.CurrentCamera.CFrame = CFrame;
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    workspace.CurrentCamera.CameraSubject = CameraSubject;

    if EnemyChar then
        EnemyChar:Destroy();
    end;

    for _, v in v25 do
        if v:IsA("BasePart") or v:IsA("Decal") then
            v.Transparency = 0;
        elseif v:IsA("Beam") or v:IsA("ParticleEmitter") then
            v.Enabled = true;
        end;
    end;

    table.clear(v25);
    HumanoidRootPart.Anchored = false;
    Char:SetAttribute("CutsceneChar", nil);
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = true;
    HumanoidRootPart.Massless = true;
    task.wait();
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = false;
    HumanoidRootPart.Massless = false;
end;