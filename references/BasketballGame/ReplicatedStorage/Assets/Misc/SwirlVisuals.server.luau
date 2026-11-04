 
 

local RunService = game:GetService("RunService");
local Parent = script.Parent.Parent.Parent;
local HumanoidRootPart = Parent:WaitForChild("HumanoidRootPart");
local Torso = Parent:FindFirstChild("Torso");
local script_Parent = script.Parent;
local math_random_ret = math.random(-100000, 100000);
local v1 = script.Sound:Clone();
v1.Parent = script_Parent;
v1:Play();
local u2 = nil;
u2 = RunService.Heartbeat:Connect(function(p3) -- Line: 14
    -- upvalues: script_Parent (copy), u2 (ref), math_random_ret (copy), HumanoidRootPart (copy), Torso (copy)
    if not script_Parent:IsDescendantOf(workspace) then
        u2:Disconnect();

        return;
    end;

    local v4 = time() + math_random_ret;
    local v5, _, v6 = HumanoidRootPart.CFrame:ToOrientation();
    script_Parent.CFrame = CFrame.new(Torso.Position) * CFrame.fromOrientation(v5, math.rad(v4 * 45 % 360 - 180), v6);
end);