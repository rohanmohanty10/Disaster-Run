 
 

return function() -- Line: 5, Name: waitUntilCutsceneEnds
    local v1 = 0;

    while v1 < 15 and workspace:FindFirstChild("CamRig") ~= nil do
        v1 = v1 + task.wait();
    end;
end;