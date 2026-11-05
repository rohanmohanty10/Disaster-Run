  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

local function Destroy(p1) -- Line: 3
    -- upvalues: Destroy (copy)
    for _, v in pairs(p1) do
        if type(v) == "table" then
            if v.Destroy then
                v:Destroy();
            else
                Destroy(v);
            end;
        elseif type(v) == "userdata" and v.Destroy then
            v:Destroy();
        end;
    end;
end;

local function YieldIndex(p2, p3) -- Line: 18
    for _, v in pairs(p3:split("/")) do
        p2 = p2:WaitForChild(v);
    end;

    return p2;
end;

local v4 = ReplicatedStorage;

for _, v in pairs(("ReplicatedModules"):split("/")) do
    ReplicatedStorage = ReplicatedStorage:WaitForChild(v);
end;

local v5 = {
    RunService = game:GetService("RunService"),
    ReplicatedStorage = v4,
    MarketService = game:GetService("MarketplaceService"),
    CollectionService = game:GetService("CollectionService"),
    Players = game:GetService("Players")
};
local v6 = ReplicatedStorage;

for _, v in pairs(("KnitPackage"):split("/")) do
    ReplicatedStorage = ReplicatedStorage:WaitForChild(v);
end;

v5.KnitPath = ReplicatedStorage;
local v7 = v4;

for _, v in pairs(("Client Assets"):split("/")) do
    v4 = v4:WaitForChild(v);
end;

v5.ClientAssetsPath = v4;
local v8 = v7;

for _, v in pairs(("ClientControllers"):split("/")) do
    v7 = v7:WaitForChild(v);
end;

v5.ClientControllers = v7;
local v9 = v8;

for _, v in pairs(("ClientLibrary"):split("/")) do
    v8 = v8:WaitForChild(v);
end;

v5.ClientLibrary = v8;
v5.ReplicatedModules = v6;
local v10 = v9;

for _, v in pairs(("Remotes"):split("/")) do
    v9 = v9:WaitForChild(v);
end;

v5.RemotesPath = v9;
local v11 = v10;

for _, v in pairs(("ClientModules"):split("/")) do
    v10 = v10:WaitForChild(v);
end;

v5.ClientModulesPath = v10;
local v12 = v6;

for _, v in pairs(("Skins"):split("/")) do
    v6 = v6:WaitForChild(v);
end;

v5.SkinsModule = v6;
local v13 = v12;

for _, v in pairs(("Stands"):split("/")) do
    v12 = v12:WaitForChild(v);
end;

v5.StandsModule = v12;
local v14 = v13;

for _, v in pairs(("Animations"):split("/")) do
    v13 = v13:WaitForChild(v);
end;

v5.AnimsModule = v13;
local v15 = v14;

for _, v in pairs(("ItemData"):split("/")) do
    v14 = v14:WaitForChild(v);
end;

v5.ItemDataModule = v14;
local v16 = v15;

for _, v in pairs(("Enums"):split("/")) do
    v15 = v15:WaitForChild(v);
end;

v5.EnumsModule = v15;
local v17 = v16;

for _, v in pairs(("Generic"):split("/")) do
    v16 = v16:WaitForChild(v);
end;

v5.GenericModule = v16;

for _, v in pairs(("BaseStats"):split("/")) do
    v17 = v17:WaitForChild(v);
end;

v5.BaseStatsModule = v17;
v5.DestroyFunction = Destroy;
v5.TestPlaces = { 9125324244, 10444059340, 9690974327, 15120891286, 88260739977198 };
v5.GameModePlaces = { 6890041519, 9762298537, 10444060200 };
v5.LinkedPlaces = {
    [1900951801] = {
        TitleScreen = 5431771993,
        GameModeLobby = 9715033059,
        GameModePlace = 15120891286,
        Arena = 96407804143331,
        MainGame = game.PlaceId == 88260739977198 and 88260739977198 or 9690974327
    },
    [2913165147] = {
        TitleScreen = 7481660839,
        MainGame = 10444059340,
        GameModeLobby = 10444059919,
        GameModePlace = 10444060200
    },
    [1782832995] = {
        TitleScreen = 5130598377,
        MainGame = 6846458508,
        GameModeLobby = 8008202756,
        GameModePlace = 8023712967,
        Arena = 94960960966233
    }
};
local v18 = v11;

for _, v in pairs(("Client Assets"):split("/")) do
    v11 = v11:WaitForChild(v);
end;

v5.ClientAssets = v11;

for _, v in pairs(("Remotes"):split("/")) do
    v18 = v18:WaitForChild(v);
end;

v5.Remotes = v18;

return v5;