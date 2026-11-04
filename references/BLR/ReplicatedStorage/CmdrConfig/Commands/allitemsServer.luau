  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(p1, p2, p3, p4) -- Line: 4
    -- upvalues: ProfileManager (copy), ReplicatedStorage (copy)
    local v5 = ProfileManager.Profiles[p2];
    local Children = ReplicatedStorage.Assets.Customization.Cards:GetChildren();
    local Children2 = ReplicatedStorage.Assets.Customization.BallSkins:GetChildren();
    local Children3 = ReplicatedStorage.Assets.GoalEffects:GetChildren();
    local Children4 = ReplicatedStorage.Assets.Emotes:GetChildren();
    local Children5 = ReplicatedStorage.Assets.Cosmetics:GetChildren();

    for _, v in pairs(Children2) do
        local v6 = v;
        local v7 = false;

        for _, v2 in pairs(v5.Data.Customization.BallSkins) do
            if v2 == v6.Name then
                v7 = true;
            end;
        end;

        if v7 == false then
            table.insert(v5.Data.Customization.BallSkins, v6.Name);
        end;
    end;

    for _, v in pairs(Children) do
        local v8 = v;
        local v9 = false;

        for _, v2 in pairs(v5.Data.Customization.Cards) do
            if v2 == v8.Name then
                v9 = true;
            end;
        end;

        if v9 == false then
            table.insert(v5.Data.Customization.Cards, v8.Name);
        end;
    end;

    for _, v in pairs(Children3) do
        local v10 = v;
        local v11 = false;

        for _, v2 in pairs(v5.Data.Customization.GoalEffects) do
            if v2 == v10.Name then
                v11 = true;
            end;
        end;

        if v11 == false then
            table.insert(v5.Data.Customization.GoalEffects, v10.Name);
        end;
    end;

    for _, v in pairs(Children4) do
        local v12 = v;
        local v13 = false;

        for _, v2 in pairs(v5.Data.Customization.Emotes) do
            if v2 == v12.Name then
                v13 = true;
            end;
        end;

        if v13 == false then
            print("give", v12.Name);
            table.insert(v5.Data.Customization.Emotes, v12.Name);
        end;
    end;

    for _, v in pairs(Children5) do
        local v14 = v;
        local v15 = false;

        for _, v2 in pairs(v5.Data.Customization.Cosmetics) do
            if v2 == v14.Name then
                v15 = true;
            end;
        end;

        if v15 == false then
            table.insert(v5.Data.Customization.Cosmetics, v14.Name);
        end;
    end;

    return "Gave all items";
end;