 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
game:GetService("RunService");
game:GetService("UserInputService");
game:GetService("TweenService");
game:GetService("Debris");
game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
game:GetService("SoundService");
game:GetService("TextService");
game:GetService("ContentProvider");
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local _ = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local _ = Lighting.Brightness;
local _ = Lighting.ClockTime;
local _ = Lighting.Ambient;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
require(script.Parent.Parent.MeshEmitter);
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
require(script.Parent.Parent.mainreplication);
require(script.Parent.Parent.TekrinnDialogue);

return {};