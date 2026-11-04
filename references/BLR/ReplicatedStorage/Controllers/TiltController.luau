  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u1:WaitForChild("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local RootJoint = HumanoidRootPart:WaitForChild("RootJoint");
local C0 = RootJoint.C0;
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
local v2 = Knit.CreateController({
    Name = "TiltController"
});

function v2.KnitStart(u3) -- Line: 21
    -- upvalues: Knit (copy), RunService (copy), Humanoid (ref), LocalPlayer (copy), HumanoidRootPart (ref), RootJoint (ref), C0 (ref)
    CFrame.new();
    u3.Camera = Knit.GetController("CameraController");
    u3.SC = Knit.GetController("StatesController");
    local CFrame_new_ret = CFrame.new();
    u3.BaseTrove:Connect(RunService.RenderStepped, function(p4) -- Line: 28
        -- upvalues: Humanoid (ref), LocalPlayer (ref), HumanoidRootPart (ref), CFrame_new_ret (ref), RootJoint (ref), C0 (ref), u3 (copy)
        if Humanoid:GetState() == Enum.HumanoidStateType.FallingDown then
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true);
        end;

        if Humanoid.WalkSpeed == 0 or (LocalPlayer.Team == game.Teams.Visitor or (LocalPlayer.PlayerGui.Style.Enabled or (LocalPlayer.PlayerGui.Customization.Enabled or HumanoidRootPart.Anchored))) then
            CFrame_new_ret = CFrame.identity;
            RootJoint.C0 = C0 * CFrame_new_ret;

            return;
        end;

        local v5 = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection);
        local v6 = 0.2 ^ (1 / (p4 * 60));

        if HumanoidRootPart.Anchored or (u3.Camera.Cutscene or (u3.SC.States.Ability or workspace:FindFirstChild("NagiCam"))) then
            v5 = Vector3.new(0, 0, 0);
            v6 = 1;
        end;

        CFrame_new_ret = CFrame_new_ret:Lerp(CFrame.Angles(math.rad(-v5.Z) * 10, math.rad(-v5.X) * 10, 0), v6);
        RootJoint.C0 = C0 * CFrame_new_ret;
    end);
end;

function v2.KnitInit(u7) -- Line: 62
    -- upvalues: Trove (copy), LocalPlayer (copy), u1 (ref), Humanoid (ref), HumanoidRootPart (ref), RootJoint (ref), C0 (ref)
    u7.BaseTrove = Trove.new();
    u7.BaseTrove:Connect(LocalPlayer.CharacterAdded, function(p8) -- Line: 65
        -- upvalues: u1 (ref), Humanoid (ref), HumanoidRootPart (ref), RootJoint (ref), C0 (ref)
        u1 = p8;
        Humanoid = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
        RootJoint = HumanoidRootPart:WaitForChild("RootJoint");
        C0 = RootJoint.C0;
    end);
    u7.BaseTrove:Connect(game.Players.PlayerRemoving, function(p9) -- Line: 74
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), Humanoid (ref), u7 (copy)
        if p9 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            Humanoid = nil;
            u7.BaseTrove:Destroy();
        end;
    end);
end;

return v2;