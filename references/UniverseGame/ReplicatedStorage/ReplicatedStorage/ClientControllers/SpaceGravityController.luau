  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local LocalPlayer = game.Players.LocalPlayer;
local PlayerModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"));
PlayerModule:GetCameras();
PlayerModule:GetControls();
local CurrentCamera = game.Workspace.CurrentCamera;
local Lighting = game:GetService("Lighting");
game:GetService("RunService");
game:GetService("UserInputService");
LocalPlayer:GetMouse();
local v1 = Knit.CreateController({
    Name = "SpaceGravityController",
    Enabled = true,
    InSpace = false,
    Character = nil,
    Humanoid = nil,
    RootPart = nil,
    Height = nil,
    TargetVelocity = Vector3.new(0, 0, 0)
});

function v1.EnterSpace(p2) -- Line: 36
    -- upvalues: Lighting (copy), LocalPlayer (copy), PathShortcuts (copy), CurrentCamera (copy)
    if not p2:IsValid() then
        return;
    end;

    if p2.Velocity then
        p2.Velocity:Destroy();
    end;

    local VectorForce = Instance.new("VectorForce");
    p2.Velocity = VectorForce;
    p2.Velocity.ApplyAtCenterOfMass = true;
    VectorForce.RelativeTo = Enum.ActuatorRelativeTo.Attachment0;
    p2.Velocity.Attachment0 = p2.RootPart:FindFirstChildWhichIsA("Attachment");
    p2.Velocity.Parent = p2.RootPart;
    Lighting.ClockTime = 0;
    LocalPlayer.PlayerGui.UI.Gameplay.SpaceInfo.Visible = true;

    if not p2.Skybox then
        local v3 = PathShortcuts.ClientAssets["P//S_R"].Skybox:Clone();
        v3.Parent = CurrentCamera;
        p2.Skybox = v3;
    end;
end;

function v1.ExitSpace(p4) -- Line: 60
    -- upvalues: Lighting (copy), LocalPlayer (copy)
    if not p4:IsValid() then
        return;
    end;

    if p4.Velocity then
        p4.Velocity:Destroy();
    end;

    Lighting.ClockTime = 13;
    p4.TargetVelocity = Vector3.new(0, 0, 0);
    LocalPlayer.PlayerGui.UI.Gameplay.SpaceInfo.Visible = false;
end;

function v1.Set(p5) -- Line: 69
    if not p5.RootPart then
        return;
    end;

    p5.Height = p5.RootPart.Position.Y;
    workspace.Gravity = math.clamp(196.2 - p5.Height / 4000 * 196.2, 0, 196.2);

    if p5.Height > 4000 then
        p5.InSpace = true;

        return;
    end;

    p5.InSpace = false;
end;

function v1.Get(p6) -- Line: 82
    return p6.InSpace;
end;

function v1.IsValid(p7) -- Line: 86
    return (p7.RootPart or p7.Character) and true or false;
end;

function v1.Update(p8, p9) -- Line: 93
    -- upvalues: Lighting (copy), CurrentCamera (copy)
    if not p8:IsValid() then
        return;
    end;

    p8:Set();

    if p8.InSpace and not p8.Enabled then
        p8:EnterSpace();
        p8.Enabled = true;
    elseif not p8.InSpace and p8.Enabled then
        p8:ExitSpace();
        p8.Enabled = false;
    end;

    if not p8.Enabled then
        return;
    end;

    if p8.InSpace then
        Lighting.ClockTime = 0;

        if p8.Skybox then
            p8.Skybox.CFrame = CurrentCamera.CFrame;
        end;
    elseif p8.Skybox then
        p8.Skybox:Destroy();
    end;

    if not p8.Velocity then
        return;
    end;

    p8.Velocity.Force = p8.Velocity.Force:Lerp(p8.TargetVelocity, 0.4);
end;

function v1.CharacterAdded(p10, p11) -- Line: 126
    p10.Character = p11;
    p10.Humanoid = p11:WaitForChild("Humanoid");
    p10.RootPart = p11:WaitForChild("HumanoidRootPart");
end;

local u12 = {
    [Enum.KeyCode.W] = Vector3.new(0, 0, -200),
    [Enum.KeyCode.A] = Vector3.new(-200, 0, 0),
    [Enum.KeyCode.S] = Vector3.new(0, 0, 200),
    [Enum.KeyCode.D] = Vector3.new(200, 0, 0),
    [Enum.KeyCode.Space] = Vector3.new(0, 100, 0),
    [Enum.KeyCode.Z] = Vector3.new(0, -300, 0),
    [Enum.KeyCode.Up] = Vector3.new(0, 0, -1),
    [Enum.KeyCode.Left] = Vector3.new(-1, 0, 0),
    [Enum.KeyCode.Down] = Vector3.new(0, 0, 1),
    [Enum.KeyCode.Right] = Vector3.new(1, 0, 0)
};

function v1.InputBegan(p13, p14, p15) -- Line: 148
    -- upvalues: u12 (copy)
    if not p13.Enabled or p15 then
        return;
    end;

    if u12[p14.KeyCode] then
        p13.TargetVelocity = p13.TargetVelocity + u12[p14.KeyCode];
    end;
end;

function v1.InputEnded(p16, p17, p18) -- Line: 157
    -- upvalues: u12 (copy)
    if not p16.Enabled or p18 then
        return;
    end;

    if u12[p17.KeyCode] then
        p16.TargetVelocity = p16.TargetVelocity - u12[p17.KeyCode];
    end;
end;

function v1.TouchTap(p19, p20, p21) -- Line: 167
    -- upvalues: CurrentCamera (copy)
    if not p19.Enabled or p21 then
        return;
    end;

    local v22 = p20[1];
    local ViewportSize = CurrentCamera.ViewportSize;
    p19.TargetVelocity = Vector3.new(ViewportSize.X / v22.X - 0.5, 0, ViewportSize.Y / v22.Y - 0.5) * 100;
end;

function v1.KnitStart(p23) -- Line: 183
end;

return v1;