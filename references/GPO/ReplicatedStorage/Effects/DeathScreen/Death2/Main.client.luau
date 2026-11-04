 

local u1 = game:GetService("TweenService")
local u2 = {
    "Destroyed by",
    "Eradicated by",
    "Obliterated by",
    "Exterminated by",
    "Eliminated by",
    "Erased by",
    "Annihilated by",
    "Demolished by",
    "Slaughtered by",
    "Executed by",
    "Deleted by",
    "Killed by",
    "Owned by",
    "Terminated by"
}
local u3 = script.Parent
local u4 = u3:WaitForChild("Bar")
local u5 = u4:WaitForChild("Frame"):WaitForChild("FirstMessage")
_G.hideUI(true);
(function() --[[ Name: AnimateDeathScreen, Line 44 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
        [3] = u2
        [4] = u1
    --]]
    if _G.music == true then
        script.DeathMusic:Play()
    end
    u4.Size = UDim2.new(1, 0, 0, 0)
    u5.TextTransparency = 0
    u5.Size = UDim2.new(1, 0, 1, 0)
    u5.Text = ("%* %*"):format(u2[math.random(#u2)], script.Parent.killerName.Value)
    u4:TweenSize(UDim2.new(1, 0, 0.1, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.35, true)
    task.wait(0.35)
    u5:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.35, true)
    task.wait(4)
    u1:Create(u5, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        ["TextTransparency"] = 1
    }):Play()
    task.wait(1.25)
    u4:TweenSize(UDim2.new(1, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.35, true)
end)()
local u6 = nil
u6 = game.Players.LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 84 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u3
    --]]
    _G.hideUI(false)
    u6:Disconnect()
    u6 = nil
    u3:Destroy()
end)