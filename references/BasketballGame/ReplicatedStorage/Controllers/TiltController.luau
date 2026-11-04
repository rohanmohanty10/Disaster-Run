 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local u3 = nil;
local u4 = nil;
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.Trove);
local u5 = nil;
local v6 = Knit.CreateController({
    Name = "TiltController"
});

function v6.KnitStart(p7) -- Line: 24
    -- upvalues: u5 (ref), Knit (copy), RunService (copy), u3 (ref), u2 (ref), u4 (ref), HumanoidRootPart (ref)
    local CFrame_new_ret = CFrame.new();
    u5 = Knit.GetController("MovementController");
    RunService.RenderStepped:Connect(function(p8) -- Line: 29
        -- upvalues: u3 (ref), u2 (ref), CFrame_new_ret (ref), u4 (ref), u5 (ref), HumanoidRootPart (ref)
        if u3 == nil then
            return;
        end;

        if u2 == nil then
            return;
        end;

        if u2.WalkSpeed == 0 then
            CFrame_new_ret = CFrame.new();
            u3.C0 = u4 * CFrame_new_ret;

            return;
        end;

        if u5.States.Ability then
            CFrame_new_ret = CFrame.new();
            u3.C0 = u4 * CFrame_new_ret;

            return;
        end;

        local v9 = HumanoidRootPart.CFrame:VectorToObjectSpace(u2.MoveDirection);
        CFrame_new_ret = CFrame_new_ret:Lerp(CFrame.Angles(math.rad(-v9.Z) * 8, math.rad(-v9.X) * 8, 0), 0.2 ^ (1 / (p8 * 60)));
        u3.C0 = u4 * CFrame_new_ret;
    end);
end;

function v6.KnitInit(p10) -- Line: 40
    -- upvalues: u3 (ref), HumanoidRootPart (ref), u4 (ref), LocalPlayer (copy), u1 (ref), u2 (ref)
    task.spawn(function() -- Line: 41
        -- upvalues: u3 (ref), HumanoidRootPart (ref), u4 (ref)
        u3 = HumanoidRootPart:WaitForChild("RootJoint");
        u4 = u3.C0;
    end);
    LocalPlayer.CharacterAdded:Connect(function(p11) -- Line: 45
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref), u3 (ref), u4 (ref)
        u1 = p11;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
        u3 = HumanoidRootPart:WaitForChild("RootJoint");
        u4 = u3.C0;
    end);
end;

return v6;