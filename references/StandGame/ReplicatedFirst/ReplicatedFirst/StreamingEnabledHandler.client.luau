 

 

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local v1 = {
    Vector3.new(-53.622, 800.361, -251.162),
    Vector3.new(-504.832, 800.361, 11.538),
    Vector3.new(5.068, 800.361, 513.038),
    Vector3.new(-242.16, 733.307, 26.459),
    Vector3.new(-300.16, 733.307, 349.459),
    Vector3.new(27.84, 733.307, 26.459),
    Vector3.new(27.84, 733.307, 237.459),
    Vector3.new(179.84, 710.307, 374.459),
    Vector3.new(675.561, 808.622, -222.925)
};
repeat
    wait();
until l__LocalPlayer__1.Character and l__LocalPlayer__1.Character.Parent;
for _, v2 in pairs(v1) do
    l__LocalPlayer__1:RequestStreamAroundAsync(v2);
end;