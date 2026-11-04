 

local v1 = game:GetService("GuiService")
local u2 = game:GetService("RunService")
local u3 = game:GetService("Players")
v1.MenuClosed:Connect(function() --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    for _, u4 in ipairs(u3:GetPlayers()) do
        task.delay(1, function() --[[ Line: 6 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u4
            --]]
            u2:UnbindFromRenderStep("utility-focus-state" .. "-friendstatuslabel-" .. u4.Name)
            u2:UnbindFromRenderStep("utility-focus-state" .. "-blockbutton-" .. u4.Name)
            u2:UnbindFromRenderStep("utility-focus-state" .. "-mutestatusbutton-" .. u4.Name)
            u2:UnbindFromRenderStep("utility-focus-state" .. "-reportplayer-" .. u4.Name)
            u2:UnbindFromRenderStep("utility-focus-state" .. "-inspect-" .. u4.Name)
            u2:UnbindFromRenderStep("utility-focus-state-sharegame")
            u2:UnbindFromRenderStep("utility-focus-state-muteall")
        end)
    end
end)