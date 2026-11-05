  

 

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

local function CastRay(p2, p3, p4) -- Line: 40
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

return function(u6) -- Line: 58, Name: Fly
    -- upvalues: PlayerModule (copy), Trove (copy), RunService (copy), CurrentCamera (copy), CastRay (copy)
    if not u6 then
        return;
    end;

    local HumanoidRootPart = u6:FindFirstChild("HumanoidRootPart");
    local RootAttachment = HumanoidRootPart:FindFirstChild("RootAttachment");
    local v7 = u6:FindFirstChildOfClass("Humanoid");

    if not (HumanoidRootPart and (RootAttachment and v7)) then
        return;
    end;

    local u8 = PlayerModule:GetControls();
    local v9 = Trove.new();
    v9:AttachToInstance(u6);
    local u10 = v9:Clone(script.Gyros.Position);
    u10.Attachment0 = RootAttachment;
    u10.Position = HumanoidRootPart.Position;
    u10.Parent = RootAttachment;
    u10.RigidityEnabled = true;
    u10.Enabled = true;
    local u11 = v9:Clone(script.Gyros.Rotation);
    u11.Attachment0 = RootAttachment;
    u11.Parent = RootAttachment;
    u10.Enabled = true;
    local u12 = v9:Clone(script.Gyros.VerticalVelocity);
    u12.Parent = HumanoidRootPart;
    u12.Attachment0 = RootAttachment;
    u12.MaxForce = 50000;
    u12.LineDirection = Vector3.new(0, 1, 0);
    u12.Enabled = false;
    local v13 = v9:Construct(Instance, "Folder");
    v13.Name = "Animations";
    v13.Parent = script;
    local u14 = {};

    for _, child in script.Animations:GetChildren() do
        u14[child.Name] = v7.Animator:LoadAnimation(child);
        u14[child.Name]:Play(nil, 0.0001, 1);
    end;

    v9:Add(function() -- Line: 102
        -- upvalues: u14 (copy)
        for _, v in u14 do
            v:Stop();
        end;
    end);
    local u15 = os.clock();
    local u16 = nil;
    v9:Connect(RunService.PreRender, function(p17) -- Line: 113
        -- upvalues: CurrentCamera (ref), u8 (copy), u14 (copy), u16 (ref), u6 (copy), u10 (copy), u12 (copy), HumanoidRootPart (copy), CastRay (ref), u11 (copy), u15 (ref)
        local LookVector = CurrentCamera.CFrame.LookVector;
        local RightVector = CurrentCamera.CFrame.RightVector;
        local v18 = u8:GetMoveVector();

        if v18.Magnitude > 1 then
            v18 = v18.Unit;
        end;

        local _ = v18.X;
        local _ = -v18.Z;
        local v19 = Vector3.new(0, 0, 0);

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
            local v20 = math.max(0, v18[v.Type] * v.Value);
            u14[i]:AdjustWeight((math.max(0.00001, v20)));
            v19 = v19 + v.Relative * v20;
        end;

        if v18.Magnitude > 0.1 then
            u14.Idle:AdjustWeight(0.00001);
        else
            u16 = nil;
            u14.Idle:AdjustWeight(1);
        end;

        local v21 = u6:GetAttribute("ULT_FlightDisableStack") ~= nil and u6:GetAttribute("ULT_FlightDisableStack") >= 1;

        if v21 then
            u10.Enabled = false;
            u12.Enabled = true;
        end;

        if HumanoidRootPart.Anchored then
            return;
        end;

        local v22 = u6:GetAttribute("MINIMUM_HEIGHT") or 3;
        local v23 = CastRay(HumanoidRootPart.Position, Vector3.new(0, -6, 0));
        local v24 = CastRay(HumanoidRootPart.Position, (vector.create(0, -v22, 0)));
        local v25;

        if v24 then
            v25 = vector.create(v19.X, 0, v19.Z);
        else
            v25 = v19;
        end;

        if v19 == Vector3.new(0, 0, 0) and v23 ~= nil or v21 then
            if v23 ~= nil or v19 == Vector3.new(0, 0, 0) then
                u10.Enabled = false;
                u12.Enabled = true;

                if os.clock() - u15 >= 1 then
                    u12.LineVelocity = not (v24 and v21) and (CastRay(HumanoidRootPart.Position, Vector3.new(0, -3.75, 0)) == nil and -1.5 or 1.5) or v22;
                    u15 = os.clock();
                end;

                u11.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + CurrentCamera.CFrame.LookVector);
            end;
        else
            u12.Enabled = false;
            u10.Enabled = true;

            if not u16 then
                u16 = os.clock();
            end;

            local v26 = u6:GetAttribute("MAX_SPEED");

            if not v26 then
                if v18.Z < -0.1 then
                    local v27 = 0.25 * ((os.clock() - u16) * 8);
                    v26 = math.clamp(v27, 0.25, 0.8) or 0.6153846153846154;
                else
                    v26 = 0.6153846153846154;
                end;
            end;

            local v28 = v25 * v26 * p17 * 60;
            local v29 = HumanoidRootPart.Position + v28;

            if not CastRay(HumanoidRootPart.Position, v28) then
                if v24 then
                    v29 = vector.create(v29.X, v24.Position.Y + v22, v29.Z);
                end;

                u10.Position = v29;
            end;

            if v19 ~= Vector3.new(0, 0, 0) then
                u11.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + CurrentCamera.CFrame.LookVector);
            end;
        end;
    end);

    while u6.Parent and u6:GetAttribute("Flying") do
        task.wait(0.1);
    end;

    v9:Destroy();
end;