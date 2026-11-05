  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local _ = PathShortcuts.RunService;
require(PathShortcuts.GenericModule);
game.ReplicatedStorage:WaitForChild("Client Assets");
game:GetService("TweenService");

return function(u1) -- Line: 9
    -- upvalues: PathShortcuts (copy)
    if not u1 then
        return;
    end;

    local GearWeld = u1.Stand["Stand Left Arm"].GearWeld;

    if not u1:GetAttribute("Posing") then
        local u2 = nil;
        local u3 = coroutine.running();
        u2 = u1:GetAttributeChangedSignal("Posing"):Once(function() -- Line: 18
            -- upvalues: u2 (ref), u3 (copy)
            u2:Disconnect();
            u2 = nil;
            coroutine.resume(u3, true);
        end);
        task.delay(0.5, coroutine.resume, u3, false);

        if not coroutine.yield() then
            u2:Disconnect();
            u2 = nil;

            return;
        end;
    end;

    local u4 = 0;
    local u5 = nil;
    u5 = PathShortcuts.RunService.PreSimulation:Connect(function(p6) -- Line: 36
        -- upvalues: u1 (copy), u5 (ref), u4 (ref), GearWeld (copy)
        if not (u1:IsDescendantOf(workspace) and u1:GetAttribute("Posing")) then
            u5:Disconnect();
            u5 = nil;
        end;

        u4 = (u4 + p6 * 150) % 360;
        GearWeld.Transform = CFrame.Angles(0, math.rad(u4), 0);
    end);
end;