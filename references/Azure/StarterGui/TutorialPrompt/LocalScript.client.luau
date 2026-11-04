 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local packets = require(ReplicatedStorage.packets);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local LocalPlayer = Players.LocalPlayer;
local script_Parent = script.Parent;
local Frame = script_Parent.Frame;
Frame.Naur.MouseButton1Click:Connect(function() -- Line: 12
    -- upvalues: script_Parent (copy), soundUtil (copy), ReplicatedStorage (copy)
    script_Parent.Enabled = false;
    soundUtil:play(ReplicatedStorage.Resources.click, soundUtil);
end);
Frame.Yay.MouseButton1Click:Connect(function() -- Line: 17
    -- upvalues: script_Parent (copy), packets (copy), soundUtil (copy), ReplicatedStorage (copy)
    script_Parent.Enabled = false;
    packets.bytenet_teleportGamemode.send("Tutorial");
    soundUtil:play(ReplicatedStorage.Resources.click, soundUtil);
end);
local goals = LocalPlayer:WaitForChild("leaderstats"):WaitForChild("goals");

if not goals:GetAttribute("loaded") then
    goals:GetAttributeChangedSignal("loaded"):Wait();
end;

if not goals:GetAttribute("o") then
    goals:GetAttributeChangedSignal("o"):Wait();
end;

if goals:GetAttribute("o") < 50 then
    local v1 = not LocalPlayer:GetAttribute("tutorial") and not LocalPlayer:GetAttribute("tutorialdone");
    script_Parent.Enabled = v1;
end;

LocalPlayer:GetAttributeChangedSignal("tutorialdone"):Connect(function() -- Line: 37
    -- upvalues: LocalPlayer (copy), script_Parent (copy)
    if LocalPlayer:GetAttribute("tutorialdone") then
        script_Parent.Enabled = false;
    end;
end);