 

 

local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local FallenKingSpoils = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("FallenKingSpoils"));
local Game = ChickenOrHero:WaitForChild("Game");
local FallenKingEvent = Game:WaitForChild("FallenKingEvent", 10);

while not FallenKingEvent do
    warn("[FallenKingSpoils] still waiting for ReplicatedStorage.ChickenOrHero.Game.FallenKingEvent");
    FallenKingEvent = Game:WaitForChild("FallenKingEvent", 30);
end;

task.delay(5, FallenKingSpoils.preload);
FallenKingEvent.OnClientEvent:Connect(function(p1, p2) -- Line: 25
    -- upvalues: FallenKingSpoils (copy)
    if p1 ~= "Spoils" then
        return;
    end;

    FallenKingSpoils.show(p2);
end);