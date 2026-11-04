 
 

local u1 = require("@game/ReplicatedStorage/Shared/Utility/ForgeVFX");
local u2 = require("@game/ReplicatedStorage/Shared/Utility/SfxManager");

return function(p3: any, p4: table) -- Line: 4
    -- upvalues: u2 (copy), u1 (copy)
    local Character = p4.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;

    if Character == nil or HumanoidRootPart == nil then
        return;
    end;

    local v5 = workspace:GetServerTimeNow() - p4.TimeSent;
    u2:playSound({
        Sound = p4.Transform == true and "BBZ Ninja Nine Tails" or "BBZ Ninja Ninja",
        Parent = HumanoidRootPart
    }).TimePosition = v5;
    local v6 = script["Kurama Transform"]:Clone();
    task.delay(6, v6.Destroy, v6);
    v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.39999366, 0);
    v6.Parent = workspace.Debris;
    u1.emit(v6);
end;