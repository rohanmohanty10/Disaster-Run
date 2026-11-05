  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local u1 = require(PathShortcuts.KnitPath.Knit).GetService("EventCandyService");

return {
    Start = "start",
    Title = "The Sigma Of Halloween",
    Nodes = {
        start = {
            Mutable = true,
            Text = "...",
            Options = {
                {
                    Response = "I want to exchange my candy",
                    Next = Dialogue.PLACEHOLDER,

                    Callback = function(p2, p3) -- Line: 18, Name: Callback
                        -- upvalues: u1 (copy)
                        local v4 = u1:ExchangeCandy():expect() or 0;

                        if v4 > 0 then
                            p3.Next = {
                                Mutable = true,
                                Text = `I can give you <Color=255,85,255>{v4}uE<Color=/> for your candy`,
                                Options = {
                                    {
                                        Response = "I\'ll take it",

                                        Callback = function() -- Line: 28, Name: Callback
                                            -- upvalues: u1 (ref)
                                            u1:ExchangeCandy(true):expect();
                                        end,

                                        Next = {
                                            Text = "I gotchu"
                                        }
                                    },
                                    {
                                        Response = "Nevermind",
                                        Next = {
                                            Text = "..."
                                        }
                                    }
                                }
                            };

                            return;
                        end;

                        p3.Next = {
                            Text = "You got nothing to exchange"
                        };
                    end
                },
                {
                    Response = "Hi",
                    Next = {
                        Text = "..."
                    }
                },
                {
                    Response = "Nevermind",
                    Next = {
                        Text = "..."
                    }
                }
            }
        }
    }
};