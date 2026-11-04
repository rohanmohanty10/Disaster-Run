  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");

return {
    PlayerData = require(ReplicatedStorage.Modules.ReplicatorClient).get("PlayerData"),
    PlayerGui = Players.LocalPlayer.PlayerGui
};