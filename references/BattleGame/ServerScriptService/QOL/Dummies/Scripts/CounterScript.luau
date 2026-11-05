--ServerScriptService/QOL/Dummies/Scripts/CounterScript
--
-- MODULESCRIPT. Driven by Dummies.server.luau via start(Dummy) -> cleanup.
-- See AttackScript for why dummy behaviour must not live inside the dummy -- this one
-- mattered most: Counter applies an INDEFINITE stun to the player, so losing its
-- release machinery to a dummy deletion strands the victim with no timer to save them.

local Counter = require(script.Counter)

local CounterScript = {}

function CounterScript.start(Character: Model)
	return Counter.Start(Character)
end

return CounterScript
