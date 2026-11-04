 

local v1 = game:GetService("ReplicatedStorage"):WaitForChild("Modules").Client
local u2 = require(v1:WaitForChild("UIUtils"))
local v3 = require(game.ReplicatedStorage.Modules.RichText)
local v4 = require(game.ReplicatedStorage.Modules.ToolDesc)
local v5 = script:GetAttribute("Item")
local u6 = v4[v5].Max - _G.CheckItemAmmount(game.Players.LocalPlayer, v5)
local v7 = "How many do you want? <Color=Yellow>MAX: " .. u6 .. "<Color=/><AnimateYield=1>"
_G.hideUI(true)
v3:New(script.Parent.Frame.ImageLabel.desc, v7, {
    ["SFX"] = true
}):Show()
script.Parent.Frame.cancel.MouseButton1Click:Connect(function() --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u2.ButtonEffect()
    _G.hideUI(false)
    script.done.Value = true
    script.Parent.Enabled = false
    task.wait(1)
    script.Parent:Destroy()
end)
local u8 = game.ReplicatedStorage:FindFirstChild("Stats" .. game.Players.LocalPlayer.Name)
script.Parent.Frame.buy.MouseButton1Click:Connect(function() --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u6
        [3] = u8
    --]]
    u2.ButtonEffect()
    local v9 = script.Parent.Frame.count.Text
    local v10 = tonumber(v9)
    if v10 == nil or v10 and v10 <= 0 then
        _G.displayMessage("<Color=Red>Enter a valid number")
        return
    elseif u6 < v10 then
        _G.displayMessage("<Color=Red>Above max: " .. u6)
        return
    else
        local v11 = v10 * script.itemProp.Value.Info.Price.Value
        if u8.Stats.Peli.Value < v11 then
            _G.displayMessage("You need <Color=Red>" .. v11 - u8.Stats.Peli.Value .. "<Color=/> more Peli!")
        else
            game.ReplicatedStorage.Events.Shop:InvokeServer(script.itemProp.Value, v10)
            script.Item_Box_Get2:Play()
            script.Parent.Enabled = false
            _G.hideUI(false)
            script.done.Value = true
            _G.destroy(script.Parent, 5)
        end
    end
end)