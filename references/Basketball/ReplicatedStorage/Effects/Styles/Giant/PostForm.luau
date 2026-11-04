 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 13
    -- upvalues: Essentials (copy), VfxManager (copy), RunService (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local v3 = script.StartUp:Clone();
    v3.Parent = workspace.Debris;
    v3.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(v3, HumanoidRootPart);
    VfxManager.Emit(v3);
    task.delay(3, v3.Destroy, v3);
    local u4 = tick() + 5;
    local u5 = false;
    local BALL = Char:FindFirstChild("BALL", true);
    local u6 = nil;
    u6 = RunService.RenderStepped:Connect(function(p7) -- Line: 35
        -- upvalues: HumanoidRootPart (copy), u4 (copy), u6 (ref), VfxManager (ref), BALL (copy), Char (copy), u5 (ref)
        local v8 = HumanoidRootPart:FindFirstChildWhichIsA("LinearVelocity");

        if u4 <= tick() then
            u6:Disconnect();

            return;
        end;

        if HumanoidRootPart and HumanoidRootPart:FindFirstChildWhichIsA("AlignPosition") then
            local v9 = script.Jump:Clone();
            v9.Parent = workspace.Debris;
            v9:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.Emit(v9);
            task.delay(3, v9.Destroy, v9);
            u6:Disconnect();

            return;
        end;

        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret:AddToFilter(BALL.Parent);
        RaycastParams_new_ret:AddToFilter(Char);

        if workspace:Raycast(BALL.Position, Vector3.new(-0, -1.2, -0), RaycastParams_new_ret) and not u5 then
            u5 = true;
            task.delay(0.25, function() -- Line: 62
                -- upvalues: u5 (ref)
                u5 = false;
            end);
            local v10 = script.Dribble:Clone();
            v10.Parent = workspace.Debris;
            v10:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.Emit(v10);
            task.delay(3, v10.Destroy, v10);
        end;

        if v8 then
            return;
        end;

        u6:Disconnect();
    end);
end;