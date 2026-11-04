 
 

local CollectionService = game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local v1 = Knit.CreateController({
    Name = "TelevisionCameraController"
});
local u2 = false;
local u3 = nil;
local u4 = nil;

function v1.CameraView(u5) -- Line: 28
    -- upvalues: LocalPlayer (copy), u3 (ref), u2 (ref), ReplicatedStorage (copy), u4 (ref), Lighting (copy), TweenService (copy), RunService (copy)
    if LocalPlayer.Team == game.Teams.Visitor then
        return;
    end;

    if not u3.Player.Customization.Settings.TVCameras then
        return;
    end;

    if workspace:FindFirstChild("CamRig") then
        return;
    end;

    if u5._trackee == nil then
        return;
    end;

    if #u5._cameras == 0 then
        return;
    end;

    if u2 then
        return;
    end;

    local v6 = (1 / 0);
    local u7 = nil;

    for _, v in u5._cameras do
        if v:IsDescendantOf(workspace) then
            local LensAttachment = v.LensAttachment;
            local v8;

            if u5._trackee == ReplicatedStorage.Basketball then
                v8 = u4:GetServerBallPosition();
            else
                v8 = u5._trackee:GetPivot().Position;
            end;

            local math_abs_ret = math.abs((LensAttachment.WorldCFrame.Position - v8).Magnitude);

            if math_abs_ret < v6 then
                u7 = LensAttachment;
                v6 = math_abs_ret;
            end;
        end;
    end;

    if not u7 then
        return;
    end;

    u2 = true;
    local u9 = u5._trove:Clone(ReplicatedStorage.Assets.UI.CamOverlay);
    u9.Parent = LocalPlayer.PlayerGui;
    u5._trove:Add(task.spawn(function() -- Line: 83
        -- upvalues: u9 (copy)
        while u9 and u9:FindFirstChild("Recording") do
            u9.Recording.Visible = not u9.Recording.Visible;
            task.wait(1);
        end;
    end));
    local u10 = u5._trove:Add(Instance.new("BlurEffect"));
    u10.Parent = Lighting;
    Lighting.DepthOfField.Enabled = false;
    task.delay(0.08333333333333333, function() -- Line: 95
        -- upvalues: TweenService (ref), u10 (copy)
        TweenService:Create(u10, TweenInfo.new(0.06666666666666667), {
            Size = 17
        }):Play();
    end);
    task.delay(0.15, function() -- Line: 101
        -- upvalues: TweenService (ref), u10 (copy)
        TweenService:Create(u10, TweenInfo.new(1.3), {
            Size = 1
        }):Play();
    end);
    u5._trove:Connect(RunService.PreRender, function() -- Line: 107
        -- upvalues: u5 (copy), ReplicatedStorage (ref), u4 (ref), u7 (ref)
        if workspace:FindFirstChild("CamRig") then
            return;
        end;

        if u5._trackee == nil then
            return;
        end;

        local v11;

        if u5._trackee == ReplicatedStorage.Basketball then
            v11 = u4:GetServerBallPosition();
        else
            v11 = u5._trackee:GetPivot().Position;
        end;

        workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local math_abs_ret = math.abs((u7.WorldCFrame.Position - v11).Magnitude);
        local v12 = ((math.clamp(math_abs_ret, 10, 140) - 10) / 130 * -55 + 70 - workspace.CurrentCamera.MaxAxisFieldOfView) * 0.1;
        local workspace_CurrentCamera = workspace.CurrentCamera;
        workspace_CurrentCamera.MaxAxisFieldOfView = workspace_CurrentCamera.MaxAxisFieldOfView + v12;
        workspace.CurrentCamera.CFrame = u7.WorldCFrame;
    end);
    u5._trove:Add(function() -- Line: 135
        -- upvalues: Lighting (ref), LocalPlayer (ref), u2 (ref)
        Lighting.DepthOfField.Enabled = true;
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
        workspace.CurrentCamera.CameraSubject = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid");
        u2 = false;
    end);
    u5._trove:Add(task.delay(10, function() -- Line: 144
        -- upvalues: u5 (copy)
        u5:ResetCamera();
    end));
end;

function v1.ResetCamera(p13) -- Line: 150
    -- upvalues: ReplicatedStorage (copy)
    p13._trackee = ReplicatedStorage.Basketball;
    p13._trove:Clean();
end;

