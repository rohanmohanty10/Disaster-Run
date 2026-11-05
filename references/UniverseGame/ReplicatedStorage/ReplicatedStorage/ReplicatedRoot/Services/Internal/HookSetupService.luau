  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local u1 = game:GetService("RunService"):IsServer() and game.ServerStorage.ServerRoot or nil;
require(ReplicatedRoot.Core);
local WorldService = require(ReplicatedRoot.Services.Gameplay.WorldService);
local u2 = {
    Name = "HookSetupService"
};

function u2.Scan(p3, p4) -- Line: 11
    -- upvalues: u2 (copy)
    if not p4:IsA("ModuleScript") then
        if p4:IsA("Folder") then
            for _, child in pairs(p4:GetChildren()) do
                u2.Scan(p3, child);
            end;
        end;

        return;
    end;

    local v5 = require(p4);
    p3:Hook(v5.Type, v5.Name or p4.Name, v5.Priority, v5.Function);
end;

function u2._Init() -- Line: 22
    -- upvalues: u2 (copy), WorldService (copy), ReplicatedRoot (copy), u1 (copy)
    u2.Scan(WorldService.GenerateHook, ReplicatedRoot.Libraries.Gameplay.Hooks.CharacterGeneration);

    if u1 then
        u2.Scan(WorldService.GenerateHook, u1.Libraries.Gameplay.Hooks.CharacterGeneration);
    end;
end;

return u2;