 
 

local RunService = game:GetService("RunService");
local Head = script.Parent.Parent:FindFirstChild("Head");
local script_Parent = script.Parent;
script_Parent.Size = script_Parent.Size * 0.4;
local math_random_ret = math.random(-100000, 100000);
local u1 = nil;
u1 = RunService.Heartbeat:Connect(function(p2) -- Line: 11
    -- upvalues: script_Parent (copy), u1 (ref), math_random_ret (copy), Head (copy)
    if not script_Parent:IsDescendantOf(workspace) then
        u1:Disconnect();

        return;
    end;

    local v3 = time() + math_random_ret;
    local CFrame_Angles = CFrame.Angles;
    local v4 = (v3 % 360 - 180) * 5 * math.sin(v3);
    script_Parent.CFrame = CFrame_Angles(0, math.rad(v4), 0) + (CFrame.Angles(0, math.rad(v3 * 45 % 360 - 180), 0) * CFrame.new(0, math.sin(v3 * 2) * 0.4 + 0.5, -2)).Position + Head.Position;
end);