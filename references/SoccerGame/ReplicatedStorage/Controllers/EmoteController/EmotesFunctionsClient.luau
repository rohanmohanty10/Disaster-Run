  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("PathfindingService");
local Players = game:GetService("Players");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
local LocalPlayer = game.Players.LocalPlayer;
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
u1:WaitForChild("Humanoid");
local Moonlite = require(ReplicatedStorage.Shared.Moonlite);
require(ReplicatedStorage.Shared.MoonCutsceneStreamer);
local v2 = {};
PlayerTracks = {};

function v2.GlitchLoki(p3, p4, p5) -- Line: 28
    -- upvalues: SoundManager (copy), ReplicatedStorage (copy), Players (copy), Moonlite (copy), LocalPlayer (copy), u1 (copy)
    if p5 ~= "Start" then
        if p5 == "End" then
            game:GetService("RunService"):UnbindFromRenderStep((`{u1.Name}LokiEmoteFOV`));

            if p4.Parent then
                p4:SetAttribute("EmoteCutscene", nil);
            end;

            if not PlayerTracks[p4] then
                return;
            end;

            PlayerTracks[p4].Track:Stop();

            for i, v in PlayerTracks[p4] do
                if i == "AllInstances" then
                    for _, v3 in v do
                        v3:Destroy();
                    end;
                else
                    v:Destroy();
                end;
            end;

            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid;
            PlayerTracks[p4] = nil;
        end;

        return;
    end;

    local v6 = SoundManager.SpawnSound("YouWereAllAmazingUntilIShowedUp");
    local GlitchCutsceneData = require(ReplicatedStorage.Assets.Misc.Emotes.LokiVFX.GlitchCutsceneData);
    local GlitchCutsceneData2 = ReplicatedStorage.Assets.Misc.Emotes.LokiVFX.GlitchCutsceneData;

    if not (GlitchCutsceneData and GlitchCutsceneData2) then
        warn("how did this happen. no cutscene data");

        return;
    end;

    local Character = Players.LocalPlayer.Character;

    if not Character then
        return;
    end;

    local HumanoidRootPart = p4:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v7 = GlitchCutsceneData2.VFX:Clone();
    local Pivot = v7:GetPivot();
    local Pivot2 = HumanoidRootPart:GetPivot();
    v7:PivotTo(Pivot2);
    local v8 = {};
    table.insert(v8, v6);
    local u9;

    if p4 == Character or p3.CameraController.CharOfScored == p4 then
        p4:SetAttribute("EmoteCutscene", true);
        u9 = Instance.fromExisting(workspace.CurrentCamera);
        workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        u9.Name = "CurrentCamera";
        u9.Parent = v7;
    else
        u9 = nil;
    end;

    local v10 = Moonlite.CreatePlayer(GlitchCutsceneData, v7);
    PlayerTracks[p4] = {
        Track = v10,
        AllInstances = v8,
        Model = v7,
        FakeCamera = u9
    };

    for _, child in v7.astdubs:GetChildren() do
        local v11 = p4:FindFirstChild(child.Name);

        if v11 then
            for _, child2 in child:GetChildren() do
                child2.Parent = v11;
                table.insert(v8, child2);
            end;
        end;
    end;

    v7.astdubs:Destroy();

    if v10._moduleInfo and p4 then
        for i, v in v10._moduleInfo.Compiled do
            local v12 = v.Path or i;

            if v12.ItemType == "Rig" and v12.InstanceNames[2] == "astdubs" then
                v.Props.CFrame = nil;
            end;

            if v12.InstanceNames[2] == "astdubs" then
                local table_clone_ret = table.clone(v12);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, p4);
            end;

            local CFrame = v.Props.CFrame;

            if CFrame and v12.ItemType ~= "Attachment" then
                CFrame.Default = Pivot:ToObjectSpace(CFrame.Default):ToWorldSpace(Pivot2);

                for _, v3 in CFrame.Sequence do
                    v3.Value = Pivot:ToObjectSpace(v3.Value):ToWorldSpace(Pivot2);
                end;
            end;
        end;
    end;

    v10:Compile();
    v7.Parent = workspace;

    if p4 == Character or p3.CameraController.CharOfScored == p4 then
        for _, child in v7:GetChildren() do
            if child:IsA("LayerCollector") then
                child.Parent = Players.LocalPlayer.PlayerGui;
            elseif child:IsA("PostEffect") then
                child.Parent = workspace.CurrentCamera;
            end;

            table.insert(v8, child);
        end;

        local u13 = { "CFrame", "FieldOfView", "CameraSubject", "CameraType" };
        game:GetService("RunService"):BindToRenderStep(`{Character.Name}LokiEmoteFOV`, Enum.RenderPriority.Last.Value, function() -- Line: 130
            -- upvalues: u13 (copy), u9 (ref)
            for _, v in u13 do
                workspace.CurrentCamera[v] = u9[v];
            end;
        end);
    end;

    v10:Play();
    v10.Completed:Wait();

    if not PlayerTracks[p4] then
        return;
    end;

    game:GetService("RunService"):UnbindFromRenderStep((`{Character.Name}LokiEmoteFOV`));

    for i, v in PlayerTracks[p4] do
        if i == "AllInstances" then
            for _, v3 in v do
                v3:Destroy();
            end;
        else
            v:Destroy();
        end;
    end;

    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid;
    PlayerTracks[p4] = nil;
end;

return v2;