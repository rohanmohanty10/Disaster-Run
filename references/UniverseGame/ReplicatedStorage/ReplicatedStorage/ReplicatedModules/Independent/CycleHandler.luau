  

 

local Xtal = require(game.ReplicatedStorage:WaitForChild("Xtal"));
local Output = game.ReplicatedStorage.Remotes.Output;

return function(u1, u2, u3) -- Line: 4
    -- upvalues: Xtal (copy), Output (copy)
    local Janitor = Xtal.new("Janitor");
    Janitor:LinkToInstance(u1);
    Output:FireAllClients("FX", "Q_MODEL_COLOR_CYCLE", u1, u2, u3);
    local u4 = nil;
    u4 = game.Players.PlayerAdded:Connect(function(u5) -- Line: 11
        -- upvalues: u1 (copy), Output (ref), u2 (copy), u3 (copy), u4 (ref), Janitor (copy)
        if u1 then
            task.delay(5, function() -- Line: 13
                -- upvalues: u5 (copy), Output (ref), u1 (ref), u2 (ref), u3 (ref)
                if u5 then
                    Output:FireClient(u5, "FX", "Q_MODEL_COLOR_CYCLE", u1, u2, u3);
                end;
            end);

            return;
        end;

        if u4 then
            u4:Disconnect();
            u4 = nil;
        end;

        if Janitor and Janitor.Destroy then
            Janitor:Destroy();
        end;
    end);
    Janitor:Add(u4);
end;