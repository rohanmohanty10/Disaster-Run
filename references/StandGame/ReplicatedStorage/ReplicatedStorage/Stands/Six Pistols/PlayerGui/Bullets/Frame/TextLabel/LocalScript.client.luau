 

 

local l__Parent__1 = script.Parent;
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local v1 = l__LocalPlayer__2.Character or l__LocalPlayer__2.CharacterAdded:wait();
v1:WaitForChild("StandMorph");
v1.Bullets.Changed:connect(function(p2) --[[ Line: 7 ]]
    -- upvalues: l__Parent__1 (copy)
    l__Parent__1.Text = "Bullets: " .. p2;
end);