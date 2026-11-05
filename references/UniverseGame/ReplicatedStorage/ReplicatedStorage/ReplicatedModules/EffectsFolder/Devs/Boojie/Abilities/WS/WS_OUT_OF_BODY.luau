  

 

local u1 = false;
local RunService = game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);

local function CreateNoCollision(p2, p3) -- Line: 7
    local Folder = Instance.new("Folder");
    Folder.Name = "NoCollision";

    for _, v in pairs(p2) do
        if v:IsA("BasePart") and v.CanCollide then
            for _, v2 in pairs(p3) do
                if v2:IsA("BasePart") and v2.CanCollide then
                    local NoCollisionConstraint = Instance.new("NoCollisionConstraint");
                    NoCollisionConstraint.Part0 = v;
                    NoCollisionConstraint.Part1 = v2;
                    NoCollisionConstraint.Parent = Folder;
                end;
            end;
        end;
    end;

    return Folder;
end;

return function(p4) -- Line: 25
    -- upvalues: u1 (ref), Trove (copy), CreateNoCollision (copy), RunService (copy)
    if p4 == false then
        u1 = false;

        return;
    end;

    if u1 then
        u1 = false;
        task.wait(0.1);
    end;

    local LocalPlayer = game.Players.LocalPlayer;
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local u5 = Trove.new();
    local Humanoid = Character:WaitForChild("Humanoid");
    local CurrentCamera = game.Workspace.CurrentCamera;
    local u6 = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls();
    local moveFunction = u6.moveFunction;
    local u7 = game.Players:CreateHumanoidModelFromUserId(LocalPlayer.UserId);
    local Humanoid2 = u7:WaitForChild("Humanoid");
    Humanoid2.NameDisplayDistance = 0;
    Humanoid2.DisplayName = " ";
    local u8 = script.Animate:Clone();
    u8.Target.Value = u7;
    u8.Name = "BodyAnimate";
    u8.Parent = Character;
    u8.Disabled = false;
    CreateNoCollision(Character:GetDescendants(), u7:GetDescendants()).Parent = u7;
    u7.HumanoidRootPart.CFrame = p4 or Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4);
    u7.Parent = Character;
    CurrentCamera.CameraSubject = Humanoid2;
    u6:OnCharacterAdded(u7);

    function u6.moveFunction(p9, ...) -- Line: 71
        -- upvalues: Humanoid2 (copy)
        if Humanoid2 and Humanoid2.Parent then
            Humanoid2:Move(...);
        end;
    end;

    u5:Connect(LocalPlayer.CharacterAdded, function(p10) -- Line: 79
        -- upvalues: u1 (ref), CurrentCamera (copy), u6 (copy), moveFunction (copy), LocalPlayer (copy)
        u1 = false;
        CurrentCamera.CameraSubject = p10:WaitForChild("Humanoid");

        for _ = 1, 3 do
            u6:OnCharacterAdded(p10);
            u6.moveFunction = moveFunction;
            local v11 = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls();
            v11:OnCharacterAdded(p10);
            v11.moveFunction = moveFunction;
            task.wait(1.5);
        end;
    end);

    local function CleanUp() -- Line: 99
        -- upvalues: u1 (ref), LocalPlayer (copy), CurrentCamera (copy), u6 (copy), moveFunction (copy), u7 (copy), u8 (copy), u5 (copy)
        u1 = false;

        local function ResetControls() -- Line: 102
            -- upvalues: LocalPlayer (ref), CurrentCamera (ref), u6 (ref), moveFunction (ref)
            local Character2 = LocalPlayer.Character;
            local v12 = Character2 and Character2:FindFirstChildOfClass("Humanoid");

            if not v12 then
                return false;
            end;

            CurrentCamera.CameraSubject = v12;
            u6:OnCharacterAdded(Character2);
            u6.moveFunction = moveFunction;
            local v13 = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls();
            v13:OnCharacterAdded(Character2);
            v13.moveFunction = moveFunction;
            v12:Move(Vector3.new(0, 0, 0));

            return true;
        end;

        if not ResetControls() then
            for i = 1, 5 do
                task.wait(0.2);

                if ResetControls() then
                    break;
                end;

                local _ = i == 5;
            end;
        end;

        if u7 and u7.Parent then
            u7:Destroy();
        end;

        if u8 and u8.Parent then
            u8:Destroy();
        end;

        u5:Destroy();
    end;

    u1 = true;

    while u1 and (Character and (Character:IsDescendantOf(workspace.Living) and (Humanoid and (Humanoid.Health > 0 and (u7 and (u7.Parent and LocalPlayer.Character == Character)))))) do
        Humanoid:Move(Vector3.new(0, 0, 0));
        RunService.Heartbeat:Wait();
    end;

    CleanUp();
end;