  

local RunService = game:GetService("RunService");
local u3 = RunService:IsClient() and (function() -- Line: 23, Name: WaitForRemoteFolder
    local v1 = false;
    local v2;

    while true do
        v2 = script:WaitForChild("Remotes", 30);

        if v2 then
            break;
        end;

        if not v1 then
            warn("[Gamebeast] Remote folder not found after 30 seconds, infinite yield is possible.");
            v1 = true;
        end;

        if v2 ~= nil then
            return;
        end;
    end;

    return v2;
end)() or Instance.new("Folder", script);
u3.Name = "Remotes";
local u4 = RunService:IsServer();

return function(p5: string, p6: string) -- Line: 58
    -- upvalues: u4 (copy), u3 (copy)
    local v7;

    if u4 then
        v7 = u3:FindFirstChild(p5 .. p6);
    else
        v7 = u3:WaitForChild(p5 .. p6);
    end;

    if not v7 then
        v7 = Instance.new("Remote" .. p5, u3);
        v7.Name = p5 .. p6;
    end;

    return v7;
end;