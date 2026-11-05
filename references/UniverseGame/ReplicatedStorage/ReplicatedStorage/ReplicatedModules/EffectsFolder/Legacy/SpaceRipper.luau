  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(p1, u2) -- Line: 3
    -- upvalues: ReplicatedStorage (copy)
    local v3 = ReplicatedStorage["Client Assets"].Universal.SpaceRipperParticles.Attachment:Clone();
    v3.Parent = p1.Head;

    for _, child in pairs(v3:GetChildren()) do
        coroutine.resume(coroutine.create(function() -- Line: 8
            -- upvalues: child (copy), u2 (copy)
            if child.Name ~= "Hit" then
                child:Emit(1);

                return;
            end;

            wait(u2);
            child:Emit(1);
        end));
    end;

    game.Debris:AddItem(v3, u2 + 1);
end;