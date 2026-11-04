 
 

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local script_Parent = script.Parent;

if not script_Parent.Root.Value then
    script_Parent.Root.Changed:Wait();
end;

local v1 = require(ReplicatedStorage.Shared.Utility.Trove).new();
local Value = script_Parent.Root.Value;
local v2 = { script_Parent.Meteor };

for i = 1, 4 do
    local v3 = v2[1]:Clone();
    v3.Parent = script_Parent;
    table.insert(v2, v3);
    local _ = i;
end;

local Random_new_ret = Random.new(math.random());

for _, v in v2 do
    local u4 = Random_new_ret:NextNumber(3, 5);
    local u5 = Random_new_ret:NextNumber(0.7, 1.3) * (Random_new_ret:NextInteger(0, 1) == 1 and 1 or -1);
    local CFrame_Angles_ret = CFrame.Angles(Random_new_ret:NextNumber(-3.141592653589793, 3.141592653589793), Random_new_ret:NextNumber(-3.141592653589793, 3.141592653589793), Random_new_ret:NextNumber(-3.141592653589793, 3.141592653589793));
    v1:Add(RunService.PreRender:Connect(function(p6) -- Line: 34
        -- upvalues: CFrame_Angles_ret (ref), u5 (copy), v (copy), u4 (copy), Value (copy)
        CFrame_Angles_ret = CFrame_Angles_ret * CFrame.Angles(0, p6 * 3.141592653589793 * u5, p6 * 3.141592653589793 * u5 * 0.25);
        v.CFrame = CFrame_Angles_ret * CFrame.new(0, 0, u4) + Value.Position;
    end));
end;

v1:AttachToInstance(Value);
v1:AttachToInstance(script_Parent);