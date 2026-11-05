  

 

return function(u1) -- Line: 1
    task.spawn(function() -- Line: 2
        -- upvalues: u1 (copy)
        game.ReplicatedStorage:WaitForChild("Remotes").UIOutput.OnClientEvent:Connect(function(p2, ...) -- Line: 3
            -- upvalues: u1 (ref)
            local v3 = u1[p2];

            if v3 then
                v3(u1, ...);
            end;
        end);
        game.ReplicatedStorage:WaitForChild("Remotes").UIOutputUnreliable.OnClientEvent:Connect(function(p4, ...) -- Line: 10
            -- upvalues: u1 (ref)
            local v5 = u1[p4];

            if v5 then
                v5(u1, ...);
            end;
        end);
        game.ReplicatedStorage:WaitForChild("Remotes").ClientUIOutput.Event:Connect(function(p6, ...) -- Line: 17
            -- upvalues: u1 (ref)
            local v7 = u1[p6];

            if v7 then
                v7(u1, ...);
            end;
        end);
    end);
end;