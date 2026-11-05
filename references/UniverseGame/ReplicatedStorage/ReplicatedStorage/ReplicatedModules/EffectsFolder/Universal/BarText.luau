  

 

return function(u1, u2, u3) -- Line: 1
    for _, descendant in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
        if descendant:IsA("ScreenGui") and (descendant.Name == "ScreenImages" and descendant:FindFirstChild("TimeStop")) then
            task.spawn(function() -- Line: 6
                -- upvalues: descendant (copy), u2 (copy), u1 (copy), u3 (copy)
                descendant:FindFirstChild("TimeStop").bar.Size = UDim2.new(1, 0, 1, 0);
                descendant:FindFirstChild("TimeStop").Visible = true;
                game:GetService("TweenService"):Create(descendant:FindFirstChild("TimeStop"), TweenInfo.new((tonumber(0.2))), {
                    Transparency = 0
                }):Play();
                descendant:FindFirstChild("TimeStop").txt.Text = u2;
                local v4 = game:GetService("TweenService"):Create(descendant:FindFirstChild("TimeStop").bar, TweenInfo.new(tonumber(u1) + 1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                    Size = UDim2.new(0, 0, 1, 0)
                });
                v4:Play();
                v4.Completed:connect(function() -- Line: 13
                    -- upvalues: descendant (ref), u3 (ref)
                    descendant:FindFirstChild("TimeStop").txt.Text = u3;
                    wait(0.5);
                    descendant:FindFirstChild("TimeStop").Visible = false;
                    descendant:FindFirstChild("TimeStop").Transparency = 1;
                end);
            end);
        end;
    end;
end;