function v1.KnitStart(u14) -- Line: 155
    -- upvalues: u3 (ref), Knit (copy), u4 (ref), ReplicatedStorage (copy), Trove (copy), RunService (copy), CollectionService (copy)
    u3 = Knit.GetController("Network");
    u4 = Knit.GetController("BallController");
    local Service = Knit.GetService("ScoreService");
    u14.MovementController = Knit.GetController("MovementController");
    u14._trackee = ReplicatedStorage.Basketball;
    u14._trove = Trove.new();
    Service.Scored:Connect(function(p15, p16) -- Line: 166
        -- upvalues: u14 (copy)
        u14._trackee = p15.Character;

        if p16 and p16.CamView then
            u14:CameraView();
        end;
    end);
    ReplicatedStorage.Remotes.FrameText.OnClientEvent:Connect(function(p17) -- Line: 174
        -- upvalues: u14 (copy)
        if p17 == "Dunk" then
            u14:CameraView();
        end;
    end);
    ReplicatedStorage.Remotes.TVCamera.OnClientEvent:Connect(function(p18) -- Line: 180
        -- upvalues: u14 (copy), RunService (ref), u4 (ref), ReplicatedStorage (ref)
        u14:CameraView();

        if p18 == "BuzzerBeater" then
            task.delay(0.5, function() -- Line: 184
                -- upvalues: u14 (ref), RunService (ref), u4 (ref), ReplicatedStorage (ref)
                u14._trove:Connect(RunService.Heartbeat, function() -- Line: 185
                    -- upvalues: u4 (ref), ReplicatedStorage (ref), u14 (ref)
                    if u4:GetServerBallPosition().Y <= 5 and not ReplicatedStorage.GameValues.Scoring.Value then
                        u14:ResetCamera();
                    end;
                end);
            end);
        end;
    end);
    ReplicatedStorage.GameValues.Scoring:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 195
        -- upvalues: ReplicatedStorage (ref), u14 (copy)
        if not ReplicatedStorage.GameValues.Scoring.Value then
            u14:ResetCamera();
        end;
    end);
    workspace.ChildAdded:Connect(function(p19) -- Line: 201
        -- upvalues: u14 (copy)
        if p19.Name == "CamRig" then
            u14._trove:Clean();
        end;
    end);
    u14._cameras = {};
    RunService.PreRender:Connect(function() -- Line: 209
        -- upvalues: u14 (copy), ReplicatedStorage (ref), u4 (ref)
        if u14._trackee == nil then
            return;
        end;

        if #u14._cameras == 0 then
            return;
        end;

        for _, v in u14._cameras do
            if v:IsDescendantOf(workspace) then
                local v20;

                if u14._trackee == ReplicatedStorage.Basketball then
                    v20 = u4:GetServerBallPosition();
                else
                    v20 = u14._trackee:GetPivot().Position;
                end;

                local Unit = (v20 - v.Position).Unit;
                local Unit2 = Vector3.new(v.CFrame.LookVector.X, 0, v.CFrame.LookVector.Z).Unit;
                local v21 = Unit2.Magnitude == 0 and Vector3.new(0, 0, -1) or Unit2;
                local v22 = v21:Cross(Vector3.new(0, 1, 0));
                local v23 = v22:Cross(v21);
                local CFrame_fromMatrix_ret = CFrame.fromMatrix(v.Position, v22, v23);
                local v24 = CFrame_fromMatrix_ret:VectorToObjectSpace(Unit);
                local math_atan2_ret = math.atan2(-v24.X, -v24.Z);
                local math_asin_ret = math.asin(v24.Y);
                local math_deg_ret = math.deg(math_atan2_ret);
                local math_clamp_ret = math.clamp(math_deg_ret, -45, 45);
                local math_deg_ret2 = math.deg(math_asin_ret);
                local math_clamp_ret2 = math.clamp(math_deg_ret2, -10, 45);
                local CFrame_Angles_ret = CFrame.Angles(math.rad(math_clamp_ret2), math.rad(math_clamp_ret), 0);
                v.CFrame = v.CFrame:Lerp(CFrame_fromMatrix_ret * CFrame_Angles_ret, 0.2);
                local CameraMan = v:FindFirstChild("CameraMan");

                if CameraMan then
                    local Unit3 = Vector3.new(v.CFrame.LookVector.X, 0, v.CFrame.LookVector.Z).Unit;
                    local v25 = v.Position - Unit3 * 2.5;
                    CameraMan:SetPivot(CFrame.new(Vector3.new(v25.X, 3.23, v25.Z), CameraMan:GetPivot().Position + Unit3));
                end;
            end;
        end;
    end);
    CollectionService:GetInstanceRemovedSignal("camera"):Connect(function(p26: userdata) -- Line: 259, Name: unregisterCamera
        -- upvalues: u14 (copy)
        table.remove(u14._cameras, table.find(u14._cameras, p26));
    end);
    CollectionService:GetInstanceAddedSignal("camera"):Connect(function(p27: userdata) -- Line: 255, Name: registerCamera
        -- upvalues: u14 (copy)
        table.insert(u14._cameras, p27);
    end);

    for _, v in CollectionService:GetTagged("camera") do
        table.insert(u14._cameras, v);
    end;
end;

return v1;