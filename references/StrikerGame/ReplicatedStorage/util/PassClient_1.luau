 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local packets = require(ReplicatedStorage.packets);
local Signal = require(ReplicatedStorage.util.Signal);
local u1 = 0;
local LocalPlayer = Players.LocalPlayer;
local u2 = {};
local v8 = {
    checkPass = function(p3: any, p4: number) -- Line: 14, Name: checkPass
        -- upvalues: MarketplaceService (copy), LocalPlayer (copy), u1 (ref), Signal (copy), packets (copy), u2 (copy)
        if typeof(p3) == "number" then
            p4 = p3;
        end;

        local v5;

        if typeof(p3) == "number" then
            v5 = MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, p4);
        else
            v5 = false;
        end;

        if v5 then
            return v5;
        end;

        local v6 = u1;
        u1 = u1 + 1;
        local v7 = Signal.new();
        packets.bytenet_checkPass.send({ p4, v6, typeof(p3) == "Player" and p3 and p3 or nil });
        u2[v6] = v7;

        return v7:Wait();
    end
};
packets.bytenet_checkPass.listen(function(p9) -- Line: 32
    -- upvalues: u2 (copy)
    local v10, v11 = unpack(p9);
    local v12 = u2[tonumber(v11)];
    v12:Fire(v10 == "1");
    task.defer(v12.Destroy, v12);
end);

return v8;