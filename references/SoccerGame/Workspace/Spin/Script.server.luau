  

local CollectionService = game:GetService("CollectionService");

while true do
    local task_wait_ret = task.wait();
    local CFrame_Angles_ret = CFrame.Angles(0, 0.6981317007977318 * task_wait_ret, 0);

    for _, child in script.Parent:GetChildren() do
        if child:IsA("BasePart") then
            child.CFrame = child.CFrame * CFrame_Angles_ret;
        end;
    end;

    for _, v in CollectionService:GetTagged("Spin") do
        if v:IsA("BasePart") then
            v.CFrame = v.CFrame * CFrame_Angles_ret;
        end;
    end;
end;