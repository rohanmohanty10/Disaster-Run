  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts");
local u1 = require(PlayerScripts:WaitForChild("PlayerModule")):GetControls();

local function Inverted(p2, p3, p4) -- Line: 9
    -- upvalues: LocalPlayer (copy)
    LocalPlayer.Move(p2, -p3, p4);
end;

return function(p5) -- Line: 13
    -- upvalues: u1 (copy), Inverted (copy), LocalPlayer (copy)
    u1.moveFunction = p5 and Inverted or LocalPlayer.Move;
end;