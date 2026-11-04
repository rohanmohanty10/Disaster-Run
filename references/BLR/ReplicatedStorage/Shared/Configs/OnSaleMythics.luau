  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local script_Emote = require(script.Emote);
local script_MVPCutscene = require(script.MVPCutscene);
local Gamepasses = require(ReplicatedStorage.Shared.Configs.Gamepasses);

return { script_Emote("Come With Me", Gamepasses["Come With Me"]), script_MVPCutscene("Barou2MVPCutscene", Gamepasses.Barou2MVPCutscene, "MythicMVP", 21) };