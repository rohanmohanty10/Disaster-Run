  

 

return function(p1, u2, u3) -- Line: 1
    if not p1 then
        return;
    end;

    local u4 = p1:Clone();
    local u5 = u4;

    if typeof(u2) == "Instance" then
        u4.Parent = u2;
    elseif typeof(u2) == "Vector3" then
        u5 = Instance.new("Attachment");
        u5.Position = u2;
        u5.Parent = workspace.Terrain;
        u4.Parent = u5;
    else
        u4.Parent = game:GetService("SoundService");
    end;

    task.spawn(function() -- Line: 23
        -- upvalues: u4 (ref), u2 (copy), u3 (copy), u5 (ref)
        if not u4.IsLoaded then
            pcall(function() -- Line: 25
                -- upvalues: u4 (ref)
                u4.Loaded:Wait();
            end);
        end;

        if not u2 and u3 then
            u5:Destroy();

            return;
        end;

        u4:Play();
        u4.Ended:Wait();
        task.wait(3);

        if u5 and u5.Parent then
            u5:Destroy();
        end;
    end);
end;