  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
require(PathShortcuts.KnitPath.Net);
local u1 = nil;
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local Content = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UI"):WaitForChild("Gameplay"):WaitForChild("Spectate"):WaitForChild("Content");
local u2 = Knit.CreateController({
    Name = "SpectateController",
    _IsSpectating = false,
    _CurrentSpectateIndex = 1,
    _MaximumSpectateIndex = 1
});

function u2.EnterSpectateMode() -- Line: 25
    -- upvalues: u2 (copy)
    u2._IsSpectating = true;
    u2.ShowSpectateGui();
    u2.ApplySpectateCamera();
end;

function u2.ExitSpectateMode() -- Line: 31
    -- upvalues: u2 (copy)
    u2._IsSpectating = false;
    u2.HideSpectateGui();
    u2.ResetSpectateCamera();
    u2.SetSpectatee(nil);
end;

function u2.GetCharacter() -- Line: 38
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
end;

function u2.IsSpectating() -- Line: 42
    -- upvalues: u2 (copy)
    return u2._IsSpectating;
end;

function u2.GetCurrentSpectatee() -- Line: 46
    -- upvalues: u2 (copy)
    return u2._Spectatee;
end;

function u2.SetSpectatee(p3) -- Line: 50
    -- upvalues: u2 (copy), u1 (ref)
    local v4 = u2.GetCurrentSpectatee();

    if v4 and (typeof(v4) == "Instance" and v4:IsA("Model")) then
        u1.Spectate:Fire(v4, false);
    end;

    if p3 then
        u2._Spectatee = p3;
        u1.Spectate:Fire(p3, true);
    end;
end;

function u2.ApplySpectateCamera() -- Line: 63
    -- upvalues: RunService (copy), u2 (copy), CurrentCamera (copy), Content (copy)
    RunService:BindToRenderStep("SpectateController", Enum.RenderPriority.Camera.Value, function(p5) -- Line: 64
        -- upvalues: u2 (ref), RunService (ref), CurrentCamera (ref), Content (ref)
        if not u2.IsSpectating() then
            RunService:UnbindFromRenderStep("SpectateController");
        end;

        u2.AdjustSpectateeMaximumIndex();
        local v6 = u2.GetSpectateeIndex();
        local v7 = u2.GetSpectatee(v6);
        local v8 = u2.GetCurrentSpectatee();

        if not v7 then
            return;
        end;

        if v7 ~= v8 then
            u2.SetSpectatee(v7);
        end;

        local v9 = v7:FindFirstChildOfClass("Humanoid");

        if not v7 then
            u2.SetSpectateeIndex(1);

            return;
        end;

        CurrentCamera.CameraSubject = v9 or v7.PrimaryPart;
        Content.Spectate.SpectateeName.Text = v7.Name;
    end);
end;

function u2.ShowSpectateGui() -- Line: 94
    -- upvalues: u2 (copy), Content (copy), Trove (copy), TweenService (copy)
    u2.LoadSpectateButtons(Content.Spectate);
    Content.Visible = true;
    local v10 = Trove.new();
    Content.Position = UDim2.fromScale(0, -0.2);
    v10:Add(TweenService:Create(Content, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0, 0)
    })):Play();
    local SpectateeName = Content.Spectate.SpectateeName;
    SpectateeName.TextTransparency = 1;
    v10:Add(TweenService:Create(SpectateeName, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        TextTransparency = 0,
        MaxVisibleGraphemes = utf8.len(SpectateeName.Text)
    })):Play();
    task.delay(1, v10.Destroy, v10);
end;

function u2.HideSpectateGui() -- Line: 115
    -- upvalues: Trove (copy), TweenService (copy), Content (copy)
    local v11 = Trove.new();
    v11:Add(TweenService:Create(Content, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0, 0.2)
    })):Play();
    v11:Add(TweenService:Create(Content.Spectate.SpectateeName, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        TextTransparency = 1,
        MaxVisibleGraphemes = 0
    })):Play();
    v11:Add(function() -- Line: 129
        -- upvalues: Content (ref)
        Content.Visible = false;
    end);
    task.delay(1, v11.Destroy, v11);
end;

function u2.LoadSpectateButtons(p12) -- Line: 136
    -- upvalues: u2 (copy)
    if not u2._ButtonsLoaded then
        local Left = p12:WaitForChild("Left");
        local Right = p12:WaitForChild("Right");
        u2.CreateSpectateSwapIndexButton(Left, -1);
        u2.CreateSpectateSwapIndexButton(Right, 1);
        u2._ButtonsLoaded = true;
    end;
end;

function u2.CreateSpectateSwapIndexButton(p13, u14) -- Line: 148
    -- upvalues: u2 (copy)
    p13.MouseButton1Click:Connect(function() -- Line: 149
        -- upvalues: u2 (ref), u14 (copy)
        local v15 = u2.GetSpectateeIndex();
        local v16 = u2.GetMaximumSpectateIndex();
        local v17 = v15 + u14;

        if v17 >= 1 then
            v16 = v16 < v17 and 1 or v17;
        end;

        u2.SetSpectateeIndex(v16);
    end);
end;

function u2.ResetSpectateCamera() -- Line: 165
    -- upvalues: u2 (copy), CurrentCamera (copy)
    local v18 = u2.GetCharacter();
    CurrentCamera.CameraType = Enum.CameraType.Custom;
    CurrentCamera.CameraSubject = v18:WaitForChild("Humanoid");
end;

function u2.AdjustSpectateeMaximumIndex() -- Line: 171
    -- upvalues: u2 (copy)
    u2._MaximumSpectateIndex = #u2.GetSpectateeList();

    if u2.GetSpectateeIndex() > u2._MaximumSpectateIndex then
        u2.SetSpectateeIndex(u2._MaximumSpectateIndex);
    end;
end;

function u2.GetSpectateeIndex() -- Line: 180
    -- upvalues: u2 (copy)
    return u2._CurrentSpectateIndex;
end;

function u2.SetSpectateeIndex(p19) -- Line: 184
    -- upvalues: u2 (copy)
    u2._CurrentSpectateIndex = p19;
end;

function u2.GetMaximumSpectateIndex() -- Line: 188
    -- upvalues: u2 (copy)
    return u2._MaximumSpectateIndex;
end;

function u2.IsSpectatable(p20) -- Line: 192
    return p20:GetAttribute("Spectatable");
end;

function u2.GetSpectateeList() -- Line: 196
    -- upvalues: Players (copy), LocalPlayer (copy), u2 (copy)
    local v21 = Players:GetPlayers();
    table.remove(v21, table.find(v21, LocalPlayer));

    for i, v in v21 do
        if not u2.IsSpectatable(v) then
            table.remove(v21, i);
        end;
    end;

    return v21;
end;

function u2.GetSpectatee(p22) -- Line: 210
    -- upvalues: u2 (copy)
    local v23 = u2.GetSpectateeList()[p22];

    return v23 and v23.Character or nil;
end;

function u2.KnitStart() -- Line: 217
    -- upvalues: u1 (ref), Knit (copy), u2 (copy)
    u1 = Knit.GetService("SpectateService");
    u1.Spectate:Connect(function(p24) -- Line: 220
        -- upvalues: u2 (ref)
        if p24 == true then
            u2:EnterSpectateMode();

            return;
        end;

        if p24 == false then
            u2:ExitSpectateMode();
        end;
    end);
end;

return u2;