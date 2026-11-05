  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local LocalPlayer = game.Players.LocalPlayer;
local PlayerModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"));
PlayerModule:GetCameras();
PlayerModule:GetControls();
local CurrentCamera = game.Workspace.CurrentCamera;
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local u1 = LocalPlayer:GetMouse();
local v2 = Knit.CreateController({
    Name = "LockOnController",
    Enabled = true,
    Character = nil,
    Humanoid = nil,
    RootPart = nil,
    Target = nil,
    TargetPart = nil
});

function v2.Set(p3, p4) -- Line: 31
    if not p4 then
        p3.Target = nil;
        p3.TargetPart = nil;

        return false;
    end;

    local v5 = p4:FindFirstChild("HumanoidRootPart") or (p4.PrimaryPart or p4:FindFirstChildWhichIsA("BasePart"));

    if v5 then
        p3.Target = p4;
        p3.TargetPart = v5;

        return true;
    end;
end;

function v2.Get(p6) -- Line: 46
    return p6.Target;
end;

function v2.ShouldUnlock(p7) -- Line: 50
    local v8 = p7.Target and (p7.Target:HasTag("TimeErase") or (p7.Target:HasTag("Vanished") or p7.Target:GetAttribute("Vanished")));

    return v8;
end;

function v2.IsValid(p9) -- Line: 54
    -- upvalues: LocalPlayer (copy), CurrentCamera (copy)
    if not p9.Target or (p9:ShouldUnlock() or not (p9.TargetPart and p9.TargetPart:IsDescendantOf(workspace))) then
        return false;
    end;

    if LocalPlayer.Character and (CurrentCamera.CameraSubject and (CurrentCamera.CameraSubject:IsA("Humanoid") and CurrentCamera.CameraSubject.Parent == LocalPlayer.Character)) then
        return CurrentCamera.CameraType ~= Enum.CameraType.Scriptable;
    end;

    return false;
end;

function v2.IsActive(p10) -- Line: 67
    return p10.Enabled and (p10.Target and p10.TargetPart) and true or false;
end;

function v2.Find(p11, u12) -- Line: 74
    local v13 = OverlapParams.new();
    v13.FilterType = Enum.RaycastFilterType.Include;
    v13.FilterDescendantsInstances = { workspace.Living };
    v13.CollisionGroup = "Raycast";
    local v14 = {};

    for _, v in pairs(workspace:GetPartBoundsInRadius(u12, 6, v13)) do
        if not v:IsDescendantOf(p11.Character) then
            local Humanoid = v.Parent:FindFirstChild("Humanoid");

            if Humanoid then
                warn(Humanoid:GetFullName());
                local v15 = v.Parent:FindFirstChild("HumanoidRootPart") or (v.Parent.PrimaryPart or v.Parent:FindFirstChildWhichIsA("BasePart"));

                if v15 then
                    table.insert(v14, {
                        Part = v15,
                        Humanoid = Humanoid,
                        Character = v.Parent
                    });
                end;
            end;
        end;
    end;

    table.sort(v14, function(p16, p17) -- Line: 109
        -- upvalues: u12 (copy)
        return (u12 - p16.Part.Position).Magnitude < (u12 - p17.Part.Position).Magnitude;
    end);

    for _, v in pairs(v14) do
        local v18 = p11:Set(v.Character);

        if v18 then
            return v18;
        end;
    end;

    return nil;
end;

function v2.Update(p19, p20) -- Line: 125
    -- upvalues: CurrentCamera (copy)
    if not p19.Enabled then
        return;
    end;

    if p19:ShouldUnlock() then
        p19:Set(nil);

        return;
    end;

    if p19:IsValid() then
        local v21 = p19.RootPart.Position + Vector3.new(0, 4.25, 0);
        local Position = p19.TargetPart.Position;
        local v22 = CFrame.lookAt(v21, Position):ToOrientation() * 180 / 3.141592653589793;
        local v23 = math.clamp(v22, -30, 50);
        local v24 = CFrame.lookAt(v21, Position * Vector3.new(1, 0, 1) + v21 * Vector3.new(0, 1, 0)) * CFrame.Angles(math.rad(v23), 0, 0);
        CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(v24, 0.2);
    end;
end;

function v2.CharacterAdded(p25, p26) -- Line: 151
    p25.Character = p26;
    p25.Humanoid = p26:WaitForChild("Humanoid");
    p25.RootPart = p26:WaitForChild("HumanoidRootPart");
end;

function v2.InputBegan(p27, p28, p29) -- Line: 157
    -- upvalues: u1 (copy)
    if not p29 and (p28.KeyCode == Enum.KeyCode.L or p28.UserInputType == Enum.UserInputType.MouseButton3) and not p27:Find(u1.Hit.Position) then
        p27:Set(nil);
    end;
end;

function v2.KnitStart(u30) -- Line: 169
    -- upvalues: LocalPlayer (copy), UserInputService (copy), RunService (copy)
    LocalPlayer.CharacterAdded:Connect(function(p31) -- Line: 170
        -- upvalues: u30 (copy)
        u30:CharacterAdded(p31);
    end);

    if LocalPlayer.Character then
        task.spawn(function() -- Line: 174
            -- upvalues: u30 (copy), LocalPlayer (ref)
            u30:CharacterAdded(LocalPlayer.Character);
        end);
    end;

    UserInputService.InputBegan:Connect(function(p32, p33) -- Line: 179
        -- upvalues: u30 (copy)
        u30:InputBegan(p32, p33);
    end);
    RunService:BindToRenderStep("LockOnController", Enum.RenderPriority.Camera.Value + 1, function(p34) -- Line: 183
        -- upvalues: u30 (copy)
        u30:Update(p34);
    end);
end;

return v2;