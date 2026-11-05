  

 

return function(u1) -- Line: 1
    local Parent = script.Parent;
    local u2 = u1.Knit.GetService("GameModeService");
    Parent.Activated:Connect(function() -- Line: 5
        -- upvalues: u1 (copy), u2 (copy)
        u1.NewPrompt({
            Title = "End Your Run",
            Text = "Are you sure you want to end your run? (this will set your lives to 0)",
            Delay = 1,
            Options = { "Yes", "No" },

            Callback = function(p3) -- Line: 14, Name: Callback
                -- upvalues: u2 (ref), u1 (ref)
                if p3.Choice ~= 1 then
                    return;
                end;

                if u2:RemoveAllLives():expect() then
                    u1.NewPrompt({
                        Title = "Run Ended",
                        Text = "Your run has been ended successfully."
                    });

                    return;
                end;

                u1.NewPrompt({
                    Title = "Failed",
                    Text = "I don\'t know what happened ngl."
                });
            end
        });
    end);
end;