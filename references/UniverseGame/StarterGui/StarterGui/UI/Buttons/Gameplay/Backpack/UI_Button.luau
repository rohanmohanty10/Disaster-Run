  

 

return function(u1) -- Line: 1
    local Core = require(game:GetService("ReplicatedStorage").ReplicatedRoot:WaitForChild("Core"));
    Core.OnStart():await();

    if Core.GetClientService("ConfigurationService"):GetFFlags():expect().new_backpack_enabled then
        script.Parent.MouseButton1Click:Connect(function() -- Line: 14
            -- upvalues: u1 (copy)
            u1:ToggleBackpack();
        end);

        return;
    end;

    script.Parent.Visible = false;
end;