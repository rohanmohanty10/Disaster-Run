 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local SmartBone = require(ReplicatedStorage.Shared.Utility.SmartBone);
local u1 = Knit.CreateController({
    Name = "SmartboneController",
    Stop = nil
});

function u1.OnPlatformChanged(p2: string) -- Line: 11
    -- upvalues: u1 (copy), SmartBone (copy)
    if p2 == "Touchscreen" then
        if u1.Stop then
            u1.Stop();
            u1.Stop = nil;
        end;
    elseif not u1.Stop then
        local v3 = SmartBone.Start();

        if v3 ~= nil then
            u1.Stop = v3.Stop;
        end;
    end;
end;

function u1.KnitInit(p4) -- Line: 28
end;

function u1.KnitStart(p5) -- Line: 32
end;

return u1;