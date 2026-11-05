  

 

game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;

if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait();
end;

local PlayerModule = require(LocalPlayer:WaitForChild("PlayerScripts").PlayerModule);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };

local function CastRay(p2, p3, p4) -- Line: 39
    -- upvalues: u1 (copy)
    local v5 = workspace:Raycast(p2, p3 or Vector3.new(-0, -8, -0), p4 or u1);

    if v5 then
        return table.freeze({
            Position = v5.Position,
            Normal = v5.Normal,
            Color = v5.Instance.Color,
            Material = v5.Instance.Material,
            Instance = v5.Instance,
            Transparency = v5.Instance.Transparency,
            Raw = v5
        });
    end;
end;

return function(p6) -- Line: 57, Name: Fly
    -- upvalues: PlayerModule (copy), Trove (copy), RunService (copy), CurrentCamera (copy), CastRay (copy)
    if not p6 then
        return;
    end;

    local HumanoidRootPart = p6:FindFirstChild("HumanoidRootPart");
    local RootAttachment = HumanoidRootPart:FindFirstChild("RootAttachment");
    local v7 = p6:FindFirstChildOfClass("Humanoid");

    if not (HumanoidRootPart and (RootAttachment and v7)) then
        return;
    end;

    local u8 = PlayerModule:GetControls();
    local v9 = Trove.new();
    v9:AttachToInstance(p6);
    local u10 = v9:Clone(script.Gyros.Position);
    u10.Attachment0 = RootAttachment;
    u10.Position = HumanoidRootPart.Position;
    u10.Parent = RootAttachment;
    u10.RigidityEnabled = true;
    local u11 = v9:Clone(script.Gyros.Rotation);
    u11.Attachment0 = RootAttachment;
    u11.Parent = RootAttachment;
    local v12 = v9:Construct(Instance, "Folder");
    v12.Name = "Animations";
    v12.Parent = script;
    local u13 = {};

    for _, child in script.Animations:GetChildren() do
        u13[child.Name] = v7.Animator:LoadAnimation(child);
        u13[child.Name]:Play(nil, 0.0001, 1);
    end;

    v9:Add(function() -- Line: 92
        -- upvalues: u13 (copy)
        for _, v in u13 do
            v:Stop();
        end;
    end);
    v9:Connect(RunService.PreRender, function(p14) -- Line: 98
        -- upvalues: CurrentCamera (ref), u8 (copy), u13 (copy), HumanoidRootPart (copy), CastRay (ref), u10 (copy), u11 (copy)
        local LookVector = CurrentCamera.CFrame.LookVector;
        local RightVector = CurrentCamera.CFrame.RightVector;
        local v15 = u8:GetMoveVector();

        if v15.Magnitude > 1 then
            v15 = v15.Unit;
        end;

        local _ = v15.X;
        local _ = -v15.Z;
        local v16 = Vector3.new(0, 0, 0);

        for i, v in {
            Forward = {
                Type = "Z",
                Value = -1,
                Relative = LookVector
            },
            Backwards = {
                Type = "Z",
                Value = 1,
                Relative = -LookVector
            },
            Left = {
                Type = "X",
                Value = -1,
                Relative = -RightVector
            },
            Right = {
                Type = "X",
                Value = 1,
                Relative = RightVector
            }
        } do
            local v17 = math.max(0, v15[v.Type] * v.Value);
            u13[i]:AdjustWeight((math.max(0.00001, v17)));
            v16 = v16 + v.Relative * v17;
        end;

        if v15.Magnitude > 0.1 then
            u13.Idle:AdjustWeight(0.00001);
        else
            u13.Idle:AdjustWeight(1);
        end;

        local v18 = math.clamp(v15.Z * -1, 0, 1);
        local v19 = math.lerp(25, 50, v18);

        if HumanoidRootPart.Anchored then
            return;
        end;

        if CastRay(HumanoidRootPart.Position, v16 * (v19 * p14)) == nil then
            u10.Position = HumanoidRootPart.Position + v16 * (v19 * p14);
        end;

        if v16 ~= Vector3.new(0, 0, 0) then
            u11.CFrame = CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + CurrentCamera.CFrame.LookVector);
        end;
    end);

    while p6.Parent and (p6:GetAttribute("Flying") and not p6:GetAttribute("InCombat")) do
        task.wait(0.1);
    end;

    v9:Destroy();
end;