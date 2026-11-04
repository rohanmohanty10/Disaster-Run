  

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
require(ReplicatedStorage.Shared.LightingStorage);
local Moonlite = require(ReplicatedStorage.Shared.Moonlite);

local function changeLighting(p1) -- Line: 20
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

return function(p2) -- Line: 35
    -- upvalues: MoonCutsceneStreamer (copy), SpectatorController (copy), Players (copy), SoundManager (copy), Knit (copy), Moonlite (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy), RunService (copy)
    local CutsceneData, v3 = MoonCutsceneStreamer.getCutsceneData("LavinhoSecretAwk");

    if not (CutsceneData and v3) then
        warn("how did this happen. no cutscene data");

        return;
    end;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p2.Char;

    if not Char then
        return;
    end;

    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true;
    local v4 = v3.VFX:Clone();
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Char);
    local v5 = nil;

    for _, v in Players:GetPlayers() do
        if v.Team == PlayerFromCharacter.Team and v ~= PlayerFromCharacter then
            v5 = v.Character;
            break;
        end;
    end;

    if v5 then
        v5.Archivable = true;
        v5 = v5:Clone();
        v5.HumanoidRootPart.Anchored = true;
        v5:PivotTo(Char.HumanoidRootPart.CFrame);
        v5.Parent = workspace;
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
    SoundManager.SpawnSound("LavinhoSecretAwk", 0.6, workspace, 150);
    local Controller = Knit.GetController("CameraController");
    Players.LocalPlayer.Character.Values.InCutscene.Value = true;
    HumanoidRootPart.Anchored = true;
    local u6 = true;
    task.spawn(function() -- Line: 94
        -- upvalues: u6 (ref), Controller (copy), Players (ref)
        while u6 do
            task.wait();

            if workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
                workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            end;

            Controller.Cutscene = true;
            Players.LocalPlayer.PlayerGui.InGameUI.Enabled = false;
        end;
    end);
    local Pivot = v4:GetPivot();
    local Pivot2 = HumanoidRootPart:GetPivot();
    v4:PivotTo(Pivot2);
    local v7 = script["RioDeJan(Scene)"];
    v7:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(184.765381, 308.047363, 17.5621243, -1, 0, 0, 0, 0, 1, 0, 1, 0));
    v7.Parent = workspace;
    local v8 = 0;
    local v9 = {};

    for _, descendant in workspace:FindFirstChild("Field"):GetDescendants() do
        v8 = v8 + 1;

        if descendant:IsA("BasePart") and descendant.Transparency ~= 1 then
            v9[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        end;
    end;

    print(v8);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = v4;
    local v10 = Moonlite.CreatePlayer(CutsceneData, v4);
    local v11 = {};

    for _, child in v4.Lahvino:GetChildren() do
        local v12 = Char:FindFirstChild(child.Name);

        if v12 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v12;
                table.insert(v11, child2);
            end;
        end;
    end;

    v4.Lahvino:Destroy();

    if v5 then
        v4.Bachira:Destroy();
    end;

    if v10._moduleInfo and Char then
        for i, v in v10._moduleInfo.Compiled do
            local v13 = v.Path or i;

            if v13.InstanceNames[2] == "Lahvino" then
                local table_clone_ret = table.clone(v13);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, Char);
            elseif v5 and v13.InstanceNames[2] == "Bachira" then
                local table_clone_ret = table.clone(v13);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, v5);
            end;

            local CFrame3 = v.Props.CFrame;

            if CFrame3 and v13.ItemType ~= "Attachment" then
                CFrame3.Default = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(CFrame3.Default));

                for _, v2 in CFrame3.Sequence do
                    v2.Value = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(v2.Value));
                end;
            end;
        end;
    end;

    v10:Compile();

    local function timestampToFrame(p14) -- Line: 188
        local v15, v16 = p14:match("^(%d+):(%d+)$");

        return not (v15 and v16) and (tonumber(p14) or 0) or tonumber(v15) + tonumber(v16) / 1000;
    end;

    local function showCutsceneText(p17: string, u18: number, u19: string, u20) -- Line: 197
        -- upvalues: Players (ref), ReplicatedStorage (ref), TweenService (ref), Debris (ref)
        local v21, v22 = p17:match("^(%d+):(%d+)$");
        local v23;

        if v21 and v22 then
            v23 = tonumber(v21) + tonumber(v22) / 1000;
        else
            v23 = tonumber(p17) or 0;
        end;

        task.delay(v23, function() -- Line: 200
            -- upvalues: Players (ref), ReplicatedStorage (ref), u19 (copy), u20 (copy), TweenService (ref), u18 (copy), Debris (ref)
            local Popup = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette"):FindFirstChild("Popup");

            if Popup then
                Popup:Destroy();
            end;

            local u24 = ReplicatedStorage.Assets.UI.Popup:Clone();
            u24.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
            u24.Position = UDim2.new(0.5, 0, 0.8, 0);
            u24.AnchorPoint = Vector2.new(0.5, 0.5);
            u24.Size = UDim2.new(1, 0, 0.1, 0);
            u24.BackgroundTransparency = 1;
            u24.Font = Enum.Font.ArialBold;
            u24.Text = u19;
            u24.TextColor3 = u20 or Color3.new(1, 1, 1);
            u24.TextTransparency = 0;
            u24.TextStrokeTransparency = 0;
            u24.MaxVisibleGraphemes = 0;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Parent = u24;
            UIStroke.Thickness = 4;
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
            UIStroke.Color = Color3.new(0, 0, 0);
            UIStroke.Transparency = 1;
            TweenService:Create(u24, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                TextTransparency = 0,
                TextStrokeTransparency = 0,
                MaxVisibleGraphemes = #u19
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                Transparency = 0
            }):Play();
            task.delay(u18, function() -- Line: 232
                -- upvalues: TweenService (ref), u24 (copy), UIStroke (copy), Debris (ref)
                TweenService:Create(u24, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1
                }):Play();
                TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
                Debris:AddItem(u24, 1);
            end);
        end);
    end;

    for _, child in v4:GetChildren() do
        local v25;

        if child:IsA("LayerCollector") then
            v25 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 253
                        -- upvalues: child2 (copy), RunService (ref)
                        local v26 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v26);
                        child2.ImageTransparency = 0.999;
                        local v27 = RunService.PreRender:Connect(function() -- Line: 259
                            -- upvalues: child2 (ref)
                            child2.Visible = true;
                        end);

                        while not child2.IsLoaded and child2:IsDescendantOf(game) do
                            task.wait();
                        end;

                        v27:Disconnect();
                        child2.Visible = false;
                        child2.ImageTransparency = 0;
                    end);
                end;
            end;

            v25.Parent = Players.LocalPlayer.PlayerGui;
        elseif child:IsA("PostEffect") then
            child.Parent = workspace.CurrentCamera;
            v25 = child;
        else
            v25 = child;
        end;

        table.insert(v11, v25);
    end;

    v4.Parent = workspace;
    Camera.Changed:Connect(function(p28: string) -- Line: 283
        -- upvalues: Camera (copy)
        if p28 ~= "CFrame" and p28 ~= "FieldOfView" then
            return;
        end;

        workspace.CurrentCamera[p28] = Camera[p28];
    end);
    Char:SetAttribute("CutsceneChar", true);
    v10:Play();
    require(script.CodeEvents)(v10);
    v10.Completed:Wait();
    v10:Stop();
    u6 = false;
    task.wait();
    Controller.Cutscene = false;
    Players.LocalPlayer.Character.Values.InCutscene.Value = false;

    if Players.LocalPlayer.Team ~= game.Teams.Visitor then
        Players.LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    end;

    v10:Destroy();
    v4:Destroy();
    v7.Parent = script;

    for i, v in v9 do
        i.Transparency = v;
    end;

    for _, v in v11 do
        v:Destroy();
    end;

    Camera:Destroy();

    if v5 then
        v5:Destroy();
    end;

    workspace.CurrentCamera.CFrame = CFrame2;
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    workspace.CurrentCamera.CameraSubject = CameraSubject;
    HumanoidRootPart.Anchored = false;
    Char:SetAttribute("CutsceneChar", nil);
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = true;
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false;
    HumanoidRootPart.Massless = true;
    task.wait();
    game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = false;
    HumanoidRootPart.Massless = false;
end;