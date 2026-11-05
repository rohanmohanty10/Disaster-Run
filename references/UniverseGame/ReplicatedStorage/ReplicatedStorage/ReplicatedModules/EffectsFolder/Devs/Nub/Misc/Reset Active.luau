  

 

local LocalPlayer = game.Players.LocalPlayer;

return function() -- Line: 2
    -- upvalues: LocalPlayer (copy)
    LocalPlayer.Character.Values.Active.Value = "";
end;