  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
Random.new();
local u1 = Trove.new();
local u2 = nil;

return function(p3) -- Line: 13
    -- upvalues: u1 (copy), u2 (ref)
    u1:Clean();

    if not p3 then
        if u2.Parent ~= game.Lighting then
            task.defer(function() -- Line: 66
                -- upvalues: u2 (ref)
                u2.Parent = game.Lighting;
            end);
        end;

        return;
    end;

    local u4 = {};

    for i, v in pairs(p3:GetAttributes()) do
        u4[i] = game.Lighting[i];
        game.Lighting[i] = v;
    end;

    u1:Add(function() -- Line: 22
        -- upvalues: u4 (copy)
        for i, v in pairs(u4) do
            game.Lighting[i] = v;
        end;
    end);

    for _, child in pairs(p3:GetChildren()) do
        if child:IsA("Sky") then
            if not u2 then
                u2 = game.Lighting:FindFirstChildWhichIsA("Sky");
            end;

            if u2 then
                u2.Parent = nil;
            end;

            local u5 = u1:Clone(child);
            task.defer(function() -- Line: 37
                -- upvalues: u5 (copy)
                u5.Parent = game.Lighting;
            end);
        elseif child:IsA("PostEffect") then
            u1:Clone(child).Parent = game.Lighting;
        elseif child:IsA("Atmosphere") then
            local u6 = {};

            for _, v in pairs({ "Density", "Offset", "Color", "Decay", "Glare", "Haze" }) do
                u6[v] = game.Lighting.Atmosphere[v];
                game.Lighting.Atmosphere[v] = child[v];
            end;

            u1:Add(function() -- Line: 57
                -- upvalues: u6 (copy)
                for i, v in pairs(u6) do
                    game.Lighting.Atmosphere[i] = v;
                end;
            end);
        end;
    end;
end;