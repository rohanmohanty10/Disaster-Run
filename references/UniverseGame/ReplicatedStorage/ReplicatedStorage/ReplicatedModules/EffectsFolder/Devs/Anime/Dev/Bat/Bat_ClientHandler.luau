  

 

game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local u2 = LocalPlayer:GetMouse();

return function() -- Line: 22
    -- upvalues: LocalPlayer (copy), Trove (copy), RunService (copy), u2 (copy), CurrentCamera (copy), u1 (copy)
    local u3 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local HumanoidRootPart = u3.HumanoidRootPart;
    local v4 = Trove.new();
    v4:AttachToInstance(u3);
    local u5 = v4:Clone(script.Grapple);
    u5.BillboardGui.MaxDistance = 250;
    u5.Parent = workspace.Effects;
    v4:Connect(RunService.RenderStepped, function(p6) -- Line: 33
        -- upvalues: u5 (copy), u3 (copy), LocalPlayer (ref), u2 (ref), CurrentCamera (ref), u1 (ref), HumanoidRootPart (copy)
        if u5:GetAttribute("GrappleUIFX") then
            return;
        end;

        local ImageLabel = u5.BillboardGui.ImageLabel;
        ImageLabel.Rotation = ImageLabel.Rotation + p6 * 60;
        u5.BillboardGui.Enabled = not u3:GetAttribute("Grappling");

        if u3:GetAttribute("Vaulting") or (LocalPlayer.PlayerGui:FindFirstChild("SelectScreen") or u3:GetAttribute("MoveActive") and not u3:GetAttribute("Gliding")) then
            u5.BillboardGui.Enabled = false;

            return;
        end;

        if u3:GetAttribute("Grappling") then
            u5.BillboardGui.Enabled = false;

            return;
        end;

        local Unit = (u2.Hit.Position - CurrentCamera.CFrame.Position).Unit;
        local v7 = workspace:Raycast(CurrentCamera.CFrame.Position, Unit * 250, u1);

        if not v7 then
            u5.BillboardGui.Enabled = false;

            return;
        end;

        u5.RayInstance.Value = v7.Instance;
        u5.RayPosition.Value = v7.Position;
        u5.RayNormal.Value = v7.Normal;

        if v7.Instance.Position.Y + v7.Instance.Size.Y / 2 >= HumanoidRootPart.Position.Y - 30 and v7.Instance.Position.Y + v7.Instance.Size.Y / 2 <= HumanoidRootPart.Position.Y then
            u5.BillboardGui.Enabled = false;

            return;
        end;

        u5.BillboardGui.Enabled = true;
        local v8 = Vector3.new(v7.Position.X, v7.Instance.Position.Y + v7.Instance.Size.Y / 2, v7.Position.Z);
        local v9 = workspace:Raycast(v8 + Unit * Vector3.new(1, 0, 1) + Vector3.new(0, 0.25, 0), Vector3.new(0, -v7.Instance.Size.Y, 0), u1);

        if v9 then
            v8 = v9.Position or v8;
        end;

        if (v8 - HumanoidRootPart.Position).Magnitude > 250 then
            u5.BillboardGui.Enabled = false;

            return;
        end;

        u5.Position = v8;
    end);
end;