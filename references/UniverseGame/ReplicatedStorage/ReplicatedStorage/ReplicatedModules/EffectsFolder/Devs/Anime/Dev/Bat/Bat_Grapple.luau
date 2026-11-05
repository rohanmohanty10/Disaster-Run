  

 

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };

return function(u2, p3) -- Line: 17
    -- upvalues: TweenService (copy)
    if not u2 or u2 ~= game.Players.LocalPlayer.Character and u2:GetAttribute("Vanished") then
        return;
    end;

    local GrapplingGun = u2:WaitForChild("GrapplingGun", 3);
    local u4 = u2["Right Arm"];

    if GrapplingGun then
        u4 = GrapplingGun.Barrel;
    end;

    local v5, v6, _, v7 = unpack(p3);
    local _ = u2.HumanoidRootPart;
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = workspace.Terrain;
    Attachment.WorldPosition = u4.Position;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = workspace.Terrain;
    Attachment2.WorldPosition = Attachment.WorldPosition;
    local SpringConstraint = Instance.new("SpringConstraint");
    SpringConstraint.Thickness = 0.25;
    SpringConstraint.Radius = math.max(v6 / 125, 0.35);
    SpringConstraint.Color = BrickColor.Black();
    SpringConstraint.Attachment0 = Attachment;
    SpringConstraint.Attachment1 = Attachment2;
    SpringConstraint.Visible = true;
    SpringConstraint.Coils = math.ceil(v6 / 15);
    SpringConstraint.Parent = Attachment;
    TweenService:Create(SpringConstraint, TweenInfo.new(v7), {
        Coils = 0,
        Radius = 0
    }):Play();
    TweenService:Create(Attachment2, TweenInfo.new(v7 - 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        WorldPosition = v5
    }):Play();
    task.spawn(function() -- Line: 58
        -- upvalues: u2 (copy), u4 (ref), Attachment (copy), Attachment2 (copy)
        while u2:IsDescendantOf(game) and (u2:GetAttribute("Grappling") and u4:IsDescendantOf(game)) do
            task.wait(0.1);
        end;

        Attachment:Destroy();
        Attachment2:Destroy();
    end);

    while Attachment:IsDescendantOf(game) and u2:IsDescendantOf(game) do
        Attachment.WorldPosition = u4.Position;
        task.wait();
    end;
end;