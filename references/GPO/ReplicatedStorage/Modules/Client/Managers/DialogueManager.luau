 

local v1 = game:GetService("ReplicatedStorage")
local v2 = v1:WaitForChild("Modules").Client.Core
local u3 = require(v2.Dialogue)
local u4 = v1:WaitForChild("Remotes"):WaitForChild("Dialogue")
local v5 = table.freeze
local v6 = {}
local v7 = {
    ["Text"] = "<font animate = \"fall\">You\'ve entered my <font color = \"rainbow\">domain</font>. I\'ve already seen how this fight ends for <font animate = \"shakey\" color = \"blue\">you.",
    ["Character"] = {
        ["Idle"] = { "rbxassetid://113950273103519", "rbxassetid://138854614966553" },
        ["Talking"] = { "rbxassetid://121947987493850", "rbxassetid://98289664533023" }
    },
    ["Duration"] = 5,
    ["CharacterSound"] = { script["Cupid Queen"].Letter1, script["Cupid Queen"].Letter2 },
    ["AppearSound"] = { script["Cupid Queen"].Appear1, script["Cupid Queen"].Appear2 }
}
v6["Cupid Queen"] = v7
local v8 = {
    ["Text"] = "<font animate = \"fall\">You\'ve entered my <font color = \"rainbow\">domain</font>. I\'ve already seen how this fight ends for <font animate = \"shakey\" color = \"blue\">you.",
    ["Character"] = {
        ["Idle"] = { "rbxassetid://135470988221668", "rbxassetid://108607163829370" },
        ["Talking"] = { "rbxassetid://93447667874031", "rbxassetid://72209161417520" }
    },
    ["Duration"] = 5,
    ["CharacterSound"] = { script["Cupid Queen"].Letter1, script["Cupid Queen"].Letter2 },
    ["AppearSound"] = { script["Cupid Queen"].MadAppear1 }
}
v6["Cupid QueenMad"] = v8
local u9 = v5(v6)
return {
    ["Initialize"] = function() --[[ Name: Initialize, Line 60 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u9
            [3] = u3
        --]]
        u4.OnClientEvent:Connect(function(p10) --[[ Line: 61 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u3
            --]]
            local v11 = p10.Speaker
            local v12 = table.clone(u9[v11])
            v12.Text = p10.Text or v12.Text
            u3:Display(v12)
        end)
    end
}