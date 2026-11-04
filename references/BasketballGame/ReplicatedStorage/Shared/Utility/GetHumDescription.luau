 
 

local Players = game:GetService("Players");
game:GetService("ReplicatedStorage");
local Backup = script:WaitForChild("Backup");
local u1 = {};
Players.PlayerRemoving:Connect(function(p2: userdata) -- Line: 8
    -- upvalues: u1 (copy)
    if u1[p2.UserId] then
        u1[p2.UserId]:Destroy();
        u1[p2.UserId] = nil;
    end;
end);

return {
    FromUserId = function(u3: number, u4: boolean?) -- Line: 17, Name: FromUserId
        -- upvalues: u1 (copy), Players (copy), Backup (copy)
        if not u4 and u1[u3] ~= nil then
            return u1[u3];
        end;

        local success, result = pcall(function() -- Line: 24
            -- upvalues: Players (ref), u3 (copy), u4 (copy), u1 (ref)
            local HumanoidDescriptionFromUserIdAsync = Players:GetHumanoidDescriptionFromUserIdAsync(u3);

            if not u4 then
                u1[u3] = HumanoidDescriptionFromUserIdAsync;
            end;

            return HumanoidDescriptionFromUserIdAsync;
        end);

        if success == true then
            return result;
        end;

        return Backup:Clone();
    end,

    FromOutfitId = function(u5: number) -- Line: 37, Name: FromOutfitId
        -- upvalues: Players (copy), Backup (copy)
        local success, result = pcall(function() -- Line: 38
            -- upvalues: Players (ref), u5 (copy)
            return Players:GetHumanoidDescriptionFromOutfitIdAsync(u5);
        end);

        if success == true then
            return result;
        end;

        return Backup:Clone();
    end
};