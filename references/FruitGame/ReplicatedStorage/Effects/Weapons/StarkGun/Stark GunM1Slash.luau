 

local _ = script
local v1 = game:GetService("ReplicatedStorage")
local u2 = require(v1.Modules.Client.WeaponVFXRecolor)
local v3 = {}
local u4 = {
    ["1"] = { "Stark GunSword" },
    ["2"] = { "Stark GunSword2" },
    ["3"] = { "Stark GunSword2" },
    ["4"] = { "Stark GunSword" },
    ["5"] = { "Stark GunSword2", "Stark GunSword" },
    ["Air-4"] = { "Stark GunSword" },
    ["Air-5"] = { "Stark GunSword2", "Stark GunSword" },
    ["Dash"] = { "Stark GunSword2", "Stark GunSword" }
}
function v3.start(_, p5, p6, _, p7) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    local v8 = p6.Parent
    local v9 = game.ReplicatedStorage:FindFirstChild("Stats" .. v8.Name)
    local v10 = Color3.fromRGB(0, 100, 255)
    if v9 then
        v10 = v9.Customization.BusoColor.Value
    end
    local v11 = p7 == true and "Dash" or p5
    local v12 = p6.Parent:GetChildren()
    for v13 = 1, #v12 do
        if v12[v13]:IsA("Model") and (v12[v13].ClassName ~= "Tool" and table.find(u4[v11], v12[v13].Name)) then
            _G.recolorParticles(v12[v13].Blade.FireHole, v10)
            u2.apply(v12[v13].Blade.FireHole, v8)
            _G.customEmit(v12[v13].Blade.FireHole)
            local v14 = Instance.new("PointLight")
            v14.Brightness = 4
            v14.Color = v10
            v14:SetAttribute("UniqueID", "67600bc8-93a1-4e53-83fc-1cb1e6230a6a")
            u2.apply(v14, v8)
            v14.Parent = v12[v13].Blade.FireHole
            _G.tween(v14, {
                0.25,
                "Cubic",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = 16,
                ["Brightness"] = 0
            })
            _G.destroy(v14, 0.25)
            local v15 = Instance.new("Highlight")
            v15.OutlineTransparency = -2
            v15.DepthMode = Enum.HighlightDepthMode.Occluded
            v15.FillTransparency = 1
            v15.OutlineColor = v10
            v15:SetAttribute("UniqueID", "25f7b053-4f02-4e53-91f9-95e2ca743798")
            u2.apply(v15, v8)
            v15.Parent = v12[v13]
            _G.destroy(v15, 0.15)
        end
    end
end
return v3