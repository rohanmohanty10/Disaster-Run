  

 

local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Util = require(script.Parent:WaitForChild("Util"));
local Pin = require(script:WaitForChild("Pin"));
local Signal = require(game.ReplicatedStorage.ReplicatedModules.KnitPackage.Signal);
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local u1 = { Enum.KeyCode.Right, Enum.KeyCode.Left };
local u2 = { "Large", "Medium", "Small" };
local u3 = {};
u3.__index = u3;

function u3.new(p4) -- Line: 20
    -- upvalues: u3 (copy), Signal (copy), ReplicatedStorage (copy), u2 (copy), Util (copy), Pin (copy), LocalPlayer (copy)
    local u5 = setmetatable({}, u3);
    u5.Data = p4;
    u5.Template = u5.Data.Template:Clone();
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillTransparency = 1;
    Highlight.Parent = u5.Template.Lockpick:FindFirstChildOfClass("MeshPart");
    u5.Template.Parent = workspace.Effects;
    u5.Template:PivotTo(p4.Origin or CFrame.new(0, 20, 0));
    u5.Lockpick = u5.Template:WaitForChild("Lockpick");
    u5.Collider = u5.Lockpick:WaitForChild("Collider");
    u5.Interval = 5;
    u5.Pins = {};
    u5.UncrackedPins = {};
    u5.Ended = Signal.new();
    u5.Lockpicked = Signal.new();
    u5.Active = true;

    for i = 1, 5 do
        local v6 = u5.Template:FindFirstChild((tostring(i)));
        local v7 = ReplicatedStorage["Client Assets"].LockpickMechanisms:FindFirstChild(u2[math.random(1, #u2)]):Clone();
        v7.Parent = u5.Template;

        for i2 = 1, 2 do
            local v8 = (i2 <= 1 and "Bottom" or "Top") .. "Pin";
            local Highlight2 = Instance.new("Highlight");
            Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight2.FillColor = v8 == "BottomPin" and Color3.fromRGB(252, 250, 255) or Color3.fromRGB(255, 0, 0);
            Highlight2.FillTransparency = 1;
            Highlight2.OutlineTransparency = 0;
            Highlight2.OutlineColor = Color3.fromRGB(255, 0, 4);
            Highlight2.Parent = v7[v8];
        end;

        local Y = Util.GetLowestPoint(v7.BottomPin).Y;
        local v9 = v7:GetPivot().Y - Y;
        local Y2 = Util.GetHighestPoint(u5.Template.InvisWall).Y;
        v7:PivotTo(CFrame.new((Vector3.new(v6.Position.X, Y2 + v9, v6.Position.Z))) * CFrame.Angles(0, 0, -1.5707963267948966));
        local v10 = Pin.new(v7);
        table.insert(u5.Pins, v10);
    end;

    for _, v in pairs(u5.Pins) do
        table.insert(u5.UncrackedPins, v);
    end;

    u5:RandomPin();
    local v11 = ReplicatedStorage["Client Assets"].MinigameUI:Clone();
    v11.Parent = LocalPlayer:WaitForChild("PlayerGui");
    v11.Frame.CancelButton.MouseButton1Click:Connect(function() -- Line: 90
        -- upvalues: u5 (copy)
        u5:Stop();
    end);
    u5.UI = v11;

    return u5;
end;

function u3.GetPinFromModel(p12, p13) -- Line: 99
    for _, v in pairs(p12.Pins) do
        if v:GetModel() == p13 then
            return v;
        end;
    end;
end;

function u3.Start(u14) -- Line: 107
    -- upvalues: HttpService (copy), RunService (copy)
    if u14._RenderStepUUID then
        u14:Stop();
    end;

    u14._RenderStepUUID = HttpService:GenerateGUID(false);
    local u15 = 0;
    local u16 = 0;

    for _, v in pairs(u14.Pins) do
        u15 = u15 + 1;
        local u17 = nil;
        u17 = v.CrackedSignal:Connect(function() -- Line: 118
            -- upvalues: u17 (ref), u16 (ref), u15 (ref), u14 (copy)
            u17:Disconnect();
            u16 = u16 + 1;

            if u16 == u15 then
                u14.Lockpicked:Fire();
                u14:Stop();
            end;
        end);
    end;

    RunService:BindToRenderStep(u14._RenderStepUUID, Enum.RenderPriority.Input.Value, function(p18) -- Line: 129
        -- upvalues: u14 (copy)
        u14:_Update(p18);
    end);
end;

function u3.Stop(p19) -- Line: 134
    -- upvalues: RunService (copy), CurrentCamera (copy)
    if not p19._RenderStepUUID then
        return;
    end;

    RunService:UnbindFromRenderStep(p19._RenderStepUUID);
    p19._RenderStepUUID = nil;
    p19.Active = false;
    CurrentCamera.CameraType = Enum.CameraType.Custom;

    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid");
    end;

    p19.Template:Destroy();
    p19.UI:Destroy();
    p19.Ended:Fire();
end;

function u3.RandomPin(p20) -- Line: 155
    if #p20.UncrackedPins <= 0 then
        return;
    end;

    local v21 = math.random(1, #p20.UncrackedPins);
    local v22 = p20.UncrackedPins[v21];

    if not v22 then
        return;
    end;

    v22:SetLoose(true);
    table.remove(p20.UncrackedPins, v21);
end;

function u3._Update(u23, p24) -- Line: 171
    -- upvalues: CurrentCamera (copy), UserInputService (copy), Util (copy), u1 (copy)
    if not u23.Active then
        return;
    end;

    CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local CameraReference = u23.Template:FindFirstChild("CameraReference");

    if CameraReference then
        CurrentCamera.CFrame = CameraReference.CFrame;
    end;

    local u25 = u23.Interval * p24;
    local u26 = false;
    task.spawn(function() -- Line: 187
        -- upvalues: UserInputService (ref), u23 (copy), Util (ref), u26 (ref), u25 (copy)
        if not UserInputService:IsKeyDown(Enum.KeyCode.W) then
            if not UserInputService:IsKeyDown(Enum.KeyCode.W) then
                local InvisWall = u23.Template.InvisWall;
                local Y = Util.GetHighestPoint(InvisWall).Y;
                local Y2 = Util.GetLowestPoint(InvisWall).Y;
                local Y3 = Util.GetLowestPoint(u23.Lockpick).Y;

                if Y < Y3 - u25 or Y3 - u25 < Y2 then
                    local v27 = Y < Y3 and Y3 - Y;

                    if not v27 then
                        if Y3 < Y2 then
                            v27 = Y3 - Y2;
                        else
                            v27 = false;
                        end;
                    end;

                    if v27 then
                        local Lockpick = u23.Lockpick;
                        Lockpick.CFrame = Lockpick.CFrame * CFrame.new(0, -v27, 0);

                        return;
                    end;
                else
                    local Lockpick = u23.Lockpick;
                    Lockpick.CFrame = Lockpick.CFrame * CFrame.new(0, -u25, 0);
                end;
            end;

            return;
        end;

        local CFrame2 = u23.Collider.CFrame;
        local Size = u23.Collider.Size;
        local InvisWall = u23.Template.InvisWall;
        local Y = Util.GetHighestPoint(InvisWall).Y;
        local Y2 = Util.GetLowestPoint(InvisWall).Y;
        local Y3 = Util.GetHighestPoint(u23.Lockpick).Y;
        local v28 = RaycastParams.new();
        v28.FilterDescendantsInstances = { workspace.Effects };
        v28.FilterType = Enum.RaycastFilterType.Include;
        local v29 = workspace:Blockcast(CFrame2, Size, Vector3.new(0, 0.1, 0));

        if v29 then
            u26 = true;
            local InvisWall2 = u23.Template.InvisWall;
            local Y4 = Util.GetHighestPoint(InvisWall2).Y;
            local _ = Util.GetLowestPoint(InvisWall2).Y;

            if Util.GetHighestPoint(u23.Lockpick).Y < Y4 then
                local v30 = u23:GetPinFromModel(v29.Instance.Parent);

                if not v30 then
                    return;
                end;

                local v31 = v30:GetBottom();
                local v32 = v30:GetTop();
                local v33 = CFrame.new(-u25, 0, 0);

                if v30:IsCracked() then
                    return;
                end;

                v31.CFrame = v31.CFrame * v33;
                v32.CFrame = v32.CFrame * v33;
            end;
        end;

        if Y < Y3 or Y3 < Y2 then
            return;
        end;

        local Lockpick = u23.Lockpick;
        Lockpick.CFrame = Lockpick.CFrame * CFrame.new(0, u25, 0);
    end);

    if not u26 then
        for _, v in pairs(u23.Pins) do
            local v34 = v:GetBottom();
            local v35 = v:GetTop();
            local MiddleWall = u23.Template:FindFirstChild("MiddleWall");

            if MiddleWall then
                local Y = Util.GetHighestPoint(MiddleWall).Y;
                local Y2 = Util.GetLowestPoint(v35).Y;
                local Y3 = Util.GetHighestPoint(u23.Template.InvisWall).Y;
                local Y4 = Util.GetLowestPoint(v34).Y;
                local _ = Y2 - Y;
                local v36 = Y4 - Y3;

                if Y4 - u25 <= Y3 then
                    if not v:IsCracked() then
                        v35.CFrame = v35.CFrame * CFrame.new(v36, 0, 0);
                    end;

                    v34.CFrame = v34.CFrame * CFrame.new(v36, 0, 0);
                else
                    if v:IsCracked() or not v:IsLoose() then
                        if not v:IsCracked() then
                            v35.CFrame = v35.CFrame * CFrame.new(u25, 0, 0);
                        end;
                    else
                        local v37 = Y2 - u25;

                        if v37 < Y then
                            local _ = Y - v37;
                            v35.Highlight.FillColor = Color3.new(0, 1, 0);
                            v35.Highlight.OutlineColor = Color3.new(0, 1, 0);
                            v35.Color = Color3.new(0, 1, 0);
                            v35.SpringConstraint.Color = BrickColor.new("Lime green");
                            v34.Highlight.OutlineColor = Color3.new(0, 1, 0);
                            v35.Position = Vector3.new(v35.Position.X, Y + v35.Size.Y / 2, v35.Position.Z);
                            v:SetCracked(true);
                            v:SetLoose(false);
                            u23:RandomPin();
                        else
                            v35.CFrame = v35.CFrame * CFrame.new(u25, 0, 0);
                        end;
                    end;

                    v34.CFrame = v34.CFrame * CFrame.new(u25, 0, 0);
                end;
            end;
        end;
    end;

    local v38 = true;

    for _, v in pairs(u1) do
        if not UserInputService:IsKeyDown(v) then
            v38 = false;
        end;
    end;

    if v38 then
        return;
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        if workspace:Blockcast(u23.Collider.CFrame, u23.Collider.Size, u23.Collider.CFrame.RightVector * -0.1) then
            return;
        end;

        local Lockpick = u23.Lockpick;
        Lockpick.CFrame = Lockpick.CFrame * CFrame.new(-u25, 0, 0);
    elseif UserInputService:IsKeyDown(Enum.KeyCode.A) then
        if workspace:Blockcast(u23.Collider.CFrame, u23.Collider.Size, u23.Collider.CFrame.RightVector * 0.1) then
            return;
        end;

        local Lockpick = u23.Lockpick;
        Lockpick.CFrame = Lockpick.CFrame * CFrame.new(u25, 0, 0);
    end;
end;

return u3;