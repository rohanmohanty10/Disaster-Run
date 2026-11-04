  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local script_Dribble = require(script.Dribble);
local script_Take = require(script.Take);

return function(p1, p2, p3) -- Line: 19
    -- upvalues: script_Dribble (copy), script_Take (copy)
    if p1.KaiserDribbleTake then
        return script_Take(p1, p2, p3);
    end;

    return script_Dribble(p1, p2, p3);
end;